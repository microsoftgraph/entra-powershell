$cmdlets = @(
    @{
        SourceName = "Remove-EntraAdministrativeUnit";
        TargetName = "Remove-MgDirectoryAdministrativeUnit";
        IsApi = $false
    },    
    @{
        SourceName = "Remove-EntraDeletedDirectoryObject";
        TargetName = "";
        IsApi = $true
    },
    @{
        SourceName = "Remove-EntraGroup";
        TargetName = "Remove-MgGroup";
        IsApi = $false
    },
    @{
        SourceName = "Remove-EntraGroupLifecyclePolicy";
        TargetName = "Remove-MgGroupLifecyclePolicy";
        IsApi = $false
    },
    @{
        SourceName = "Remove-EntraIdentityProvider";
        TargetName = "Remove-MgIdentityProvider";
        IsApi = $false
    },
    @{
        SourceName = "Remove-EntraPermissionGrantPolicy";
        TargetName = "Remove-MgPolicyPermissionGrantPolicy";
        IsApi = $false
    },
    @{
        SourceName = "Remove-EntraRoleAssignment";
        TargetName = "Remove-MgRoleManagementDirectoryRoleAssignment"
        IsApi = $false
    },
    @{
        SourceName = "Remove-EntraRoleDefinition";
        TargetName = "Remove-MgRoleManagementDirectoryRoleDefinition";
        IsApi = $false
    },
    # @{
    #     SourceName = "Remove-EntraApplication";
    #     TargetName = "Remove-MgApplication";
    #     IsApi = $false
    # },
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
    # @{
    #     SourceName = "Remove-EntraGroup";
    #     TargetName = "Remove-MgGroup";
    #     IsApi = $false
    # },
    @{
        SourceName = "Remove-EntraApplication";
        TargetName = "Remove-MgApplication";
        IsApi = $false
    },
    @{
        SourceName = "Remove-EntraApplicationKey";
        TargetName = "Remove-MgApplicationKey";
        IsApi = $false
    },
    @{
        SourceName = "Remove-EntraApplicationPassword";
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

$cmdlets2 = @(
    @{
        SourceName = "Get-EntraApplication";
        TargetName = "Get-MgApplication";
        IsApi = $false
    },
    @{
        SourceName = "Get-EntraApplicationExtensionProperty";
        TargetName = "Get-MgApplicationExtensionProperty";
        IsApi = $false
    },
    @{
        SourceName = "Get-EntraApplicationKeyCredential";
        TargetName = "";
        IsApi = $true
    },
    @{
        SourceName = "Get-EntraApplicationLogo";
        TargetName = "";
        IsApi = $true
    },
    @{
        SourceName = "Get-EntraApplicationOwner";
        TargetName = "";
        IsApi = $true
    },
    @{
        SourceName = "Get-EntraApplicationPasswordCredential";
        TargetName = "";
        IsApi = $true
    },
    @{
        SourceName = "Get-EntraApplicationServiceEndpoint";
        TargetName = "Get-MgServicePrincipalEndpoint";
        IsApi = $false
    },
    @{
        SourceName = "Get-EntraContact";
        TargetName = "Get-MgContact";
        IsApi = $false
    },
    @{
        SourceName = "Get-EntraContactDirectReport";
        TargetName = "Get-MgContactDirectReport";
        IsApi = $false
    },
    @{
        SourceName = "Get-EntraContactManager";
        TargetName = "Get-MgContactManager";
        IsApi = $false
    },
    @{
        SourceName = "Get-EntraContactMembership";
        TargetName = "Get-MgContactMemberOf";
        IsApi = $false
    },
    @{
        SourceName = "Get-EntraContract";
        TargetName = "Get-MgContract";
        IsApi = $false
    },
    @{
        SourceName = "Get-EntraDevice";
        TargetName = "Get-MgDevice";
        IsApi = $false
    },
    @{
        SourceName = "Get-EntraDeviceRegisteredOwner";
        TargetName = "";
        IsApi = $true
    },
    @{
        SourceName = "Get-EntraDeviceRegisteredUser";
        TargetName = "";
        IsApi = $true
    },
    @{
        SourceName = "Get-EntraDirectoryRole";
        TargetName = "Get-MgDirectoryRole";
        IsApi = $false
    },
    @{
        SourceName = "Get-EntraDirectoryRoleMember";
        TargetName = "";
        IsApi = $true
    },
    @{
        SourceName = "Get-EntraGroup";
        TargetName = "Get-MgGroup";
        IsApi = $false
    },
    @{
        SourceName = "Get-EntraGroupAppRoleAssignment";
        TargetName = "Get-MgGroupAppRoleAssignment";
        IsApi = $false
    },
    @{
        SourceName = "Get-EntraGroupMember";
        TargetName = "";
        IsApi = $true
    },
    @{
        SourceName = "Get-EntraGroupOwner";
        TargetName = "";
        IsApi = $true
    },
    @{
        SourceName = "Get-EntraServiceAppRoleAssignedTo";
        TargetName = "Get-MgServicePrincipalAppRoleAssignment";
        IsApi = $false
    },
    @{
        SourceName = "Get-EntraServiceAppRoleAssignment";
        TargetName = "Get-MgServicePrincipalAppRoleAssignedTo";
        IsApi = $false
    },
    @{
        SourceName = "Get-EntraServicePrincipal";
        TargetName = "Get-MgServicePrincipal";
        IsApi = $false
    },
    @{
        SourceName = "Get-EntraServicePrincipalCreatedObject";
        TargetName = "Get-MgServicePrincipalCreatedObject";
        IsApi = $false
    },
    @{
        SourceName = "Get-EntraServicePrincipalKeyCredential";
        TargetName = "";
        IsApi = $true
    },
    @{
        SourceName = "Get-EntraServicePrincipalMembership";
        TargetName = "Get-MgServicePrincipalTransitiveMemberOf";
        IsApi = $false
    },
    @{
        SourceName = "Get-EntraServicePrincipalOAuth2PermissionGrant";
        TargetName = "Get-MgServicePrincipalOauth2PermissionGrant";
        IsApi = $false
    },
    @{
        SourceName = "Get-EntraServicePrincipalOwnedObject";
        TargetName = "Get-MgServicePrincipalOwnedObject";
        IsApi = $false
    },
    @{
        SourceName = "Get-EntraServicePrincipalOwner";
        TargetName = "Get-MgServicePrincipalOwner";
        IsApi = $false
    },
    @{
        SourceName = "Get-EntraServicePrincipalPasswordCredential";
        TargetName = "";
        IsApi = $true
    },
    @{
        SourceName = "Get-EntraSubscribedSku";
        TargetName = "Get-MgSubscribedSku";
        IsApi = $false
    },
    @{
        SourceName = "Get-EntraUser";
        TargetName = "";
        IsApi = $true
    },
    @{
        SourceName = "Get-EntraUserAppRoleAssignment";
        TargetName = "Get-MgUserAppRoleAssignment";
        IsApi = $false
    },
    @{
        SourceName = "Get-EntraUserCreatedObject";
        TargetName = "Get-MgUserCreatedObject";
        IsApi = $false
    },
    @{
        SourceName = "Get-EntraUserDirectReport";
        TargetName = "";
        IsApi = $true
    },
    @{
        SourceName = "Get-EntraUserExtension";
        TargetName = "Get-MgUserExtension";
        IsApi = $false
    },
    @{
        SourceName = "Get-EntraUserLicenseDetail";
        TargetName = "Get-MgUserLicenseDetail";
        IsApi = $false
    },
    @{
        SourceName = "Get-EntraUserManager";
        TargetName = "";
        IsApi = $true
    },
    @{
        SourceName = "Get-EntraUserMembership";
        TargetName = "Get-MgUserMemberOf";
        IsApi = $true
    },
    @{
        SourceName = "Get-EntraUserOAuth2PermissionGrant";
        TargetName = "Get-MgUserOAuth2PermissionGrant";
        IsApi = $false
    },
    @{
        SourceName = "Get-EntraUserOwnedDevice";
        TargetName = "Get-MgUserOwnedDevice";
        IsApi = $false
    },
    @{
        SourceName = "Get-EntraUserOwnedObject";
        TargetName = "";
        IsApi = $true
    },
    @{
        SourceName = "Get-EntraUserRegisteredDevice";
        TargetName = "Get-MgUserRegisteredDevice";
        IsApi = $false
    },
    @{
        SourceName = "Get-EntraUserThumbnailPhoto";
        TargetName = "Get-MgUserPhoto";
        IsApi = $false
    }
)
$cmdlets3 = @(
    @{
        SourceName = "Get-EntraAdministrativeUnit";
        TargetName = "Get-MgDirectoryAdministrativeUnit";
        IsApi = $false
    },
    @{
        SourceName = "Get-EntraAdministrativeUnitMember";
        TargetName = "Get-MgDirectoryAdministrativeUnitMember";
        IsApi = $false
    },
    @{
        SourceName = "Get-EntraAttributeSet";
        TargetName = "";
        IsApi = $true
    }
    ,
    @{
        SourceName = "Get-EntraDeletedDirectoryObject";
        TargetName = "Get-MgDirectoryDeletedItem";
        IsApi = $false
    },
    @{
        SourceName = "Get-EntraDeletedGroup";
        TargetName = "Get-MgDirectoryDeletedItemAsGroup";
        IsApi = $false
    },
    @{
        SourceName = "Get-EntraGroupLifecyclePolicy";
        TargetName = "Get-MgGroupLifecyclePolicy";
        IsApi = $false
    },
    @{
        SourceName = "Get-EntraGroupPermissionGrant";
        TargetName = "Get-MgGroupPermissionGrant";
        IsApi = $false
    },
    @{
        SourceName = "Get-EntraIdentityProvider";
        TargetName = "Get-MgIdentityProvider";
        IsApi = $false
    },
    @{
        SourceName = "Get-EntraLifecyclePolicyGroup";
        TargetName = "Get-MgGroupLifecyclePolicyByGroup";
        IsApi = $false
    },
    # @{
    #     SourceName = "Get-EntraPermissionGrantConditionSet";
    #     TargetName = "Get-MgPolicyPermissionGrantPolicyInclude";
    #     IsApi = $false
    # },
    @{
        SourceName = "Get-EntraPermissionGrantPolicy";
        TargetName = "Get-MgPolicyPermissionGrantPolicy";
        IsApi = $false
    },
    @{
        SourceName = "Get-EntraPolicy";
        TargetName = "";
        IsApi = $true
    },
    @{
        SourceName = "Get-EntraRoleAssignment";
        TargetName = "Get-MgRoleManagementDirectoryRoleAssignment";
        IsApi = $false
    },
    @{
        SourceName = "Get-EntraRoleDefinition";
        TargetName = "Get-MgRoleManagementDirectoryRoleDefinition";
        IsApi = $false
    },
    @{
        SourceName = "Get-EntraScopedRoleMembership";
        TargetName = "Get-MgDirectoryAdministrativeUnitScopedRoleMember";
        IsApi = $false
    }
    # @{
    #     SourceName = "Get-EntraServicePrincipalDelegatedPermissionClassification";
    #     TargetName = "Get-MgServicePrincipalDelegatedPermissionClassification";
    #     IsApi = $false
    # }
)