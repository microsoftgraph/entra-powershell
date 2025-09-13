# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
BeforeAll {  
    if((Get-Module -Name Microsoft.Entra.Beta.DirectoryManagement) -eq $null){
        Import-Module Microsoft.Entra.Beta.DirectoryManagement       
    }
    Import-Module (Join-Path $PSScriptRoot "..\..\Common-Functions.ps1") -Force
    
    $scriptblock = {
        return @(
            [PSCustomObject]@{
              "Id"                           = "aaaaaaaa-1111-2222-3333-bbbbbbbbbbbb"
              "DisplayName"                  = "Mock-Administrative-unit"
              "Description"                  = "NewAdministrativeUnit"
              "DeletedDateTime"              = $null
              "IsMemberManagementRestricted" = $null
              "Members"                      = $null
              "ScopedRoleMembers"            = $null
              "Visibility"                   = $null
              "AdditionalProperties"         = @{"@odata.context"  = 'https://graph.microsoft.com/beta/`$metadata#scopedRoleMemberships/`$entity]'}
              "Parameters"                   = $args
            }
        )
    }

    Mock -CommandName Get-MgBetaAdministrativeUnit -MockWith $scriptblock -ModuleName Microsoft.Entra.Beta.DirectoryManagement

    Mock -CommandName Get-EntraContext -MockWith { @{
        Environment = @{ Name = "Global" }
        Scopes      = @('AdministrativeUnit.Read.All')
    }} -ModuleName Microsoft.Entra.Beta.DirectoryManagement
}

