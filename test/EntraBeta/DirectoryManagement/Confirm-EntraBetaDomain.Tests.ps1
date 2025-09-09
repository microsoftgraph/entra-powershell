# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
BeforeAll {  
    if((Get-Module -Name Microsoft.Entra.Beta.DirectoryManagement) -eq $null){
        Import-Module Microsoft.Entra.Beta.DirectoryManagement       
    }
    Import-Module (Join-Path $PSScriptRoot "..\..\Common-Functions.ps1") -Force
    

    Mock -CommandName Invoke-GraphRequest -MockWith {} -ModuleName Microsoft.Entra.Beta.DirectoryManagement

    Mock -CommandName Get-EntraContext -MockWith { @{
        Environment = @{ Name = "Global" }
        Scopes      = @("Domain.ReadWrite.All")
    }} -ModuleName Microsoft.Entra.Beta.DirectoryManagement
}

Describe "Confirm-EntraBetaDomain" {
    Context "Test for Confirm-EntraBetaDomain" {
        It "Should return empty object" {
            $result = Confirm-EntraBetaDomain -DomainName "Contoso.com" -ForceTakeover $true
            $result | Should -BeNullOrEmpty

            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.Beta.DirectoryManagement -Times 1
        }
        It "Should fail when DomainName is invalid" {
            { Confirm-EntraBetaDomain -DomainName "" } | Should -Throw "Cannot bind argument to parameter 'DomainName' because it is an empty string.*"
        }
        It "Should fail when DomainName is empty" {
            { Confirm-EntraBetaDomain -DomainName } | Should -Throw "Missing an argument for parameter 'DomainName'*"
        }
        It "Should fail when ForceTakeover is invalid" {
            { Confirm-EntraBetaDomain -DomainName "Contoso.com" -ForceTakeover "XY"  } | Should -Throw "Cannot process argument transformation on parameter 'ForceTakeover'*"
        }
        It "Should fail when ForceTakeover is empty" {
            { Confirm-EntraBetaDomain -DomainName "Contoso.com" -ForceTakeover } | Should -Throw "Missing an argument for parameter 'ForceTakeover'*"
        }
        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Confirm-EntraBetaDomain"
            
            Confirm-EntraBetaDomain -DomainName "Contoso.com" -ForceTakeover $true
            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.Beta.DirectoryManagement -Times 1 -ParameterFilter {
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
                { Confirm-EntraBetaDomain -DomainName "Contoso.com" -ForceTakeover $true -Debug } | Should -Not -Throw
            } finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        } 
    }
}

