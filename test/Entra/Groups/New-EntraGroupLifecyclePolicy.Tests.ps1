# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
BeforeAll {  
    if ((Get-Module -Name Microsoft.Entra.Groups) -eq $null) {
        Import-Module Microsoft.Entra.Groups      
    }
    Import-Module (Join-Path $PSScriptRoot "..\..\Common-Functions.ps1") -Force
    
    $scriptblock = {
        return @(
            [PSCustomObject]@{
                "Id"                          = "22cc22cc-dd33-ee44-ff55-66aa66aa66aa"
                "AlternateNotificationEmails" = "example@contoso.com"
                "GroupLifetimeInDays"         = "99"
                "ManagedGroupTypes"           = "Selected"
                "Parameters"                  = $args
            }
        )
    }

    Mock -CommandName New-MgGroupLifecyclePolicy -MockWith $scriptblock -ModuleName Microsoft.Entra.Groups
    Mock -CommandName Get-EntraContext -MockWith { @{Scopes = @("Directory.ReadWrite.All") } } -ModuleName Microsoft.Entra.Groups
}
  
Describe "New-EntraGroupLifecyclePolicy" {
    Context "Test for New-EntraGroupLifecyclePolicy" {
        It "Should return created GroupLifecyclePolicy" {
            $result = New-EntraGroupLifecyclePolicy -GroupLifetimeInDays 99 -ManagedGroupTypes "Selected" -AlternateNotificationEmails "example@contoso.com"
            $result | Should -Not -BeNullOrEmpty
            $result.Id | should -Be "22cc22cc-dd33-ee44-ff55-66aa66aa66aa"
            $result.GroupLifetimeInDays | should -Be "99"
            $result.ManagedGroupTypes | should -Be "Selected"
            $result.AlternateNotificationEmails | should -Be "example@contoso.com"

            Should -Invoke -CommandName New-MgGroupLifecyclePolicy -ModuleName Microsoft.Entra.Groups -Times 1
        }
        It "Should fail when GroupLifetimeInDays is invalid" {
            { New-EntraGroupLifecyclePolicy -GroupLifetimeInDays a -ManagedGroupTypes "Selected" -AlternateNotificationEmails "example@contoso.com" } | Should -Throw "Cannot process argument transformation on parameter 'GroupLifetimeInDays'.*"
        }
        It "Should fail when GroupLifetimeInDays is empty" {
            { New-EntraGroupLifecyclePolicy -GroupLifetimeInDays -ManagedGroupTypes "Selected" -AlternateNotificationEmails "example@contoso.com" } | Should -Throw "Missing an argument for parameter 'GroupLifetimeInDays'.*"
        } 

        It "Should fail when ManagedGroupTypes is empty" {
            { New-EntraGroupLifecyclePolicy -GroupLifetimeInDays 99 -ManagedGroupTypes -AlternateNotificationEmails "example@contoso.com" } | Should -Throw "Missing an argument for parameter 'ManagedGroupTypes'.*"
        }

        It "Should fail when AlternateNotificationEmails is empty" {
            { New-EntraGroupLifecyclePolicy -GroupLifetimeInDays 99 -ManagedGroupTypes "Selected" -AlternateNotificationEmails } | Should -Throw "Missing an argument for parameter 'AlternateNotificationEmails'.*"
        }
        It "Result should Contain ObjectId" {
            $result = New-EntraGroupLifecyclePolicy -GroupLifetimeInDays 99 -ManagedGroupTypes "Selected" -AlternateNotificationEmails "example@contoso.com"
            $result.ObjectId | should -Be "22cc22cc-dd33-ee44-ff55-66aa66aa66aa"
        } 
        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion New-EntraGroupLifecyclePolicy"

            $result = New-EntraGroupLifecyclePolicy -GroupLifetimeInDays 99 -ManagedGroupTypes "Selected" -AlternateNotificationEmails "example@contoso.com"
            $result | Should -Not -BeNullOrEmpty

            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion New-EntraGroupLifecyclePolicy"

            Should -Invoke -CommandName New-MgGroupLifecyclePolicy -ModuleName Microsoft.Entra.Groups -Times 1 -ParameterFilter {
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
                { New-EntraGroupLifecyclePolicy -GroupLifetimeInDays 99 -ManagedGroupTypes "Selected" -AlternateNotificationEmails "example@contoso.com" -Debug } | Should -Not -Throw
            }
            finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        }
    }
}

