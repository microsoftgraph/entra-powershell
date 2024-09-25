# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra) -eq $null){
        Import-Module Microsoft.Graph.Entra        
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force
    
    $scriptblock = {
        return @(
            [PSCustomObject]@{
                "AlternateNotificationEmails"   = "admingroup@contoso.com"
                "GroupLifetimeInDays"           = 200
                "Id"                            = "00aa00aa-bb11-cc22-dd33-44ee44ee44ee"
                "ManagedGroupTypes"             = "All"
                "AdditionalProperties"          = @{}
                "Parameters"                    = $args
            }
        )
    }
    Mock -CommandName Get-MgGroupLifecyclePolicy -MockWith $scriptblock -ModuleName Microsoft.Graph.Entra
}
  
Describe "Get-EntraGroupLifecyclePolicy" {
    Context "Test for Get-EntraGroupLifecyclePolicy" {
        It "Retrieve all groupLifecyclePolicies" {
            $result = Get-EntraGroupLifecyclePolicy 
            $result | Should -Not -BeNullOrEmpty
            $result.GroupLifetimeInDays | Should -Be 200
            $result.AlternateNotificationEmails | Should -Be "admingroup@contoso.com"
            $result.Id | Should -Be "00aa00aa-bb11-cc22-dd33-44ee44ee44ee"
            $result.ManagedGroupTypes | Should -Be "All"    
            
            Should -Invoke -CommandName Get-MgGroupLifecyclePolicy -ModuleName Microsoft.Graph.Entra -Times 1
        }

        It "Retrieve properties of an groupLifecyclePolicy" {
            $result = Get-EntraGroupLifecyclePolicy -Id "00aa00aa-bb11-cc22-dd33-44ee44ee44ee"
            $result | Should -Not -BeNullOrEmpty
            $result.ObjectId | should -Be '00aa00aa-bb11-cc22-dd33-44ee44ee44ee'
            $result.GroupLifetimeInDays | Should -Be 200
            $result.AlternateNotificationEmails | Should -Be "admingroup@contoso.com"
            $result.Id | Should -Be "00aa00aa-bb11-cc22-dd33-44ee44ee44ee"
            $result.ManagedGroupTypes | Should -Be "All"

            Should -Invoke -CommandName Get-MgGroupLifecyclePolicy -ModuleName Microsoft.Graph.Entra -Times 1
        }

        It "Should fail when Id is empty" {
            { Get-EntraGroupLifecyclePolicy -Id } | Should -Throw "Missing an argument for parameter 'Id'*"
        }

        It "Should fail when Id is invalid" {
            { Get-EntraGroupLifecyclePolicy -Id "" } | Should -Throw "Cannot bind argument to parameter 'Id' because it is an empty string."
        }

        It "Should contain GroupLifecyclePolicyId in parameters when passed Id to it" {
            $result = Get-EntraGroupLifecyclePolicy -Id "00aa00aa-bb11-cc22-dd33-44ee44ee44ee"
            $params = Get-Parameters -data $result.Parameters
            $params.GroupLifecyclePolicyId | Should -Be "00aa00aa-bb11-cc22-dd33-44ee44ee44ee"
        }
        
        It "Property parameter should work" {
            $result =  Get-EntraGroupLifecyclePolicy -Id "00aa00aa-bb11-cc22-dd33-44ee44ee44ee" -Property Id 
            $result | Should -Not -BeNullOrEmpty
            $result.Id | Should -Be "00aa00aa-bb11-cc22-dd33-44ee44ee44ee"

            Should -Invoke -CommandName Get-MgGroupLifecyclePolicy -ModuleName Microsoft.Graph.Entra -Times 1
        }

        It "Should fail when Property is empty" {
             { Get-EntraGroupLifecyclePolicy -Id "00aa00aa-bb11-cc22-dd33-44ee44ee44ee" -Property } | Should -Throw "Missing an argument for parameter 'Property'*"
        }

        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraGroupLifecyclePolicy"

            $result = Get-EntraGroupLifecyclePolicy -Id "00aa00aa-bb11-cc22-dd33-44ee44ee44ee"
            $result | Should -Not -BeNullOrEmpty

            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraGroupLifecyclePolicy"

            Should -Invoke -CommandName Get-MgGroupLifecyclePolicy -ModuleName Microsoft.Graph.Entra -Times 1 -ParameterFilter {
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
                { Get-EntraGroupLifecyclePolicy -Id "00aa00aa-bb11-cc22-dd33-44ee44ee44ee" -Debug } | Should -Not -Throw
            } finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        }  
    }
}