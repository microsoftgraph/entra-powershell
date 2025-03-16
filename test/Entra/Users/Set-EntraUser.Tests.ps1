# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

[System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("PSAvoidUsingConvertToSecureStringWithPlainText", "")]
param()

BeforeAll {

    # Mock Get-EntraContext to always return a fake authentication context
    Mock -CommandName Get-EntraContext -MockWith { @{ IsAuthenticated = $true } }

    # Mock Get-Module to simulate the Entra module being available
    Mock -CommandName Get-Module -MockWith { @{ Name = "Microsoft.Entra.Users" } }

    if ((Get-Module -Name Microsoft.Entra.Users) -eq $null) {
        Import-Module Microsoft.Entra.Users      
    }
    Import-Module (Join-Path $PSScriptRoot "..\..\Common-Functions.ps1") -Force

    Mock -CommandName Invoke-GraphRequest -MockWith {} -ModuleName Microsoft.Entra.Users

}
Describe "Tests for Set-EntraUser" {

    It "Should return empty object" {
        $result = Set-EntraUser -UserId "sawyerM@contoso.com" -AccountEnabled $true -SkipChecks
        $result | Should -BeNull
    }

    It "Should return empty object when UserId is not provided" {
        $result = Set-EntraUser -AccountEnabled $true -SkipChecks
        $result | Should -BeNull
    }

    It "Should fail when UserId is missing" {
        { Set-EntraUser -UserId -SkipChecks} | Should -Throw "Missing an argument for parameter 'UserId'. Specify a parameter of type 'System.String' and try again."
    }
    
    It "Should contain 'User-Agent' header" {
        $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Set-EntraUser"
        $result = Set-EntraUser -UserId "sawyerM@contoso.com" -AccountEnabled $true -SkipChecks
        $result | Should -BeNull
        Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.Users -Times 1 -ParameterFilter {
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
            { Set-EntraUser -UserId "sawyerM@contoso.com" -AccountEnabled $true -SkipChecks -Debug } | Should -Not -Throw
        }
        finally {
            # Restore original confirmation preference            
            $DebugPreference = $originalDebugPreference        
        }
    } 
}
