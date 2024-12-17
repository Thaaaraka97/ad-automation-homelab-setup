# Import the Active Directory module
Import-Module ActiveDirectory

# Function to create OU and return its Distinguished Name
function CreateOrganizationalUnit {
    param (
        [string]$Name,
        [string]$Path,
        [string]$Description = ""
    )
    
    try {
        # Check if OU already exists
        $existingOU = Get-ADOrganizationalUnit -Filter "Name -eq '$Name'" -SearchBase $Path -SearchScope OneLevel -ErrorAction SilentlyContinue
        
        if ($existingOU) {
            Write-Host "OU '$Name' already exists at path: $Path" -ForegroundColor Yellow
            return $existingOU.DistinguishedName
        }
        
        # Create new OU
        $ou = New-ADOrganizationalUnit -Name $Name -Path $Path -Description $Description -PassThru
        Write-Host "Successfully created OU '$Name' at path: $Path" -ForegroundColor Green
        return $ou.DistinguishedName
    }
    catch {
        Write-Host "Error creating OU '$Name': $_" -ForegroundColor Red
        return $null
    }
}

# Read the CSV file
$csvPath = "ADOUList.csv"
$ous = Import-Csv $csvPath

# Sort OUs by path depth (number of backslashes) to ensure parent OUs are created first
$ous = $ous | Sort-Object { ($_.Path -split "\\").Count }

# Process each OU
foreach ($ou in $ous) {
    Write-Host "`nProcessing OU path: $($ou.Path)" -ForegroundColor Cyan
    
    $currentPath = $ou.Path -split "\\"
    $baseDN = (Get-ADDomain).DistinguishedName
    $currentDN = $baseDN
    
    # Create each level of the OU hierarchy from top to bottom
    for ($i = 0; $i -lt $currentPath.Count; $i++) {
        if ($currentPath[$i]) {
            $ouName = $currentPath[$i]
            $parentDN = $currentDN
            
            Write-Host "Creating level $($i + 1) OU: $ouName" -ForegroundColor Gray
            $dn = CreateOrganizationalUnit -Name $ouName -Path $parentDN -Description $ou.Description
            
            if ($dn) {
                $currentDN = $dn
            }
            else {
                Write-Host "Failed to create OU hierarchy for: $($ou.Path)" -ForegroundColor Red
                break
            }
        }
    }
}

Write-Host "`nOU creation process completed!" -ForegroundColor Green