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
              "DirectoryScopeId"             = "/0000aaaa-11bb-cccc-dd22-eeeeee333333"
              "Condition"                    = $null
              "Principal"                    = "Microsoft.Graph.PowerShell.Models.MicrosoftGraphDirectoryObject"
              "PrincipalId"                  = "aaaaaaaa-bbbb-cccc-1111-222222222222"
              "RoleDefinition"               = "Microsoft.Graph.PowerShell.Models.MicrosoftGraphUnifiedRoleDefinition"
              "RoleDefinitionId"             = "1b1b1b1b-2222-cccc-3333-4d4d4d4d4d4d"
              "AdditionalProperties"         = @{"@odata.context" = "https://graph.microsoft.com/v1.0/`$metadata#roleManagement/directory/roleAssignments/`$entity"}
              "Parameters"                   = $args
            }
        )
    }

    Mock -CommandName Get-MgRoleManagementDirectoryRoleAssignment -MockWith $scriptblock -ModuleName Microsoft.Entra.Governance

    Mock -CommandName Get-EntraContext -MockWith {
        @{
            Environment = @{
                Name = "Global"
            }
            Scopes      = @('RoleManagement.Read.Directory', 'EntitlementManagement.Read.All')
        }
    } -ModuleName Microsoft.Entra.Applications
}