Describe "Get-EntraBetaAdministrativeUnit" {
    Context "Test for Get-EntraBetaAdministrativeUnit" {
        It "Should throw when not connected and not invoke SDK" {
            Mock -CommandName Get-EntraContext -MockWith { $null } -ModuleName Microsoft.Entra.Beta.DirectoryManagement
            { Get-EntraBetaAdministrativeUnit -AdministrativeUnitId "aaaaaaaa-1111-2222-3333-bbbbbbbbbbbb" } | Should -Throw "Not connected to Microsoft Graph*"
            Should -Invoke -CommandName Get-MgBetaAdministrativeUnit -ModuleName Microsoft.Entra.Beta.DirectoryManagement -Times 0
        }

        It "Should return specific administrative unit" {
            $result = Get-EntraBetaAdministrativeUnit -AdministrativeUnitId "aaaaaaaa-1111-2222-3333-bbbbbbbbbbbb"
            $result | Should -Not -BeNullOrEmpty
            $result.Id | Should -Be "aaaaaaaa-1111-2222-3333-bbbbbbbbbbbb"
            $result.DisplayName | Should -Be "Mock-Administrative-unit"
            $result.Description | Should -Be "NewAdministrativeUnit"

            Should -Invoke -CommandName Get-MgBetaAdministrativeUnit -ModuleName Microsoft.Entra.Beta.DirectoryManagement -Times 1
        }
        It "Should return specific administrative unit with alias" {
            $result = Get-EntraBetaAdministrativeUnit -ObjectId "aaaaaaaa-1111-2222-3333-bbbbbbbbbbbb"
            $result | Should -Not -BeNullOrEmpty
            $result.Id | Should -Be "aaaaaaaa-1111-2222-3333-bbbbbbbbbbbb"
            $result.DisplayName | Should -Be "Mock-Administrative-unit"
            $result.Description | Should -Be "NewAdministrativeUnit"

            Should -Invoke -CommandName Get-MgBetaAdministrativeUnit -ModuleName Microsoft.Entra.Beta.DirectoryManagement -Times 1
        }
        It "Should fail when AdministrativeUnitId is empty" {
            { Get-EntraBetaAdministrativeUnit -AdministrativeUnitId  } | Should -Throw "Missing an argument for parameter 'AdministrativeUnitId'*"
        }
        It "Should fail when AdministrativeUnitId is invalid" {
            { Get-EntraBetaAdministrativeUnit -AdministrativeUnitId "" } | Should -Throw "Cannot bind argument to parameter 'AdministrativeUnitId' because it is an empty string."
        }
        It "Should return all administrative units" {
            $result = Get-EntraBetaAdministrativeUnit -All
            $result | Should -Not -BeNullOrEmpty            
            
            Should -Invoke -CommandName Get-MgBetaAdministrativeUnit -ModuleName Microsoft.Entra.Beta.DirectoryManagement -Times 1
        }
        It "Should fail when All is invalid" {
            { Get-EntraBetaAdministrativeUnit -All XY } | Should -Throw "A positional parameter cannot be found that accepts argument 'xy'.*"
        }
        It "Should return top administrative unit" {
            $result = Get-EntraBetaAdministrativeUnit -Top 1
            $result | Should -Not -BeNullOrEmpty

            Should -Invoke -CommandName Get-MgBetaAdministrativeUnit -ModuleName Microsoft.Entra.Beta.DirectoryManagement -Times 1
        }
        It "Should fail when Top is empty" {
            { Get-EntraBetaAdministrativeUnit -Top  } | Should -Throw "Missing an argument for parameter 'Top'*"
        }
        It "Should fail when Top is invalid" {
            { Get-EntraBetaAdministrativeUnit -Top XY } | Should -Throw "Cannot process argument transformation on parameter 'Top'*"
        }
        It "Should return specific administrative unit by filter" {
            $result = Get-EntraBetaAdministrativeUnit -Filter "DisplayName eq 'Mock-Administrative-unit'"
            $result | Should -Not -BeNullOrEmpty
            $result.DisplayName | should -Be 'Mock-Administrative-unit'

            Should -Invoke -CommandName Get-MgBetaAdministrativeUnit -ModuleName Microsoft.Entra.Beta.DirectoryManagement -Times 1
        }
        It "Should fail when filter is empty" {
            { Get-EntraBetaAdministrativeUnit -Filter  } | Should -Throw "Missing an argument for parameter 'Filter'*"
        }
        It "Result should contain AdministrativeUnitId"{
            $result = Get-EntraBetaAdministrativeUnit -AdministrativeUnitId "aaaaaaaa-1111-2222-3333-bbbbbbbbbbbb"
            $result.ObjectId | Should -Be "aaaaaaaa-1111-2222-3333-bbbbbbbbbbbb"
        }
        It "Should contain AdministrativeUnitId in parameters when passed AdministrativeUnitId to it" {    

            $result = Get-EntraBetaAdministrativeUnit -AdministrativeUnitId "aaaaaaaa-1111-2222-3333-bbbbbbbbbbbb"
            $params = Get-Parameters -data $result.Parameters
            $params.AdministrativeUnitId | Should -Be "aaaaaaaa-1111-2222-3333-bbbbbbbbbbbb"
        }
        It "Property parameter should work" {
            $result = Get-EntraBetaAdministrativeUnit -AdministrativeUnitId "aaaaaaaa-1111-2222-3333-bbbbbbbbbbbb" -Property DisplayName
            $result | Should -Not -BeNullOrEmpty
            $result.DisplayName | Should -Be 'Mock-Administrative-unit'
 
            Should -Invoke -CommandName Get-MgBetaAdministrativeUnit -ModuleName Microsoft.Entra.Beta.DirectoryManagement -Times 1
        }
        It "Should fail when Property is empty" {
             { Get-EntraBetaAdministrativeUnit -Property } | Should -Throw "Missing an argument for parameter 'Property'*"
        }
        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraBetaAdministrativeUnit"

            $result = Get-EntraBetaAdministrativeUnit -AdministrativeUnitId "aaaaaaaa-1111-2222-3333-bbbbbbbbbbbb"
            $result | Should -Not -BeNullOrEmpty

            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraBetaAdministrativeUnit"

            Should -Invoke -CommandName Get-MgBetaAdministrativeUnit -ModuleName Microsoft.Entra.Beta.DirectoryManagement -Times 1 -ParameterFilter {
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
                { Get-EntraBetaAdministrativeUnit -AdministrativeUnitId "aaaaaaaa-1111-2222-3333-bbbbbbbbbbbb" -Debug } | Should -Not -Throw
            } finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        } 

    }
}   

