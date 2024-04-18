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
              "Id"                           = "shjUVMBM7kebOej4Ttjgcz2U7QLKbplPg9bm-_ncY66yGNRUwEzuR5s56PhO2OBz-1"
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

    Mock -CommandName New-MgRoleManagementDirectoryRoleAssignment -MockWith $scriptblock -ModuleName Microsoft.Graph.Entra
}

Describe "New-EntraMSRoleAssignment" {
Context "Test for New-EntraMSRoleAssignment" {
        It "Should return created Ms role assignment" {
            $result = New-EntraMSRoleAssignment -PrincipalId "02ed943d-6eca-4f99-83d6-e6fbf9dc63ae" -RoleDefinitionId  "54d418b2-4cc0-47ee-9b39-e8f84ed8e073" -DirectoryScopeId "/54d418b2-4cc0-47ee-9b39-e8f84ed8e073"
            $result | Should -Not -BeNullOrEmpty
            $result.PrincipalId | Should -Be "02ed943d-6eca-4f99-83d6-e6fbf9dc63ae"
            $result.RoleDefinitionId | Should -Be "54d418b2-4cc0-47ee-9b39-e8f84ed8e073"
            $result.DirectoryScopeId | Should -Be "/54d418b2-4cc0-47ee-9b39-e8f84ed8e073"

            Should -Invoke -CommandName New-MgRoleManagementDirectoryRoleAssignment  -ModuleName Microsoft.Graph.Entra -Times 1
        }
        It "Should fail when PrincipalId is empty" {
            { New-EntraMSRoleAssignment -PrincipalId  -RoleDefinitionId  "54d418b2-4cc0-47ee-9b39-e8f84ed8e073" -DirectoryScopeId "/54d418b2-4cc0-47ee-9b39-e8f84ed8e073"  } | Should -Throw "Missing an argument for parameter 'PrincipalId'*"
        }
        It "Should fail when PrincipalId is invalid" {
            { New-EntraMSRoleAssignment -PrincipalId "" -RoleDefinitionId  "54d418b2-4cc0-47ee-9b39-e8f84ed8e073" -DirectoryScopeId "/54d418b2-4cc0-47ee-9b39-e8f84ed8e073" } | Should -Throw "Cannot bind argument to parameter 'PrincipalId' because it is an empty string."
        }
        It "Should fail when RoleDefinitionId is empty" {
            { New-EntraMSRoleAssignment -PrincipalId "02ed943d-6eca-4f99-83d6-e6fbf9dc63ae" -RoleDefinitionId   -DirectoryScopeId "/54d418b2-4cc0-47ee-9b39-e8f84ed8e073"  } | Should -Throw "Missing an argument for parameter 'RoleDefinitionId'*"
        }
        It "Should fail when RoleDefinitionId is invalid" {
            { New-EntraMSRoleAssignment -PrincipalId "02ed943d-6eca-4f99-83d6-e6fbf9dc63ae" -RoleDefinitionId  "" -DirectoryScopeId "/54d418b2-4cc0-47ee-9b39-e8f84ed8e073" } | Should -Throw "Cannot bind argument to parameter 'RoleDefinitionId' because it is an empty string."
        }
        It "Should fail when DirectoryScopeId is empty" {
            { New-EntraMSRoleAssignment -PrincipalId "02ed943d-6eca-4f99-83d6-e6fbf9dc63ae" -RoleDefinitionId "54d418b2-4cc0-47ee-9b39-e8f84ed8e073"  -DirectoryScopeId   } | Should -Throw "Missing an argument for parameter 'DirectoryScopeId'*"
        }
        # It "Should fail when DirectoryScopeId is invalid" {
        #     { New-EntraMSRoleAssignment -PrincipalId "02ed943d-6eca-4f99-83d6-e6fbf9dc63ae" -RoleDefinitionId  "54d418b2-4cc0-47ee-9b39-e8f84ed8e073" -DirectoryScopeId "" } | Should -Throw "Must specify valid property scope of entity RoleAssignment."
        # }
        It "Result should Contain ObjectId" {
            $result = New-EntraMSRoleAssignment -PrincipalId "02ed943d-6eca-4f99-83d6-e6fbf9dc63ae" -RoleDefinitionId  "54d418b2-4cc0-47ee-9b39-e8f84ed8e073" -DirectoryScopeId "/54d418b2-4cc0-47ee-9b39-e8f84ed8e073"
            $result.ObjectId | should -Be "shjUVMBM7kebOej4Ttjgcz2U7QLKbplPg9bm-_ncY66yGNRUwEzuR5s56PhO2OBz-1"
        }
        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion New-EntraMSRoleAssignment"

            $result = New-EntraMSRoleAssignment -PrincipalId "02ed943d-6eca-4f99-83d6-e6fbf9dc63ae" -RoleDefinitionId  "54d418b2-4cc0-47ee-9b39-e8f84ed8e073" -DirectoryScopeId "/54d418b2-4cc0-47ee-9b39-e8f84ed8e073"
            $params = Get-Parameters -data $result.Parameters
            $params.Headers["User-Agent"] | Should -Be $userAgentHeaderValue
        }


    }

}   