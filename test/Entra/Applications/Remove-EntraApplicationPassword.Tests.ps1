# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
BeforeAll {  
    if ((Get-Module -Name Microsoft.Entra.Applications) -eq $null) {
        Import-Module Microsoft.Entra.Applications       
    }
    Import-Module (Join-Path $PSScriptRoot "..\..\Common-Functions.ps1") -Force

    Mock -CommandName Remove-MgApplicationPassword -MockWith {} -ModuleName Microsoft.Entra.Applications
}

Describe "Remove-EntraApplicationPassword" {
    It "Should return empty object" {
        $result = Remove-EntraApplicationPassword -ApplicationId "aaaaaaaa-bbbb-cccc-1111-222222222222" -KeyId "aaaaaaaa-0b0b-1c1c-2d2d-333333333333"
        $result | Should -BeNullOrEmpty
        Should -Invoke -CommandName Remove-MgApplicationPassword -ModuleName Microsoft.Entra.Applications -Times 1
    }
    It "Should fail when ApplicationId is empty" {
        { Remove-EntraApplicationPassword -ApplicationId "" } | Should -Throw "Cannot validate argument on parameter 'ApplicationId'. The argument is null or empty. Provide an argument that is not null or empty, and then try the command again."
    }
    It "Should fail when ApplicationId is null" {
        { Remove-EntraApplicationPassword -ApplicationId } | Should -Throw "Missing an argument for parameter 'ApplicationId'*"
    }    
    It "Should fail when KeyId is null" {
        { Remove-EntraApplicationPassword -ApplicationId "aaaaaaaa-bbbb-cccc-1111-222222222222" -KeyId } | Should -Throw "Missing an argument for parameter 'KeyId'*"
    }    
    It "Should fail when invalid parameter is passed" {
        { Remove-EntraApplicationPassword -DisplayName "abc" } | Should -Throw "A parameter cannot be found that matches parameter name 'DisplayName'."
    }
    It "Should contain ApplicationId in parameters when passed ApplicationId to it" {
        Mock -CommandName Remove-MgApplicationPassword -MockWith { $args } -ModuleName Microsoft.Entra.Applications
        $result = Remove-EntraApplicationPassword -ApplicationId "aaaaaaaa-bbbb-cccc-1111-222222222222" -KeyId "aaaaaaaa-0b0b-1c1c-2d2d-333333333333"
        $params = Get-Parameters -data $result
        $params.ApplicationId | Should -Be "aaaaaaaa-bbbb-cccc-1111-222222222222"
    }
    It "Should contain 'User-Agent' header" {
        $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Remove-EntraApplicationPassword"
        $result = Remove-EntraApplicationPassword -ApplicationId "aaaaaaaa-bbbb-cccc-1111-222222222222" -KeyId "aaaaaaaa-0b0b-1c1c-2d2d-333333333333"
        $result | Should -BeNullOrEmpty
        $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Remove-EntraApplicationPassword"
        Should -Invoke -CommandName Remove-MgApplicationPassword -ModuleName Microsoft.Entra.Applications -Times 1 -ParameterFilter {
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
            { Remove-EntraApplicationPassword -ApplicationId "aaaaaaaa-bbbb-cccc-1111-222222222222" -KeyId "aaaaaaaa-0b0b-1c1c-2d2d-333333333333" -Debug } | Should -Not -Throw
        }
        finally {
            # Restore original confirmation preference            
            $DebugPreference = $originalDebugPreference        
        }
    }
}

