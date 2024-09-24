$cmdlets = @(
    @{
        SourceName = "Remove-EntraMSAdministrativeUnit";
        TargetName = "Remove-MgDirectoryAdministrativeUnit";
        IsApi = $false
    },    
    @{
        SourceName = "Remove-EntraMSDeletedDirectoryObject";
        TargetName = "";
        IsApi = $true
    },
    @{
        SourceName = "Remove-EntraMSGroup";
        TargetName = "Remove-MgGroup";
        IsApi = $false
    },
    @{
        SourceName = "Remove-EntraMSGroupLifecyclePolicy";
        TargetName = "Remove-MgGroupLifecyclePolicy";
        IsApi = $false
    },
    @{
        SourceName = "Remove-EntraMSIdentityProvider";
        TargetName = "Remove-MgIdentityProvider";
        IsApi = $false
    },
    @{
        SourceName = "Remove-EntraMSPermissionGrantPolicy";
        TargetName = "Remove-MgPolicyPermissionGrantPolicy";
        IsApi = $false
    },
    @{
        SourceName = "Remove-EntraMSRoleAssignment";
        TargetName = "Remove-MgRoleManagementDirectoryRoleAssignment"
        IsApi = $false
    },
    @{
        SourceName = "Remove-EntraMSRoleDefinition";
        TargetName = "Remove-MgRoleManagementDirectoryRoleDefinition";
        IsApi = $false
    },
    @{
        SourceName = "Remove-EntraApplication";
        TargetName = "Remove-MgApplication";
        IsApi = $false
    },
    @{
        SourceName = "Remove-EntraContact";
        TargetName = "Remove-MgContact";
        IsApi = $false
    },
    @{
        SourceName = "Remove-EntraDeletedApplication";
        TargetName = "Remove-MgDirectoryDeletedItem";
        IsApi = $false
    },
    @{
        SourceName = "Remove-EntraDevice";
        TargetName = "Remove-MgDevice";
        IsApi = $false
    },
    @{
        SourceName = "Remove-EntraGroup";
        TargetName = "Remove-MgGroup";
        IsApi = $false
    },
    @{
        SourceName = "Remove-EntraMSApplication";
        TargetName = "Remove-MgApplication";
        IsApi = $false
    },
    @{
        SourceName = "Remove-EntraMSApplicationKey";
        TargetName = "Remove-MgApplicationKey";
        IsApi = $false
    },
    @{
        SourceName = "Remove-EntraMSApplicationPassword";
        TargetName = "Remove-MgApplicationPassword";
        IsApi = $false
    },
    @{
        SourceName = "Remove-EntraOAuth2PermissionGrant";
        TargetName = "Remove-MgOAuth2PermissionGrant";
        IsApi = $false
    },
    @{
        SourceName = "Remove-EntraServicePrincipal";
        TargetName = "Remove-MgServicePrincipal";
        IsApi = $false
    },
    @{
        SourceName = "Remove-EntraUser";
        TargetName = "Remove-MgUser";
        IsApi = $false
    },
    @{
        SourceName = "Remove-EntraUserManager";
        TargetName = "Remove-MgUserManagerByRef";
        IsApi = $false
    }
)