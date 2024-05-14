$cmdlets = @(
    @{
        SourceName = "Remove-EntraBetaMSAdministrativeUnit";
        TargetName = "Remove-MgBetaDirectoryAdministrativeUnit";
        IsApi = $false
    },    
    @{
        SourceName = "Remove-EntraBetaMSDeletedDirectoryObject";
        TargetName = "";
        IsApi = $true
    },
    @{
        SourceName = "Remove-EntraBetaMSGroup";
        TargetName = "Remove-MgBetaGroup";
        IsApi = $false
    },
    @{
        SourceName = "Remove-EntraBetaMSGroupLifecyclePolicy";
        TargetName = "Remove-MgBetaGroupLifecyclePolicy";
        IsApi = $false
    },
    @{
        SourceName = "Remove-EntraBetaMSIdentityProvider";
        TargetName = "Remove-MgBetaIdentityProvider";
        IsApi = $false
    },
    @{
        SourceName = "Remove-EntraBetaMSPermissionGrantPolicy";
        TargetName = "Remove-MgBetaPolicyPermissionGrantPolicy";
        IsApi = $false
    },
    @{
        SourceName = "Remove-EntraBetaMSRoleAssignment";
        TargetName = "Remove-MgBetaRoleManagementDirectoryRoleAssignment"
        IsApi = $false
    },
    @{
        SourceName = "Remove-EntraBetaMSRoleDefinition";
        TargetName = "Remove-MgBetaRoleManagementDirectoryRoleDefinition";
        IsApi = $false
    },
    @{
        SourceName = "Remove-EntraBetaApplication";
        TargetName = "Remove-MgBetaApplication";
        IsApi = $false
    },
    @{
        SourceName = "Remove-EntraBetaContact";
        TargetName = "Remove-MgBetaContact";
        IsApi = $false
    },
    @{
        SourceName = "Remove-EntraBetaDeletedApplication";
        TargetName = "Remove-MgBetaDirectoryDeletedItem";
        IsApi = $false
    },
    @{
        SourceName = "Remove-EntraBetaDevice";
        TargetName = "Remove-MgBetaDevice";
        IsApi = $false
    },
    @{
        SourceName = "Remove-EntraBetaGroup";
        TargetName = "Remove-MgBetaGroup";
        IsApi = $false
    },
    @{
        SourceName = "Remove-EntraBetaMSApplication";
        TargetName = "Remove-MgBetaApplication";
        IsApi = $false
    },
    @{
        SourceName = "Remove-EntraBetaMSApplicationKey";
        TargetName = "Remove-MgBetaApplicationKey";
        IsApi = $false
    },
    @{
        SourceName = "Remove-EntraBetaMSApplicationPassword";
        TargetName = "Remove-MgBetaApplicationPassword";
        IsApi = $false
    },
    @{
        SourceName = "Remove-EntraBetaOAuth2PermissionGrant";
        TargetName = "Remove-MgBetaOAuth2PermissionGrant";
        IsApi = $false
    },
    @{
        SourceName = "Remove-EntraBetaServicePrincipal";
        TargetName = "Remove-MgBetaServicePrincipal";
        IsApi = $false
    },
    @{
        SourceName = "Remove-EntraBetaUser";
        TargetName = "Remove-MgBetaUser";
        IsApi = $false
    },
    @{
        SourceName = "Remove-EntraBetaUserManager";
        TargetName = "Remove-MgBetaUserManagerByRef";
        IsApi = $false
    }
)