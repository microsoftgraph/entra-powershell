# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
@{
    SourceName = "Add-AzureADMSScopedRoleMembership"
    TargetName = "New-MgBetaDirectoryAdministrativeUnitScopedRoleMember"
    Parameters = @(
        @{
            SourceName = "Id"
            TargetName = "AdministrativeUnitId"
            ConversionType = "Name"
            SpecialMapping = $null
        }
        @{
            SourceName = "AdministrativeUnitId"
            TargetName = "AdministrativeUnitId1"
            ConversionType = "Name"
            SpecialMapping = $null
        }
        @{
            SourceName = "RoleMemberInfo"
            TargetName = "RoleMemberInfo"
            ConversionType = "ScriptBlock"
            SpecialMapping = @'
            $RoleMember= @{
                DisplayName = $TmpValue.DisplayName
                Id = $TmpValue.Id
            }
            $Value = $RoleMember
'@
        }
    )
    Outputs = $null
}