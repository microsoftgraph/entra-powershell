# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
@{
    SourceName = "Set-AzureADMSConditionalAccessPolicy"
    TargetName = "Update-MgIdentityConditionalAccessPolicy"
    Parameters = @(
        @{
            SourceName = "Id"
            TargetName = "Id"
            ConversionType = "Name"
            SpecialMapping = $null
        }
        @{
            SourceName = "PolicyId"
            TargetName = "ConditionalAccessPolicyId"
            ConversionType = "Name"
            SpecialMapping = $null
        }
        @{
            SourceName = "Conditions"
            TargetName = "Conditions"
            ConversionType = "ScriptBlock"
            SpecialMapping = @'
            $hash = @{}
            $hash["Applications"] = $TmpValue.Applications 
            $hash["ClientAppTypes"] = $TmpValue.ClientAppTypes 
            $hash["Locations"] = $TmpValue.Locations 
            $hash["Platforms"] = $TmpValue.Platforms 
            $hash["SignInRiskLevels"] = $TmpValue.SignInRiskLevels 
            $hash["Users"] = $TmpValue.Users 

            $Value = $hash
'@
        }
        @{
            SourceName = "GrantControls"
            TargetName = "GrantControls"
            ConversionType = "ScriptBlock"
            SpecialMapping = @'
            $hash = @{}
            $hash["Operator"] = $TmpValue._Operator 
            $hash["BuiltInControls"] = $TmpValue.BuiltInControls 
            $hash["CustomAuthenticationFactors"] = $TmpValue.CustomAuthenticationFactors 
            $hash["TermsOfUse"] = $TmpValue.TermsOfUse 

            $Value = $hash
'@
        }
        @{
            SourceName = "SessionControls"
            TargetName = "SessionControls"
            ConversionType = "ScriptBlock"
            SpecialMapping = @'
            $hash = @{}
            $hash["ApplicationEnforcedRestrictions"] = $TmpValue.ApplicationEnforcedRestrictions 
            $hash["CloudAppSecurity"] = $TmpValue.CloudAppSecurity 
            $hash["SignInFrequency"] = $TmpValue.SignInFrequency 
            $hash["PersistentBrowser"] = $TmpValue.PersistentBrowser 

            $Value = $hash
'@
        }
    )
    Outputs = $null
}