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
                    "Id"                           = "bbbbbbbb-1111-2222-3333-cccccccccccc"
                    "AppId"                        = "dddddddd-1111-2222-3333-aaaaaaaaaaaa"
                    "AppDisplayName"               = "Mock Portal"
                    "AggregatedEventDateTime"      = "29-05-2024 00:00:00"
                    "SignInCount"                  = "3"
                    "isOrganizationDefault"        = $false 
                    "createdDateTime"              = "16-08-2023 08:25:02"      
                    "Parameters"                   = $args                
                }
            
            )
            
        }

    }

    Mock -CommandName Invoke-GraphRequest -MockWith $scriptblock -ModuleName Microsoft.Graph.Entra.Beta
}

Describe "Get-EntraBetaApplicationSignInSummary" {
    Context "Test for Get-EntraBetaApplicationSignInSummary" {
        It "Should return application sign in summary" {
            $result = Get-EntraBetaApplicationSignInSummary -Days "30" 
            $result | Should -Not -BeNullOrEmpty
            $result.Id | Should -Be "bbbbbbbb-1111-2222-3333-cccccccccccc"
            $result.AppDisplayName | Should -Be "Mock Portal"
            $result.AppId | Should -be "dddddddd-1111-2222-3333-aaaaaaaaaaaa"

            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }
        It "Should fail when Days is empty" {
            { Get-EntraBetaApplicationSignInSummary -Days   } | Should -Throw "Missing an argument for parameter 'Days'*"
        }
        It "Should return specific application signed in summary by filter" {
            $result = Get-EntraBetaApplicationSignInSummary -Days "7" -Filter "AppdisplayName eq 'Mock Portal'"
            $result | Should -Not -BeNullOrEmpty
            $result.AppDisplayName | Should -Be "Mock Portal"

            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }
        It "Should fail when filter is empty" {
            { Get-EntraBetaApplicationSignInDetailedSummary -Filter  } | Should -Throw "Missing an argument for parameter 'Filter'*"
        }
        It "Should return top 1 application sign in summary" {
            $result = Get-EntraBetaApplicationSignInSummary -Days "7" -Top 1
            $result | Should -Not -BeNullOrEmpty
            $result.Id | Should -Be "bbbbbbbb-1111-2222-3333-cccccccccccc"

            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }
        It "Should fail when Top is empty" {
            { Get-EntraBetaApplicationSignInSummary -Days "7" -Top  } | Should -Throw "Missing an argument for parameter 'Top'*"
        }
         It "Should fail when Top is invalid" {
            { Get-EntraBetaApplicationSignInSummary -Days "7" -Top XY } | Should -Throw "Cannot process argument transformation on parameter 'Top'*"
        }
        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraBetaApplicationSignInSummary"

            $result = Get-EntraBetaApplicationSignInSummary -Days "30"
            $result | Should -Not -BeNullOrEmpty
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
                { Get-EntraBetaApplicationSignInSummary -Days "30"  -Debug } | Should -Not -Throw
            } finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        } 

    }
}        