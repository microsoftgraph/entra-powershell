# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra.Beta) -eq $null){
        Import-Module Microsoft.Graph.Entra.Beta       
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force
    

$scriptblock = {
        return @{
            value = @(
                @{
                    "Id"                           = "bbbbbbbb-7777-8888-9999-cccccccccccc"
                    "DeletedDateTime"              = $null
                    "@odata.type"                  = "#microsoft.graph.policy"
                    "keyCredentials"               = $null
                    "alternativeIdentifier"        = $null
                    "displayName"                  = "Mock application policy"
                    "type"                         = "HomeRealmDiscoveryPolicy"
                    "isOrganizationDefault"        = $false 
                    "createdDateTime"              = "16-08-2023 08:25:02"      
                    "Parameters"                   = $args                
                }
            
            )
            
        }

    }

    Mock -CommandName Invoke-GraphRequest -MockWith $scriptblock -ModuleName Microsoft.Graph.Entra.Beta
}

Describe "Get-EntraBetaApplicationPolicy" {
    Context "Test for Get-EntraBetaApplicationPolicy" {
        It "Should return specific application policy" {
            $result = Get-EntraBetaApplicationPolicy -Id "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" 
            $result | Should -Not -BeNullOrEmpty
            write-host $result
            $result.Id | Should -Be "bbbbbbbb-7777-8888-9999-cccccccccccc"
            $result.displayName | Should -Be "Mock application policy"
            $result.type | Should -be "HomeRealmDiscoveryPolicy"

            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }
        It "Should fail when Id is empty" {
            { Get-EntraBetaApplicationPolicy -Id  } | Should -Throw "Missing an argument for parameter 'Id'*"
        }
        It "Should fail when Id is invalid" {
            { Get-EntraBetaApplicationPolicy -Id "" } | Should -Throw "Cannot bind argument to parameter 'Id' because it is an empty string."
        }
        It "Result should Contain @odata.type" {
            $result = Get-EntraBetaApplicationPolicy -Id "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" 
            $result."@odata.type" | should -Be "#microsoft.graph.policy"
        }
        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraBetaApplicationPolicy"

            $result = Get-EntraBetaApplicationPolicy -Id "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" 
            $result | Should -Not -BeNullOrEmpty

            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraBetaApplicationPolicy"

            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Graph.Entra.Beta -Times 1 -ParameterFilter {
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
                { Get-EntraBetaApplicationPolicy -Id "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -Debug } | Should -Not -Throw
            } finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        } 
    }
}    