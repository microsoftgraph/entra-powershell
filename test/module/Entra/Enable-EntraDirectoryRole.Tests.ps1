# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra) -eq $null){
        Import-Module Microsoft.Graph.Entra
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force

    Mock -CommandName New-MgDirectoryRole -MockWith {} -ModuleName Microsoft.Graph.Entra
}

Describe "Enable-EntraDirectoryRole" {
    Context "Test for Enable-EntraDirectoryRole" {
        It "Should return empty object" {
            $result = Enable-EntraDirectoryRole -RoleTemplateId 056b2531-005e-4f3e-be78-01a71ea30a04
            $result | Should -BeNullOrEmpty

            Should -Invoke -CommandName New-MgDirectoryRole -ModuleName Microsoft.Graph.Entra -Times 1
        }
        It "Should fail when RoleTemplateId is empty" {
            { Enable-EntraDirectoryRole -RoleTemplateId } | Should -Throw "Missing an argument for parameter 'RoleTemplateId'*"
        }
        It "Should contain 'User-Agent' header" {
            Mock -CommandName New-MgDirectoryRole -MockWith { $args } -ModuleName Microsoft.Graph.Entra

            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Enable-EntraDirectoryRole"

            $result = Enable-EntraDirectoryRole -RoleTemplateId 056b2531-005e-4f3e-be78-01a71ea30a04
            $params = Get-Parameters -data $result
            $params.Headers["User-Agent"] | Should -Be $userAgentHeaderValue
        } 
    }
}