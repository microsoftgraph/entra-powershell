# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
BeforeAll {  
    if((Get-Module -Name Microsoft.Entra.DirectoryManagement) -eq $null){
        Import-Module Microsoft.Entra.DirectoryManagement
    }
    Import-Module (Join-Path $PSScriptRoot "..\..\Common-Functions.ps1") -Force

    Mock -CommandName Invoke-GraphRequest -MockWith {} -ModuleName Microsoft.Entra.DirectoryManagement

    $auId = "bbbbbbbb-1111-1111-1111-cccccccccccc"
    $memId = "bbbbbbbb-2222-2222-2222-cccccccccccc"

    Mock -CommandName Get-EntraContext -MockWith { @{
        Environment = @{ Name = "Global" }
        Scopes      = @('AdministrativeUnit.Read.All')
    }} -ModuleName Microsoft.Entra.DirectoryManagement
}

Describe "Test for Remove-EntraAdministrativeUnitMember" {
    It "Should throw when not connected and not invoke graph call" {
        Mock -CommandName Get-EntraContext -MockWith { $null } -ModuleName Microsoft.Entra.DirectoryManagement
        { Remove-EntraAdministrativeUnitMember -AdministrativeUnitId $auId -MemberId $memId } | Should -Throw "Not connected to Microsoft Graph*"
        Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.DirectoryManagement -Times 0
    }

    It "Should return empty object" {
        $result = Remove-EntraAdministrativeUnitMember -AdministrativeUnitId $auId -MemberId $memId
        $result | Should -BeNullOrEmpty
        Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.DirectoryManagement -Times 1
    }
    It "Should return empty object with ObjectId" {
        $result = Remove-EntraAdministrativeUnitMember -ObjectId $auId -MemberId $memId
        $result | Should -BeNullOrEmpty
        Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.DirectoryManagement -Times 1
    }
    It "Should fail when AdministrativeUnitId is empty" {
        { Remove-EntraAdministrativeUnitMember -AdministrativeUnitId "" } | Should -Throw "Cannot bind argument to parameter 'AdministrativeUnitId'*"
    }
    It "Should fail when AdministrativeUnitId is null" {
        { Remove-EntraAdministrativeUnitMember -AdministrativeUnitId } | Should -Throw "Missing an argument for parameter 'AdministrativeUnitId'*"
    }
    It "Should fail when MemberId is empty" {
        { Remove-EntraAdministrativeUnitMember -MemberId "" } | Should -Throw "Cannot bind argument to parameter 'MemberId'*"
    }
    It "Should fail when MemberId is null" {
        { Remove-EntraAdministrativeUnitMember -MemberId } | Should -Throw "Missing an argument for parameter 'MemberId'*"
    }
    It "Should fail when invalid parameter is passed" {
        { Remove-EntraAdministrativeUnitMember -xyz } | Should -Throw "A parameter cannot be found that matches parameter name 'xyz'*"
    }
    It "Should contain 'User-Agent' header" {
        $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Remove-EntraAdministrativeUnitMember"

        Remove-EntraAdministrativeUnitMember -AdministrativeUnitId $auId -MemberId $memId

        $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Remove-EntraAdministrativeUnitMember"

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
            { Remove-EntraAdministrativeUnitMember -AdministrativeUnitId $auId -MemberId $memId -Debug } | Should -Not -Throw
        } finally {
            # Restore original confirmation preference            
            $DebugPreference = $originalDebugPreference        
        }
    }   
}

