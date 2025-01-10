# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
BeforeAll {  
    if((Get-Module -Name Microsoft.Entra.Groups) -eq $null){
        Import-Module Microsoft.Entra.Groups        
    }
    Import-Module (Join-Path $PSScriptRoot "..\..\Common-Functions.ps1") -Force
    
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
    Mock -CommandName Get-MgGroupLifecyclePolicyByGroup -MockWith $scriptblock -ModuleName Microsoft.Entra.Groups
}
  
Describe "Get-EntraLifecyclePolicyGroup" {
    Context "Test for Get-EntraLifecyclePolicyGroup" {
        It "Retrieve lifecycle policy object" {
            $result = Get-EntraLifecyclePolicyGroup -GroupId "11bb11bb-cc22-dd33-ee44-55ff55ff55ff"
            $result | Should -Not -BeNullOrEmpty
            $result.ObjectId | should -Be '00aa00aa-bb11-cc22-dd33-44ee44ee44ee'
            $result.GroupLifetimeInDays | Should -Be 200
            $result.AlternateNotificationEmails | Should -Be "admingroup@contoso.com"
            $result.Id | Should -Be "00aa00aa-bb11-cc22-dd33-44ee44ee44ee"
            $result.ManagedGroupTypes | Should -Be "All"

            Should -Invoke -CommandName Get-MgGroupLifecyclePolicyByGroup -ModuleName Microsoft.Entra.Groups -Times 1
        }

        It "Retrieve lifecycle policy object with alias" {
            $result = Get-EntraLifecyclePolicyGroup -Id "11bb11bb-cc22-dd33-ee44-55ff55ff55ff"
            $result | Should -Not -BeNullOrEmpty
            $result.ObjectId | should -Be '00aa00aa-bb11-cc22-dd33-44ee44ee44ee'
            $result.GroupLifetimeInDays | Should -Be 200
            $result.AlternateNotificationEmails | Should -Be "admingroup@contoso.com"
            $result.Id | Should -Be "00aa00aa-bb11-cc22-dd33-44ee44ee44ee"
            $result.ManagedGroupTypes | Should -Be "All"

            Should -Invoke -CommandName Get-MgGroupLifecyclePolicyByGroup -ModuleName Microsoft.Entra.Groups -Times 1
        }

        It "Should fail when GroupId is empty" {
            { Get-EntraLifecyclePolicyGroup -GroupId } | Should -Throw "Missing an argument for parameter 'GroupId'*"
        }

        It "Should fail when GroupId is invalid" {
            { Get-EntraLifecyclePolicyGroup -GroupId "" } | Should -Throw "Cannot bind argument to parameter 'GroupId' because it is an empty string."
        }

        It "Should contain GroupId in parameters when passed GroupId to it" {
            $result = Get-EntraLifecyclePolicyGroup -GroupId "11bb11bb-cc22-dd33-ee44-55ff55ff55ff"
            $params = Get-Parameters -data $result.Parameters
            $params.GroupId | Should -Be "11bb11bb-cc22-dd33-ee44-55ff55ff55ff"
        }

        It "Property parameter should work" {
            $result =  Get-EntraLifecyclePolicyGroup -GroupId "11bb11bb-cc22-dd33-ee44-55ff55ff55ff" -Property Id 
            $result | Should -Not -BeNullOrEmpty
            $result.Id | Should -Be "00aa00aa-bb11-cc22-dd33-44ee44ee44ee"

            Should -Invoke -CommandName Get-MgGroupLifecyclePolicyByGroup -ModuleName Microsoft.Entra.Groups -Times 1
        }

        It "Should fail when Property is empty" {
             { Get-EntraLifecyclePolicyGroup -GroupId "11bb11bb-cc22-dd33-ee44-55ff55ff55ff" -Property } | Should -Throw "Missing an argument for parameter 'Property'*"
        }

        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraLifecyclePolicyGroup"

            $result = Get-EntraLifecyclePolicyGroup -GroupId "11bb11bb-cc22-dd33-ee44-55ff55ff55ff"
            $result | Should -Not -BeNullOrEmpty

            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraLifecyclePolicyGroup"

            Should -Invoke -CommandName Get-MgGroupLifecyclePolicyByGroup -ModuleName Microsoft.Entra.Groups -Times 1 -ParameterFilter {
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
                {  Get-EntraLifecyclePolicyGroup -GroupId "11bb11bb-cc22-dd33-ee44-55ff55ff55ff" -Debug } | Should -Not -Throw
            } finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        }  
    }
}

