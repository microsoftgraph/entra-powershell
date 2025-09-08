# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
BeforeAll{
    if ((Get-Module -Name Microsoft.Entra.DirectoryManagement) -eq $null) {
        Import-Module Microsoft.Entra.DirectoryManagement      
    }
    Import-Module (Join-Path $PSScriptRoot "..\..\Common-Functions.ps1") -Force

    $scriptblock = {
        @{
            "description" =  "test111"
            "membershipRule" =  $null
            "membershipRuleProcessingState" =  $null
            "id" =  "aaaaaaaa-2222-3333-4444-bbbbbbbbbbbb"
            "deletedDateTime" =  $null
            "visibility" =  $null
            "displayName" =  "test111"
            "membershipType" =  $null
            "Parameters" = $args
        }
    }

    Mock -CommandName Invoke-GraphRequest -MockWith $scriptblock -ModuleName Microsoft.Entra.DirectoryManagement

    Mock -CommandName Get-EntraContext -MockWith { @{
        Environment = @{ Name = "Global" }
        Scopes      = @('AdministrativeUnit.ReadWrite.All')
    }} -ModuleName Microsoft.Entra.DirectoryManagement
}
Describe "Tests for Get-EntraAdministrativeUnitMember"{
    It "Result should not be empty"{
        $result = Get-EntraAdministrativeUnitMember -AdministrativeUnitId "aaaaaaaa-1111-2222-3333-bbbbbbbbbbbb"
        $result | Should -Not -BeNullOrEmpty
        Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.DirectoryManagement -Times 1
    }
    It "Result should not be empty objectId"{
        $result = Get-EntraAdministrativeUnitMember -ObjectId "aaaaaaaa-1111-2222-3333-bbbbbbbbbbbb"
        $result | Should -Not -BeNullOrEmpty
        Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.DirectoryManagement -Times 1
    }
    It "Should fail when AdministrativeUnitId is empty" {
        { Get-EntraAdministrativeUnitMember -AdministrativeUnitId "" } | Should -Throw "Cannot bind argument to parameter 'AdministrativeUnitId'*"
    }
    It "Should fail when AdministrativeUnitId is null" {
        { Get-EntraAdministrativeUnitMember -AdministrativeUnitId } | Should -Throw "Missing an argument for parameter 'AdministrativeUnitId'*"
    }    
    It "Should fail when All has an argument" {
        { Get-EntraAdministrativeUnitMember -All $true } | Should -Throw "A positional parameter cannot be found that accepts argument 'True'.*"
    }
    It "Should fail when Top is empty" {
        { Get-EntraAdministrativeUnitMember -Top } | Should -Throw "Missing an argument for parameter 'Top'*"
    }
    It "Should fail when Top is invalid" {
        { Get-EntraAdministrativeUnitMember -Top XY } | Should -Throw "Cannot process argument transformation on parameter 'Top'*"
    }         
    It "Should fail when invalid parameter is passed" {
        { Get-EntraAdministrativeUnitMember -xyz } | Should -Throw "A parameter cannot be found that matches parameter name 'xyz'*"
    }
    It "Should return top AdministrativeUnit" {
        $result = @(Get-EntraAdministrativeUnitMember -AdministrativeUnitId "aaaaaaaa-1111-2222-3333-bbbbbbbbbbbb" -Top 1)
        $result | Should -Not -BeNullOrEmpty
        $result | Should -HaveCount 1 
        Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.DirectoryManagement -Times 1
    }  
    It "Should contain 'User-Agent' header" {
        $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraAdministrativeUnitMember"
        $result = Get-EntraAdministrativeUnitMember -AdministrativeUnitId "aaaaaaaa-1111-2222-3333-bbbbbbbbbbbb" 
        $result | Should -Not -BeNullOrEmpty
        $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraAdministrativeUnitMember"
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
            { Get-EntraAdministrativeUnitMember -AdministrativeUnitId "aaaaaaaa-1111-2222-3333-bbbbbbbbbbbb" -Top 1 -Debug } | Should -Not -Throw
        } finally {
            # Restore original confirmation preference            
            $DebugPreference = $originalDebugPreference        
        }
    }
}

