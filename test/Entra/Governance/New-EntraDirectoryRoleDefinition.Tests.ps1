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
              "RolePermissions"              = {"Microsoft.Graph.PowerShell.Models.MicrosoftGraphUnifiedRolePermission"}
              "Description"                  = "Mock-App"
              "DisplayName"                  = "Mock-App"
              "Id"                           = "00aa00aa-bb11-cc22-dd33-44ee44ee44ee"
              "InheritsPermissionsFrom"      = {}
              "IsBuiltIn"                    = $False
              "IsEnabled"                    = $False
              "ResourceScopes"               = {/}
              "TemplateId"                   = "11bb11bb-cc22-dd33-ee44-55ff55ff55ff"
              "Version"                      = "2"
              "RoleDefinitionId"             = "22cc22cc-dd33-ee44-ff55-66aa66aa66aa"
              "AdditionalProperties"         = @{"@odata.context" = "https://graph.microsoft.com/v1.0/`$metadata#roleManagement/directory/roleDefinitions/`$entity"
                                                }
              "Parameters"                   = $args
            }
        )
    }

    Mock -CommandName New-MgRoleManagementDirectoryRoleDefinition -MockWith $scriptblock -ModuleName Microsoft.Entra.Governance

    Mock -CommandName Get-EntraContext -MockWith {
        @{
            Environment = @{
                Name = "Global"
            }
            Scopes      = @('RoleManagement.ReadWrite.Directory')
        }
    } -ModuleName Microsoft.Entra.Applications
}

