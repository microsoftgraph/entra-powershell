# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
@{
    SourceName = "New-AzureADMSApplicationPassword"
    TargetName = "Add-MgApplicationPassword"
    Parameters = @(
        @{
            SourceName = "PasswordCredential"
            TargetName = "PasswordCredential"
            ConversionType = "ScriptBlock"
            SpecialMapping = @'
            $hash = @{}
            $TmpValue.PSObject.Properties | ForEach-Object {
                if ($_.Value) {
                    $hash[$_.Name] = $_.Value
                }
            }

            $Value = $hash
'@
        }
    )
    Outputs = $null
}