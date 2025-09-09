# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

BeforeAll {  
    if ((Get-Module -Name Microsoft.Entra.Beta.SignIns) -eq $null) {
        Import-Module Microsoft.Entra.Beta.SignIns    
    }
    Import-Module (Join-Path $PSScriptRoot "..\..\Common-Functions.ps1") -Force

    $scriptblock = {
        #Write-Host "Mocking Set-EntraBetaPolicy with parameters: $($args | ConvertTo-Json -Depth 3)"
        
        $response = @{
            '@odata.context' = 'https://graph.microsoft.com/beta/`$metadata#policies/homeRealmDiscoveryPolicies/`$entity'            
        }

        return $response
    }
    Mock -CommandName Invoke-GraphRequest -MockWith $scriptblock -ModuleName Microsoft.Entra.Beta.SignIns

    Mock -CommandName Get-EntraContext -MockWith { @{
        Environment = @{ Name = "Global" }
        Scopes      = @('Policy.ReadWrite.ApplicationConfiguration')
    }} -ModuleName Microsoft.Entra.Beta.SignIns
}

Describe "Set-EntraBetaPolicy" {
    Context "Test for Set-EntraBetaPolicy" {
        It "Should throw when not connected and not invoke graph call" {
            Mock -CommandName Get-EntraContext -MockWith { $null } -ModuleName Microsoft.Entra.Beta.SignIns
            { Set-EntraBetaPolicy -Id "00aa00aa-bb11-cc22-dd33-44ee44ee44ee" -Definition @('{"homeRealmDiscoveryPolicies":{"AlternateLoginIDLookup":true, "IncludedUserIds":["UserID"]}}') -DisplayName "new update 13" -IsOrganizationDefault $false } | Should -Throw "Not connected to Microsoft Graph*"
            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.Beta.SignIns -Times 0
        }

        It "Should return empty object" {
            $matches = @('permissionGrantPolicies','homeRealmDiscoveryPolicies')
            InModuleScope 'Microsoft.Entra.Beta.SignIns' -Parameters @{ Matches = $matches } {
                $result = Set-EntraBetaPolicy -Id "00aa00aa-bb11-cc22-dd33-44ee44ee44ee" -Definition @('{"homeRealmDiscoveryPolicies":{"AlternateLoginIDLookup":true, "IncludedUserIds":["UserID"]}}') -DisplayName "new update 13" -IsOrganizationDefault $false
                Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.Beta.SignIns -Times 1
            }
        }

        It "Should fail when Id is empty" {
            { Set-EntraBetaPolicy -Id   } | Should -Throw "Missing an argument for parameter 'Id'*"
        } 

        It "Should fail when Id is invalid" {
            { Set-EntraBetaPolicy -Id ""  } | Should -Throw "Cannot bind argument to parameter 'Id' because it is an empty string.*"
        } 

        It "Should fail when Definition is empty" {
            { Set-EntraBetaPolicy -Id "00aa00aa-bb11-cc22-dd33-44ee44ee44ee" -Definition   } | Should -Throw "Missing an argument for parameter 'Definition'*"
        } 

        It "Should fail when DisplayName is empty" {
            { Set-EntraBetaPolicy -Id "00aa00aa-bb11-cc22-dd33-44ee44ee44ee" -DisplayName   } | Should -Throw "Missing an argument for parameter 'DisplayName'*"
        } 

        It "Should fail when IsOrganizationDefault is empty" {
            { Set-EntraBetaPolicy -Id "00aa00aa-bb11-cc22-dd33-44ee44ee44ee" -IsOrganizationDefault   } | Should -Throw "Missing an argument for parameter 'IsOrganizationDefault'*"
        } 

        It "Should fail when IsOrganizationDefault is invalid" {
            { Set-EntraBetaPolicy -Id "00aa00aa-bb11-cc22-dd33-44ee44ee44ee" -IsOrganizationDefault ""  } | Should -Throw "Cannot process argument transformation on parameter 'IsOrganizationDefault'*"
        } 

        It "Should fail when KeyCredentials is empty" {
            { Set-EntraBetaPolicy -Id "00aa00aa-bb11-cc22-dd33-44ee44ee44ee" -KeyCredentials   } | Should -Throw "Missing an argument for parameter 'KeyCredentials'*"
        } 

        It "Should fail when KeyCredentials is invalid" {
            { Set-EntraBetaPolicy -Id "00aa00aa-bb11-cc22-dd33-44ee44ee44ee" -KeyCredentials ""  } | Should -Throw "Cannot process argument transformation on parameter 'KeyCredentials'*"
        } 

        It "Should fail when AlternativeIdentifier is empty" {
            { Set-EntraBetaPolicy -Id "00aa00aa-bb11-cc22-dd33-44ee44ee44ee" -AlternativeIdentifier   } | Should -Throw "Missing an argument for parameter 'AlternativeIdentifier'*"
        } 

        It "Should fail when Type is empty" {
            { Set-EntraBetaPolicy -Id "00aa00aa-bb11-cc22-dd33-44ee44ee44ee" -Type   } | Should -Throw "Missing an argument for parameter 'Type'*"
        } 

        It "Should return updated Policy when passes Type" {
            Mock -CommandName Invoke-GraphRequest -MockWith {} -ModuleName Microsoft.Entra.Beta.SignIns
            Set-EntraBetaPolicy -Id "00aa00aa-bb11-cc22-dd33-44ee44ee44ee" -Type "HomeRealmDiscoveryPolicy"
            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.Beta.SignIns -Times 1
        }
        It "Should contain 'User-Agent' header" {
            $matches = @('permissionGrantPolicies','homeRealmDiscoveryPolicies')
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Set-EntraBetaPolicy"
            $customHeaders = New-Object 'system.collections.generic.dictionary[string,string]'
            $customHeaders["User-Agent"] = $userAgentHeaderValue
            InModuleScope 'Microsoft.Entra.Beta.SignIns' -Parameters @{ Matches = $matches; customHeaders = $customHeaders} {
                Set-EntraBetaPolicy -Id "00aa00aa-bb11-cc22-dd33-44ee44ee44ee"  -type "HomeRealmDiscoveryPolicy"
                Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.Beta.SignIns -Times 1 -ParameterFilter {
                    $Headers.'User-Agent' | Should -Be $customHeaders["User-Agent"]
                    $true
                }
            }
        }
        It "Should execute successfully without throwing an error" {
            $matches = @('permissionGrantPolicies','homeRealmDiscoveryPolicies')
            InModuleScope 'Microsoft.Entra.Beta.SignIns' -Parameters @{ Matches = $matches } {
                # Disable confirmation prompts
                $originalDebugPreference = $DebugPreference
                $DebugPreference = 'Continue'

                try {
                    # Act & Assert: Ensure the function doesn't throw an exception
                    { Set-EntraBetaPolicy -Id "00aa00aa-bb11-cc22-dd33-44ee44ee44ee" -Debug } | Should -Not -Throw
                } finally {
                    # Restore original confirmation preference
                    $DebugPreference = $originalDebugPreference
                }
            }
        }
    }
}

