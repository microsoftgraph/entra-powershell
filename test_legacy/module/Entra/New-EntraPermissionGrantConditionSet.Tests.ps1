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
                "Id"                                          = "00aa00aa-bb11-cc22-dd33-44ee44ee44ee"
                "ClientApplicationIds"                        = {"All"}
                "ClientApplicationPublisherIds"               = {"All"}
                "ClientApplicationTenantIds"                  = {"All"}
                "ClientApplicationsFromVerifiedPublisherOnly" = $true
                "PermissionClassification"                    = "all"
                "PermissionType"                              = "delegated"
                "Parameters"                                  = $args
            }
        )
    }    

    Mock -CommandName New-MgPolicyPermissionGrantPolicyInclude -MockWith $scriptblock -ModuleName Microsoft.Graph.Entra

    Mock -CommandName New-MgPolicyPermissionGrantPolicyExclude -MockWith $scriptblock -ModuleName Microsoft.Graph.Entra
}
Describe "New-EntraPermissionGrantConditionSet"{
    It "Should not return empty object for condition set 'includes'"{
        $result = New-EntraPermissionGrantConditionSet -PolicyId "test1" -ConditionSetType "includes" -PermissionType "delegated"
        $result | Should -Not -BeNullOrEmpty
        Should -Invoke -CommandName New-MgPolicyPermissionGrantPolicyInclude -ModuleName Microsoft.Graph.Entra -Times 1
    }
    It "Should not return empty object for condition set 'excludes'"{
        $result = New-EntraPermissionGrantConditionSet -PolicyId "test1" -ConditionSetType "excludes" -PermissionType "delegated"
        $result | Should -Not -BeNullOrEmpty
        Should -Invoke -CommandName New-MgPolicyPermissionGrantPolicyExclude -ModuleName Microsoft.Graph.Entra -Times 1
    }
    It "Should fail when parameters are empty" {
        { New-EntraPermissionGrantConditionSet -PolicyId "" -ConditionSetType ""} | Should -Throw "Cannot bind argument to parameter*"
    }
    It "Should fail when parameters are null" {
        { New-EntraPermissionGrantConditionSet -PolicyId  -ConditionSetType } | Should -Throw "Missing an argument for parameter*"
    }
    It "Should contain PermissionGrantPolicyId in parameters when passed PolicyId to it" {              
        $result = New-EntraPermissionGrantConditionSet -PolicyId "test1" -ConditionSetType "includes" -PermissionType "delegated"
        $params = Get-Parameters -data $result.Parameters
        $params.PermissionGrantPolicyId | Should -Be "test1"
    }
    It "Should contain 'User-Agent' header" {
        $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion New-EntraPermissionGrantConditionSet"
        $result = New-EntraPermissionGrantConditionSet -PolicyId "test1" -ConditionSetType "includes" -PermissionType "delegated"
        $result | Should -Not -BeNullOrEmpty
        $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion New-EntraPermissionGrantConditionSet"
        Should -Invoke -CommandName New-MgPolicyPermissionGrantPolicyInclude -ModuleName Microsoft.Graph.Entra -Times 1 -ParameterFilter {
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
            { New-EntraPermissionGrantConditionSet -PolicyId "test1" -ConditionSetType "includes" -PermissionType "delegated" -Debug } | Should -Not -Throw
        } finally {
            # Restore original confirmation preference            
            $DebugPreference = $originalDebugPreference        
        }
    }

}