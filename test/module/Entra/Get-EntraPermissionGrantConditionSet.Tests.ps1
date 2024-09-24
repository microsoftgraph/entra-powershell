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
                "Id"                                          = "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
                "ClientApplicationIds"                        = {"All"}
                "ClientApplicationPublisherIds"               = {"All"}
                "ClientApplicationTenantIds"                  = {"All"}
                "ClientApplicationsFromVerifiedPublisherOnly" = $true
                "Parameters"                                  = $args
            }
        )
    }    

    Mock -CommandName Get-MgPolicyPermissionGrantPolicyInclude -MockWith $scriptblock -ModuleName Microsoft.Graph.Entra

    Mock -CommandName Get-MgPolicyPermissionGrantPolicyExclude -MockWith $scriptblock -ModuleName Microsoft.Graph.Entra
}
Describe "Get-EntraPermissionGrantConditionSet"{
    It "Should not return empty object for condition set 'includes'"{
        $result = Get-EntraPermissionGrantConditionSet -PolicyId "policy1" -ConditionSetType "includes" -Id "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
        $result | Should -Not -BeNullOrEmpty
        Should -Invoke -CommandName Get-MgPolicyPermissionGrantPolicyInclude -ModuleName Microsoft.Graph.Entra -Times 1
    }
    It "Should not return empty object for condition set 'excludes'"{
        $result = Get-EntraPermissionGrantConditionSet -PolicyId "policy1" -ConditionSetType "excludes" -Id "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
        $result | Should -Not -BeNullOrEmpty
        Should -Invoke -CommandName Get-MgPolicyPermissionGrantPolicyExclude -ModuleName Microsoft.Graph.Entra -Times 1
    }
    It "Should fail when parameters are empty" {
        { Get-EntraPermissionGrantConditionSet -PolicyId "" -ConditionSetType "" -Id ""} | Should -Throw "Cannot bind argument to parameter*"
    }
    It "Should fail when parameters are null" {
        { Get-EntraPermissionGrantConditionSet -PolicyId  -ConditionSetType  -Id} | Should -Throw "Missing an argument for parameter*"
    }
    It "Should contain PermissionGrantConditionSetId in parameters when passed Id to it" {              
        $result = Get-EntraPermissionGrantConditionSet -PolicyId "policy1" -ConditionSetType "includes" -Id "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
        $params = Get-Parameters -data $result.Parameters
        $params.PermissionGrantConditionSetId | Should -Be "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
    }
    It "Should contain PermissionGrantPolicyId in parameters when passed PolicyId to it" {              
        $result = Get-EntraPermissionGrantConditionSet -PolicyId "policy1" -ConditionSetType "includes" -Id "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
        $params = Get-Parameters -data $result.Parameters
        $params.PermissionGrantPolicyId | Should -Be "policy1"
    }
    It "Property parameter should work" {
        $result = Get-EntraPermissionGrantConditionSet -PolicyId "policy1" -ConditionSetType "includes" -Id "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"  -Property Id 
        $result | Should -Not -BeNullOrEmpty
        $result.Id | Should -Be "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"

        Should -Invoke -CommandName Get-MgPolicyPermissionGrantPolicyInclude -ModuleName Microsoft.Graph.Entra -Times 1
    }

    It "Should fail when Property is empty" {
         {Get-EntraPermissionGrantConditionSet -PolicyId "policy1" -ConditionSetType "includes" -Id "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"  -Property } | Should -Throw "Missing an argument for parameter 'Property'*"
    }
    It "Should contain 'User-Agent' header" {
        $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraPermissionGrantConditionSet"
        $result = Get-EntraPermissionGrantConditionSet -PolicyId "policy1" -ConditionSetType "includes" -Id "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
        $result | Should -Not -BeNullOrEmpty
        $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraPermissionGrantConditionSet"    
        Should -Invoke -CommandName Get-MgPolicyPermissionGrantPolicyInclude -ModuleName Microsoft.Graph.Entra -Times 1 -ParameterFilter {
            $Headers.'User-Agent' | Should -Be $userAgentHeaderValue
            $true
        }
    }
    It "Should execute successfully without throwing an error " {
        # Disable confirmation prompts       
        $originalDebugPreference = $DebugPreference
        $DebugPreference = 'Continue'

        try {
            # Act & Assert: Ensure the function doesn't throw an exception
            { Get-EntraPermissionGrantConditionSet -PolicyId "policy1" -ConditionSetType "includes" -Id "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -Debug } | Should -Not -Throw
        } finally {
            # Restore original confirmation preference            
            $DebugPreference = $originalDebugPreference        
        }
    } 
}