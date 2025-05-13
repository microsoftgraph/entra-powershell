# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
BeforeAll {  
    if ((Get-Module -Name Microsoft.Entra.Applications) -eq $null) {
        Import-Module Microsoft.Entra.Applications        
    }
    Import-Module (Join-Path $PSScriptRoot "..\..\Common-Functions.ps1") -Force

    Mock -CommandName Invoke-GraphRequest -MockWith {} -ModuleName Microsoft.Entra.Applications
}

Describe "Remove-EntraDeletedDirectoryObject" {
    Context "Test for Remove-EntraDeletedDirectoryObject" {
        It "Should delete a previously deleted directory object" {
            $result = Remove-EntraDeletedDirectoryObject -DirectoryObjectId "11112222-bbbb-3333-cccc-4444dddd5555"
            $result | Should -BeNullOrEmpty

            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.Applications -Times 1
        }

        It "Should execute successfully with Alias" {
            $result = Remove-EntraDeletedDirectoryObject -Id "11112222-bbbb-3333-cccc-4444dddd5555"
            $result | Should -BeNullOrEmpty

            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.Applications -Times 1
        }

        It "Should fail when DirectoryObjectId is empty" {
            { Remove-EntraDeletedDirectoryObject -DirectoryObjectId } | Should -Throw "Missing an argument for parameter 'DirectoryObjectId'*"
        }   

        It "Should fail when DirectoryObjectId is invalid" {
            { Remove-EntraDeletedDirectoryObject -DirectoryObjectId "" } | Should -Throw "Cannot validate argument on parameter 'DirectoryObjectId'. The argument is null or empty. Provide an argument that is not null or empty, and then try the command again."
        }   

        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Remove-EntraDeletedDirectoryObject"

            Remove-EntraDeletedDirectoryObject -DirectoryObjectId "11112222-bbbb-3333-cccc-4444dddd5555"

            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Remove-EntraDeletedDirectoryObject"

            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.Applications -Times 1 -ParameterFilter {
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
                { Remove-EntraDeletedDirectoryObject -DirectoryObjectId "11112222-bbbb-3333-cccc-4444dddd5555" -Debug } | Should -Not -Throw
            }
            finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        }  
    }
}

