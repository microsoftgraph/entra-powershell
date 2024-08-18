# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
@{
    SourceName = "Set-AzureADMSRoleDefinition"
    TargetName = "Update-MgRoleManagementDirectoryRoleDefinition"
    Parameters = @(
        @{
            SourceName = "Id"
            TargetName = "UnifiedRoleDefinitionId"
            ConversionType = "Name"
            SpecialMapping = $null
        }
        @{
            SourceName = "RolePermissions"
            TargetName = "RolePermissions"
            ConversionType = "ScriptBlock"
            SpecialMapping = @'
            $Value = @()
            foreach($val in $TmpValue)
            {
                $Temp = $val | ConvertTo-Json
                $hash = @{}

                (ConvertFrom-Json $Temp).psobject.properties | Foreach { $hash[$_.Name] = $_.Value }
                $Value += $hash
            }
'@
        }
    )
    Outputs = $null
}