BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra) -eq $null){
        Import-Module Microsoft.Graph.Entra       
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force

    Mock -CommandName Update-MgIdentityConditionalAccessNamedLocation -MockWith {} -ModuleName Microsoft.Graph.Entra
}
  
Describe "Set-EntraMSNamedLocationPolicy" {
    Context "Test for Set-EntraMSNamedLocationPolicy" {
        It "Should return empty object" {
            $ipRanges1 = New-Object -TypeName Microsoft.Open.MSGraph.Model.IpRange
            $ipRanges1.cidrAddress = "6.5.4.1/30"
            $ipRanges2 = New-Object -TypeName Microsoft.Open.MSGraph.Model.IpRange
            $ipRanges2.cidrAddress = "6.5.4.2/30"
            $result = Set-EntraMSNamedLocationPolicy -PolicyId "0f0125ee-d1b7-4285-9124-657009f38219" -OdataType "#microsoft.graph.ipNamedLocation" -DisplayName "Mock-App policies" -IpRanges @($ipRanges1,$ipRanges2) -IsTrusted $true -Id "0f0125ee-d1b7-4285-9124-657009f38210" -CountriesAndRegions @("US","ID","CA") -IncludeUnknownCountriesAndRegions $true
            $result | Should -BeNullOrEmpty

            Should -Invoke -CommandName Update-MgIdentityConditionalAccessNamedLocation -ModuleName Microsoft.Graph.Entra -Times 1
        }
        It "Should fail when PolicyId is empty" {
            { Set-EntraMSNamedLocationPolicy -PolicyId -OdataType "#microsoft.graph.ipNamedLocation" } | Should -Throw "Missing an argument for parameter 'PolicyId'*"
        }
        It "Should fail when PolicyId is invalid" {
            { Set-EntraMSNamedLocationPolicy -PolicyId "" -OdataType "#microsoft.graph.ipNamedLocation" } | Should -Throw "Cannot bind argument to parameter 'PolicyId' because it is an empty string*"
        }
        It "Should fail when OdataType is empty" {
            { Set-EntraMSNamedLocationPolicy -PolicyId "0f0125ee-d1b7-4285-9124-657009f38219" -OdataType  } | Should -Throw "Missing an argument for parameter 'OdataType'*"
        }
        It "Should fail when DisplayName is empty" {
            { Set-EntraMSNamedLocationPolicy -PolicyId "0f0125ee-d1b7-4285-9124-657009f38219" -DisplayName } | Should -Throw "Missing an argument for parameter 'DisplayName'*"
        }
        It "Should fail when IpRanges is empty" {
            { Set-EntraMSNamedLocationPolicy -PolicyId "0f0125ee-d1b7-4285-9124-657009f38219" -IpRanges  } | Should -Throw "Missing an argument for parameter 'IpRanges'*"
        }
        It "Should fail when IsTrusted is empty" {
            { Set-EntraMSNamedLocationPolicy -PolicyId "0f0125ee-d1b7-4285-9124-657009f38219" -IsTrusted  } | Should -Throw "Missing an argument for parameter 'IsTrusted'*"
        }
        It "Should fail when IsTrusted is invalid" {
            { Set-EntraMSNamedLocationPolicy -PolicyId "0f0125ee-d1b7-4285-9124-657009f38219" -IsTrusted xy } | Should -Throw "Cannot process argument transformation on parameter 'IsTrusted'*"
        }
        It "Should fail when Id is empty" {
            { Set-EntraMSNamedLocationPolicy -PolicyId "0f0125ee-d1b7-4285-9124-657009f38219" -Id  } | Should -Throw "Missing an argument for parameter 'Id'*"
        }
        It "Should fail when CountriesAndRegions is empty" {
            { Set-EntraMSNamedLocationPolicy -PolicyId "0f0125ee-d1b7-4285-9124-657009f38219" -CountriesAndRegions } | Should -Throw "Missing an argument for parameter 'CountriesAndRegions'*"
        }
        It "Should fail when CountriesAndRegions is invalid" {
            { Set-EntraMSNamedLocationPolicy -PolicyId "0f0125ee-d1b7-4285-9124-657009f38219" -CountriesAndRegions xy } | Should -Throw "Cannot process argument transformation on parameter 'CountriesAndRegions'*"
        }
        It "Should fail when IncludeUnknownCountriesAndRegions is empty" {
            { Set-EntraMSNamedLocationPolicy -PolicyId "0f0125ee-d1b7-4285-9124-657009f38219" -IncludeUnknownCountriesAndRegions  } | Should -Throw "Missing an argument for parameter 'IncludeUnknownCountriesAndRegions'*"
        }
        It "Should fail when IncludeUnknownCountriesAndRegions is invalid" {
            { Set-EntraMSNamedLocationPolicy -PolicyId "0f0125ee-d1b7-4285-9124-657009f38219" -IncludeUnknownCountriesAndRegions xyz } | Should -Throw "Cannot process argument transformation on parameter 'IncludeUnknownCountriesAndRegions'*"
        }
        It "Should contain NamedLocationId in parameters when passed PolicyId to it" {
            Mock -CommandName Update-MgIdentityConditionalAccessNamedLocation -MockWith {$args} -ModuleName Microsoft.Graph.Entra

            $result = Set-EntraMSNamedLocationPolicy -PolicyId "0f0125ee-d1b7-4285-9124-657009f38219" -OdataType "#microsoft.graph.ipNamedLocation" -DisplayName "Mock-App policies"
            $params = Get-Parameters -data $result
            $params.NamedLocationId | Should -Be "0f0125ee-d1b7-4285-9124-657009f38219"
        }
            
        It "Should contain @odata.type in bodyparameters when passed OdataId to it" {
            Mock -CommandName Update-MgIdentityConditionalAccessNamedLocation -MockWith {$args} -ModuleName Microsoft.Graph.Entra

            $result = Set-EntraMSNamedLocationPolicy -PolicyId "0f0125ee-d1b7-4285-9124-657009f38219" -OdataType "#microsoft.graph.ipNamedLocation" -DisplayName "Mock-App policies"
            $params= $result | Convertto-json -Depth 10 | Convertfrom-json 
            $additionalProperties = $params[-1].AdditionalProperties 
            Write-Host $additionalProperties."@odata.type"
            $additionalProperties."@odata.type" | Should -Be "#microsoft.graph.ipNamedLocation"
        }
        It "Should contain 'User-Agent' header" {
            Mock -CommandName Update-MgIdentityConditionalAccessNamedLocation -MockWith {$args} -ModuleName Microsoft.Graph.Entra

            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Set-EntraMSNamedLocationPolicy"

            $result = Set-EntraMSNamedLocationPolicy -PolicyId "0f0125ee-d1b7-4285-9124-657009f38219" -OdataType "#microsoft.graph.ipNamedLocation" -DisplayName "Mock-App policies"
            $params = Get-Parameters -data $result
            $params.Headers["User-Agent"] | Should -Be $userAgentHeaderValue
        }


    }
}