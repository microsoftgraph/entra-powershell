# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

BeforeAll{
    if((Get-Module -Name Microsoft.Graph.Entra) -eq $null){
        Import-Module Microsoft.Graph.Entra      
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force

    Mock -CommandName Invoke-GraphRequest -MockWith {} -ModuleName Microsoft.Graph.Entra

    $CurrentPassword = ConvertTo-SecureString 'test@123' -AsPlainText -Force
    $NewPassword = ConvertTo-SecureString 'test@1234' -AsPlainText -Force
}
Describe "Tests for Update-EntraSignedInUserPassword"{
    Context "Test for Update-EntraSignedInUserPassword" {
    It "should return empty object"{
        $result = Update-EntraSignedInUserPassword -CurrentPassword $CurrentPassword -NewPassword $NewPassword
        $result | Should -BeNullOrEmpty
        Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Graph.Entra -Times 1
    }
    It "Should fail when CurrentPassword is null" {
        { Update-EntraSignedInUserPassword -CurrentPassword } | Should -Throw "Missing an argument for parameter 'CurrentPassword'*"
    }  
    It "Should fail when CurrentPassword is empty" {
        { Update-EntraSignedInUserPassword -CurrentPassword "" } | Should -Throw "Cannot process argument transformation on parameter 'CurrentPassword'*"
    }
    It "Should fail when NewPassword is null" {
        { Update-EntraSignedInUserPassword -NewPassword } | Should -Throw "Missing an argument for parameter 'NewPassword'*"
    }  
    It "Should fail when NewPassword is empty" {
        { Update-EntraSignedInUserPassword -NewPassword "" } | Should -Throw "Cannot process argument transformation on parameter 'NewPassword'*"
    }

    It "Should contain 'User-Agent' header" {
        $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Update-EntraSignedInUserPassword"

        Update-EntraSignedInUserPassword -CurrentPassword $CurrentPassword -NewPassword $NewPassword

        $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Update-EntraSignedInUserPassword"

        Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Graph.Entra -Times 1 -ParameterFilter {
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
                { 
                    Update-EntraSignedInUserPassword -CurrentPassword $CurrentPassword -NewPassword $NewPassword -Debug 
                } | Should -Not -Throw
            } finally {
                # Restore original confirmation preference
                $DebugPreference = $originalDebugPreference
            }
        }
        
    }
}
