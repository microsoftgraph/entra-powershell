BeforeAll {  
    if ((Get-Module -Name Microsoft.Graph.Entra) -eq $null) {
        Import-Module Microsoft.Graph.Entra      
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force
    
    $scriptblock = {
        return @(
            [PSCustomObject]@{
                "Id"                   = "04fee326-10cf-4211-8edd-d2bd3f4a9a9c"
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
  
Describe "New-EntraMSNamedLocationPolicy " {
    Context "Test for New-EntraMSNamedLocationPolicy" {
        It "Should return created NamedLocationPolicy" {
            $ipRanges1 = New-Object -TypeName Microsoft.Open.MSGraph.Model.IpRange
            $ipRanges1.cidrAddress = "6.5.4.1/30"
            $ipRanges2 = New-Object -TypeName Microsoft.Open.MSGraph.Model.IpRange
            $ipRanges2.cidrAddress = "6.5.4.2/30"
            $result = New-EntraMSNamedLocationPolicy -OdataType "#microsoft.graph.ipNamedLocation" -DisplayName "NamedLocation" -IpRanges @($ipRanges1, $ipRanges2) -IsTrusted $false 
            $result | Should -Not -BeNullOrEmpty
            $result.Id | should -Be "04fee326-10cf-4211-8edd-d2bd3f4a9a9c"

            Should -Invoke -CommandName New-MgIdentityConditionalAccessNamedLocation  -ModuleName Microsoft.Graph.Entra -Times 1
        }
        It "Should fail when OdataType is empty" {
            { New-EntraMSNamedLocationPolicy -OdataType } | Should -Throw "Missing an argument for parameter 'OdataType'. Specify a parameter of type 'System.String' and try again."
        }
        It "Should fail when DisplayName is empty" {
            { New-EntraMSNamedLocationPolicy -DisplayName } | Should -Throw "Missing an argument for parameter 'DisplayName'. Specify a parameter of type 'System.String' and try again."
        }
        It "Should fail when IpRanges is empty" {
            { New-EntraMSNamedLocationPolicy -IpRanges } | Should -Throw "Missing an argument for parameter 'IpRanges'.*"
        }
        It "Should fail when IsTrusted is empty" {
            { New-EntraMSNamedLocationPolicy -IsTrusted } | Should -Throw "Missing an argument for parameter 'IsTrusted'.*"
        }
        It "Should fail when CountriesAndRegions is empty" {
            { New-EntraMSNamedLocationPolicy -CountriesAndRegions } | Should -Throw "Missing an argument for parameter 'CountriesAndRegions'.*"
        }
        It "Should fail when IncludeUnknownCountriesAndRegions is empty" {
            { New-EntraMSNamedLocationPolicy -IncludeUnknownCountriesAndRegions } | Should -Throw "Missing an argument for parameter 'IncludeUnknownCountriesAndRegions'.*"
        } 
        It "Result should Contain ObjectId" {
            $result = New-EntraMSNamedLocationPolicy -OdataType "#microsoft.graph.countryNamedLocation" -DisplayName "NamedLocation" -CountriesAndRegions @("US", "ID", "CA") -IncludeUnknownCountriesAndRegions $true
            $result.ObjectId | should -Be "04fee326-10cf-4211-8edd-d2bd3f4a9a9c"
        }     
        It "Should contain params inside BodyParameter" {              
            $result = New-EntraMSNamedLocationPolicy -OdataType "#microsoft.graph.countryNamedLocation" -DisplayName "NamedLocation" -CountriesAndRegions @("US", "ID", "CA") -IncludeUnknownCountriesAndRegions $true
            $params = Get-Parameters -data $result.Parameters
            $BodyParameters = $params.BodyParameter.AdditionalProperties
            $BodyParameters.includeUnknownCountriesAndRegions | Should -Be "True"
            $BodyParameters.'@odata.type' | Should -Be "#microsoft.graph.countryNamedLocation"
            $BodyParameters.countriesAndRegions | Should -Be @('US', 'ID', 'CA')
        }
        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion New-EntraMSNamedLocationPolicy"

            $result = New-EntraMSNamedLocationPolicy -OdataType "#microsoft.graph.countryNamedLocation" -DisplayName "NamedLocation" -CountriesAndRegions @("US", "ID", "CA") -IncludeUnknownCountriesAndRegions $true
            $params = Get-Parameters -data $result.Parameters
            $params.Headers["User-Agent"] | Should -Be $userAgentHeaderValue
        }
    }
}