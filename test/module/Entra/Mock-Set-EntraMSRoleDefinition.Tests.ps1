BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra) -eq $null){
        Import-Module Microsoft.Graph.Entra       
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force

    Mock -CommandName Update-MgRoleManagementDirectoryRoleDefinition -MockWith {} -ModuleName Microsoft.Graph.Entra
}
  
Describe "Set-EntraMSRoleDefinition" {
    Context "Test for Set-EntraMSRoleDefinition" {
        It "Should return empty object" {
            $RolePermissions = New-object Microsoft.Open.MSGraph.Model.RolePermission
            $RolePermissions.AllowedResourceActions =  @("microsoft.directory/applications/basic/read")
            $result = Set-EntraMSRoleDefinition -Id "54d418b2-4cc0-47ee-9b39-e8f84ed8e073" -RolePermissions $RolePermissions -IsEnabled $false -DisplayName 'Mock-App' -ResourceScopes "/" -Description "Mock-App" -TemplateId "4dd5aa9c-cf4d-4895-a993-740d342802b1" -Version 3
            $result | Should -BeNullOrEmpty

            Should -Invoke -CommandName Update-MgRoleManagementDirectoryRoleDefinition -ModuleName Microsoft.Graph.Entra -Times 1
        }
        It "Should fail when Id is empty" {
            { Set-EntraMSRoleDefinition -Id  -DisplayName 'Mock-App' -TemplateId "4dd5aa9c-cf4d-4895-a993-740d342802b1" } | Should -Throw "Missing an argument for parameter 'Id'*"
        }
        It "Should fail when Id is invalid" {
            { Set-EntraMSRoleDefinition -Id "" -IsEnabled $false -DisplayName 'Mock-App' -TemplateId "4dd5aa9c-cf4d-4895-a993-740d342802b1" -Version 3  } | Should -Throw "Cannot bind argument to parameter 'Id' because it is an empty string*"
        }
        It "Should fail when RolePermissions is empty" {
            {Set-EntraMSRoleDefinition -Id "54d418b2-4cc0-47ee-9b39-e8f84ed8e073" -RolePermissions  } | Should -Throw "Missing an argument for parameter 'RolePermissions'*"
        }
        It "Should fail when IsEnabled is empty" {
            $RolePermissions = New-object Microsoft.Open.MSGraph.Model.RolePermission
            $RolePermissions.AllowedResourceActions =  @("microsoft.directory/applications/basic/read")
            {Set-EntraMSRoleDefinition -Id "54d418b2-4cc0-47ee-9b39-e8f84ed8e073"  -IsEnabled  } | Should -Throw "Missing an argument for parameter 'IsEnabled'*"
        }
        It "Should fail when DisplayName is empty" {
            $RolePermissions = New-object Microsoft.Open.MSGraph.Model.RolePermission
            $RolePermissions.AllowedResourceActions =  @("microsoft.directory/applications/basic/read")
            {Set-EntraMSRoleDefinition -Id "54d418b2-4cc0-47ee-9b39-e8f84ed8e073"  -DisplayName  } | Should -Throw "Missing an argument for parameter 'DisplayName'*"
        }
        It "Should fail when ResourceScopes is empty" {
            $RolePermissions = New-object Microsoft.Open.MSGraph.Model.RolePermission
            $RolePermissions.AllowedResourceActions =  @("microsoft.directory/applications/basic/read")
            {Set-EntraMSRoleDefinition -Id "54d418b2-4cc0-47ee-9b39-e8f84ed8e073" -ResourceScopes } | Should -Throw "Missing an argument for parameter 'ResourceScopes'*"
        }
        It "Should fail when Description is empty" {
            $RolePermissions = New-object Microsoft.Open.MSGraph.Model.RolePermission
            $RolePermissions.AllowedResourceActions =  @("microsoft.directory/applications/basic/read")
            {Set-EntraMSRoleDefinition -Id "54d418b2-4cc0-47ee-9b39-e8f84ed8e073" -Description } | Should -Throw "Missing an argument for parameter 'Description'*"
        }
        It "Should fail when TemplateId is empty" {
            $RolePermissions = New-object Microsoft.Open.MSGraph.Model.RolePermission
            $RolePermissions.AllowedResourceActions =  @("microsoft.directory/applications/basic/read")
            {Set-EntraMSRoleDefinition -Id "54d418b2-4cc0-47ee-9b39-e8f84ed8e073"  -TemplateId } | Should -Throw "Missing an argument for parameter 'TemplateId'*"
        }
        It "Should fail when Version is empty" {
            $RolePermissions = New-object Microsoft.Open.MSGraph.Model.RolePermission
            $RolePermissions.AllowedResourceActions =  @("microsoft.directory/applications/basic/read")
            {Set-EntraMSRoleDefinition -Id "54d418b2-4cc0-47ee-9b39-e8f84ed8e073" -Version } | Should -Throw "Missing an argument for parameter 'Version'*"
        }
        It "Should contain UnifiedRoleDefinitionId in parameters when passed Id to it" {
            Mock -CommandName Update-MgRoleManagementDirectoryRoleDefinition -MockWith {$args} -ModuleName Microsoft.Graph.Entra

            $RolePermissions = New-object Microsoft.Open.MSGraph.Model.RolePermission
            $RolePermissions.AllowedResourceActions =  @("microsoft.directory/applications/basic/read")
            $result = Set-EntraMSRoleDefinition -Id "54d418b2-4cc0-47ee-9b39-e8f84ed8e073" -RolePermissions $RolePermissions -IsEnabled $false -DisplayName 'Mock-App' -ResourceScopes "/" -Description "Mock-App" -TemplateId "4dd5aa9c-cf4d-4895-a993-740d342802b1" -Version 2
            $params = Get-Parameters -data $result
            $params.UnifiedRoleDefinitionId | Should -Be "54d418b2-4cc0-47ee-9b39-e8f84ed8e073"
        }
        It "Should contain 'User-Agent' header" {
            Mock -CommandName Update-MgRoleManagementDirectoryRoleDefinition -MockWith {$args} -ModuleName Microsoft.Graph.Entra

            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Set-EntraMSRoleDefinition"

            $RolePermissions = New-object Microsoft.Open.MSGraph.Model.RolePermission
            $RolePermissions.AllowedResourceActions =  @("microsoft.directory/applications/basic/read")
            $result = Set-EntraMSRoleDefinition -Id "54d418b2-4cc0-47ee-9b39-e8f84ed8e073" -RolePermissions $RolePermissions -IsEnabled $false -DisplayName 'Mock-App' -ResourceScopes "/" -Description "Mock-App" -TemplateId "4dd5aa9c-cf4d-4895-a993-740d342802b1" -Version 2
            $params = Get-Parameters -data $result
            $params.Headers["User-Agent"] | Should -Be $userAgentHeaderValue
        }


    }
}        