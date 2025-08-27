# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
BeforeAll {  
    if((Get-Module -Name Microsoft.Entra.Governance) -eq $null){
        Import-Module Microsoft.Entra.Governance       
    }
    Import-Module (Join-Path $PSScriptRoot "..\..\Common-Functions.ps1") -Force

    Mock -CommandName Update-MgRoleManagementDirectoryRoleDefinition -MockWith {} -ModuleName Microsoft.Entra.Governance

    Mock -CommandName Get-EntraContext -MockWith {
        @{
            Environment = @{
                Name = "Global"
            }
            Scopes      = @('RoleManagement.ReadWrite.Directory')
        }
    } -ModuleName Microsoft.Entra.Applications
}
  
Describe "Set-EntraDirectoryRoleDefinition" {
    Context "Test for Set-EntraDirectoryRoleDefinition" {
        It "Should return empty object" {
            $RolePermissions = New-object Microsoft.Open.MSGraph.Model.RolePermission
            $RolePermissions.AllowedResourceActions =  @("microsoft.directory/applications/basic/read")
            $result = Set-EntraDirectoryRoleDefinition -UnifiedRoleDefinitionId "00aa00aa-bb11-cc22-dd33-44ee44ee44ee" -RolePermissions $RolePermissions -IsEnabled $false -DisplayName 'Mock-App' -ResourceScopes "/" -Description "Mock-App" -TemplateId "11bb11bb-cc22-dd33-ee44-55ff55ff55ff" -Version 3
            $result | Should -BeNullOrEmpty

            Should -Invoke -CommandName Update-MgRoleManagementDirectoryRoleDefinition -ModuleName Microsoft.Entra.Governance -Times 1
        }
        It "Should execute successfully with Alias" {
            $RolePermissions = New-object Microsoft.Open.MSGraph.Model.RolePermission
            $RolePermissions.AllowedResourceActions =  @("microsoft.directory/applications/basic/read")
            $result = Set-EntraDirectoryRoleDefinition -Id "00aa00aa-bb11-cc22-dd33-44ee44ee44ee" -RolePermissions $RolePermissions -IsEnabled $false -DisplayName 'Mock-App' -ResourceScopes "/" -Description "Mock-App" -TemplateId "11bb11bb-cc22-dd33-ee44-55ff55ff55ff" -Version 3
            $result | Should -BeNullOrEmpty

            Should -Invoke -CommandName Update-MgRoleManagementDirectoryRoleDefinition -ModuleName Microsoft.Entra.Governance -Times 1
        }
        It "Should fail when UnifiedRoleDefinitionId is empty" {
            { Set-EntraDirectoryRoleDefinition -UnifiedRoleDefinitionId  -DisplayName 'Mock-App' -TemplateId "11bb11bb-cc22-dd33-ee44-55ff55ff55ff" } | Should -Throw "Missing an argument for parameter 'UnifiedRoleDefinitionId'*"
        }
        It "Should fail when UnifiedRoleDefinitionId is invalid" {
            { Set-EntraDirectoryRoleDefinition -UnifiedRoleDefinitionId "" -IsEnabled $false -DisplayName 'Mock-App' -TemplateId "11bb11bb-cc22-dd33-ee44-55ff55ff55ff" -Version 3  } | Should -Throw "Cannot bind argument to parameter 'UnifiedRoleDefinitionId' because it is an empty string*"
        }
        It "Should fail when RolePermissions is empty" {
            {Set-EntraDirectoryRoleDefinition -UnifiedRoleDefinitionId "00aa00aa-bb11-cc22-dd33-44ee44ee44ee" -RolePermissions  } | Should -Throw "Missing an argument for parameter 'RolePermissions'*"
        }
        It "Should fail when IsEnabled is empty" {
            $RolePermissions = New-object Microsoft.Open.MSGraph.Model.RolePermission
            $RolePermissions.AllowedResourceActions =  @("microsoft.directory/applications/basic/read")
            {Set-EntraDirectoryRoleDefinition -UnifiedRoleDefinitionId "00aa00aa-bb11-cc22-dd33-44ee44ee44ee"  -IsEnabled  } | Should -Throw "Missing an argument for parameter 'IsEnabled'*"
        }
        It "Should fail when DisplayName is empty" {
            $RolePermissions = New-object Microsoft.Open.MSGraph.Model.RolePermission
            $RolePermissions.AllowedResourceActions =  @("microsoft.directory/applications/basic/read")
            {Set-EntraDirectoryRoleDefinition -UnifiedRoleDefinitionId "00aa00aa-bb11-cc22-dd33-44ee44ee44ee"  -DisplayName  } | Should -Throw "Missing an argument for parameter 'DisplayName'*"
        }
        It "Should fail when ResourceScopes is empty" {
            $RolePermissions = New-object Microsoft.Open.MSGraph.Model.RolePermission
            $RolePermissions.AllowedResourceActions =  @("microsoft.directory/applications/basic/read")
            {Set-EntraDirectoryRoleDefinition -UnifiedRoleDefinitionId "00aa00aa-bb11-cc22-dd33-44ee44ee44ee" -ResourceScopes } | Should -Throw "Missing an argument for parameter 'ResourceScopes'*"
        }
        It "Should fail when Description is empty" {
            $RolePermissions = New-object Microsoft.Open.MSGraph.Model.RolePermission
            $RolePermissions.AllowedResourceActions =  @("microsoft.directory/applications/basic/read")
            {Set-EntraDirectoryRoleDefinition -UnifiedRoleDefinitionId "00aa00aa-bb11-cc22-dd33-44ee44ee44ee" -Description } | Should -Throw "Missing an argument for parameter 'Description'*"
        }
        It "Should fail when TemplateId is empty" {
            $RolePermissions = New-object Microsoft.Open.MSGraph.Model.RolePermission
            $RolePermissions.AllowedResourceActions =  @("microsoft.directory/applications/basic/read")
            {Set-EntraDirectoryRoleDefinition -UnifiedRoleDefinitionId "00aa00aa-bb11-cc22-dd33-44ee44ee44ee"  -TemplateId } | Should -Throw "Missing an argument for parameter 'TemplateId'*"
        }
        It "Should fail when Version is empty" {
            $RolePermissions = New-object Microsoft.Open.MSGraph.Model.RolePermission
            $RolePermissions.AllowedResourceActions =  @("microsoft.directory/applications/basic/read")
            {Set-EntraDirectoryRoleDefinition -UnifiedRoleDefinitionId "00aa00aa-bb11-cc22-dd33-44ee44ee44ee" -Version } | Should -Throw "Missing an argument for parameter 'Version'*"
        }
        It "Should contain UnifiedRoleDefinitionId in parameters when passed Id to it" {
            Mock -CommandName Update-MgRoleManagementDirectoryRoleDefinition -MockWith {$args} -ModuleName Microsoft.Entra.Governance

            $RolePermissions = New-object Microsoft.Open.MSGraph.Model.RolePermission
            $RolePermissions.AllowedResourceActions =  @("microsoft.directory/applications/basic/read")
            $result = Set-EntraDirectoryRoleDefinition -UnifiedRoleDefinitionId "00aa00aa-bb11-cc22-dd33-44ee44ee44ee" -RolePermissions $RolePermissions -IsEnabled $false -DisplayName 'Mock-App' -ResourceScopes "/" -Description "Mock-App" -TemplateId "11bb11bb-cc22-dd33-ee44-55ff55ff55ff" -Version 2
            $params = Get-Parameters -data $result
            $params.UnifiedRoleDefinitionId | Should -Be "00aa00aa-bb11-cc22-dd33-44ee44ee44ee"
        }
        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Set-EntraDirectoryRoleDefinition"

            $RolePermissions = New-object Microsoft.Open.MSGraph.Model.RolePermission
            $RolePermissions.AllowedResourceActions =  @("microsoft.directory/applications/basic/read")
            Set-EntraDirectoryRoleDefinition -UnifiedRoleDefinitionId "00aa00aa-bb11-cc22-dd33-44ee44ee44ee" -RolePermissions $RolePermissions -IsEnabled $false -DisplayName 'Mock-App' -ResourceScopes "/" -Description "Mock-App" -TemplateId "11bb11bb-cc22-dd33-ee44-55ff55ff55ff" -Version 2
            
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Set-EntraDirectoryRoleDefinition"

            Should -Invoke -CommandName Update-MgRoleManagementDirectoryRoleDefinition -ModuleName Microsoft.Entra.Governance -Times 1 -ParameterFilter {
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
                { Set-EntraDirectoryRoleDefinition -UnifiedRoleDefinitionId "00aa00aa-bb11-cc22-dd33-44ee44ee44ee" -RolePermissions $RolePermissions -IsEnabled $false -DisplayName 'Mock-App' -ResourceScopes "/" -Description "Mock-App" -TemplateId "11bb11bb-cc22-dd33-ee44-55ff55ff55ff" -Version 2 -Debug } | Should -Not -Throw
            } finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        }

    }
}        
