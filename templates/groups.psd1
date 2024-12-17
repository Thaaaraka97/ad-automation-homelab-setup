$GroupMapping = @{
    "MGT_Global_Access_Grp" = @{
        OUName      = "Management"
        ParentOU    = ""
        Description = "Global access to company resources with exceptions for IT security controls"
        Scope       = "Global"
        Type        = "Security"
        MemberOf    = @()
    }
    "MGT_Policy_Grp" = @{
        OUName      = "Management"
        ParentOU    = ""
        Description = "Rights to approve and review policy changes"
        Scope       = "Global"
        Type        = "Security"
        MemberOf    = @()
    }
    "IT_Domain_Admins_Grp" = @{
        OUName      = "IT"
        ParentOU    = ""
        Description = "Domain Administrator rights"
        Scope       = "Global"
        Type        = "Security"
        MemberOf    = @()
    }
    "IT_Server_Admins_Grp" = @{
        OUName      = "IT"
        ParentOU    = ""
        Description = "Server Administrator rights and excluding Domain Controller access"
        Scope       = "Global"
        Type        = "Security"
        MemberOf    = @()
    }
    "IT_HelpDesk_L1_Grp" = @{
        OUName      = "IT"
        ParentOU    = ""
        Description = "Basic user support and password resets"
        Scope       = "Global"
        Type        = "Security"
        MemberOf    = @()
    }
    "IT_HelpDesk_L2_Grp" = @{
        OUName      = "IT"
        ParentOU    = ""
        Description = "Advanced support and local admin rights"
        Scope       = "Global"
        Type        = "Security"
        MemberOf    = @()
    }
    "HR_Sensitive_Data_Grp" = @{
        OUName      = "HR"
        ParentOU    = ""
        Description = "Full access to employee confidential data"
        Scope       = "Global"
        Type        = "Security"
        MemberOf    = @()
    }
    "HR_General_Staff_Grp" = @{
        OUName      = "HR"
        ParentOU    = ""
        Description = "Access to general HR documents and policies"
        Scope       = "Global"
        Type        = "Security"
        MemberOf    = @()
    }
    "Sales_Managers_Grp" = @{
        OUName      = "Sales"
        ParentOU    = ""
        Description = "Full access to sales data and reports"
        Scope       = "Global"
        Type        = "Security"
        MemberOf    = @()
    }
    "Sales_Staff_Grp" = @{
        OUName      = "Sales"
        ParentOU    = ""
        Description = "Access to basic sales tools and customer data"
        Scope       = "Global"
        Type        = "Security"
        MemberOf    = @()
    }
    "IT_All_Staff_Grp" = @{
        OUName      = "IT"
        ParentOU    = ""
        Description = ""
        Scope       = "Global"
        Type        = "Security"
        MemberOf    = @("IT_Domain_Admins_Grp", "IT_Server_Admins_Grp", "IT_HelpDesk_L1_Grp", "IT_HelpDesk_L2_Grp")
    }
    "HR_All_Staff_Grp" = @{
        OUName      = "HR"
        ParentOU    = ""
        Description = ""
        Scope       = "Global"
        Type        = "Security"
        MemberOf    = @("HR_Sensitive_Data_Grp", "HR_General_Staff_Grp")
    }
    "Sales_All_Staff_Grp" = @{
        OUName      = "Sales"
        ParentOU    = ""
        Description = ""
        Scope       = "Global"
        Type        = "Security"
        MemberOf    = @("Sales_Managers_Grp", "Sales_Staff_Grp")
    }
    "All_Staff_DL" = @{
        OUName      = "0"
        ParentOU    = ""
        Description = ""
        Scope       = "Global"
        Type        = "Distribution"
        MemberOf    = @()
    }
    "Management_DL" = @{
        OUName      = "0"
        ParentOU    = ""
        Description = ""
        Scope       = "Global"
        Type        = "Distribution"
        MemberOf    = @()
    }
    "Department_Heads_DL" = @{
        OUName      = "0"
        ParentOU    = ""
        Description = ""
        Scope       = "Global"
        Type        = "Distribution"
        MemberOf    = @()
    }
    "Global_Read_Grp" = @{
        OUName      = "0"
        ParentOU    = ""
        Description = "Basic read access to company-wide resources"
        Scope       = "Global"
        Type        = "Security"
        MemberOf    = @()
    }
    "Confidential_Data_Grp" = @{
        OUName      = "0"
        ParentOU    = ""
        Description = "Access to confidential company documents"
        Scope       = "Global"
        Type        = "Security"
        MemberOf    = @()
    }
}
