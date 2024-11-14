# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra) -eq $null){
        Import-Module Microsoft.Graph.Entra       
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force

    Mock -CommandName Update-MgIdentityConditionalAccessNamedLocation -MockWith {} -ModuleName Microsoft.Graph.Entra
}
  
Describe "Set-EntraNamedLocationPolicy" {
    Context "Test for Set-EntraNamedLocationPolicy" {
        It "Should return empty object" {
            $ipRanges1 = New-Object -TypeName Microsoft.Open.MSGraph.Model.IpRange
            $ipRanges1.cidrAddress = "6.5.4.1/30"
            $ipRanges2 = New-Object -TypeName Microsoft.Open.MSGraph.Model.IpRange
            $ipRanges2.cidrAddress = "6.5.4.2/30"
            $result = Set-EntraNamedLocationPolicy -PolicyId "1aaaaaa1-2bb2-3cc3-4dd4-5eeeeeeeeee5" -OdataType "#microsoft.graph.ipNamedLocation" -DisplayName "Mock-App policies" -IpRanges @($ipRanges1,$ipRanges2) -IsTrusted $true -Id "00aa00aa-bb11-cc22-dd33-44ee44ee44ee" -CountriesAndRegions @("US","ID","CA") -IncludeUnknownCountriesAndRegions $true
            $result | Should -BeNullOrEmpty

            Should -Invoke -CommandName Update-MgIdentityConditionalAccessNamedLocation -ModuleName Microsoft.Graph.Entra -Times 1
        }
        It "Should fail when PolicyId is empty" {
            { Set-EntraNamedLocationPolicy -PolicyId -OdataType "#microsoft.graph.ipNamedLocation" } | Should -Throw "Missing an argument for parameter 'PolicyId'*"
        }
        It "Should fail when PolicyId is invalid" {
            { Set-EntraNamedLocationPolicy -PolicyId "" -OdataType "#microsoft.graph.ipNamedLocation" } | Should -Throw "Cannot bind argument to parameter 'PolicyId' because it is an empty string*"
        }
        It "Should fail when OdataType is empty" {
            { Set-EntraNamedLocationPolicy -PolicyId "1aaaaaa1-2bb2-3cc3-4dd4-5eeeeeeeeee5" -OdataType  } | Should -Throw "Missing an argument for parameter 'OdataType'*"
        }
        It "Should fail when DisplayName is empty" {
            { Set-EntraNamedLocationPolicy -PolicyId "1aaaaaa1-2bb2-3cc3-4dd4-5eeeeeeeeee5" -DisplayName } | Should -Throw "Missing an argument for parameter 'DisplayName'*"
        }
        It "Should fail when IpRanges is empty" {
            { Set-EntraNamedLocationPolicy -PolicyId "1aaaaaa1-2bb2-3cc3-4dd4-5eeeeeeeeee5" -IpRanges  } | Should -Throw "Missing an argument for parameter 'IpRanges'*"
        }
        It "Should fail when IsTrusted is empty" {
            { Set-EntraNamedLocationPolicy -PolicyId "1aaaaaa1-2bb2-3cc3-4dd4-5eeeeeeeeee5" -IsTrusted  } | Should -Throw "Missing an argument for parameter 'IsTrusted'*"
        }
        It "Should fail when IsTrusted is invalid" {
            { Set-EntraNamedLocationPolicy -PolicyId "1aaaaaa1-2bb2-3cc3-4dd4-5eeeeeeeeee5" -IsTrusted xy } | Should -Throw "Cannot process argument transformation on parameter 'IsTrusted'*"
        }
        It "Should fail when Id is empty" {
            { Set-EntraNamedLocationPolicy -PolicyId "1aaaaaa1-2bb2-3cc3-4dd4-5eeeeeeeeee5" -Id  } | Should -Throw "Missing an argument for parameter 'Id'*"
        }
        It "Should fail when CountriesAndRegions is empty" {
            { Set-EntraNamedLocationPolicy -PolicyId "1aaaaaa1-2bb2-3cc3-4dd4-5eeeeeeeeee5" -CountriesAndRegions } | Should -Throw "Missing an argument for parameter 'CountriesAndRegions'*"
        }
        It "Should fail when CountriesAndRegions is invalid" {
            { Set-EntraNamedLocationPolicy -PolicyId "1aaaaaa1-2bb2-3cc3-4dd4-5eeeeeeeeee5" -CountriesAndRegions xy } | Should -Throw "Cannot process argument transformation on parameter 'CountriesAndRegions'*"
        }
        It "Should fail when IncludeUnknownCountriesAndRegions is empty" {
            { Set-EntraNamedLocationPolicy -PolicyId "1aaaaaa1-2bb2-3cc3-4dd4-5eeeeeeeeee5" -IncludeUnknownCountriesAndRegions  } | Should -Throw "Missing an argument for parameter 'IncludeUnknownCountriesAndRegions'*"
        }
        It "Should fail when IncludeUnknownCountriesAndRegions is invalid" {
            { Set-EntraNamedLocationPolicy -PolicyId "1aaaaaa1-2bb2-3cc3-4dd4-5eeeeeeeeee5" -IncludeUnknownCountriesAndRegions xyz } | Should -Throw "Cannot process argument transformation on parameter 'IncludeUnknownCountriesAndRegions'*"
        }
        It "Should contain NamedLocationId in parameters when passed PolicyId to it" {
            Mock -CommandName Update-MgIdentityConditionalAccessNamedLocation -MockWith {$args} -ModuleName Microsoft.Graph.Entra

            $result = Set-EntraNamedLocationPolicy -PolicyId "1aaaaaa1-2bb2-3cc3-4dd4-5eeeeeeeeee5" -OdataType "#microsoft.graph.ipNamedLocation" -DisplayName "Mock-App policies"
            $params = Get-Parameters -data $result
            $params.NamedLocationId | Should -Be "1aaaaaa1-2bb2-3cc3-4dd4-5eeeeeeeeee5"
        }
            
        It "Should contain @odata.type in bodyparameters when passed OdataId to it" {
            Set-EntraNamedLocationPolicy -PolicyId "1aaaaaa1-2bb2-3cc3-4dd4-5eeeeeeeeee5" -OdataType "#microsoft.graph.ipNamedLocation" -DisplayName "Mock-App policies"
            Should -Invoke -CommandName Update-MgIdentityConditionalAccessNamedLocation -ModuleName Microsoft.Graph.Entra -Times 1 -ParameterFilter {
                Write-Host $BodyParameter.AdditionalProperties."@odata.type" | ConvertTo-Json
                $BodyParameter.AdditionalProperties."@odata.type" | Should -Be "#microsoft.graph.ipNamedLocation"
                $true
            }
        }
        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Set-EntraNamedLocationPolicy"

            Set-EntraNamedLocationPolicy -PolicyId "1aaaaaa1-2bb2-3cc3-4dd4-5eeeeeeeeee5" -OdataType "#microsoft.graph.ipNamedLocation" -DisplayName "Mock-App policies"

            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Set-EntraNamedLocationPolicy"

            Should -Invoke -CommandName Update-MgIdentityConditionalAccessNamedLocation -ModuleName Microsoft.Graph.Entra -Times 1 -ParameterFilter {
                $Headers.'User-Agent' | Should -Be $userAgentHeaderValue
                $true
            }
        }
        It "Should execute successfully without throwing an error" {
            # Disable confirmation prompts       
            $originalDebugPreference = $DebugPreference
            $DebugPreference = 'Continue'

            try {
                # Act & Assert: Ensure the function doesn't throw an exception
                { Set-EntraNamedLocationPolicy -PolicyId "1aaaaaa1-2bb2-3cc3-4dd4-5eeeeeeeeee5" -OdataType "#microsoft.graph.ipNamedLocation" -DisplayName "Mock-App policies" -Debug } | Should -Not -Throw
            } finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        } 
    }
}