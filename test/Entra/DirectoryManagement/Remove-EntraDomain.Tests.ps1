# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
BeforeAll {  
    if((Get-Module -Name Microsoft.Entra.DirectoryManagement) -eq $null){
        Import-Module Microsoft.Entra.DirectoryManagement
    }
    Import-Module (Join-Path $PSScriptRoot "..\..\Common-Functions.ps1") -Force

    Mock -CommandName Remove-MgDomain -MockWith {} -ModuleName Microsoft.Entra.DirectoryManagement

    Mock -CommandName Get-EntraContext -MockWith { @{
        Environment = @{ Name = "Global" }
        Scopes      = @('Domain.ReadWrite.All')
    }} -ModuleName Microsoft.Entra.DirectoryManagement
}

Describe "Remove-EntraDomain" {
    Context "Test for Remove-EntraDomain" {
        It "Should throw when not connected and not invoke SDK call" {
            Mock -CommandName Get-EntraContext -MockWith { $null } -ModuleName Microsoft.Entra.DirectoryManagement
            { Remove-EntraDomain -Name "Contoso.com" } | Should -Throw "Not connected to Microsoft Graph*"
            Should -Invoke -CommandName Remove-MgDomain -ModuleName Microsoft.Entra.DirectoryManagement -Times 0
        }

        It "Should return empty domain name" {
            $result = Remove-EntraDomain -Name "Contoso.com"
            $result | Should -BeNullOrEmpty

            Should -Invoke -CommandName Remove-MgDomain -ModuleName Microsoft.Entra.DirectoryManagement -Times 1
        }

        It "Should fail when Name is empty" {
            { Remove-EntraDomain -Name } | Should -Throw "Missing an argument for parameter 'Name'*"
        }   

        It "Should fail when Name is invalid" {
            { Remove-EntraDomain -Name "" } | Should -Throw "Cannot bind argument to parameter 'Name' because it is an empty string."
        }   

        It "Should contain DomainId in parameters when passed Name to it" {
            Mock -CommandName Remove-MgDomain -MockWith {$args} -ModuleName Microsoft.Entra.DirectoryManagement

            $result = Remove-EntraDomain -Name "Contoso.com"
            $params = Get-Parameters -data $result
            $params.DomainId | Should -Be "Contoso.com"
        }

        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Remove-EntraDomain"

            Remove-EntraDomain -Name "Contoso.com"

            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Remove-EntraDomain"

            Should -Invoke -CommandName Remove-MgDomain -ModuleName Microsoft.Entra.DirectoryManagement -Times 1 -ParameterFilter {
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
                { Remove-EntraDomain -Name "Contoso.com" -Debug } | Should -Not -Throw
            } finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        }   
    }
}

