# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
BeforeAll {
    if ((Get-Module -Name Microsoft.Entra.Beta.Users) -eq $null) {
        Import-Module Microsoft.Entra.Beta.Users      
    }
    Import-Module (Join-Path $PSScriptRoot "..\..\Common-Functions.ps1") -Force

    Mock -CommandName Invoke-GraphRequest -MockWith {} -ModuleName Microsoft.Entra.Beta.Users
    Mock -CommandName Get-EntraContext -MockWith { @{Scopes = @("User.ReadWrite.All") } } -ModuleName Microsoft.Entra.Beta.Users

}
Describe "Tests for Set-EntraBetaUserExtension" {
    It "should throw when not connected and not invoke graph call" {
        Mock -CommandName Get-EntraContext -MockWith { $null } -ModuleName Microsoft.Entra.Beta.Users
        { Set-EntraBetaUserExtension -UserId "sawyerM@contoso.com" -ExtensionName 'extension_e5e29b8a85d941eab8d12162bd004528_JobGroup' -ExtensionValue 'Job Group D' } | Should -Throw "Not connected to Microsoft Graph*"
        Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.Beta.Users -Times 0
    }

    It "Should return empty object" {
        $result = Set-EntraBetaUserExtension -UserId "sawyerM@contoso.com" -ExtensionName 'extension_e5e29b8a85d941eab8d12162bd004528_JobGroup' -ExtensionValue 'Job Group D'
        $result | Should -BeNull
    }

    It "Should fail when UserId is missing" {
        { Set-EntraBetaUserExtension -UserId } | Should -Throw "Missing an argument for parameter 'UserId'. Specify a parameter of type 'System.String' and try again."
    }
    
    It "Should contain 'User-Agent' header" {
        $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Set-EntraBetaUserExtension"
        $result = Set-EntraBetaUserExtension -UserId "sawyerM@contoso.com" -ExtensionName 'extension_e5e29b8a85d941eab8d12162bd004528_JobGroup' -ExtensionValue 'Job Group D'
        $result | Should -BeNull
        Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.Beta.Users -Times 1 -ParameterFilter {
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
            { Set-EntraBetaUserExtension -UserId "sawyerM@contoso.com" -ExtensionName 'extension_e5e29b8a85d941eab8d12162bd004528_JobGroup' -ExtensionValue 'Job Group D' -Debug } | Should -Not -Throw
        }
        finally {
            # Restore original confirmation preference            
            $DebugPreference = $originalDebugPreference        
        }
    } 
}
