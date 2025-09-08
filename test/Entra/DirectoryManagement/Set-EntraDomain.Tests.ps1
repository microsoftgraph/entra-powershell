# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
BeforeAll {  
    if((Get-Module -Name Microsoft.Entra.DirectoryManagement) -eq $null){
        
        Import-Module Microsoft.Entra.DirectoryManagement      
    }
    Import-Module (Join-Path $PSScriptRoot "..\..\Common-Functions.ps1") -Force

    Mock -CommandName Update-MgDomain -MockWith {} -ModuleName Microsoft.Entra.DirectoryManagement

    Mock -CommandName Get-EntraContext -MockWith { @{
        Environment = @{ Name = "Global" }
        Scopes      = @('Domain.ReadWrite.All')
    }} -ModuleName Microsoft.Entra.DirectoryManagement
}   

Describe "Set-EntraDomain"{
    Context "Test for Set-EntraDomain" {
        It "Should throw when not connected and not invoke SDK call" {
            Mock -CommandName Get-EntraContext -MockWith { $null } -ModuleName Microsoft.Entra.DirectoryManagement
            { Set-EntraDomain -Name "test.mail.onmicrosoft.com" -IsDefault $True -SupportedServices @("OrgIdAuthentication") } | Should -Throw "Not connected to Microsoft Graph*"
            Should -Invoke -CommandName Update-MgDomain -ModuleName Microsoft.Entra.DirectoryManagement -Times 0
        }
        
        It "Should return empty object"{
            $result = Set-EntraDomain -Name "test.mail.onmicrosoft.com" -IsDefault $True -SupportedServices @("OrgIdAuthentication")
            $result | Should -BeNullOrEmpty           

            Should -Invoke -CommandName Update-MgDomain -ModuleName Microsoft.Entra.DirectoryManagement -Times 1
        }
        It "Should fail when Name is empty" {
            { Set-EntraDomain -Name   } | Should -Throw "Missing an argument for parameter 'Name'*"

        }
        It "Should fail when Name is invalid" {
            { Set-EntraDomain -Name ""  } | Should -Throw "Cannot bind argument to parameter 'Name' because it is an empty string."

        }
        It "Should fail when SupportedServices is empty" {
            { Set-EntraDomain -Name "test.mail.onmicrosoft.com" -SupportedServices  } | Should -Throw "Missing an argument for parameter 'SupportedServices'*"

        }
        It "Should fail when -IsDefault is empty" {
            { Set-EntraDomain -Name "test.mail.onmicrosoft.com" -IsDefault  } | Should -Throw "Missing an argument for parameter 'IsDefault'*"

        }
        It "Should fail when -IsDefault is invalid" {
            { Set-EntraDomain -Name "test.mail.onmicrosoft.com" -IsDefault xyz  } | Should -Throw "Cannot process argument transformation on parameter 'IsDefault'*"

        }
        It "Should contain DomainId in parameters when passed Name to it" {
            Mock -CommandName Update-MgDomain -MockWith {$args} -ModuleName Microsoft.Entra.DirectoryManagement

            $result = Set-EntraDomain -Name "test.mail.onmicrosoft.com"
            $params = Get-Parameters -data $result
            $params.DomainId | Should -Be "test.mail.onmicrosoft.com"
        }
        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Set-EntraDomain"

            Set-EntraDomain -Name "test.mail.onmicrosoft.com"
            
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Set-EntraDomain"

            Should -Invoke -CommandName Update-MgDomain -ModuleName Microsoft.Entra.DirectoryManagement -Times 1 -ParameterFilter {
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
                { Set-EntraDomain -Name "test.mail.onmicrosoft.com" -Debug } | Should -Not -Throw
            } finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        }
    }
}            

