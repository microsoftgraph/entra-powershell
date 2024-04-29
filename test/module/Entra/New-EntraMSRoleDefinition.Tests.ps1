BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra) -eq $null){
        Import-Module Microsoft.Graph.Entra      
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force
    
    $scriptblock = {
        return @(
            [PSCustomObject]@{
              "RolePermissions"              = {"Microsoft.Graph.PowerShell.Models.MicrosoftGraphUnifiedRolePermission"}
              "Description"                  = "Mock-App"
              "DisplayName"                  = "Mock-App"
              "Id"                           = "54d418b2-4cc0-47ee-9b39-e8f84ed8e073"
              "InheritsPermissionsFrom"      = {}
              "IsBuiltIn"                    = $False
              "IsEnabled"                    = $False
              "ResourceScopes"               = {/}
              "TemplateId"                   = "4dd5aa9c-cf4d-4895-a993-740d342802b1"
              "Version"                      = "2"
              "RoleDefinitionId"             = "54d418b2-4cc0-47ee-9b39-e8f84ed8e073"
              "AdditionalProperties"         = @{"@odata.context" = "https://graph.microsoft.com/v1.0/$metadata#roleManagement/directory/roleDefinitions/$entity"
                                                }
              "Parameters"                   = $args
            }
        )
    }

    Mock -CommandName New-MgRoleManagementDirectoryRoleDefinition -MockWith $scriptblock -ModuleName Microsoft.Graph.Entra
}

