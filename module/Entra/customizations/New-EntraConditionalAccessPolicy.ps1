# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
@{
    SourceName = "New-AzureADMSConditionalAccessPolicy"
    TargetName = "New-MgIdentityConditionalAccessPolicy"
    Parameters = @(
        @{
            SourceName = "SessionControls"
            TargetName = "SessionControls"
            ConversionType = "ScriptBlock"
            SpecialMapping = @'
            $Value = @{}
            $TmpValue.PSObject.Properties | foreach {
                $propName = $_.Name
                $propValue = $_.Value
                if ($propValue -is [System.Object]) {
                    $nestedProps = @{}
                    $propValue.PSObject.Properties | foreach {
                        $nestedPropName = $_.Name
                        $nestedPropValue = $_.Value
                        $nestedProps[$nestedPropName] = $nestedPropValue
                    }
                    $Value[$propName] = $nestedProps
                } 
            }
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
            SourceName = "Conditions"
            TargetName = "Conditions"
            ConversionType = "ScriptBlock"
            SpecialMapping = @'
            $Value = @{}
            $TmpValue.PSObject.Properties | foreach {
                $propName = $_.Name
                $propValue = $_.Value
                if ($propName -eq 'clientAppTypes') {
                    $Value[$propName] = $propValue
                }
                elseif ($propValue -is [System.Object]) {
                    $nestedProps = @{}
                    $propValue.PSObject.Properties | foreach {
                        $nestedPropName = $_.Name
                        $nestedPropValue = $_.Value
                        $nestedProps[$nestedPropName] = $nestedPropValue
                    }
                    $Value[$propName] = $nestedProps
                } 
            }
'@
        }
    )
    Outputs = $null
}
