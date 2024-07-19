# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
@{
    SourceName = "Set-AzureADMSAuthorizationPolicy"
    TargetName = "Update-MgBetaPolicyAuthorizationPolicy"
    Parameters = @(
        @{
            SourceName = "DefaultUserRolePermissions"
            TargetName = "DefaultUserRolePermissions"
            ConversionType = "ScriptBlock"
            SpecialMapping = @'
            $hash = @{}
            $hash["AllowedToCreateApps"] = $TmpValue.AllowedToCreateApps 
            $hash["AllowedToCreateSecurityGroups"] = $TmpValue.AllowedToCreateSecurityGroups 
            $hash["AllowedToReadOtherUsers"] = $TmpValue.AllowedToReadOtherUsers 
            
            $Value = $hash
'@
        }
    )
    Outputs = $null
}