Describe "New-EntraDirectoryRoleDefinition" {
    Context "Test for New-EntraDirectoryRoleDefinition" {
        It "Should return specific Ms role Defination" {
            $RolePermissions = New-object Microsoft.Open.MSGraph.Model.RolePermission
            $RolePermissions.AllowedResourceActions =  @("microsoft.directory/applications/basic/read")
            $result = New-EntraDirectoryRoleDefinition -RolePermissions $RolePermissions -IsEnabled $false -DisplayName 'Mock-App' -ResourceScopes "/" -Description "Mock-App" -TemplateId "4dd5aa9c-cf4d-4895-a993-740d342802b1" -Version 2
            $result | Should -Not -BeNullOrEmpty
            $result.DisplayName | Should -Be "Mock-App"
            $result.Id | Should -Be "00aa00aa-bb11-cc22-dd33-44ee44ee44ee"
            $result.IsEnabled | Should -Be $False
            $result.TemplateId | Should -Be "11bb11bb-cc22-dd33-ee44-55ff55ff55ff"
            $result.Version | Should -Be 2


            Should -Invoke -CommandName New-MgRoleManagementDirectoryRoleDefinition  -ModuleName Microsoft.Entra.Governance -Times 1
        }
        It "Should fail when RolePermissions is empty" {
            {New-EntraDirectoryRoleDefinition -RolePermissions  -IsEnabled $false -DisplayName 'Mock-App' -ResourceScopes "/" -Description "Mock-App" -TemplateId "11bb11bb-cc22-dd33-ee44-55ff55ff55ff" -Version 2} | Should -Throw "Missing an argument for parameter 'RolePermissions'*"
        }
        It "Should fail when IsEnabled is empty" {
            $RolePermissions = New-object Microsoft.Open.MSGraph.Model.RolePermission
            $RolePermissions.AllowedResourceActions =  @("microsoft.directory/applications/basic/read")
            {New-EntraDirectoryRoleDefinition -RolePermissions $RolePermissions -IsEnabled  -DisplayName 'Mock-App' -ResourceScopes "/" -Description "Mock-App" -TemplateId "11bb11bb-cc22-dd33-ee44-55ff55ff55ff" -Version 2} | Should -Throw "Missing an argument for parameter 'IsEnabled'*"
        }
        It "Should fail when IsEnabled is invalid" {
            $RolePermissions = New-object Microsoft.Open.MSGraph.Model.RolePermission
            $RolePermissions.AllowedResourceActions =  @("microsoft.directory/applications/basic/read")
            {New-EntraDirectoryRoleDefinition -RolePermissions $RolePermissions -IsEnabled xy -DisplayName 'Mock-App' -ResourceScopes "/" -Description "Mock-App" -TemplateId "11bb11bb-cc22-dd33-ee44-55ff55ff55ff" -Version 2} | Should -Throw "Cannot process argument transformation on parameter 'IsEnabled'*"
        }
        It "Should fail when DisplayName is empty" {
            $RolePermissions = New-object Microsoft.Open.MSGraph.Model.RolePermission
            $RolePermissions.AllowedResourceActions =  @("microsoft.directory/applications/basic/read")
            {New-EntraDirectoryRoleDefinition -RolePermissions $RolePermissions -IsEnabled $false -DisplayName  -ResourceScopes "/" -Description "Mock-App" -TemplateId "11bb11bb-cc22-dd33-ee44-55ff55ff55ff" -Version 2} | Should -Throw "Missing an argument for parameter 'DisplayName'*"
        }
        It "Should fail when DisplayName is invalid" {
            $RolePermissions = New-object Microsoft.Open.MSGraph.Model.RolePermission
            $RolePermissions.AllowedResourceActions =  @("microsoft.directory/applications/basic/read")
            {New-EntraDirectoryRoleDefinition -RolePermissions $RolePermissions -IsEnabled $false -DisplayName "" -ResourceScopes "/" -Description "Mock-App" -TemplateId "11bb11bb-cc22-dd33-ee44-55ff55ff55ff" -Version 2} | Should -Throw "Cannot bind argument to parameter 'DisplayName' because it is an empty string."
        }
        It "Should fail when ResourceScopes is empty" {
            $RolePermissions = New-object Microsoft.Open.MSGraph.Model.RolePermission
            $RolePermissions.AllowedResourceActions =  @("microsoft.directory/applications/basic/read")
            {New-EntraDirectoryRoleDefinition -RolePermissions $RolePermissions -IsEnabled $false -DisplayName 'Mock-App' -ResourceScopes  -Description "Mock-App" -TemplateId "11bb11bb-cc22-dd33-ee44-55ff55ff55ff" -Version 2} | Should -Throw "Missing an argument for parameter 'ResourceScopes'*"
        }
        It "Should fail when Description is empty" {
            $RolePermissions = New-object Microsoft.Open.MSGraph.Model.RolePermission
            $RolePermissions.AllowedResourceActions =  @("microsoft.directory/applications/basic/read")
            {New-EntraDirectoryRoleDefinition -RolePermissions $RolePermissions -IsEnabled $false -DisplayName 'Mock-App' -ResourceScopes "/"  -Description -TemplateId "11bb11bb-cc22-dd33-ee44-55ff55ff55ff" -Version 2} | Should -Throw "Missing an argument for parameter 'Description'*"
        }
        It "Should fail when TemplateId is empty" {
            $RolePermissions = New-object Microsoft.Open.MSGraph.Model.RolePermission
            $RolePermissions.AllowedResourceActions =  @("microsoft.directory/applications/basic/read")
            {New-EntraDirectoryRoleDefinition -RolePermissions $RolePermissions -IsEnabled $false -DisplayName 'Mock-App' -ResourceScopes "/"  -Description "Mock-App" -TemplateId  -Version 2} | Should -Throw "Missing an argument for parameter 'TemplateId'*"
        }
        It "Should fail when Version is empty" {
            $RolePermissions = New-object Microsoft.Open.MSGraph.Model.RolePermission
            $RolePermissions.AllowedResourceActions =  @("microsoft.directory/applications/basic/read")
            {New-EntraDirectoryRoleDefinition -RolePermissions $RolePermissions -IsEnabled $false -DisplayName 'Mock-App' -ResourceScopes "/"  -Description "Mock-App" -TemplateId "11bb11bb-cc22-dd33-ee44-55ff55ff55ff"-Version } | Should -Throw "Missing an argument for parameter 'Version'*"
        }
        It "Result should Contain ObjectId" {
            $result = $RolePermissions = New-object Microsoft.Open.MSGraph.Model.RolePermission
            $RolePermissions.AllowedResourceActions =  @("microsoft.directory/applications/basic/read")
            $result = New-EntraDirectoryRoleDefinition -RolePermissions $RolePermissions -IsEnabled $false -DisplayName 'Mock-App' -ResourceScopes "/" -Description "Mock-App" -TemplateId "11bb11bb-cc22-dd33-ee44-55ff55ff55ff" -Version 2
            $result.ObjectId | should -Be "00aa00aa-bb11-cc22-dd33-44ee44ee44ee"
        }
        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion New-EntraDirectoryRoleDefinition"

            $result = $RolePermissions = New-object Microsoft.Open.MSGraph.Model.RolePermission
            $RolePermissions.AllowedResourceActions =  @("microsoft.directory/applications/basic/read")
            $result = New-EntraDirectoryRoleDefinition -RolePermissions $RolePermissions -IsEnabled $false -DisplayName 'Mock-App' -ResourceScopes "/" -Description "Mock-App" -TemplateId "11bb11bb-cc22-dd33-ee44-55ff55ff55ff" -Version 2
            
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion New-EntraDirectoryRoleDefinition"

            Should -Invoke -CommandName New-MgRoleManagementDirectoryRoleDefinition -ModuleName Microsoft.Entra.Governance -Times 1 -ParameterFilter {
                $Headers.'User-Agent' | Should -Be $userAgentHeaderValue
                $true
            }
        }
        It "Should execute successfully without throwing an error" {
            # Disable confirmation prompts       
            $originalDebugPreference = $DebugPreference
            $DebugPreference = 'Continue'
            $RolePermissions = New-object Microsoft.Open.MSGraph.Model.RolePermission
            $RolePermissions.AllowedResourceActions =  @("microsoft.directory/applications/basic/read")

            try {
                # Act & Assert: Ensure the function doesn't throw an exception
                { New-EntraDirectoryRoleDefinition -RolePermissions $RolePermissions -IsEnabled $false -DisplayName 'Mock-App' -ResourceScopes "/" -Description "Mock-App" -TemplateId "11bb11bb-cc22-dd33-ee44-55ff55ff55ff" -Version 2 -Debug } | Should -Not -Throw
            } finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        }
    }
}       

