# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra.Beta) -eq $null){
        Import-Module Microsoft.Graph.Entra.Beta    
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force

    Mock -CommandName Remove-MgBetaDirectorySetting -MockWith {} -ModuleName Microsoft.Graph.Entra.Beta
}

Describe "Remove-EntraBetaDirectorySetting" {
    Context "Test for Remove-EntraBetaDirectorySetting" {
        It "Should removes a directory setting from Azure Active Directory (AD)" {
            $result = Remove-EntraBetaDirectorySetting -Id "a658c48f-fd66-498d-8199-27ed3d33c7c3"
            $result | Should -BeNullOrEmpty

            Should -Invoke -CommandName Remove-MgBetaDirectorySetting -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }

        It "Should fail when Id is empty" {
            { Remove-EntraBetaDirectorySetting -Id } | Should -Throw "Missing an argument for parameter 'Id'*"
        }   

        It "Should fail when Id is invalid" {
            { Remove-EntraBetaDirectorySetting -Id "" } | Should -Throw "Cannot bind argument to parameter 'Id' because it is an empty string."
        }   

        It "Should contain DirectorySettingId in parameters when passed Id to it" {
            Mock -CommandName Remove-MgBetaDirectorySetting -MockWith {$args} -ModuleName Microsoft.Graph.Entra.Beta

            $result = Remove-EntraBetaDirectorySetting -Id "a658c48f-fd66-498d-8199-27ed3d33c7c3"
            $params = Get-Parameters -data $result
            $params.DirectorySettingId | Should -Be "a658c48f-fd66-498d-8199-27ed3d33c7c3"
        }

        It "Should contain 'User-Agent' header" {
            Mock -CommandName Remove-MgBetaDirectorySetting -MockWith {$args} -ModuleName Microsoft.Graph.Entra.Beta

            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Remove-EntraBetaDirectorySetting"
            $result = Remove-EntraBetaDirectorySetting -Id "a658c48f-fd66-498d-8199-27ed3d33c7c3"
            $params = Get-Parameters -data $result
            $params.Headers["User-Agent"] | Should -Be $userAgentHeaderValue
        } 

        It "Should execute successfully without throwing an error " {
            # Disable confirmation prompts       
            $originalDebugPreference = $DebugPreference
            $DebugPreference = 'Continue'
    
            try {
                # Act & Assert: Ensure the function doesn't throw an exception
                { Remove-EntraBetaDirectorySetting -Id "a658c48f-fd66-498d-8199-27ed3d33c7c3" -Debug } | Should -Not -Throw
            } finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        } 
    }
}