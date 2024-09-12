# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra) -eq $null){
        Import-Module Microsoft.Graph.Entra      
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force
    
    $scriptblock = {
        return @(
            [PSCustomObject]@{
              "Id"                           = "11bb11bb-cc22-dd33-ee44-55ff55ff55ff"
              "DisplayName"                  = "Mock-App policies"
              "CreatedDateTime"              = "14-05-2024 09:38:07"
              "ModifiedDateTime"             = "14-05-2024 09:38:07"
              "AdditionalProperties"         = @{
                                                  "@odata.context" = "https://graph.microsoft.com/v1.0/$metadata#identity/conditionalAccess/namedLocations/$entity"
                                                  "@odata.type"    = "#microsoft.graph.ipNamedLocation"
                                                  "isTrusted"      = $true
                                                  "ipRanges"       = @{
                                                                        "@odata.type" = "#microsoft.graph.iPv4CidrRange"
                                                                        "cidrAddress" = "6.5.4.1/30"
                                                                    }
                                                }
              "Parameters"                   = $args
            }
        )
    }

    Mock -CommandName New-MgIdentityConditionalAccessNamedLocation -MockWith $scriptblock -ModuleName Microsoft.Graph.Entra
}

Describe "New-EntraNamedLocationPolicy" {
Context "Test for New-EntraNamedLocationPolicy" {
        It "Should return created Ms named location policy" {
            $ipRanges = New-Object -TypeName Microsoft.Open.MSGraph.Model.IpRange
            $ipRanges.cidrAddress = "6.5.4.1/30"
            $result = New-EntraNamedLocationPolicy -OdataType "#microsoft.graph.ipNamedLocation" -DisplayName "Mock-App policies" -IpRanges $ipRanges -IsTrusted $true  -CountriesAndRegions @("US","ID","CA") -IncludeUnknownCountriesAndRegions $true
            $result | Should -Not -BeNullOrEmpty
            $result.Id | Should -Be "11bb11bb-cc22-dd33-ee44-55ff55ff55ff"
            $result.DisplayName | Should -Be "Mock-App policies"
            $result.CreatedDateTime | Should -Be "14-05-2024 09:38:07"

            Should -Invoke -CommandName New-MgIdentityConditionalAccessNamedLocation -ModuleName Microsoft.Graph.Entra -Times 1
        }
        It "Should fail when OdataType is empty" {
            { New-EntraNamedLocationPolicy -OdataType  } | Should -Throw "Missing an argument for parameter 'OdataType'*"
        }
        It "Should fail when DisplayName is empty" {
            { New-EntraNamedLocationPolicy -DisplayName } | Should -Throw "Missing an argument for parameter 'DisplayName'*"
        }
        It "Should fail when IpRanges is empty" {
            { New-EntraNamedLocationPolicy -IpRanges  } | Should -Throw "Missing an argument for parameter 'IpRanges'*"
        }
        It "Should fail when IsTrusted is empty" {
            { New-EntraNamedLocationPolicy -IsTrusted  } | Should -Throw "Missing an argument for parameter 'IsTrusted'*"
        }
        It "Should fail when IsTrusted is invalid" {
            { New-EntraNamedLocationPolicy -IsTrusted xy } | Should -Throw "Cannot process argument transformation on parameter 'IsTrusted'*"
        }
        It "Should fail when Id is empty" {
            { New-EntraNamedLocationPolicy -Id  } | Should -Throw "Missing an argument for parameter 'Id'*"
        }
        It "Should fail when CountriesAndRegions is empty" {
            { New-EntraNamedLocationPolicy -CountriesAndRegions } | Should -Throw "Missing an argument for parameter 'CountriesAndRegions'*"
        }
        It "Should fail when CountriesAndRegions is invalid" {
            { New-EntraNamedLocationPolicy -CountriesAndRegions xy } | Should -Throw "Cannot process argument transformation on parameter 'CountriesAndRegions'*"
        }
        It "Should fail when IncludeUnknownCountriesAndRegions is empty" {
            { New-EntraNamedLocationPolicy -IncludeUnknownCountriesAndRegions  } | Should -Throw "Missing an argument for parameter 'IncludeUnknownCountriesAndRegions'*"
        }
        It "Should fail when IncludeUnknownCountriesAndRegions is invalid" {
            { New-EntraNamedLocationPolicy -IncludeUnknownCountriesAndRegions xyz } | Should -Throw "Cannot process argument transformation on parameter 'IncludeUnknownCountriesAndRegions'*"
        }
        It "Result should Contain ObjectId" {
            $ipRanges = New-Object -TypeName Microsoft.Open.MSGraph.Model.IpRange
            $ipRanges.cidrAddress = "6.5.4.1/30"
            $result = New-EntraNamedLocationPolicy  -OdataType "#microsoft.graph.ipNamedLocation" -DisplayName "Mock-App policies" -IpRanges $ipRanges -IsTrusted $true  -CountriesAndRegions @("US","ID","CA") -IncludeUnknownCountriesAndRegions $true
            $result.ObjectId | should -Be "11bb11bb-cc22-dd33-ee44-55ff55ff55ff"
        }
        It "Should contain @odata.type in bodyparameters when passed OdataId to it" {
            Mock -CommandName New-MgIdentityConditionalAccessNamedLocation -MockWith $scriptblock -ModuleName Microsoft.Graph.Entra

            $ipRanges = New-Object -TypeName Microsoft.Open.MSGraph.Model.IpRange
            $ipRanges.cidrAddress = "6.5.4.1/30"
            $result = New-EntraNamedLocationPolicy  -OdataType "#microsoft.graph.ipNamedLocation" -DisplayName "Mock-App policies" -IpRanges $ipRanges -IsTrusted $true  -CountriesAndRegions @("US","ID","CA") -IncludeUnknownCountriesAndRegions $true
            $params= $result | Convertto-json -Depth 10 | Convertfrom-json 
            $additionalProperties = $params[-1].AdditionalProperties 
            $additionalProperties."@odata.type" | Should -Be "#microsoft.graph.ipNamedLocation"
        }
        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion New-EntraNamedLocationPolicy"

            $result = New-EntraNamedLocationPolicy  -OdataType "#microsoft.graph.ipNamedLocation" -DisplayName "Mock-App policies" -IpRanges $ipRanges -IsTrusted $true  -CountriesAndRegions @("US","ID","CA") -IncludeUnknownCountriesAndRegions $true
            $result | Should -Not -BeNullOrEmpty

            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion New-EntraNamedLocationPolicy"

            Should -Invoke -CommandName New-MgIdentityConditionalAccessNamedLocation -ModuleName Microsoft.Graph.Entra -Times 1 -ParameterFilter {
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
                { New-EntraNamedLocationPolicy -OdataType "#microsoft.graph.ipNamedLocation" -DisplayName "Mock-App policies" -IpRanges $ipRanges -IsTrusted $true  -CountriesAndRegions @("US","ID","CA") -IncludeUnknownCountriesAndRegions $true -Debug } | Should -Not -Throw
            } finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }        
        }

    }
}   