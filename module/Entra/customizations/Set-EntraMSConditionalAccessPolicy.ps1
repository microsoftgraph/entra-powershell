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
            if($TmpValue.Applications){
                $Applications=@{}
                $Applications["IncludeApplications"] = $TmpValue.Applications.IncludeApplications
                $Applications["ExcludeApplications"] = $TmpValue.Applications.ExcludeApplications
                $Applications["IncludeUserActions"] = $TmpValue.Applications.IncludeUserActions
                $Applications["IncludeProtectionLevels"] = $TmpValue.Applications.IncludeProtectionLevels
            }
            
            if($TmpValue.Locations){
                $Locations = @{}
                $Locations["IncludeLocations"] = $TmpValue.Locations.IncludeLocations
                $Locations["ExcludeLocations"] = $TmpValue.Locations.ExcludeLocations
            }
    
            if($TmpValue.Platforms){
                $Platforms = @{}
                $Platforms["IncludePlatforms"] = $TmpValue.Platforms.IncludePlatforms
                $Platforms["ExcludePlatforms"] = $TmpValue.Platforms.ExcludePlatforms
            }
    
            if($TmpValue.Users){
                $Users = @{}
                $Users["IncludeUsers"] = $TmpValue.Users.IncludeUsers
                $Users["ExcludeUsers"] = $TmpValue.Users.ExcludeUsers
                $Users["IncludeGroups"] = $TmpValue.Users.IncludeGroups
                $Users["ExcludeGroups"] = $TmpValue.Users.ExcludeGroups
                $Users["IncludeRoles"] = $TmpValue.Users.IncludeRoles
                $Users["ExcludeRoles"] = $TmpValue.Users.ExcludeRoles
            }
                  
            $hash = @{}
                        
            if($TmpValue.Applications) {$hash["Applications"] = $Applications }
            if($TmpValue.ClientAppTypes) { $hash["ClientAppTypes"] = $TmpValue.ClientAppTypes }
            if($TmpValue.Locations) { $hash["Locations"] = $Locations }
            if($TmpValue.Platforms) { $hash["Platforms"] = $Platforms }
            if($TmpValue.SignInRiskLevels) { $hash["SignInRiskLevels"] = $TmpValue.SignInRiskLevels }
            if($TmpValue.Users) { $hash["Users"] = $Users }
            
            $Value = $hash
'@
        }
        @{
            SourceName = "GrantControls"
            TargetName = "GrantControls"
            ConversionType = "ScriptBlock"
            SpecialMapping = @'
            $hash = @{}
            if($TmpValue._Operator) { $hash["Operator"] = $TmpValue._Operator }
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
            if($TmpValue.ApplicationEnforcedRestrictions){
                $ApplicationEnforcedRestrictions = @{}
                $ApplicationEnforcedRestrictions["IsEnabled"] = $TmpValue.ApplicationEnforcedRestrictions.IsEnabled
            }
    
            if($TmpValue.CloudAppSecurity){
                $CloudAppSecurity = @{}
                $CloudAppSecurity["IsEnabled"] = $TmpValue.CloudAppSecurity.IsEnabled
                $CloudAppSecurity["CloudAppSecurityType"] = $TmpValue.CloudAppSecurity.CloudAppSecurityType
            }
    
            if($TmpValue.PersistentBrowser){
                $PersistentBrowser = @{}
                $PersistentBrowser["IsEnabled"] = $TmpValue.PersistentBrowser.IsEnabled
                $PersistentBrowser["Mode"] = $TmpValue.PersistentBrowser.Mode
            }
    
            if($TmpValue.SignInFrequency){
                $SignInFrequency = @{}
                $SignInFrequency["IsEnabled"] = $TmpValue.SignInFrequency.IsEnabled
                $SignInFrequency["Type"] = $TmpValue.SignInFrequency.Type
                $SignInFrequency["Value"] = $TmpValue.SignInFrequency.Value
            }
            
            $hash = @{}
            if($TmpValue.ApplicationEnforcedRestrictions) { $hash["ApplicationEnforcedRestrictions"] = $ApplicationEnforcedRestrictions }
            if($TmpValue.CloudAppSecurity) { $hash["CloudAppSecurity"] = $CloudAppSecurity }
            if($TmpValue.SignInFrequency) { $hash["SignInFrequency"] = $SignInFrequency }
            if($TmpValue.PersistentBrowser) { $hash["PersistentBrowser"] = $PersistentBrowser }
    
            $Value = $hash
'@
        }
    )
    Outputs = $null
}