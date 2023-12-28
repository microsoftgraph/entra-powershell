# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
@{
    SourceName = "New-AzureADServicePrincipal"
    TargetName = "New-MgBetaServicePrincipal"
    Parameters = @(
        @{
            SourceName = "AccountEnabled"
            TargetName = "AccountEnabled"
            ConversionType = "ScriptBlock"
            SpecialMapping = @'
            $Value = [System.Convert]::ToBoolean($TmpValue)
'@
        },
        @{
            SourceName = "KeyCredentials"
            TargetName = "KeyCredentials"
            ConversionType = "ScriptBlock"
            SpecialMapping = @'
            $a = @()
            $input = $TmpValue
            foreach($v in $input)
            {
                $hash = @{
                    CustomKeyIdentifier= $v.CustomKeyIdentifier
                    EndDateTime = $v.EndDate
                    Key= $v.Value
                    StartDateTime= $v.StartDate
                    Type= $v.Type
                    Usage= $v.Usage
                }
                
                $a += $hash
            }
            $Value = $a
'@
        },
        @{
            SourceName = "PasswordCredentials"
            TargetName = "PasswordCredentials"
            ConversionType = "ScriptBlock"
            SpecialMapping = @'
            $a = @()
            $input = $TmpValue
            foreach($v in $input)
            {
                $hash = @{
                    CustomKeyIdentifier= $v.CustomKeyIdentifier
                    EndDateTime = $v.EndDate
                    SecretText= $v.Value
                    StartDateTime= $v.StartDate
                }
                
                $a += $hash
            }
            $Value = $a
'@
        }
    )
    Outputs = $null
}