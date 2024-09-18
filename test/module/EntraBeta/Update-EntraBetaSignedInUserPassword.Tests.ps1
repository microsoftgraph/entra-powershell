# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra.Beta) -eq $null){
        Import-Module Microsoft.Graph.Entra.Beta    
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force

    Mock -CommandName Invoke-GraphRequest -MockWith {} -ModuleName Microsoft.Graph.Entra.Beta
}

Describe "Tests for Update-EntraBetaSignedInUserPassword"{
    Context "Test for Update-EntraBetaSignedInUserPassword" {
        It "should updates the password for the signed-in user."{
            $CurrentPassword = ConvertTo-SecureString 'test@123' -AsPlainText -Force
            $NewPassword = ConvertTo-SecureString 'test@1234' -AsPlainText -Force
            $result = Update-EntraBetaSignedInUserPassword -CurrentPassword $CurrentPassword -NewPassword $NewPassword
            $result | Should -BeNullOrEmpty
            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }

        It "Should fail when CurrentPassword is null" {
            {   $CurrentPassword = ConvertTo-SecureString 'test@123' -AsPlainText -Force
                $NewPassword = ConvertTo-SecureString 'test@1234' -AsPlainText -Force
                Update-EntraBetaSignedInUserPassword -CurrentPassword  -NewPassword $NewPassword} | Should -Throw "Missing an argument for parameter 'CurrentPassword'*"
        }  

        It "Should fail when CurrentPassword is empty" {
            {   $CurrentPassword = ConvertTo-SecureString 'test@123' -AsPlainText -Force
                $NewPassword = ConvertTo-SecureString 'test@1234' -AsPlainText -Force
                Update-EntraBetaSignedInUserPassword -CurrentPassword "" -NewPassword $NewPassword } | Should -Throw "Cannot process argument transformation on parameter 'CurrentPassword'*"
        }

        It "Should fail when NewPassword is null" {
            {   $CurrentPassword = ConvertTo-SecureString 'test@123' -AsPlainText -Force
                $NewPassword = ConvertTo-SecureString 'test@1234' -AsPlainText -Force
                Update-EntraBetaSignedInUserPassword -CurrentPassword $CurrentPassword -NewPassword } | Should -Throw "Missing an argument for parameter 'NewPassword'*"
        }  

        It "Should fail when NewPassword is empty" {
            {   $CurrentPassword = ConvertTo-SecureString 'test@123' -AsPlainText -Force
                $NewPassword = ConvertTo-SecureString 'test@1234' -AsPlainText -Force
                Update-EntraBetaSignedInUserPassword -CurrentPassword $CurrentPassword -NewPassword "" } | Should -Throw "Cannot process argument transformation on parameter 'NewPassword'*"
        }

        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Update-EntraBetaSignedInUserPassword"
            $CurrentPassword = ConvertTo-SecureString 'test@123' -AsPlainText -Force
            $NewPassword = ConvertTo-SecureString 'test@1234' -AsPlainText -Force
            $result =  Update-EntraBetaSignedInUserPassword -CurrentPassword $CurrentPassword -NewPassword $NewPassword
            $result | Should -BeNullOrEmpty
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Update-EntraBetaSignedInUserPassword"
            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Graph.Entra.Beta -Times 1 -ParameterFilter {
                $Headers.'User-Agent' | Should -Be $userAgentHeaderValue
                $true
            }
        } 

        It "Should execute successfully without throwing an error " {
            $CurrentPassword = ConvertTo-SecureString 'test@123' -AsPlainText -Force
            $NewPassword = ConvertTo-SecureString 'test@1234' -AsPlainText -Force
            # Disable confirmation prompts       
            $originalDebugPreference = $DebugPreference
            $DebugPreference = 'Continue'
    
            try {
                # Act & Assert: Ensure the function doesn't throw an exception
                { Update-EntraBetaSignedInUserPassword -CurrentPassword $CurrentPassword -NewPassword $NewPassword -Debug } | Should -Not -Throw
            } finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        } 
    }
}