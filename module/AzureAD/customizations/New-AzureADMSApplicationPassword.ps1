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
            $hash["DisplayName"] = $TmpValue.DisplayName
            $hash["StartDateTime"] = $TmpValue.StartDateTime
            $hash["EndDateTime"] = $TmpValue.EndDateTime
            $hash["KeyId"] = $TmpValue.KeyId
            $hash["CustomKeyIdentifier"] = $TmpValue.CustomKeyIdentifier
            $hash["SecretText"] = $TmpValue.SecretText
            $hash["Hint"] = $TmpValue.Hint

            $Value = $hash
'@
        }
    )
    Outputs = $null
}