# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
BeforeAll {  
    if ((Get-Module -Name Microsoft.Entra.Beta.Groups) -eq $null) {
        Import-Module Microsoft.Entra.Beta.Groups      
    }
    Import-Module (Join-Path $PSScriptRoot "..\..\Common-Functions.ps1") -Force
    
    $scriptblock = {
        return @(
            [PSCustomObject]@{
                "Id"                          = "22cc22cc-dd33-ee44-ff55-66aa66aa66aa"
                "AlternateNotificationEmails" = "admingroup@contoso.com"
                "GroupLifetimeInDays"         = "100"
                "ManagedGroupTypes"           = "All"
                "Parameters"                  = $args
            }
        )
    }

    Mock -CommandName Update-MgBetaGroupLifecyclePolicy -MockWith $scriptblock -ModuleName Microsoft.Entra.Beta.Groups
    Mock -CommandName Get-EntraContext -MockWith { @{Scopes = @("Directory.ReadWrite.All") } } -ModuleName Microsoft.Entra.Beta.Groups
}
  
Describe "Set-EntraBetaGroupLifecyclePolicy" {
    Context "Test for Set-EntraBetaGroupLifecyclePolicy" {
        It "Should return updated GroupLifecyclePolicy" {
            $result = Set-EntraBetaGroupLifecyclePolicy -GroupLifecyclePolicyId "a47d4510-08c8-4437-99e9-71ca88e7af0f" -GroupLifetimeInDays 200 -AlternateNotificationEmails "admingroup@contoso.com" -ManagedGroupTypes "All"
            $result | Should -Not -BeNullOrEmpty
            $result.Id | should -Be "22cc22cc-dd33-ee44-ff55-66aa66aa66aa"
            $result.GroupLifetimeInDays | should -Be "100"
            $result.ManagedGroupTypes | should -Be "All"
            $result.AlternateNotificationEmails | should -Be "admingroup@contoso.com"

            Should -Invoke -CommandName Update-MgBetaGroupLifecyclePolicy -ModuleName Microsoft.Entra.Beta.Groups -Times 1
        }
        It "Should execute successfully with Alias" {
            $result = Set-EntraBetaGroupLifecyclePolicy -Id "a47d4510-08c8-4437-99e9-71ca88e7af0f" -GroupLifetimeInDays 200 -AlternateNotificationEmails "admingroup@contoso.com" -ManagedGroupTypes "All"
            $result | Should -Not -BeNullOrEmpty
        }

        It "Should fail when GroupLifecyclePolicyId is empty" {
            { Set-EntraBetaGroupLifecyclePolicy -GroupLifecyclePolicyId -GroupLifetimeInDays -ManagedGroupTypes "Selected" -AlternateNotificationEmails "example@contoso.com" } | Should -Throw "Missing an argument for parameter 'GroupLifecyclePolicyId'.*"
        } 
        It "Should fail when GroupLifetimeInDays is invalid" {
            { Set-EntraBetaGroupLifecyclePolicy -GroupLifecyclePolicyId "22cc22cc-dd33-ee44-ff55-66aa66aa66aa" -GroupLifetimeInDays a -ManagedGroupTypes "Selected" -AlternateNotificationEmails "example@contoso.com" } | Should -Throw "Cannot process argument transformation on parameter 'GroupLifetimeInDays'.*"
        }
        It "Should fail when GroupLifetimeInDays is empty" {
            { Set-EntraBetaGroupLifecyclePolicy -GroupLifecyclePolicyId "22cc22cc-dd33-ee44-ff55-66aa66aa66aa" -GroupLifetimeInDays -ManagedGroupTypes "Selected" -AlternateNotificationEmails "example@contoso.com" } | Should -Throw "Missing an argument for parameter 'GroupLifetimeInDays'.*"
        } 
        It "Should fail when ManagedGroupTypes is empty" {
            { Set-EntraBetaGroupLifecyclePolicy -GroupLifecyclePolicyId "22cc22cc-dd33-ee44-ff55-66aa66aa66aa" -GroupLifetimeInDays 99 -ManagedGroupTypes -AlternateNotificationEmails "example@contoso.com" } | Should -Throw "Missing an argument for parameter 'ManagedGroupTypes'.*"
        }
        It "Should fail when AlternateNotificationEmails is empty" {
            { Set-EntraBetaGroupLifecyclePolicy -GroupLifecyclePolicyId "22cc22cc-dd33-ee44-ff55-66aa66aa66aa" -GroupLifetimeInDays 99 -ManagedGroupTypes "Selected" -AlternateNotificationEmails } | Should -Throw "Missing an argument for parameter 'AlternateNotificationEmails'.*"
        }
        It "Result should Contain ObjectId" {
            $result = Set-EntraBetaGroupLifecyclePolicy -GroupLifecyclePolicyId "22cc22cc-dd33-ee44-ff55-66aa66aa66aa" -GroupLifetimeInDays 200 -AlternateNotificationEmails "admingroup@contoso.com" -ManagedGroupTypes "All"
            $result.ObjectId | should -Be "22cc22cc-dd33-ee44-ff55-66aa66aa66aa"
        } 
        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Set-EntraBetaGroupLifecyclePolicy"
            $result = Set-EntraBetaGroupLifecyclePolicy -GroupLifecyclePolicyId "a47d4510-08c8-4437-99e9-71ca88e7af0f" -GroupLifetimeInDays 200 -AlternateNotificationEmails "admingroup@contoso.com" -ManagedGroupTypes "All"
            $result | Should -Not -BeNullOrEmpty

            Should -Invoke -CommandName Update-MgBetaGroupLifecyclePolicy -ModuleName Microsoft.Entra.Beta.Groups -Times 1 -ParameterFilter {
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
                { Set-EntraBetaGroupLifecyclePolicy -GroupLifecyclePolicyId "22cc22cc-dd33-ee44-ff55-66aa66aa66aa" -GroupLifetimeInDays 200 -AlternateNotificationEmails "admingroup@contoso.com" -ManagedGroupTypes "All" -Debug } | Should -Not -Throw
            }
            finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        }
    }
}