Describe "Get-EntraDirectoryRoleAssignment" {
    Context "Test for Get-EntraDirectoryRoleAssignment" {
        It "Should return specific role assignment" {
            $result = Get-EntraDirectoryRoleAssignment -UnifiedRoleAssignmentId "Aa1Bb2Cc3.-Dd4Ee5Ff6Gg7Hh8Ii9_~Jj0Kk1Ll2"
            $result | Should -Not -BeNullOrEmpty

            Should -Invoke -CommandName Get-MgRoleManagementDirectoryRoleAssignment  -ModuleName Microsoft.Entra.Governance -Times 1
        }
        It "Should execute successfully with Alias" {
            $result = Get-EntraDirectoryRoleAssignment -Id "Aa1Bb2Cc3.-Dd4Ee5Ff6Gg7Hh8Ii9_~Jj0Kk1Ll2"
            $result | Should -Not -BeNullOrEmpty

            Should -Invoke -CommandName Get-MgRoleManagementDirectoryRoleAssignment  -ModuleName Microsoft.Entra.Governance -Times 1
        }
        It "Should fail when Get-EntraDirectoryRoleAssignment is empty" {
            { Get-EntraDirectoryRoleAssignment -UnifiedRoleAssignmentId  } | Should -Throw "Missing an argument for parameter 'UnifiedRoleAssignmentId'*"
        }
        It "Should fail when Get-EntraDirectoryRoleAssignment is invalid" {
            { Get-EntraDirectoryRoleAssignment -UnifiedRoleAssignmentId "" } | Should -Throw "Cannot bind argument to parameter 'UnifiedRoleAssignmentId' because it is an empty string."
        }
        It "Should return all role assignments" {
            $result = Get-EntraDirectoryRoleAssignment -All 
            $result | Should -Not -BeNullOrEmpty            
            
            Should -Invoke -CommandName Get-MgRoleManagementDirectoryRoleAssignment -ModuleName Microsoft.Entra.Governance -Times 1
        }       
        It "Should fail when All is invalid" {
            { Get-EntraDirectoryRoleAssignment -All XY } | Should -Throw "A positional parameter cannot be found that accepts argument 'xy'.*"
        }     
        It "Should return top role assignment" {
            $result = Get-EntraDirectoryRoleAssignment -Top 1
            $result | Should -Not -BeNullOrEmpty

            Should -Invoke -CommandName Get-MgRoleManagementDirectoryRoleAssignment  -ModuleName Microsoft.Entra.Governance -Times 1
        }
        It "Should fail when Top is empty" {
            { Get-EntraDirectoryRoleAssignment -Top  } | Should -Throw "Missing an argument for parameter 'Top'*"
        }
         It "Should fail when Top is invalid" {
            { Get-EntraDirectoryRoleAssignment -Top XY } | Should -Throw "Cannot process argument transformation on parameter 'Top'*"
        }          
        It "Should return specific application by filter" {
            $result = Get-EntraDirectoryRoleAssignment -Filter "PrincipalId eq 'aaaaaaaa-bbbb-cccc-1111-222222222222'"
            $result | Should -Not -BeNullOrEmpty
            $result.Id | should -Be 'Aa1Bb2Cc3.-Dd4Ee5Ff6Gg7Hh8Ii9_~Jj0Kk1Ll2'

            Should -Invoke -CommandName Get-MgRoleManagementDirectoryRoleAssignment  -ModuleName Microsoft.Entra.Governance -Times 1
        }
        It "Should fail when filter is empty" {
            { Get-EntraDirectoryRoleAssignment -Filter  } | Should -Throw "Missing an argument for parameter 'Filter'*"
        }
          
        It "Result should Contain ObjectId" {
            $result = Get-EntraDirectoryRoleAssignment -UnifiedRoleAssignmentId "Aa1Bb2Cc3.-Dd4Ee5Ff6Gg7Hh8Ii9_~Jj0Kk1Ll2"
            $result.ObjectId | should -Be "Aa1Bb2Cc3.-Dd4Ee5Ff6Gg7Hh8Ii9_~Jj0Kk1Ll2"
        }     
        It "Should contain UnifiedRoleAssignmentId in parameters when passed Id to it" {              
            $result = Get-EntraDirectoryRoleAssignment -UnifiedRoleAssignmentId "Aa1Bb2Cc3.-Dd4Ee5Ff6Gg7Hh8Ii9_~Jj0Kk1Ll2"
            $params = Get-Parameters -data $result.Parameters
            $params.UnifiedRoleAssignmentId | Should -Be "Aa1Bb2Cc3.-Dd4Ee5Ff6Gg7Hh8Ii9_~Jj0Kk1Ll2"
        }
        It "Property parameter should work" {
            $result = Get-EntraDirectoryRoleAssignment -UnifiedRoleAssignmentId "Aa1Bb2Cc3.-Dd4Ee5Ff6Gg7Hh8Ii9_~Jj0Kk1Ll2" -Property PrincipalId
            $result | Should -Not -BeNullOrEmpty
            $result.PrincipalId | Should -Be 'aaaaaaaa-bbbb-cccc-1111-222222222222'

            Should -Invoke -CommandName Get-MgRoleManagementDirectoryRoleAssignment -ModuleName Microsoft.Entra.Governance -Times 1
        }
        It "Should fail when Property is empty" {
             { Get-EntraDirectoryRoleAssignment -UnifiedRoleAssignmentId "Aa1Bb2Cc3.-Dd4Ee5Ff6Gg7Hh8Ii9_~Jj0Kk1Ll2" -Property } | Should -Throw "Missing an argument for parameter 'Property'*"
        }
        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraDirectoryRoleAssignment"

            Get-EntraDirectoryRoleAssignment -UnifiedRoleAssignmentId "Aa1Bb2Cc3.-Dd4Ee5Ff6Gg7Hh8Ii9_~Jj0Kk1Ll2"
            
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraDirectoryRoleAssignment"

            Should -Invoke -CommandName Get-MgRoleManagementDirectoryRoleAssignment -ModuleName Microsoft.Entra.Governance -Times 1 -ParameterFilter {
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
                {  Get-EntraDirectoryRoleAssignment -UnifiedRoleAssignmentId "Aa1Bb2Cc3.-Dd4Ee5Ff6Gg7Hh8Ii9_~Jj0Kk1Ll2" -Debug } | Should -Not -Throw
            } finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        }
    }
}
