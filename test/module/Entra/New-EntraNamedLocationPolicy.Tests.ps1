# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
BeforeAll {  
    if ((Get-Module -Name Microsoft.Graph.Entra) -eq $null) {
        Import-Module Microsoft.Graph.Entra      
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force
    
    $scriptblock = {
        return @(
            [PSCustomObject]@{
                "Id"                   = "22cc22cc-dd33-ee44-ff55-66aa66aa66aa"
                "CreatedDateTime"      = "5/7/2024 10:52:23 AM"
                "DisplayName"          = "NamedLocation"
                "ModifiedDateTime"     = "5/7/2024 10:52:23 AM"
                "AdditionalProperties" = @{
                    "isTrusted"                         = "False"
                    "ipRanges"                          = @(
                        @{"@odata.type" = "#microsoft.graph.iPv4CidrRange"; cidrAddress = 6.5.4.1 / 30 }
                        @{"@odata.type" = "#microsoft.graph.iPv4CidrRange"; cidrAddress = 6.5.4.2 / 30 }
                    )
                    "countriesAndRegions"               = @('US', 'ID', 'CA')
                    "includeUnknownCountriesAndRegions" = "True"
                    "countryLookupMethod"               = "clientIpAddress"
                }
                "Parameters"           = $args
            }
        )
    }

    Mock -CommandName New-MgIdentityConditionalAccessNamedLocation -MockWith $scriptblock -ModuleName Microsoft.Graph.Entra
}
  
Describe "New-EntraNamedLocationPolicy" {
    Context "Test for New-EntraNamedLocationPolicy" {
        It "Should return created NamedLocationPolicy" {
            $ipRanges1 = New-Object -TypeName Microsoft.Open.MSGraph.Model.IpRange
            $ipRanges1.cidrAddress = "6.5.4.1/30"
            $ipRanges2 = New-Object -TypeName Microsoft.Open.MSGraph.Model.IpRange
            $ipRanges2.cidrAddress = "6.5.4.2/30"
            $result = New-EntraNamedLocationPolicy -OdataType "#microsoft.graph.ipNamedLocation" -DisplayName "NamedLocation" -IpRanges @($ipRanges1, $ipRanges2) -IsTrusted $false 
            $result | Should -Not -BeNullOrEmpty
            $result.Id | should -Be "22cc22cc-dd33-ee44-ff55-66aa66aa66aa"

            Should -Invoke -CommandName New-MgIdentityConditionalAccessNamedLocation  -ModuleName Microsoft.Graph.Entra -Times 1
        }
        It "Should fail when OdataType is empty" {
            { New-EntraNamedLocationPolicy -OdataType } | Should -Throw "Missing an argument for parameter 'OdataType'. Specify a parameter of type 'System.String' and try again."
        }
        It "Should fail when DisplayName is empty" {
            { New-EntraNamedLocationPolicy -DisplayName } | Should -Throw "Missing an argument for parameter 'DisplayName'. Specify a parameter of type 'System.String' and try again."
        }
        It "Should fail when IpRanges is empty" {
            { New-EntraNamedLocationPolicy -IpRanges } | Should -Throw "Missing an argument for parameter 'IpRanges'.*"
        }
        It "Should fail when IsTrusted is empty" {
            { New-EntraNamedLocationPolicy -IsTrusted } | Should -Throw "Missing an argument for parameter 'IsTrusted'.*"
        }
        It "Should fail when CountriesAndRegions is empty" {
            { New-EntraNamedLocationPolicy -CountriesAndRegions } | Should -Throw "Missing an argument for parameter 'CountriesAndRegions'.*"
        }
        It "Should fail when IncludeUnknownCountriesAndRegions is empty" {
            { New-EntraNamedLocationPolicy -IncludeUnknownCountriesAndRegions } | Should -Throw "Missing an argument for parameter 'IncludeUnknownCountriesAndRegions'.*"
        } 
        It "Result should Contain ObjectId" {
            $result = New-EntraNamedLocationPolicy -OdataType "#microsoft.graph.countryNamedLocation" -DisplayName "NamedLocation" -CountriesAndRegions @("US", "ID", "CA") -IncludeUnknownCountriesAndRegions $true
            $result.ObjectId | should -Be "22cc22cc-dd33-ee44-ff55-66aa66aa66aa"
        }     
        It "Should contain params inside BodyParameter" {              
            $result = New-EntraNamedLocationPolicy -OdataType "#microsoft.graph.countryNamedLocation" -DisplayName "NamedLocation" -CountriesAndRegions @("US", "ID", "CA") -IncludeUnknownCountriesAndRegions $true
            $params = Get-Parameters -data $result.Parameters
            $BodyParameters = $params.BodyParameter.AdditionalProperties
            $BodyParameters.includeUnknownCountriesAndRegions | Should -Be "True"
            $BodyParameters.'@odata.type' | Should -Be "#microsoft.graph.countryNamedLocation"
            $BodyParameters.countriesAndRegions | Should -Be @('US', 'ID', 'CA')
        }
        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion New-EntraNamedLocationPolicy"

            $result = New-EntraNamedLocationPolicy -OdataType "#microsoft.graph.countryNamedLocation" -DisplayName "NamedLocation" -CountriesAndRegions @("US", "ID", "CA") -IncludeUnknownCountriesAndRegions $true
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
                { New-EntraNamedLocationPolicy -OdataType "#microsoft.graph.countryNamedLocation" -DisplayName "NamedLocation" -CountriesAndRegions @("US", "ID", "CA") -IncludeUnknownCountriesAndRegions $true -Debug } | Should -Not -Throw
            } finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        }
    }
}