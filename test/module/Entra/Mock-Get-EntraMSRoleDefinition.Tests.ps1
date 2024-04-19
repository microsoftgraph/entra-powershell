BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra) -eq $null){
        Import-Module Microsoft.Graph.Entra      
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force
    
    $scriptblock = {
        return @(
            [PSCustomObject]@{
              "RolePermissions"              = @{AllowedResourceActions="System.Object[]"; Condition=""; ExcludedResourceActions=""; AdditionalProperties=""}
              "Description"                  = "Mock-App"
              "DisplayName"                  = "Mock-App"
              "Id"                           = "54d418b2-4cc0-47ee-9b39-e8f84ed8e073"
              "InheritsPermissionsFrom"      = {}
              "IsBuiltIn"                    = $False
              "IsEnabled"                    = $False
              "ResourceScopes"               = {/}
              "TemplateId"                   = "54d418b2-4cc0-47ee-9b39-e8f84ed8e073"
              "Version"                      = "2"
              "RoleDefinitionId"             = "54d418b2-4cc0-47ee-9b39-e8f84ed8e073"
              "AdditionalProperties"         = @{"@odata.context" = "https://graph.microsoft.com/v1.0/$metadata#roleManagement/directory/roleDefinitions/$entity"
                                                 "inheritsPermissionsFrom@odata.context" = "https://graph.microsoft.com/v1.0/$metadata#roleManagement/directory/roleDefinitions('54d418b2-4cc0-47ee-9b39-e8f84ed8e073')/inheritsPermissionsFrom"
                                                }
              "Parameters"                   = $args
            }
        )
    }

    Mock -CommandName Get-MgRoleManagementDirectoryRoleDefinition -MockWith $scriptblock -ModuleName Microsoft.Graph.Entra
}

Describe "Get-EntraMSRoleDefinition" {
    Context "Test for Get-EntraMSRoleDefinition" {
        It "Should return specific Ms role Defination" {
            $result = Get-EntraMSRoleDefinition -Id "54d418b2-4cc0-47ee-9b39-e8f84ed8e073"
            $result | Should -Not -BeNullOrEmpty
            $result.DisplayName | Should -Be "Mock-App"
            $result.Id | Should -Be "54d418b2-4cc0-47ee-9b39-e8f84ed8e073"

            Should -Invoke -CommandName Get-MgRoleManagementDirectoryRoleDefinition  -ModuleName Microsoft.Graph.Entra -Times 1
        }
        It "Should fail when Id is empty" {
            { Get-EntraMSRoleDefinition -Id  } | Should -Throw "Missing an argument for parameter 'Id'*"
        }
        It "Should fail when Id is invalid" {
            { Get-EntraMSRoleDefinition -Id "" } | Should -Throw "Cannot bind argument to parameter 'Id' because it is an empty string."
        }

        It "Should return all Ms role assignments" {
            $result = Get-EntraMSRoleDefinition -All $true
            $result | Should -Not -BeNullOrEmpty            
            
            Should -Invoke -CommandName Get-MgRoleManagementDirectoryRoleDefinition -ModuleName Microsoft.Graph.Entra -Times 1
        }
        It "Should fail when All is empty" {
            { Get-EntraMSRoleDefinition -All } | Should -Throw "Missing an argument for parameter 'All'*"
        }
         It "Should fail when All is invalid" {
            { Get-EntraMSRoleDefinition -All XY } | Should -Throw "Cannot process argument transformation on parameter 'All'*"
        }
        It "Should return top Ms role assignment" {
            $result = Get-EntraMSRoleDefinition -Top 1
            $result | Should -Not -BeNullOrEmpty

            Should -Invoke -CommandName Get-MgRoleManagementDirectoryRoleDefinition  -ModuleName Microsoft.Graph.Entra -Times 1
        }
        It "Should fail when Top is empty" {
            { Get-EntraMSRoleDefinition -Top  } | Should -Throw "Missing an argument for parameter 'Top'*"
        }
         It "Should fail when Top is invalid" {
            { Get-EntraMSRoleDefinition -Top XY } | Should -Throw "Cannot process argument transformation on parameter 'Top'*"
        }
        It "Should return specific application by SearchString" {
            $result = Get-EntraMSRoleDefinition -SearchString 'Mock-App'
            $result | Should -Not -BeNullOrEmpty
            $result.DisplayName | should -Be 'Mock-App'

            Should -Invoke -CommandName Get-MgRoleManagementDirectoryRoleDefinition  -ModuleName Microsoft.Graph.Entra -Times 1
        }
        It "Should fail when String is empty" {
            { Get-EntraMSRoleDefinition -SearchString  } | Should -Throw "Missing an argument for parameter 'SearchString'*"
        }         
        It "Should return specific application by filter" {
            $result = Get-EntraMSRoleDefinition -Filter "DisplayName eq 'Mock-App'"
            $result | Should -Not -BeNullOrEmpty
            $result.DisplayName | should -Be 'Mock-App'

            Should -Invoke -CommandName Get-MgRoleManagementDirectoryRoleDefinition  -ModuleName Microsoft.Graph.Entra -Times 1
        }
        It "Should fail when filter is empty" {
            { Get-EntraMSRoleDefinition -Filter } | Should -Throw "Missing an argument for parameter 'Filter'*"
        }
          
        It "Result should Contain ObjectId" {
            $result = Get-EntraMSRoleDefinition -Id "54d418b2-4cc0-47ee-9b39-e8f84ed8e073"
            $result.ObjectId | should -Be "54d418b2-4cc0-47ee-9b39-e8f84ed8e073"
        }     
        It "Should contain Filter in parameters when passed SearchString to it" {              
            $result = Get-EntraMSRoleDefinition -SearchString 'Mock-App'
            $params = Get-Parameters -data $result.Parameters
            $params.Filter | Should -Match "Mock-App"
        }
        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraMSRoleDefinition"

            $result = Get-EntraMSRoleDefinition -Id "54d418b2-4cc0-47ee-9b39-e8f84ed8e073"
            $params = Get-Parameters -data $result.Parameters
            $params.Headers["User-Agent"] | Should -Be $userAgentHeaderValue
        }
    }
}