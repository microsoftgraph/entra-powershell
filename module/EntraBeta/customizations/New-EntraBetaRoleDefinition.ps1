# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
@{
    SourceName = "New-AzureADMSRoleDefinition"
    TargetName = "New-MgBetaRoleManagementDirectoryRoleDefinition"
    Parameters = @(
        @{
            SourceName = "RolePermissions"
            TargetName = "RolePermissions"
            ConversionType = "ScriptBlock"
            SpecialMapping = @'
            $Temp = @{
                allowedResourceActions = $TmpValue.allowedResourceActions
                condition = $TmpValue.condition
            }
            $Value = $Temp 
'@
        }
    )
    Outputs = $null
}