# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
BeforeAll{
    if ((Get-Module -Name Microsoft.Entra.DirectoryManagement) -eq $null) {
        Import-Module Microsoft.Entra.DirectoryManagement      
    }
    Import-Module (Join-Path $PSScriptRoot "..\..\Common-Functions.ps1") -Force

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

    Mock -CommandName Invoke-GraphRequest -MockWith $scriptblock -ModuleName Microsoft.Entra.DirectoryManagement

    Mock -CommandName Get-EntraContext -MockWith { @{
        Environment = @{ Name = "Global" }
        Scopes      = @('RoleManagement.Read.Directory')
    }} -ModuleName Microsoft.Entra.DirectoryManagement
}
Describe "Tests for Get-EntraScopedRoleMembership"{
    It "Should throw when not connected and not invoke graph call" {
        Mock -CommandName Get-EntraContext -MockWith { $null } -ModuleName Microsoft.Entra.DirectoryManagement
        { Get-EntraScopedRoleMembership -AdministrativeUnitId $unitObjId -ScopedRoleMembershipId $scopedRoleMembershipId } | Should -Throw "Not connected to Microsoft Graph*"
        Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.DirectoryManagement -Times 0
    }

    It "Result should not be empty"{
        $result = Get-EntraScopedRoleMembership -AdministrativeUnitId $unitObjId -ScopedRoleMembershipId $scopedRoleMembershipId
        $result | Should -Not -BeNullOrEmpty
        $result.ObjectId | should -Be $scopedRoleMembershipId
        $result.AdministrativeUnitObjectId | should -Be $unitObjId
        $result.RoleObjectId | should -Be $roleObjId
        Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.DirectoryManagement -Times 1
    }
    It "Result should not be empty with ObjectId"{
        $result = Get-EntraScopedRoleMembership -ObjectId $unitObjId -ScopedRoleMembershipId $scopedRoleMembershipId
        $result | Should -Not -BeNullOrEmpty
        $result.ObjectId | should -Be $scopedRoleMembershipId
        $result.AdministrativeUnitObjectId | should -Be $unitObjId
        $result.RoleObjectId | should -Be $roleObjId
        Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.DirectoryManagement -Times 1
    }
    It "Should fail when AdministrativeUnitId is invalid" {
        { Get-EntraScopedRoleMembership -AdministrativeUnitId "" } | Should -Throw "Cannot bind argument to parameter 'AdministrativeUnitId'*"
    }
    It "Should fail when AdministrativeUnitId is empty" {
        { Get-EntraScopedRoleMembership -AdministrativeUnitId } | Should -Throw "Missing an argument for parameter 'AdministrativeUnitId'*"
    }    
    It "Should fail when ScopedRoleMembershipId is empty" {
        { Get-EntraScopedRoleMembership -AdministrativeUnitId $unitObjId -ScopedRoleMembershipId } | Should -Throw "Missing an argument for parameter 'ScopedRoleMembershipId'*"
    }
    It "Should fail when invalid parameter is passed" {
        { Get-EntraScopedRoleMembership -xyz } | Should -Throw "A parameter cannot be found that matches parameter name 'xyz'*"
    }
    It "Should contain 'User-Agent' header" {
        $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraScopedRoleMembership"
        $result = Get-EntraScopedRoleMembership -AdministrativeUnitId $unitObjId -ScopedRoleMembershipId $scopedRoleMembershipId
        $result | Should -Not -BeNullOrEmpty
        $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraScopedRoleMembership"
        Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.DirectoryManagement -Times 1 -ParameterFilter {
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
            { Get-EntraScopedRoleMembership -AdministrativeUnitId $unitObjId -ScopedRoleMembershipId $scopedRoleMembershipId -Debug } | Should -Not -Throw
        } finally {
            # Restore original confirmation preference            
            $DebugPreference = $originalDebugPreference        
        }
    }
}

