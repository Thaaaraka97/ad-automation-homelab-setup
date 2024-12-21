# Import the Active Directory module
Import-Module ActiveDirectory

# Constant Domain Components
$DomainDC = "OU=ou-name,DC=domain-name,DC=local"

# Default password for all the users
$Password = "P@ssw0rd@123"

# Define comprehensive group mappings
$GroupMappings = @{
    "Management" = @{
        DepartmentGroups = @("MGT_Global_Access_Grp", "MGT_Policy_Grp", "Management_DL", "Department_Heads_DL", "All_Staff_DL", "Global_Read_Grp");
    };
    "IT" = @{
        DepartmentGroups = @("IT_All_Staff_Grp", "All_Staff_DL", "Global_Read_Grp");
        RoleGroups = @{
            "HelpDesk Admin" = @("IT_HelpDesk_L2_Grp");
            "System Admin" = @("IT_Server_Admins_Grp");
            "Network Engineer" = @("IT_Server_Admins_Grp")
        }
    };
    "HR" = @{
        DepartmentGroups = @("HR_All_Staff_Grp", "HR_General_Staff_Grp", "All_Staff_DL", "Global_Read_Grp");
        RoleGroups = @{
            "HR Manager" = @("HR_Sensitive_Data_Grp", "Department_Heads_DL", "Confidential_Data_Grp");
            "HR Assistant" = @("HR_General_Staff_Grp")
        }
    };
    "Sales" = @{
        DepartmentGroups = @("Sales_All_Staff_Grp", "All_Staff_DL", "Global_Read_Grp");
        RoleGroups = @{
            "Sales Manager" = @("Sales_Managers_Grp", "Department_Heads_DL");
            "Sales Representative" = @("Sales_Staff_Grp")
        }
    }
}

# Specify the path to your CSV file
$CSVPath = "users.csv"

# Read the CSV file
$Users = Import-Csv -Path $CSVPath

# Function to add user to groups
function Add-UserToGroups {
    param(
        [string]$Username,
        [string]$Department,
        [string]$Role
    )

    # Retrieve group mapping for the department
    $DepartmentMapping = $GroupMappings[$Department]

    if ($DepartmentMapping) {
        # Add to Department Groups
        if ($DepartmentMapping.DepartmentGroups) {
            $DepartmentMapping.DepartmentGroups | ForEach-Object {
                try {
                    Add-ADGroupMember -Identity $_ -Members $Username
                    Write-Host "Added $Username to department group $_" -ForegroundColor Cyan
                }
                catch {
                    Write-Host "Failed to add $Username to department group $_" -ForegroundColor Yellow
                }
            }
        }

        # Add to Role-specific Groups if defined
        if ($DepartmentMapping.RoleGroups -and $DepartmentMapping.RoleGroups.ContainsKey($Role)) {
            $DepartmentMapping.RoleGroups[$Role] | ForEach-Object {
                try {
                    Add-ADGroupMember -Identity $_ -Members $Username
                    Write-Host "Added $Username to role-specific group $_" -ForegroundColor Cyan
                }
                catch {
                    Write-Host "Failed to add $Username to role-specific group $_" -ForegroundColor Yellow
                }
            }
        }
    }
}

# Loop through each user in the CSV
foreach ($User in $Users) {
    # Extract user details
    $FirstName = $User.FirstName
    $LastName = $User.LastName
    $Username = $User.Username
    $Department = $User.Department
    $Role = $User.Role
    $OU = $User.OU
    $Email = $User.Email

    # Construct full name
    $DisplayName = "$FirstName $LastName"

    # Construct OU Path with nested OUs
    $OUPath = $OU.Split('\') | ForEach-Object { "OU=$_" }
    $OUPath = ($OUPath -join ',') + ",$DomainDC"

    try {
        # Convert password to secure string
        $SecurePassword = ConvertTo-SecureString $Password -AsPlainText -Force


        # Create the new AD user
        New-ADUser `
            -Name $DisplayName `
            -GivenName $FirstName `
            -Surname $LastName `
            -DisplayName $DisplayName `
            -SamAccountName $Username `
            -UserPrincipalName $Email `
            -EmailAddress $Email `
            -Department $Department `
            -Title $Role `
            -Path $OUPath `
            -AccountPassword $SecurePassword `
            -Enabled $true `
            -ChangePasswordAtLogon $true

        # Add user to groups
        Add-UserToGroups -Username $Username -Department $Department -Role $Role

        Write-Host "User $Username created successfully in $OUPath" -ForegroundColor Green
    }
    catch {
        Write-Host "Failed to create user $Username. Error: $_" -ForegroundColor Red
    }
}

Write-Host "User creation process completed." -ForegroundColor Cyan