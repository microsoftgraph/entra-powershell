# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra) -eq $null){
        Import-Module Microsoft.Graph.Entra
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force

    Mock -CommandName Invoke-GraphRequest -MockWith {} -ModuleName Microsoft.Graph.Entra
}

Describe "Test for Remove-EntraScopedRoleMembership" {
    It "Should return empty object" {
        $result = Remove-EntraScopedRoleMembership -AdministrativeUnitId bbbbbbbb-1111-1111-1111-cccccccccccc -ScopedRoleMembershipId bbbbbbbb-2222-2222-2222-cccccccccccc
        $result | Should -BeNullOrEmpty
        Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Graph.Entra -Times 1
    }
    It "Should fail when AdministrativeUnitId is empty" {
        { Remove-EntraScopedRoleMembership -AdministrativeUnitId "" } | Should -Throw "Cannot bind argument to parameter 'AdministrativeUnitId'*"
    }
    It "Should fail when AdministrativeUnitId is null" {
        { Remove-EntraScopedRoleMembership -AdministrativeUnitId } | Should -Throw "Missing an argument for parameter 'AdministrativeUnitId'*"
    }
    It "Should fail when ScopedRoleMembershipId is empty" {
        { Remove-EntraScopedRoleMembership -ScopedRoleMembershipId "" } | Should -Throw "Cannot bind argument to parameter 'ScopedRoleMembershipId'*"
    }
    It "Should fail when ScopedRoleMembershipId is null" {
        { Remove-EntraScopedRoleMembership -ScopedRoleMembershipId } | Should -Throw "Missing an argument for parameter 'ScopedRoleMembershipId'*"
    }   
    It "Should fail when invalid parameter is passed" {
        { Remove-EntraScopedRoleMembership -xyz } | Should -Throw "A parameter cannot be found that matches parameter name 'xyz'*"
    }
    It "Should contain 'User-Agent' header" {
        Mock -CommandName Invoke-GraphRequest -MockWith {$args} -ModuleName Microsoft.Graph.Entra
        $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Remove-EntraScopedRoleMembership"
        $result = Remove-EntraScopedRoleMembership -AdministrativeUnitId bbbbbbbb-1111-1111-1111-cccccccccccc -ScopedRoleMembershipId bbbbbbbb-2222-2222-2222-cccccccccccc
        $params = Get-Parameters -data $result
        $params.Headers["User-Agent"] | Should -Be $userAgentHeaderValue
    } 
}