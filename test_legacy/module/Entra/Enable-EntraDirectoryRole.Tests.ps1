# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra) -eq $null){
        Import-Module Microsoft.Graph.Entra
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force

    Mock -CommandName New-MgDirectoryRole -MockWith {} -ModuleName Microsoft.Graph.Entra
}

Describe "Enable-EntraDirectoryRole" {
    Context "Test for Enable-EntraDirectoryRole" {
        It "Should return empty object" {
            $result = Enable-EntraDirectoryRole -RoleTemplateId 'aaaaaaaa-1111-2222-3333-bbbbbbbbbbbb'
            $result | Should -BeNullOrEmpty

            Should -Invoke -CommandName New-MgDirectoryRole -ModuleName Microsoft.Graph.Entra -Times 1
        }
        It "Should fail when RoleTemplateId is empty" {
            { Enable-EntraDirectoryRole -RoleTemplateId } | Should -Throw "Missing an argument for parameter 'RoleTemplateId'*"
        }
        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Enable-EntraDirectoryRole"
            Enable-EntraDirectoryRole -RoleTemplateId 'aaaaaaaa-1111-2222-3333-bbbbbbbbbbbb'
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Enable-EntraDirectoryRole"
            Should -Invoke -CommandName New-MgDirectoryRole -ModuleName Microsoft.Graph.Entra -Times 1 -ParameterFilter {
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
                { Enable-EntraDirectoryRole -RoleTemplateId 'aaaaaaaa-1111-2222-3333-bbbbbbbbbbbb' -Debug } | Should -Not -Throw
            } finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        } 
    }
}