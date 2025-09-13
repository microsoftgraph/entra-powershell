# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

BeforeAll {  
    if ((Get-Module -Name Microsoft.Entra.Beta.SignIns) -eq $null) {
        Import-Module Microsoft.Entra.Beta.SignIns    
    }
    Import-Module (Join-Path $PSScriptRoot "..\..\Common-Functions.ps1") -Force
    $ScriptBlock = {        
        $response = @{
            '@odata.context' = 'https://graph.microsoft.com/beta/`$metadata#policies/homeRealmDiscoveryPolicies/`$entity'            
        }

        return $response            
    }
    Mock -CommandName Invoke-GraphRequest -MockWith $scriptblock -ModuleName Microsoft.Entra.Beta.SignIns

    Mock -CommandName Get-EntraContext -MockWith { @{
        Environment = @{ Name = "Global" }
        Scopes      = @('Policy.Read.ApplicationConfiguration')
    }} -ModuleName Microsoft.Entra.Beta.SignIns
}

Describe "Remove-EntraBetaPolicy" {
    Context "Test for Remove-EntraBetaPolicy" {
        It "Should throw when not connected and not invoke graph call" {
            Mock -CommandName Get-EntraContext -MockWith { $null } -ModuleName Microsoft.Entra.Beta.SignIns
            { Remove-EntraBetaPolicy -Id "bbbbcccc-1111-dddd-2222-eeee3333ffff" } | Should -Throw "Not connected to Microsoft Graph*"
            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.Beta.SignIns -Times 0
        }

        It "Should return empty object" {
            $matches = @('permissionGrantPolicies','homeRealmDiscoveryPolicies')
            InModuleScope 'Microsoft.Entra.Beta.SignIns' -Parameters @{ Matches = $matches } {
                $result = Remove-EntraBetaPolicy -Id "bbbbcccc-1111-dddd-2222-eeee3333ffff"
                Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.Beta.SignIns -Times 2
            }
        }

        It "Should fail when Id is empty" {
            { Remove-EntraBetaPolicy -Id } | Should -Throw "Missing an argument for parameter 'Id'*"
        }   

        It "Should fail when Id is invalid" {
            { Remove-EntraBetaPolicy -Id "" } | Should -Throw "Cannot bind argument to parameter 'Id' because it is an empty string."
        }

        # Needs more investigation
        # InModuleScope - We can mock variables but not the response
        # First Invoke-GraphRequest does not have a Headers parameter
        # It "Should contain 'User-Agent' header" {
        #     $matches = @('permissionGrantPolicies','homeRealmDiscoveryPolicies')
        #     $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Remove-EntraBetaPolicy"
        #     $customHeaders = New-Object 'system.collections.generic.dictionary[string,string]'
        #     $customHeaders["User-Agent"] = $userAgentHeaderValue
        #     InModuleScope 'Microsoft.Entra.Beta.SignIns' -Parameters @{ Matches = $matches; customHeaders = $customHeaders} {
        #         $result = Remove-EntraBetaPolicy -Id "bbbbcccc-1111-dddd-2222-eeee3333ffff"
        #         $result | Should -Not -BeNullOrEmpty
        #         Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.Beta.SignIns -Times 1 -ParameterFilter {
        #             $Headers.'User-Agent' | Should -Be $customHeaders["User-Agent"]
        #             $true
        #         }
        #     }
        # }
        It "Should execute successfully without throwing an error " {
            $matches = @('permissionGrantPolicies','homeRealmDiscoveryPolicies')
            InModuleScope 'Microsoft.Entra.Beta.SignIns' -Parameters @{ Matches = $matches } {
                # Disable confirmation prompts
                $originalDebugPreference = $DebugPreference
                $DebugPreference = 'Continue'

                try {
                    # Act & Assert: Ensure the function doesn't throw an exception
                    { Remove-EntraBetaPolicy -Id "bbbbcccc-1111-dddd-2222-eeee3333ffff" -Debug } | Should -Not -Throw
                } finally {
                    # Restore original confirmation preference
                    $DebugPreference = $originalDebugPreference
                }
            }
        }
    }
}