Describe "New-EntraMSRoleDefinition" {
    Context "Test for New-EntraMSRoleDefinition" {
        It "Should return specific Ms role Defination" {
            $RolePermissions = New-object Microsoft.Open.MSGraph.Model.RolePermission
            $RolePermissions.AllowedResourceActions =  @("microsoft.directory/applications/basic/read")
            $result = New-EntraMSRoleDefinition -RolePermissions $RolePermissions -IsEnabled $false -DisplayName 'Mock-App' -ResourceScopes "/" -Description "Mock-App" -TemplateId "4dd5aa9c-cf4d-4895-a993-740d342802b1" -Version 2
            $result | Should -Not -BeNullOrEmpty
            $result.DisplayName | Should -Be "Mock-App"
            $result.Id | Should -Be "54d418b2-4cc0-47ee-9b39-e8f84ed8e073"
            $result.IsEnabled | Should -Be $False
            $result.TemplateId | Should -Be "4dd5aa9c-cf4d-4895-a993-740d342802b1"
            $result.Version | Should -Be 2


            Should -Invoke -CommandName New-MgRoleManagementDirectoryRoleDefinition  -ModuleName Microsoft.Graph.Entra -Times 1
        }
        It "Should fail when RolePermissions is empty" {
            {New-EntraMSRoleDefinition -RolePermissions  -IsEnabled $false -DisplayName 'Mock-App' -ResourceScopes "/" -Description "Mock-App" -TemplateId "4dd5aa9c-cf4d-4895-a993-740d342802b1" -Version 2} | Should -Throw "Missing an argument for parameter 'RolePermissions'*"
        }
        It "Should fail when IsEnabled is empty" {
            $RolePermissions = New-object Microsoft.Open.MSGraph.Model.RolePermission
            $RolePermissions.AllowedResourceActions =  @("microsoft.directory/applications/basic/read")
            {New-EntraMSRoleDefinition -RolePermissions $RolePermissions -IsEnabled  -DisplayName 'Mock-App' -ResourceScopes "/" -Description "Mock-App" -TemplateId "4dd5aa9c-cf4d-4895-a993-740d342802b1" -Version 2} | Should -Throw "Missing an argument for parameter 'IsEnabled'*"
        }
        It "Should fail when IsEnabled is invalid" {
            $RolePermissions = New-object Microsoft.Open.MSGraph.Model.RolePermission
            $RolePermissions.AllowedResourceActions =  @("microsoft.directory/applications/basic/read")
            {New-EntraMSRoleDefinition -RolePermissions $RolePermissions -IsEnabled xy -DisplayName 'Mock-App' -ResourceScopes "/" -Description "Mock-App" -TemplateId "4dd5aa9c-cf4d-4895-a993-740d342802b1" -Version 2} | Should -Throw "Cannot process argument transformation on parameter 'IsEnabled'*"
        }
        It "Should fail when DisplayName is empty" {
            $RolePermissions = New-object Microsoft.Open.MSGraph.Model.RolePermission
            $RolePermissions.AllowedResourceActions =  @("microsoft.directory/applications/basic/read")
            {New-EntraMSRoleDefinition -RolePermissions $RolePermissions -IsEnabled $false -DisplayName  -ResourceScopes "/" -Description "Mock-App" -TemplateId "4dd5aa9c-cf4d-4895-a993-740d342802b1" -Version 2} | Should -Throw "Missing an argument for parameter 'DisplayName'*"
        }
        It "Should fail when DisplayName is invalid" {
            $RolePermissions = New-object Microsoft.Open.MSGraph.Model.RolePermission
            $RolePermissions.AllowedResourceActions =  @("microsoft.directory/applications/basic/read")
            {New-EntraMSRoleDefinition -RolePermissions $RolePermissions -IsEnabled $false -DisplayName "" -ResourceScopes "/" -Description "Mock-App" -TemplateId "4dd5aa9c-cf4d-4895-a993-740d342802b1" -Version 2} | Should -Throw "Cannot bind argument to parameter 'DisplayName' because it is an empty string."
        }
        It "Should fail when ResourceScopes is empty" {
            $RolePermissions = New-object Microsoft.Open.MSGraph.Model.RolePermission
            $RolePermissions.AllowedResourceActions =  @("microsoft.directory/applications/basic/read")
            {New-EntraMSRoleDefinition -RolePermissions $RolePermissions -IsEnabled $false -DisplayName 'Mock-App' -ResourceScopes  -Description "Mock-App" -TemplateId "4dd5aa9c-cf4d-4895-a993-740d342802b1" -Version 2} | Should -Throw "Missing an argument for parameter 'ResourceScopes'*"
        }
        It "Should fail when Description is empty" {
            $RolePermissions = New-object Microsoft.Open.MSGraph.Model.RolePermission
            $RolePermissions.AllowedResourceActions =  @("microsoft.directory/applications/basic/read")
            {New-EntraMSRoleDefinition -RolePermissions $RolePermissions -IsEnabled $false -DisplayName 'Mock-App' -ResourceScopes "/"  -Description -TemplateId "4dd5aa9c-cf4d-4895-a993-740d342802b1" -Version 2} | Should -Throw "Missing an argument for parameter 'Description'*"
        }
        It "Should fail when TemplateId is empty" {
            $RolePermissions = New-object Microsoft.Open.MSGraph.Model.RolePermission
            $RolePermissions.AllowedResourceActions =  @("microsoft.directory/applications/basic/read")
            {New-EntraMSRoleDefinition -RolePermissions $RolePermissions -IsEnabled $false -DisplayName 'Mock-App' -ResourceScopes "/"  -Description "Mock-App" -TemplateId  -Version 2} | Should -Throw "Missing an argument for parameter 'TemplateId'*"
        }
        It "Should fail when Version is empty" {
            $RolePermissions = New-object Microsoft.Open.MSGraph.Model.RolePermission
            $RolePermissions.AllowedResourceActions =  @("microsoft.directory/applications/basic/read")
            {New-EntraMSRoleDefinition -RolePermissions $RolePermissions -IsEnabled $false -DisplayName 'Mock-App' -ResourceScopes "/"  -Description "Mock-App" -TemplateId "4dd5aa9c-cf4d-4895-a993-740d342802b1"-Version } | Should -Throw "Missing an argument for parameter 'Version'*"
        }
        It "Result should Contain ObjectId" {
            $result = $RolePermissions = New-object Microsoft.Open.MSGraph.Model.RolePermission
            $RolePermissions.AllowedResourceActions =  @("microsoft.directory/applications/basic/read")
            $result = New-EntraMSRoleDefinition -RolePermissions $RolePermissions -IsEnabled $false -DisplayName 'Mock-App' -ResourceScopes "/" -Description "Mock-App" -TemplateId "4dd5aa9c-cf4d-4895-a993-740d342802b1" -Version 2
            $result.ObjectId | should -Be "54d418b2-4cc0-47ee-9b39-e8f84ed8e073"
        }
        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion New-EntraMSRoleDefinition"
            $RolePermissions = New-object Microsoft.Open.MSGraph.Model.RolePermission
            $RolePermissions.AllowedResourceActions =  @("microsoft.directory/applications/basic/read")
            $result = New-EntraMSRoleDefinition -RolePermissions $RolePermissions -IsEnabled $false -DisplayName 'Mock-App' -ResourceScopes "/" -Description "Mock-App" -TemplateId "4dd5aa9c-cf4d-4895-a993-740d342802b1" -Version 2
            $params = Get-Parameters -data $result.Parameters
            $params.Headers["User-Agent"] | Should -Be $userAgentHeaderValue
        }

    }
}       
