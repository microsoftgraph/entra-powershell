# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
BeforeAll {  
    if ((Get-Module -Name Microsoft.Entra.Applications) -eq $null) {
        Import-Module Microsoft.Entra.Applications
    }
    Import-Module (Join-Path $PSScriptRoot "..\..\Common-Functions.ps1") -Force

    Mock -CommandName Remove-MgDirectoryDeletedItem -MockWith {} -ModuleName Microsoft.Entra.Applications
    Mock -CommandName Get-EntraContext -MockWith { @{Scopes = @("Application.ReadWrite.All") } } -ModuleName Microsoft.Entra.Applications
}

Describe "Remove-EntraDeletedApplication" {
    Context "Test for Remove-EntraDeletedApplication" {
        It "Should remove deleted application object" {
            $result = Remove-EntraDeletedApplication -ApplicationId "bbbbbbbb-1111-2222-3333-cccccccccccc"
            $result | Should -BeNullOrEmpty

            Should -Invoke -CommandName Remove-MgDirectoryDeletedItem -ModuleName Microsoft.Entra.Applications -Times 1
        }

        It "Should fail when ApplicationId is empty" {
            { Remove-EntraDeletedApplication -ApplicationId } | Should -Throw "Missing an argument for parameter 'ApplicationId'*"
        }   

        It "Should fail when ApplicationId is invalid" {
            { Remove-EntraDeletedApplication -ApplicationId "" } | Should -Throw "Cannot validate argument on parameter 'ApplicationId'. The argument is null or empty. Provide an argument that is not null or empty, and then try the command again."
        }   

        It "Should contain DirectoryObjectId in parameters when passed ObjectId to it" {
            Mock -CommandName Remove-MgDirectoryDeletedItem -MockWith { $args } -ModuleName Microsoft.Entra.Applications

            $result = Remove-EntraDeletedApplication -ApplicationId "bbbbbbbb-1111-2222-3333-cccccccccccc"
            $params = Get-Parameters -data $result
            $params.DirectoryObjectId | Should -Be "bbbbbbbb-1111-2222-3333-cccccccccccc"
        }

        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Remove-EntraDeletedApplication"
            Remove-EntraDeletedApplication -ApplicationId "bbbbbbbb-1111-2222-3333-cccccccccccc"
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Remove-EntraDeletedApplication"
            Should -Invoke -CommandName Remove-MgDirectoryDeletedItem -ModuleName Microsoft.Entra.Applications -Times 1 -ParameterFilter {
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
                { Remove-EntraDeletedApplication -ApplicationId "bbbbbbbb-1111-2222-3333-cccccccccccc" -Debug } | Should -Not -Throw
            }
            finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        } 
    }
}

