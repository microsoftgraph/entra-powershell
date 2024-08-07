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
            if($TmpValue.DisplayName) { $hash["DisplayName"] = $TmpValue.DisplayName }
            if($TmpValue.StartDateTime) { $hash["StartDateTime"] = $TmpValue.StartDateTime }
            if($TmpValue.EndDateTime) { $hash["EndDateTime"] = $TmpValue.EndDateTime }
            if($TmpValue.KeyId) { $hash["KeyId"] = $TmpValue.KeyId }
            if($TmpValue.CustomKeyIdentifier) { $hash["CustomKeyIdentifier"] = $TmpValue.CustomKeyIdentifier }
            if($TmpValue.SecretText) { $hash["SecretText"] = $TmpValue.SecretText }
            if($TmpValue.Hint) { $hash["Hint"] = $TmpValue.Hint }

            $Value = $hash
'@
        }
    )
    Outputs = $null
}