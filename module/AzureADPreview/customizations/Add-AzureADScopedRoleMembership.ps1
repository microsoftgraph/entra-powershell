# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
@{
    SourceName = "Add-AzureADScopedRoleMembership"
    TargetName = "New-MgBetaDirectoryAdministrativeUnitScopedRoleMember"
    Parameters = @(
        @{
            SourceName = "ObjectId"
            TargetName = "AdministrativeUnitId"
            ConversionType = "Name"
            SpecialMapping = $null
        },
        @{
            SourceName = "AdministrativeUnitObjectId"
            TargetName = "AdministrativeUnitId1"
            ConversionType = "Name"
            SpecialMapping = $null
        },
        @{
            SourceName = "RoleObjectId"
            TargetName = "RoleId"
            ConversionType = "Name"
            SpecialMapping = $null
        },
        @{
            SourceName = "RoleMemberInfo"
            TargetName = "RoleMemberInfo"
            ConversionType = "ScriptBlock"
            SpecialMapping =@"
            `$Value = @{
                        id = (`$TmpValue).ObjectId
                    } | ConvertTo-Json
"@
                }
    )
    Outputs = @(
        @{
            SourceName = "RoleMemberInfo"
            TargetName = "RoleMemberInfo"
            ConversionType = "ScriptBlock"
            SpecialMapping = @"
            `$Value = `$_.RoleMemberInfo.ToJsonString()
"@
        },
        @{
            SourceName = "RoleId"
            TargetName = "RoleObjectId"
            ConversionType = "Name"
            SpecialMapping = $null
        },
        @{
            SourceName = "AdministrativeUnitId"
            TargetName = "AdministrativeUnitObjectId"
            ConversionType = "Name"
            SpecialMapping = $null
        }
    )
}