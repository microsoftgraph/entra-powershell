# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
BeforeAll {    
    if ((Get-Module -Name Microsoft.Entra.DirectoryManagement) -eq $null) {
        Import-Module Microsoft.Entra.DirectoryManagement
    }

    Import-Module (Join-Path $PSScriptRoot "..\..\Common-Functions.ps1") -Force

    Mock -CommandName Get-EntraContext -MockWith { @{
        Environment = "Global"
    }} -ModuleName Microsoft.Entra.DirectoryManagement
    Mock -CommandName Get-EntraEnvironment -MockWith {return @{
        GraphEndpoint = "https://graph.microsoft.com"
    }} -ModuleName Microsoft.Entra.DirectoryManagement

    Mock -CommandName Invoke-GraphRequest -MockWith {} -ModuleName Microsoft.Entra.DirectoryManagement
}
Describe "Add-EntraAdministrativeUnitMember tests" {
    It "Should return empty object" {
        $result = Add-EntraAdministrativeUnitMember -AdministrativeUnitId "f306a126-cf2e-439d-b20f-95ce4bcb7ffa" -MemberId "d6873b36-81d6-4c5e-bec0-9e3ca2c86846"
        $result | Should -BeNullOrEmpty
        Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.DirectoryManagement -Times 1
    }
    It "Should return empty object with ObjectId" {
        $result = Add-EntraAdministrativeUnitMember -ObjectId "f306a126-cf2e-439d-b20f-95ce4bcb7ffa" -MemberId "d6873b36-81d6-4c5e-bec0-9e3ca2c86846"
        $result | Should -BeNullOrEmpty
        Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.DirectoryManagement -Times 1
    }
    It "Should fail when AdministrativeUnitId is empty" {
        { Add-EntraAdministrativeUnitMember -AdministrativeUnitId "" } | Should -Throw "Cannot bind argument to parameter 'AdministrativeUnitId'*"
    }
    It "Should fail when AdministrativeUnitId is null" {
        { Add-EntraAdministrativeUnitMember -AdministrativeUnitId } | Should -Throw "Missing an argument for parameter 'AdministrativeUnitId'*"
    }
    It "Should fail when MemberId is empty" {
        { Add-EntraAdministrativeUnitMember -MemberId "" } | Should -Throw "Cannot bind argument to parameter 'MemberId'*"
    }
    It "Should fail when MemberId is null" {
        { Add-EntraAdministrativeUnitMember -MemberId } | Should -Throw "Missing an argument for parameter 'MemberId'*"
    }
    It "Should fail when invalid paramter is passed" {
        { Add-EntraAdministrativeUnitMember -Demo } | Should -Throw "A parameter cannot be found that matches parameter name 'Demo'*"
    }
    It "Should contain 'User-Agent' header" {        
        $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Add-EntraAdministrativeUnitMember"
        Add-EntraAdministrativeUnitMember -AdministrativeUnitId "aaaaaaaa-1111-2222-3333-cccccccccccc" -MemberId "bbbbbbbb-1111-2222-3333-cccccccccccc"
        $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Add-EntraAdministrativeUnitMember"
        Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.DirectoryManagement -Times 1 -ParameterFilter {
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
            { Add-EntraAdministrativeUnitMember -AdministrativeUnitId "f306a126-cf2e-439d-b20f-95ce4bcb7ffa" -MemberId "d6873b36-81d6-4c5e-bec0-9e3ca2c86846" -Debug } | Should -Not -Throw
        }
        finally {
            # Restore original confirmation preference            
            $DebugPreference = $originalDebugPreference        
        }
    }
}

