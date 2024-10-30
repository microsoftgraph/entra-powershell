# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra.Applications) -eq $null){
        Import-Module Microsoft.Graph.Entra.Applications
    }
    Import-Module (Join-Path $PSScriptRoot "..\..\build\Common-Functions.ps1") -Force

    Mock -CommandName Remove-MgApplication -MockWith {} -ModuleName Microsoft.Graph.Entra.Applications
}

Describe "Remove-EntraApplication" {
    Context "Test for Remove-EntraApplication" {
        It "Should return empty object" {
            $result = Remove-EntraApplication -ApplicationId "bbbbbbbb-1111-2222-3333-cccccccccccc"
            $result | Should -BeNullOrEmpty

            Should -Invoke -CommandName Remove-MgApplication -ModuleName Microsoft.Graph.Entra.Applications -Times 1
        }
        It "Should execute successfully with Alias" {
            $result = Remove-EntraApplication -ObjectId "bbbbbbbb-1111-2222-3333-cccccccccccc"
            $result | Should -BeNullOrEmpty

            Should -Invoke -CommandName Remove-MgApplication -ModuleName Microsoft.Graph.Entra.Applications -Times 1
        }
        It "Should fail when ApplicationId is invalid" {
            { Remove-EntraApplication -ApplicationId "" } | Should -Throw "Cannot bind argument to parameter 'ApplicationId' because it is an empty string."
        }
        It "Should fail when ApplicationId is empty" {
            { Remove-EntraApplication -ApplicationId } | Should -Throw "Missing an argument for parameter 'ApplicationId'*"
        }   
        It "Should contain ApplicationId in parameters when passed ApplicationId to it" {
            Mock -CommandName Remove-MgApplication -MockWith {$args} -ModuleName Microsoft.Graph.Entra.Applications

            $result = Remove-EntraApplication -ApplicationId "bbbbbbbb-1111-2222-3333-cccccccccccc"
            $params = Get-Parameters -data $result
            $params.ApplicationId | Should -Be "bbbbbbbb-1111-2222-3333-cccccccccccc"
        }
        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Remove-EntraApplication"

            Remove-EntraApplication -ApplicationId bbbbbbbb-1111-2222-3333-cccccccccccc
            Should -Invoke -CommandName Remove-MgApplication -ModuleName Microsoft.Graph.Entra.Applications -Times 1 -ParameterFilter {
                $Headers.'User-Agent' | Should -Be $userAgentHeaderValue
                $true
            }
        } 
    }
}
