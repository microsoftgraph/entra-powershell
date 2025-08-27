# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
BeforeAll {  
    if((Get-Module -Name Microsoft.Entra.Governance) -eq $null){
        Import-Module Microsoft.Entra.Governance      
    }
    Import-Module (Join-Path $PSScriptRoot "..\..\Common-Functions.ps1") -Force
    
    $scriptblock = {
        return @(
            [PSCustomObject]@{
              "AppScope"                     = "Microsoft.Graph.PowerShell.Models.MicrosoftGraphAppScope"
              "AppScopeId"                   = $null
              "Id"                           = "Aa1Bb2Cc3.-Dd4Ee5Ff6Gg7Hh8Ii9_~Jj0Kk1Ll2"
              "DirectoryScope"               = "Microsoft.Graph.PowerShell.Models.MicrosoftGraphDirectoryObject"
              "DirectoryScopeId"             = "/00aa00aa-bb11-cc22-dd33-44ee44ee44ee"
              "Condition"                    = $null
              "Principal"                    = "Microsoft.Graph.PowerShell.Models.MicrosoftGraphDirectoryObject"
              "PrincipalId"                  = "aaaaaaaa-bbbb-cccc-1111-222222222222"
              "RoleDefinition"               = "Microsoft.Graph.PowerShell.Models.MicrosoftGraphUnifiedRoleDefinition"
              "RoleDefinitionId"             = "00aa00aa-bb11-cc22-dd33-44ee44ee44ee"
              "AdditionalProperties"         = @{"@odata.context" = "https://graph.microsoft.com/v1.0/`$metadata#roleManagement/directory/roleAssignments/`$entity"}
              "Parameters"                   = $args
            }
        )
    }

    Mock -CommandName New-MgRoleManagementDirectoryRoleAssignment -MockWith $scriptblock -ModuleName Microsoft.Entra.Governance

    Mock -CommandName Get-EntraContext -MockWith {
        @{
            Environment = @{
                Name = "Global"
            }
            Scopes      = @('RoleManagement.ReadWrite.Directory', 'EntitlementManagement.ReadWrite.All')
        }
    } -ModuleName Microsoft.Entra.Applications
}

Describe "New-EntraDirectoryRoleAssignment" {
Context "Test for New-EntraDirectoryRoleAssignment" {
        It "Should return created Ms role assignment" {
            $result = New-EntraDirectoryRoleAssignment -PrincipalId "aaaaaaaa-bbbb-cccc-1111-222222222222" -RoleDefinitionId  "54d418b2-4cc0-47ee-9b39-e8f84ed8e073" -DirectoryScopeId "/54d418b2-4cc0-47ee-9b39-e8f84ed8e073"
            $result | Should -Not -BeNullOrEmpty
            $result.PrincipalId | Should -Be "aaaaaaaa-bbbb-cccc-1111-222222222222"
            $result.RoleDefinitionId | Should -Be "00aa00aa-bb11-cc22-dd33-44ee44ee44ee"
            $result.DirectoryScopeId | Should -Be "/00aa00aa-bb11-cc22-dd33-44ee44ee44ee"

            Should -Invoke -CommandName New-MgRoleManagementDirectoryRoleAssignment  -ModuleName Microsoft.Entra.Governance -Times 1
        }
        It "Should fail when PrincipalId is empty" {
            { New-EntraDirectoryRoleAssignment -PrincipalId  -RoleDefinitionId  "00aa00aa-bb11-cc22-dd33-44ee44ee44ee" -DirectoryScopeId "/00aa00aa-bb11-cc22-dd33-44ee44ee44ee"  } | Should -Throw "Missing an argument for parameter 'PrincipalId'*"
        }
        It "Should fail when PrincipalId is invalid" {
            { New-EntraDirectoryRoleAssignment -PrincipalId "" -RoleDefinitionId  "00aa00aa-bb11-cc22-dd33-44ee44ee44ee" -DirectoryScopeId "/00aa00aa-bb11-cc22-dd33-44ee44ee44ee" } | Should -Throw "Cannot bind argument to parameter 'PrincipalId' because it is an empty string."
        }
        It "Should fail when RoleDefinitionId is empty" {
            { New-EntraDirectoryRoleAssignment -PrincipalId "aaaaaaaa-bbbb-cccc-1111-222222222222" -RoleDefinitionId   -DirectoryScopeId "/00aa00aa-bb11-cc22-dd33-44ee44ee44ee"  } | Should -Throw "Missing an argument for parameter 'RoleDefinitionId'*"
        }
        It "Should fail when RoleDefinitionId is invalid" {
            { New-EntraDirectoryRoleAssignment -PrincipalId "aaaaaaaa-bbbb-cccc-1111-222222222222" -RoleDefinitionId  "" -DirectoryScopeId "/00aa00aa-bb11-cc22-dd33-44ee44ee44ee" } | Should -Throw "Cannot bind argument to parameter 'RoleDefinitionId' because it is an empty string."
        }
        It "Should fail when DirectoryScopeId is empty" {
            { New-EntraDirectoryRoleAssignment -PrincipalId "aaaaaaaa-bbbb-cccc-1111-222222222222" -RoleDefinitionId "00aa00aa-bb11-cc22-dd33-44ee44ee44ee"  -DirectoryScopeId   } | Should -Throw "Missing an argument for parameter 'DirectoryScopeId'*"
        }
        It "Result should Contain ObjectId" {
            $result = New-EntraDirectoryRoleAssignment -PrincipalId "aaaaaaaa-bbbb-cccc-1111-222222222222" -RoleDefinitionId  "00aa00aa-bb11-cc22-dd33-44ee44ee44ee" -DirectoryScopeId "/00aa00aa-bb11-cc22-dd33-44ee44ee44ee"
            $result.ObjectId | should -Be "Aa1Bb2Cc3.-Dd4Ee5Ff6Gg7Hh8Ii9_~Jj0Kk1Ll2"
        }
        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion New-EntraDirectoryRoleAssignment"

            New-EntraDirectoryRoleAssignment -PrincipalId "aaaaaaaa-bbbb-cccc-1111-222222222222" -RoleDefinitionId  "00aa00aa-bb11-cc22-dd33-44ee44ee44ee" -DirectoryScopeId "/00aa00aa-bb11-cc22-dd33-44ee44ee44ee"
            
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion New-EntraDirectoryRoleAssignment"

            Should -Invoke -CommandName New-MgRoleManagementDirectoryRoleAssignment -ModuleName Microsoft.Entra.Governance -Times 1 -ParameterFilter {
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
                { New-EntraDirectoryRoleAssignment -PrincipalId "aaaaaaaa-bbbb-cccc-1111-222222222222" -RoleDefinitionId  "00aa00aa-bb11-cc22-dd33-44ee44ee44ee" -DirectoryScopeId "/00aa00aa-bb11-cc22-dd33-44ee44ee44ee" -Debug } | Should -Not -Throw
            } finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        }
    }   
}
