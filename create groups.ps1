# Import Active Directory Module
Import-Module ActiveDirectory

# Function to create AD Group
function CreateADGroupInOU {
    param (
        [string]$GroupName,
        [string]$OUPath,
        [string]$Description = "",
        [ValidateSet("Global", "Universal", "DomainLocal")]
        [string]$Scope = "Global",
        [ValidateSet("Security", "Distribution")]
        [string]$Type = "Security"
    )
    
    try {
        # Check if group already exists in the OU
        $existingGroup = Get-ADGroup -Filter "Name -eq '$GroupName'" -SearchBase $OUPath -ErrorAction SilentlyContinue
        
        if ($existingGroup) {
            Write-Host "Group '$GroupName' already exists in: $OUPath" -ForegroundColor Yellow
            return $existingGroup
        }
        
        # Create new group
        $group = New-ADGroup -Name $GroupName `
                            -Path $OUPath `
                            -Description $Description `
                            -GroupScope $Scope `
                            -GroupCategory $Type `
                            -PassThru
                            
        Write-Host "Successfully created group '$GroupName' in: $OUPath" -ForegroundColor Green
        return $group
    }
    catch {
        Write-Host "Error creating group '$GroupName': $_" -ForegroundColor Red
        return $null
    }
}

# Function to add group memberships
function Add-GroupMemberships {
    param (
        [string]$GroupName,
        [string[]]$MemberGroups
    )
    
    try {
        foreach ($memberGroup in $MemberGroups) {
            if ($memberGroup) {  # Only process if memberGroup is not empty
                Add-ADGroupMember -Identity $GroupName -Members $memberGroup
                Write-Host "Added '$memberGroup' as member of '$GroupName'" -ForegroundColor Green
            }
        }
    }
    catch {
        Write-Host "Error adding group memberships: $_" -ForegroundColor Red
    }
}

# Get domain DN
$domainDN = (Get-ADDomain).DistinguishedName

# Read the CSV file
$csvPath = "ADGroups.csv"
$groups = Import-Csv $csvPath

# First, create all groups
foreach ($group in $groups) {
    Write-Host "`nProcessing group: $($group.GroupName)" -ForegroundColor Cyan
    
    # Construct full OU path
    if (-not ($group.OUName -eq "0")){
        $ouPath = "OU=$($group.OUName),OU=TechCorp,$domainDN"
    }
    else{
        $ouPath = "OU=TechCorp,$domainDN"
    }
    
    if ($group.ParentOU) {
        $ouPath = "OU=$($group.OUName),OU=$($group.ParentOU),OU=TechCorp,$domainDN"
    }
    
    CreateADGroupInOU -GroupName $group.GroupName `
                       -OUPath $ouPath `
                       -Description $group.Description `
                       -Scope $group.Scope `
                       -Type $group.Type
}

# Then, set up all group memberships
Write-Host "`nSetting up group memberships..." -ForegroundColor Cyan
foreach ($group in $groups) {
    if ($group.MemberOf) {
        Write-Host "Adding memberships for $($group.GroupName)" -ForegroundColor Cyan
        $memberGroups = $group.MemberOf -split ';'
        Add-GroupMemberships -GroupName $group.GroupName -MemberGroups $memberGroups
    }
}

Write-Host "`nGroup creation and membership setup completed!" -ForegroundColor Green