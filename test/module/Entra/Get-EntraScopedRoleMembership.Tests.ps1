# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
BeforeAll{
    if ((Get-Module -Name Microsoft.Graph.Entra) -eq $null) {
        Import-Module Microsoft.Graph.Entra      
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force

    $userObjId = "aaaaaaaa-1111-2222-3333-bbbbbbbbbbbb"
    $roleObjId = "aaaaaaaa-2222-3333-4444-bbbbbbbbbbbb"
    $unitObjId = "aaaaaaaa-3333-4444-5555-bbbbbbbbbbbb"
    $scopedRoleMembershipId = "scopedRoleMemId"

    $scriptblock = {
        @{
            "id" = $scopedRoleMembershipId
            "roleId"= $roleObjId
            "administrativeUnitId"= $unitObjId
            "roleMemberInfo"= @(
                @{
                    "id"= $userObjId
                    "displayName"= "displayName-value"
                    "userPrincipalName"= "userPrincipalName-value"
                }
            )
            "Parameters" = $args
        }
    }

    Mock -CommandName Invoke-GraphRequest -MockWith $scriptblock -ModuleName Microsoft.Graph.Entra
}
Describe "Tests for Get-EntraScopedRoleMembership"{
    It "Result should not be empty"{
        $result = Get-EntraScopedRoleMembership -ObjectId $unitObjId -ScopedRoleMembershipId $scopedRoleMembershipId
        $result | Should -Not -BeNullOrEmpty
        $result.ObjectId | should -Be $scopedRoleMembershipId
        $result.AdministrativeUnitObjectId | should -Be $unitObjId
        $result.RoleObjectId | should -Be $roleObjId
        Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Graph.Entra -Times 1
    }
    It "Should fail when ObjectId is invalid" {
        { Get-EntraScopedRoleMembership -ObjectId "" } | Should -Throw "Cannot bind argument to parameter 'ObjectId'*"
    }
    It "Should fail when ObjectId is empty" {
        { Get-EntraScopedRoleMembership -ObjectId } | Should -Throw "Missing an argument for parameter 'ObjectId'*"
    }    
    It "Should fail when ScopedRoleMembershipId is empty" {
        { Get-EntraScopedRoleMembership -ObjectId $unitObjId -ScopedRoleMembershipId } | Should -Throw "Missing an argument for parameter 'ScopedRoleMembershipId'*"
    }
    It "Should fail when invalid parameter is passed" {
        { Get-EntraScopedRoleMembership -xyz } | Should -Throw "A parameter cannot be found that matches parameter name 'xyz'*"
    }
    It "Should contain 'User-Agent' header" {
        $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraScopedRoleMembership"
        $result = Get-EntraScopedRoleMembership -ObjectId $unitObjId -ScopedRoleMembershipId $scopedRoleMembershipId
        $result | Should -Not -BeNullOrEmpty
        $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraScopedRoleMembership"
        Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Graph.Entra -Times 1 -ParameterFilter {
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
            { Get-EntraScopedRoleMembership -ObjectId $unitObjId -ScopedRoleMembershipId $scopedRoleMembershipId -Debug } | Should -Not -Throw
        } finally {
            # Restore original confirmation preference            
            $DebugPreference = $originalDebugPreference        
        }
    }
}