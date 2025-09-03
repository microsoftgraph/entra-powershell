# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
BeforeAll {  
    if ((Get-Module -Name Microsoft.Entra.SignIns) -eq $null) {
        Import-Module Microsoft.Entra.SignIns      
    }
    Import-Module (Join-Path $PSScriptRoot "..\..\Common-Functions.ps1") -Force
    
    $scriptblock = {
        return @(
            [PSCustomObject]@{
                "Id"              = "my_new_permission_grant_policy_id"
                "DeletedDateTime" = "2/8/2024 6:39:16 AM"
                "Description"     = "My new permission grant policy"
                "DisplayName"     = "My new permission grant policy"
                "Excludes"        = @{}
                "Includes"        = @("22cc22cc-dd33-ee44-ff55-66aa66aa66aa")
                "Parameters"      = $args
            }
        )
    }

    Mock -CommandName New-MgPolicyPermissionGrantPolicy -MockWith $scriptblock -ModuleName Microsoft.Entra.SignIns
    Mock -CommandName Get-EntraContext -MockWith { @{Scopes = @('Policy.ReadWrite.PermissionGrant') } } -ModuleName Microsoft.Entra.SignIns
}
  
Describe "New-EntraPermissionGrantPolicy" {
    Context "Test for New-EntraPermissionGrantPolicy" {
        It "Should return created PermissionGrantPolicy" {
            $result = New-EntraPermissionGrantPolicy -Id "my_new_permission_grant_policy_id" -DisplayName "MyNewPermissionGrantPolicy" -Description "My new permission grant policy" 
            $result | Should -Not -BeNullOrEmpty
            $result.Id | should -Be "my_new_permission_grant_policy_id"
            $result.DisplayName | should -Be "My new permission grant policy"
            $result.Description | should -Be "My new permission grant policy"
            $result.Includes | should -Be @("22cc22cc-dd33-ee44-ff55-66aa66aa66aa")
            $result.DeletedDateTime | should -Be "2/8/2024 6:39:16 AM"

            Should -Invoke -CommandName New-MgPolicyPermissionGrantPolicy -ModuleName Microsoft.Entra.SignIns -Times 1
        }
        It "Should fail when Id is empty" {
            { New-EntraPermissionGrantPolicy -Id -DisplayName "MyNewPermissionGrantPolicy" -Description "My new permission grant policy" } | Should -Throw "Missing an argument for parameter 'Id'.*"
        }
        It "Should fail when DisplayName is empty" {
            { New-EntraPermissionGrantPolicy -Id "my_new_permission_grant_policy_id"  -DisplayName -Description "My new permission grant policy" } | Should -Throw "Missing an argument for parameter 'DisplayName'.*"
        } 
        It "Should fail when Description is empty" {
            { New-EntraPermissionGrantPolicy -Id "my_new_permission_grant_policy_id"  -DisplayName "MyNewPermissionGrantPolicy" -Description } | Should -Throw "Missing an argument for parameter 'Description'.*"
        }
        It "Result should Contain ObjectId" {
            $result = New-EntraPermissionGrantPolicy -Id "my_new_permission_grant_policy_id" -DisplayName "MyNewPermissionGrantPolicy" -Description "My new permission grant policy" 
            $result.ObjectId | should -Be "my_new_permission_grant_policy_id"
        } 
        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion New-EntraPermissionGrantPolicy"

            $result = New-EntraPermissionGrantPolicy -Id "my_new_permission_grant_policy_id" -DisplayName "MyNewPermissionGrantPolicy" -Description "My new permission grant policy" 
            $result | Should -Not -BeNullOrEmpty

            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion New-EntraPermissionGrantPolicy"

            Should -Invoke -CommandName New-MgPolicyPermissionGrantPolicy -ModuleName Microsoft.Entra.SignIns -Times 1 -ParameterFilter {
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
                { New-EntraPermissionGrantPolicy -Id "my_new_permission_grant_policy_id" -DisplayName "MyNewPermissionGrantPolicy" -Description "My new permission grant policy"  -Debug } | Should -Not -Throw
            } finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        }
    }
}

