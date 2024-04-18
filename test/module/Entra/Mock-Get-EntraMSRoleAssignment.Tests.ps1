BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra) -eq $null){
        Import-Module Microsoft.Graph.Entra      
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force
    
    $scriptblock = {
        return @(
            [PSCustomObject]@{
              "AppScope"                     = "Microsoft.Graph.PowerShell.Models.MicrosoftGraphAppScope"
              "AppScopeId"                   = $null
              "Id"                           = "shjUVMBM7kebOej4Ttjgcz2U7QLKbplPg9bm-_ncY64-1"
              "DirectoryScope"               = "Microsoft.Graph.PowerShell.Models.MicrosoftGraphDirectoryObject"
              "DirectoryScopeId"             = "/54d418b2-4cc0-47ee-9b39-e8f84ed8e073"
              "Condition"                    = $null
              "Principal"                    = "Microsoft.Graph.PowerShell.Models.MicrosoftGraphDirectoryObject"
              "PrincipalId"                  = "02ed943d-6eca-4f99-83d6-e6fbf9dc63ae"
              "RoleDefinition"               = "Microsoft.Graph.PowerShell.Models.MicrosoftGraphUnifiedRoleDefinition"
              "RoleDefinitionId"             = "54d418b2-4cc0-47ee-9b39-e8f84ed8e073"
              "AdditionalProperties"         = @{"@odata.context" = "https://graph.microsoft.com/v1.0/$metadata#roleManagement/directory/roleAssignments/$entity"}
              "Parameters"                   = $args
            }
        )
    }

    Mock -CommandName Get-MgRoleManagementDirectoryRoleAssignment -MockWith $scriptblock -ModuleName Microsoft.Graph.Entra
}

Describe "Get-EntraMSRoleAssignment" {
    Context "Test for Get-EntraMSRoleAssignment" {
        It "Should return specific Ms role assignment" {
            $result = Get-EntraMSRoleAssignment -Id "shjUVMBM7kebOej4Ttjgcz2U7QLKbplPg9bm-_ncY64-1"
            $result | Should -Not -BeNullOrEmpty

            Should -Invoke -CommandName Get-MgRoleManagementDirectoryRoleAssignment  -ModuleName Microsoft.Graph.Entra -Times 1
        }
        It "Should fail when Id is empty" {
            { Get-EntraMSRoleAssignment -Id  } | Should -Throw "Missing an argument for parameter 'Id'*"
        }
        }
        It "Should fail when Id is empty" {
            { Get-EntraMSRoleAssignment -Id "" } | Should -Throw "Cannot bind argument to parameter 'Id' because it is an empty string."
        }

        It "Should return all Ms role assignments" {
            $result = Get-EntraMSRoleAssignment -All $true
            $result | Should -Not -BeNullOrEmpty            
            
            Should -Invoke -CommandName Get-MgRoleManagementDirectoryRoleAssignment -ModuleName Microsoft.Graph.Entra -Times 1
        }
        It "Should fail when All is empty" {
            { Get-EntraMSRoleAssignment -All } | Should -Throw "Missing an argument for parameter 'All'*"
        }
         It "Should fail when All is invalid" {
            { Get-EntraMSRoleAssignment -All XY } | Should -Throw "Cannot process argument transformation on parameter 'All'*"
        }
        It "Should return top Ms role assignment" {
            $result = Get-EntraMSRoleAssignment -Top 1
            $result | Should -Not -BeNullOrEmpty

            Should -Invoke -CommandName Get-MgRoleManagementDirectoryRoleAssignment  -ModuleName Microsoft.Graph.Entra -Times 1
        }
        It "Should fail when Top is empty" {
            { Get-EntraMSRoleAssignment -Top  } | Should -Throw "Missing an argument for parameter 'Top'*"
        }
         It "Should fail when Top is invalid" {
            { Get-EntraMSRoleAssignment -Top XY } | Should -Throw "Cannot process argument transformation on parameter 'Top'*"
        }          
        It "Should return specific application by filter" {
            $result = Get-EntraMSRoleAssignment -Filter "PrincipalId eq '02ed943d-6eca-4f99-83d6-e6fbf9dc63ae'"
            $result | Should -Not -BeNullOrEmpty
            $result.Id | should -Be 'shjUVMBM7kebOej4Ttjgcz2U7QLKbplPg9bm-_ncY64-1'

            Should -Invoke -CommandName Get-MgRoleManagementDirectoryRoleAssignment  -ModuleName Microsoft.Graph.Entra -Times 1
        }
        It "Should fail when filter is empty" {
            { Get-EntraMSRoleAssignment -Filter  } | Should -Throw "Missing an argument for parameter 'Filter'*"
        }
          
        It "Result should Contain ObjectId" {
            $result = Get-EntraMSRoleAssignment -Id "shjUVMBM7kebOej4Ttjgcz2U7QLKbplPg9bm-_ncY64-1"
            $result.ObjectId | should -Be "shjUVMBM7kebOej4Ttjgcz2U7QLKbplPg9bm-_ncY64-1"
        }     
        It "Should contain UnifiedRoleAssignmentId in parameters when passed Id to it" {              
            $result = Get-EntraMSRoleAssignment -Id "shjUVMBM7kebOej4Ttjgcz2U7QLKbplPg9bm-_ncY64-1"
            $params = Get-Parameters -data $result.Parameters
            $params.UnifiedRoleAssignmentId | Should -Be "shjUVMBM7kebOej4Ttjgcz2U7QLKbplPg9bm-_ncY64-1"
        }
        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraMSRoleAssignment"

            $result = Get-EntraMSRoleAssignment -Id "shjUVMBM7kebOej4Ttjgcz2U7QLKbplPg9bm-_ncY64-1"
            $params = Get-Parameters -data $result.Parameters
            $params.Headers["User-Agent"] | Should -Be $userAgentHeaderValue
        }
    }
# }