# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra) -eq $null){
        Import-Module Microsoft.Graph.Entra      
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force
    
    $scriptblock = {
        return @(
            [PSCustomObject]@{
              "Id"                           = "00aa00aa-bb11-cc22-dd33-44ee44ee44ee"
              "DisplayName"                  = "Mock-App"
              "DeletedDateTime"              = $null
              "Description"                  = "Can read mock-app service health information"
              "AdditionalProperties"         = @{}
              "Parameters"                   = $args
            }
        )
    }

    Mock -CommandName Get-MgDirectoryRoleTemplate -MockWith $scriptblock -ModuleName Microsoft.Graph.Entra
}

Describe "Get-EntraDirectoryRoleTemplate" {
    Context "Test for Get-EntraDirectoryRoleTemplate" {
        It "Should return all directory role template" {
            $result = Get-EntraDirectoryRoleTemplate 
            $result | Should -Not -BeNullOrEmpty
            $result.Id | should -Be "00aa00aa-bb11-cc22-dd33-44ee44ee44ee"
            $result.DisplayName | should -Be "Mock-App"

            Should -Invoke -CommandName Get-MgDirectoryRoleTemplate  -ModuleName Microsoft.Graph.Entra -Times 1
        }
        It "Should be fail when provide non supported parameter" {
            { Get-EntraDirectoryRoleTemplate -Top 1} | should -Throw "A parameter cannot be found that matches parameter name 'Top'."
        }
        It "Property parameter should work" {
            $result = Get-EntraDirectoryRoleTemplate -Property DisplayName
            $result | Should -Not -BeNullOrEmpty
            $result.DisplayName | Should -Be 'Mock-App'

            Should -Invoke -CommandName Get-MgDirectoryRoleTemplate -ModuleName Microsoft.Graph.Entra -Times 1
        }
        It "Should fail when Property is empty" {
             { Get-EntraDirectoryRoleTemplate -Property } | Should -Throw "Missing an argument for parameter 'Property'*"
        }
        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraDirectoryRoleTemplate"

            Get-EntraDirectoryRoleTemplate
            
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraDirectoryRoleTemplate"

            Should -Invoke -CommandName Get-MgDirectoryRoleTemplate -ModuleName Microsoft.Graph.Entra -Times 1 -ParameterFilter {
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
                { Get-EntraDirectoryRoleTemplate -Debug } | Should -Not -Throw
            } finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        }
    }
}        