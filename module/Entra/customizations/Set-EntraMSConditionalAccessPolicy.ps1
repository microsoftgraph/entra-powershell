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
            if($TmpValue.Applications) { $hash["Applications"] = $TmpValue.Applications }
            if($TmpValue.ClientAppTypes) { $hash["ClientAppTypes"] = $TmpValue.ClientAppTypes }
            if($TmpValue.Locations) { $hash["Locations"] = $TmpValue.Locations }
            if($TmpValue.Platforms) { $hash["Platforms"] = $TmpValue.Platforms }
            if($TmpValue.SignInRiskLevels) { $hash["SignInRiskLevels"] = $TmpValue.SignInRiskLevels }
            if($TmpValue.Users) { $hash["Users"] = $TmpValue.Users }

            $Value = $hash
'@
        }
        @{
            SourceName = "GrantControls"
            TargetName = "GrantControls"
            ConversionType = "ScriptBlock"
            SpecialMapping = @'
            $hash = @{}
            if($TmpValue._Operator) { $hash["_Operator"] = $TmpValue._Operator }
            if($TmpValue.BuiltInControls) { $hash["BuiltInControls"] = $TmpValue.BuiltInControls }
            if($TmpValue.CustomAuthenticationFactors) { $hash["CustomAuthenticationFactors"] = $TmpValue.CustomAuthenticationFactors }
            if($TmpValue.TermsOfUse) { $hash["TermsOfUse"] = $TmpValue.TermsOfUse }

            $Value = $hash
'@
        }
        @{
            SourceName = "SessionControls"
            TargetName = "SessionControls"
            ConversionType = "ScriptBlock"
            SpecialMapping = @'
            $hash = @{}
            if($TmpValue.ApplicationEnforcedRestrictions) { $hash["ApplicationEnforcedRestrictions"] = $TmpValue.ApplicationEnforcedRestrictions }
            if($TmpValue.CloudAppSecurity) { $hash["CloudAppSecurity"] = $TmpValue.CloudAppSecurity }
            if($TmpValue.SignInFrequency) { $hash["SignInFrequency"] = $TmpValue.SignInFrequency }
            if($TmpValue.PersistentBrowser) { $hash["PersistentBrowser"] = $TmpValue.PersistentBrowser }

            $Value = $hash
'@
        }
    )
    Outputs = $null
}