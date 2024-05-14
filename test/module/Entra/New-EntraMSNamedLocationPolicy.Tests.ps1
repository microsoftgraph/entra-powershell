
BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra) -eq $null){
        Import-Module Microsoft.Graph.Entra      
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force
    
    $scriptblock = {
        return @(
            [PSCustomObject]@{
              "Id"                           = "0baf0e3a-86b8-464f-9778-f9d39071c876"
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

Describe "New-EntraMSNamedLocationPolicy" {
Context "Test for New-EntraMSNamedLocationPolicy" {
        It "Should return created Ms named location policy" {
            $ipRanges = New-Object -TypeName Microsoft.Open.MSGraph.Model.IpRange
            $ipRanges.cidrAddress = "6.5.4.1/30"
            $result = New-EntraMSNamedLocationPolicy -OdataType "#microsoft.graph.ipNamedLocation" -DisplayName "Mock-App policies" -IpRanges $ipRanges -IsTrusted $true  -CountriesAndRegions @("US","ID","CA") -IncludeUnknownCountriesAndRegions $true
            $result | Should -Not -BeNullOrEmpty
            $result.Id | Should -Be "0baf0e3a-86b8-464f-9778-f9d39071c876"
            $result.DisplayName | Should -Be "Mock-App policies"
            $result.CreatedDateTime | Should -Be "14-05-2024 09:38:07"

            Should -Invoke -CommandName New-MgIdentityConditionalAccessNamedLocation -ModuleName Microsoft.Graph.Entra -Times 1
        }
        It "Should fail when OdataType is empty" {
            { New-EntraMSNamedLocationPolicy -OdataType  } | Should -Throw "Missing an argument for parameter 'OdataType'*"
        }
        It "Should fail when DisplayName is empty" {
            { New-EntraMSNamedLocationPolicy -DisplayName } | Should -Throw "Missing an argument for parameter 'DisplayName'*"
        }
        It "Should fail when IpRanges is empty" {
            { New-EntraMSNamedLocationPolicy -IpRanges  } | Should -Throw "Missing an argument for parameter 'IpRanges'*"
        }
        It "Should fail when IsTrusted is empty" {
            { New-EntraMSNamedLocationPolicy -IsTrusted  } | Should -Throw "Missing an argument for parameter 'IsTrusted'*"
        }
        It "Should fail when IsTrusted is invalid" {
            { New-EntraMSNamedLocationPolicy -IsTrusted xy } | Should -Throw "Cannot process argument transformation on parameter 'IsTrusted'*"
        }
        It "Should fail when Id is empty" {
            { New-EntraMSNamedLocationPolicy -Id  } | Should -Throw "Missing an argument for parameter 'Id'*"
        }
        It "Should fail when CountriesAndRegions is empty" {
            { New-EntraMSNamedLocationPolicy -CountriesAndRegions } | Should -Throw "Missing an argument for parameter 'CountriesAndRegions'*"
        }
        It "Should fail when CountriesAndRegions is invalid" {
            { New-EntraMSNamedLocationPolicy -CountriesAndRegions xy } | Should -Throw "Cannot process argument transformation on parameter 'CountriesAndRegions'*"
        }
        It "Should fail when IncludeUnknownCountriesAndRegions is empty" {
            { New-EntraMSNamedLocationPolicy -IncludeUnknownCountriesAndRegions  } | Should -Throw "Missing an argument for parameter 'IncludeUnknownCountriesAndRegions'*"
        }
        It "Should fail when IncludeUnknownCountriesAndRegions is invalid" {
            { New-EntraMSNamedLocationPolicy -IncludeUnknownCountriesAndRegions xyz } | Should -Throw "Cannot process argument transformation on parameter 'IncludeUnknownCountriesAndRegions'*"
        }
        It "Result should Contain ObjectId" {
            $ipRanges = New-Object -TypeName Microsoft.Open.MSGraph.Model.IpRange
            $ipRanges.cidrAddress = "6.5.4.1/30"
            $result = New-EntraMSNamedLocationPolicy  -OdataType "#microsoft.graph.ipNamedLocation" -DisplayName "Mock-App policies" -IpRanges $ipRanges -IsTrusted $true  -CountriesAndRegions @("US","ID","CA") -IncludeUnknownCountriesAndRegions $true
            $result.ObjectId | should -Be "0baf0e3a-86b8-464f-9778-f9d39071c876"
        }
        It "Should contain @odata.type in bodyparameters when passed OdataId to it" {
            Mock -CommandName New-MgIdentityConditionalAccessNamedLocation -MockWith $scriptblock -ModuleName Microsoft.Graph.Entra

            $ipRanges = New-Object -TypeName Microsoft.Open.MSGraph.Model.IpRange
            $ipRanges.cidrAddress = "6.5.4.1/30"
            $result = New-EntraMSNamedLocationPolicy  -OdataType "#microsoft.graph.ipNamedLocation" -DisplayName "Mock-App policies" -IpRanges $ipRanges -IsTrusted $true  -CountriesAndRegions @("US","ID","CA") -IncludeUnknownCountriesAndRegions $true
            $params= $result | Convertto-json -Depth 10 | Convertfrom-json 
            $additionalProperties = $params[-1].AdditionalProperties 
            Write-Host $additionalProperties."@odata.type"
            $additionalProperties."@odata.type" | Should -Be "#microsoft.graph.ipNamedLocation"
        }
        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion New-EntraMSNamedLocationPolicy"

            $ipRanges = New-Object -TypeName Microsoft.Open.MSGraph.Model.IpRange
            $ipRanges.cidrAddress = "6.5.4.1/30"
            $result = New-EntraMSNamedLocationPolicy -OdataType "#microsoft.graph.ipNamedLocation" -DisplayName "Mock-App policies" -IpRanges $ipRanges -IsTrusted $true  -CountriesAndRegions @("US","ID","CA") -IncludeUnknownCountriesAndRegions $true
            $params = Get-Parameters -data $result.Parameters
            $params.Headers["User-Agent"] | Should -Be $userAgentHeaderValue
        }


    }

}   