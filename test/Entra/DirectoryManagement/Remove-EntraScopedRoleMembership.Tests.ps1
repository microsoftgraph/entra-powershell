# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
BeforeAll {  
    if((Get-Module -Name Microsoft.Entra.DirectoryManagement) -eq $null){
        Import-Module Microsoft.Entra.DirectoryManagement
    }
    Import-Module (Join-Path $PSScriptRoot "..\..\Common-Functions.ps1") -Force

    Mock -CommandName Invoke-GraphRequest -MockWith {} -ModuleName Microsoft.Entra.DirectoryManagement

    Mock -CommandName Get-EntraContext -MockWith { @{
        Environment = @{ Name = "Global" }
        Scopes      = @('RoleManagement.Read.Directory')
    }} -ModuleName Microsoft.Entra.DirectoryManagement
}

Describe "Test for Remove-EntraScopedRoleMembership" {
    It "Should throw when not connected and not invoke graph call" {
        Mock -CommandName Get-EntraContext -MockWith { $null } -ModuleName Microsoft.Entra.DirectoryManagement
        { Remove-EntraScopedRoleMembership -AdministrativeUnitId "bbbbbbbb-1111-1111-1111-cccccccccccc" -ScopedRoleMembershipId "bbbbbbbb-2222-2222-2222-cccccccccccc" } | Should -Throw "Not connected to Microsoft Graph*"
        Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.DirectoryManagement -Times 0
    }

    It "Should return empty object" {
        $result = Remove-EntraScopedRoleMembership -AdministrativeUnitId bbbbbbbb-1111-1111-1111-cccccccccccc -ScopedRoleMembershipId bbbbbbbb-2222-2222-2222-cccccccccccc
        $result | Should -BeNullOrEmpty
        Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.DirectoryManagement -Times 1
    }
    It "Should return empty object with ObjectId" {
        $result = Remove-EntraScopedRoleMembership -ObjectId bbbbbbbb-1111-1111-1111-cccccccccccc -ScopedRoleMembershipId bbbbbbbb-2222-2222-2222-cccccccccccc
        $result | Should -BeNullOrEmpty
        Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.DirectoryManagement -Times 1
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
        $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Remove-EntraScopedRoleMembership"

        Remove-EntraScopedRoleMembership -AdministrativeUnitId "bbbbbbbb-1111-1111-1111-cccccccccccc" -ScopedRoleMembershipId "bbbbbbbb-2222-2222-2222-cccccccccccc"

        $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Remove-EntraScopedRoleMembership"

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
            {  Remove-EntraScopedRoleMembership -AdministrativeUnitId "bbbbbbbb-1111-1111-1111-cccccccccccc" -ScopedRoleMembershipId "bbbbbbbb-2222-2222-2222-cccccccccccc" -Debug } | Should -Not -Throw
        } finally {
            # Restore original confirmation preference            
            $DebugPreference = $originalDebugPreference        
        }
    }  
}

