# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra) -eq $null){
        Import-Module Microsoft.Graph.Entra      
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force

    Mock -CommandName Update-MgApplication -MockWith {} -ModuleName Microsoft.Graph.Entra
}

Describe "Set-EntraApplication"{
    Context "Test for Set-EntraApplication" {
        It "Should return empty object"{
            $result = Set-EntraApplication -ApplicationId bbbbbbbb-1111-2222-3333-cccccccccccc -DisplayName "Mock-App"
            $result | Should -BeNullOrEmpty           

            Should -Invoke -CommandName Update-MgApplication -ModuleName Microsoft.Graph.Entra -Times 1
        }
        It "Should fail when ApplicationId is invalid" {
            { Set-EntraApplication -ApplicationId "" } | Should -Throw "Cannot bind argument to parameter 'ApplicationId' because it is an empty string."
        }
        It "Should fail when ApplicationId is empty" {
            { Set-EntraApplication -ApplicationId } | Should -Throw "Missing an argument for parameter 'ApplicationId'*"
        } 
        It "Should contain ApplicationId in parameters when passed ApplicationId to it" {
            Mock -CommandName Update-MgApplication -MockWith {$args} -ModuleName Microsoft.Graph.Entra

            $result = Set-EntraApplication -ApplicationId bbbbbbbb-1111-2222-3333-cccccccccccc
            $params = Get-Parameters -data $result
            $params.ApplicationId | Should -Be "bbbbbbbb-1111-2222-3333-cccccccccccc"
        }
        It "Should contain 'User-Agent' header" {
            Mock -CommandName Update-MgApplication -MockWith {$args} -ModuleName Microsoft.Graph.Entra

            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Set-EntraApplication"

            $result = Set-EntraApplication -ApplicationId bbbbbbbb-1111-2222-3333-cccccccccccc
            $params = Get-Parameters -data $result
            $params.Headers["User-Agent"] | Should -Be $userAgentHeaderValue
        }
    }
}