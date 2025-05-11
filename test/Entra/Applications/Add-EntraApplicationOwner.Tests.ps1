# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
BeforeAll {  
    if ((Get-Module -Name Microsoft.Entra.Applications) -eq $null) {
        Import-Module Microsoft.Entra.Applications      
    }
    Import-Module (Join-Path $PSScriptRoot "..\..\Common-Functions.ps1") -Force

    Mock -CommandName Get-EntraContext -MockWith { @{
            Environment = "Global"
        } } -ModuleName Microsoft.Entra.Applications
    Mock -CommandName Get-EntraEnvironment -MockWith { return @{
            GraphEndpoint = "https://graph.microsoft.com"
        } } -ModuleName Microsoft.Entra.Applications
    Mock -CommandName New-MgApplicationOwnerByRef -MockWith {} -ModuleName Microsoft.Entra.Applications
    Mock -CommandName Get-EntraContext -MockWith { @{Scopes = @("Application.ReadWrite.All") } } -ModuleName Microsoft.Entra.Applications
}
  
Describe "Add-EntraApplicationOwner" {
    Context "Test for Add-EntraApplicationOwner" { 
        It "Should return empty object" {
            $result = Add-EntraApplicationOwner -ApplicationId "aaaaaaaa-1111-2222-3333-cccccccccccc" -OwnerId "bbbbbbbb-1111-2222-3333-cccccccccccc"
            $result | Should -BeNullOrEmpty           

            Should -Invoke -CommandName New-MgApplicationOwnerByRef -ModuleName Microsoft.Entra.Applications -Times 1
        }       
        It "Should fail when parameters are empty" {
            { Add-EntraApplicationOwner -ApplicationId "" -OwnerId "" } | Should -Throw "Cannot process argument transformation on parameter 'ApplicationId'. Cannot convert value ""*"
        }
        It "Should contain ApplicationId in parameters when passed ApplicationId to it" {              
            Mock -CommandName New-MgApplicationOwnerByRef -MockWith { $args } -ModuleName Microsoft.Entra.Applications

            $result = Add-EntraApplicationOwner -ApplicationId "aaaaaaaa-1111-2222-3333-cccccccccccc" -OwnerId "bbbbbbbb-1111-2222-3333-cccccccccccc"
            $params = Get-Parameters -data $result
            $params.ApplicationId | Should -Be "aaaaaaaa-1111-2222-3333-cccccccccccc"
        }
        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Add-EntraApplicationOwner"
            Add-EntraApplicationOwner -ApplicationId "aaaaaaaa-1111-2222-3333-cccccccccccc" -OwnerId "bbbbbbbb-1111-2222-3333-cccccccccccc" 
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Add-EntraApplicationOwner"
            Should -Invoke -CommandName New-MgApplicationOwnerByRef -ModuleName Microsoft.Entra.Applications -Times 1 -ParameterFilter {
                $Headers.'User-Agent' | Should -Be $userAgentHeaderValue
                $true
            }
        }
        It "Should execute successfully without throwing an error " {
            # Disable confirmation prompts       
            $originalDebugPreference = $DebugPreference
            $DebugPreference = 'Continue'

            try {
                # Act & Assert: Ensure the function doesn't throw an exception
                { Add-EntraApplicationOwner -ApplicationId "aaaaaaaa-1111-2222-3333-cccccccccccc" -OwnerId "bbbbbbbb-1111-2222-3333-cccccccccccc" -Debug } | Should -Not -Throw
            }
            finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        }
    }
}

