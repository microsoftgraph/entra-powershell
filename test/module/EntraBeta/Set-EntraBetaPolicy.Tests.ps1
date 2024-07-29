BeforeAll {  
    if ((Get-Module -Name Microsoft.Graph.Entra.Beta) -eq $null) {
        Import-Module Microsoft.Graph.Entra.Beta    
    }
    Import-Module (Join-Path $PSScriptRoot "..\Common-Functions.ps1") -Force

    $Global:Matches = @('homeRealmDiscoveryPolicies', 'homeRealmDiscoveryPolicies')
    BeforeEach {
        $global:InvokeGraphRequestCounter = 0
    }
    $scriptblock = {
        $global:InvokeGraphRequestCounter++
        switch ($global:InvokeGraphRequestCounter) {
            1 {
                return @(
                    [PSCustomObject]@{
                        "@odata.context" = 'https://graph.microsoft.com/beta/$metadata#policies/homeRealmDiscoveryPolicies'
                    })
            }
            2 {
                return @()
                default {
                    return @()
                }
            }
        }
    }
    Mock -CommandName Invoke-GraphRequest -MockWith $scriptblock -ModuleName Microsoft.Graph.Entra.Beta
}

Describe "Set-EntraBetaPolicy" {
    Context "Test for Set-EntraBetaPolicy" {
        It "Should return updated Policy" {
            $result = Set-EntraBetaPolicy -Id "74a3bead-bfad-4839-860c-c9b248f8352b" -Definition @('{"homeRealmDiscoveryPolicies":{"AlternateLoginIDLookup":true, "IncludedUserIds":["UserID"]}}') -DisplayName "new update 13" -IsOrganizationDefault $false
            $result | Should -BeNullOrEmpty

            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }

        It "Should fail when Id is empty" {
            { Set-EntraBetaPolicy -Id   } | Should -Throw "Missing an argument for parameter 'Id'*"
        } 

        It "Should fail when Id is invalid" {
            { Set-EntraBetaPolicy -Id ""  } | Should -Throw "Cannot bind argument to parameter 'Id' because it is an empty string.*"
        } 

        It "Should fail when Definition is empty" {
            { Set-EntraBetaPolicy -Id "74a3bead-bfad-4839-860c-c9b248f8352b" -Definition   } | Should -Throw "Missing an argument for parameter 'Definition'*"
        } 

        It "Should fail when DisplayName is empty" {
            { Set-EntraBetaPolicy -Id "74a3bead-bfad-4839-860c-c9b248f8352b" -DisplayName   } | Should -Throw "Missing an argument for parameter 'DisplayName'*"
        } 

        It "Should fail when IsOrganizationDefault is empty" {
            { Set-EntraBetaPolicy -Id "74a3bead-bfad-4839-860c-c9b248f8352b" -IsOrganizationDefault   } | Should -Throw "Missing an argument for parameter 'IsOrganizationDefault'*"
        } 

        It "Should fail when IsOrganizationDefault is invalid" {
            { Set-EntraBetaPolicy -Id "74a3bead-bfad-4839-860c-c9b248f8352b" -IsOrganizationDefault ""  } | Should -Throw "Cannot process argument transformation on parameter 'IsOrganizationDefault'*"
        } 

        It "Should fail when KeyCredentials is empty" {
            { Set-EntraBetaPolicy -Id "74a3bead-bfad-4839-860c-c9b248f8352b" -KeyCredentials   } | Should -Throw "Missing an argument for parameter 'KeyCredentials'*"
        } 

        It "Should fail when KeyCredentials is invalid" {
            { Set-EntraBetaPolicy -Id "74a3bead-bfad-4839-860c-c9b248f8352b" -KeyCredentials ""  } | Should -Throw "Cannot process argument transformation on parameter 'KeyCredentials'*"
        } 

        It "Should fail when AlternativeIdentifier is empty" {
            { Set-EntraBetaPolicy -Id "74a3bead-bfad-4839-860c-c9b248f8352b" -AlternativeIdentifier   } | Should -Throw "Missing an argument for parameter 'AlternativeIdentifier'*"
        } 

        It "Should fail when Type is empty" {
            { Set-EntraBetaPolicy -Id "74a3bead-bfad-4839-860c-c9b248f8352b" -Type   } | Should -Throw "Missing an argument for parameter 'Type'*"
        } 

        It "Should return updated Policy when passes Type" {
            Mock -CommandName Invoke-GraphRequest -MockWith {} -ModuleName Microsoft.Graph.Entra.Beta
            $result = Set-EntraBetaPolicy -Id "74a3bead-bfad-4839-860c-c9b248f8352b" -Definition @('{"homeRealmDiscoveryPolicies":{"AlternateLoginIDLookup":true, "IncludedUserIds":["UserID"]}}') -Type "homeRealmDiscoveryPolicies" -DisplayName "new update 13" -IsOrganizationDefault $false
            $result | Should -BeNullOrEmpty

            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }

        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Set-EntraBetaPolicy"
            Set-EntraBetaPolicy -Id "74a3bead-bfad-4839-860c-c9b248f8352b" -Definition @('{"homeRealmDiscoveryPolicies":{"AlternateLoginIDLookup":true, "IncludedUserIds":["UserID"]}}')
            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Graph.Entra.Beta -Times 1 -ParameterFilter {
            $Headers.'User-Agent' -eq $userAgentHeaderValue -and $global:InvokeGraphRequestCounter -eq 2
            }
        }   
        AfterEach {
            $global:InvokeGraphRequestCounter = 0
        }
    }
}