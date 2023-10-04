# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
@{
    SourceName = "Set-AzureADMSPrivilegedRoleSetting"
    TargetName = "Update-MgBetaPrivilegedAccessRoleSetting"
    Parameters = @(
        @{
            SourceName = "ProviderId"
            TargetName = "PrivilegedAccessId"
            ConversionType = "Name"
            SpecialMapping = $null
        },
        @{
            SourceName = "Id"
            TargetName = "GovernanceRoleSettingId"
            ConversionType = "Name"
            SpecialMapping = $null
        },
        @{
            SourceName = "ResourceId"
            TargetName = "ResourceId"
            ConversionType = "Name"
            SpecialMapping = $null
        }
        @{
            SourceName = "RoleDefinitionId"
            TargetName = "RoleDefinitionId"
            ConversionType = "Name"
            SpecialMapping = $null
        },
        @{
            SourceName = "AdminEligibleSettings"
            TargetName = "AdminEligibleSettings"
            ConversionType = "Name"
            SpecialMapping = $null
        },
        @{
            SourceName = "AdminMemberSettings"
            TargetName = "AdminMemberSettings"
            ConversionType = "Name"
            SpecialMapping = $null
        },
        @{
            SourceName = "UserEligibleSettings"
            TargetName = "UserEligibleSettings"
            ConversionType = "Name"
            SpecialMapping = $null
        },
        @{
            SourceName = "UserMemberSettings"
            TargetName = "UserMemberSettings"
            ConversionType = "Name"
            SpecialMapping = $null
        }
    )
    Outputs = $null
}
