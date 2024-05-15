
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

    Mock -CommandName Get-MgIdentityConditionalAccessNamedLocation -MockWith $scriptblock -ModuleName Microsoft.Graph.Entra
}

Describe "Get-EntraMSNamedLocationPolicy" {
Context "Test for Get-EntraMSNamedLocationPolicy" {
        It "Should return specific Ms named location policy" {
            $result = Get-EntraMSNamedLocationPolicy -PolicyId "0baf0e3a-86b8-464f-9778-f9d39071c876"
            $result | Should -Not -BeNullOrEmpty
            $result.Id | Should -Be "0baf0e3a-86b8-464f-9778-f9d39071c876"
            $result.DisplayName | Should -Be "Mock-App policies"
            $result.AdditionalProperties."@odata.type" | Should -Be "#microsoft.graph.ipNamedLocation"

            Should -Invoke -CommandName Get-MgIdentityConditionalAccessNamedLocation  -ModuleName Microsoft.Graph.Entra -Times 1
        }
        It "Should fail when PolicyId is empty" {
            { Get-EntraMSNamedLocationPolicy -PolicyId   } | Should -Throw "Missing an argument for parameter 'PolicyId'*"
        }
        It "Should fail when PolicyId is invalid" {
            { Get-EntraMSNamedLocationPolicy -PolicyId "" } | Should -Throw "Cannot bind argument to parameter 'PolicyId' because it is an empty string."
        }
        It "Result should Contain Alias properties" {
            $result = Get-EntraMSNamedLocationPolicy -PolicyId "0baf0e3a-86b8-464f-9778-f9d39071c876"
            $result.ObjectId | should -Be "0baf0e3a-86b8-464f-9778-f9d39071c876"
        }
        It "Should contain NamedLocationId in parameters when passed PolicyId to it" {    
            
            $result = Get-EntraMSNamedLocationPolicy -PolicyId "0baf0e3a-86b8-464f-9778-f9d39071c876"
            $params = Get-Parameters -data $result.Parameters
            $params.NamedLocationId | Should -Be "0baf0e3a-86b8-464f-9778-f9d39071c876"
        }
        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraMSNamedLocationPolicy"

            $result = Get-EntraMSNamedLocationPolicy -PolicyId "0baf0e3a-86b8-464f-9778-f9d39071c876"
            $params = Get-Parameters -data $result.Parameters
            $params.Headers["User-Agent"] | Should -Be $userAgentHeaderValue
        }

    }
}   