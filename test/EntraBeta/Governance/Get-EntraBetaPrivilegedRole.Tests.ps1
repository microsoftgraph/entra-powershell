# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.
#  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

BeforeAll {
    if ((Get-Module -Name Microsoft.Entra.Beta.Governance) -eq $null) {
        Import-Module Microsoft.Entra.Beta.Governance
    }
    Import-Module (Join-Path $PSScriptRoot "..\..\Common-Functions.ps1") -Force

    Mock -CommandName Get-EntraContext -MockWith {
        @{
            Environment = @{
                Name = "Global"
            }
            Scopes = @('PrivilegedAccess.Read.AzureAD')
        }
    } -ModuleName Microsoft.Entra.Beta.Governance

    Mock -CommandName Get-MgBetaPrivilegedRole -MockWith { @() } -ModuleName Microsoft.Entra.Beta.Governance
}

Describe "Get-EntraBetaPrivilegedRole" {
    Context "Connection and basic behavior" {
        It "Should throw when not connected and not invoke SDK" {
            Mock -CommandName Get-EntraContext -MockWith { $null } -ModuleName Microsoft.Entra.Beta.Governance
            Mock -CommandName Get-MgBetaPrivilegedRole -MockWith {} -ModuleName Microsoft.Entra.Beta.Governance

            { Get-EntraBetaPrivilegedRole -Filter "displayName eq 'X'" } | Should -Throw "Not connected to Microsoft Graph*"
            Should -Invoke -CommandName Get-MgBetaPrivilegedRole -ModuleName Microsoft.Entra.Beta.Governance -Times 0
        }

        It "Should return empty when SDK returns none" {
            $result = Get-EntraBetaPrivilegedRole -Filter "displayName eq 'X'"
            $result | Should -BeNullOrEmpty
        }
    }

    Context "Parameter mapping" {
        It "Should pass Filter to Get-MgBetaPrivilegedRole" {
            Get-EntraBetaPrivilegedRole -Filter "displayName eq 'Global Reader'"

            Should -Invoke -CommandName Get-MgBetaPrivilegedRole -ModuleName Microsoft.Entra.Beta.Governance -Times 1 -ParameterFilter {
                $Filter | Should -Be "displayName eq 'Global Reader'"
                $true
            }
        }

        It "Should pass Id as PrivilegedRoleId to Get-MgBetaPrivilegedRole" {
            Get-EntraBetaPrivilegedRole -Id "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"

            Should -Invoke -CommandName Get-MgBetaPrivilegedRole -ModuleName Microsoft.Entra.Beta.Governance -Times 1 -ParameterFilter {
                $PrivilegedRoleId | Should -Be "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
                $true
            }
        }

        It "Should pass Property to Get-MgBetaPrivilegedRole" {
            Get-EntraBetaPrivilegedRole -Property id,displayName

            Should -Invoke -CommandName Get-MgBetaPrivilegedRole -ModuleName Microsoft.Entra.Beta.Governance -Times 1 -ParameterFilter {
                ($Property -join ',') | Should -Be 'id,displayName'
                $true
            }
        }
    }

    Context "Custom headers and output shaping" {
        It "Should include 'User-Agent' header" {
            $expected = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraBetaPrivilegedRole"
            Get-EntraBetaPrivilegedRole -Filter "displayName eq 'X'"

            Should -Invoke -CommandName Get-MgBetaPrivilegedRole -ModuleName Microsoft.Entra.Beta.Governance -Times 1 -ParameterFilter {
                $Headers.'User-Agent' | Should -Be $expected
                $true
            }
        }

        It "Should add ObjectId alias on results" {
            Mock -CommandName Get-MgBetaPrivilegedRole -MockWith { ,([pscustomobject]@{ Id = 'role-1'; DisplayName = 'Privileged Role 1' }) } -ModuleName Microsoft.Entra.Beta.Governance

            $res = Get-EntraBetaPrivilegedRole -Id 'role-1'
            $res | Should -Not -BeNullOrEmpty
            $res[0].ObjectId | Should -Be 'role-1'
        }

        It "Should execute with -Debug without throwing" {
            { Get-EntraBetaPrivilegedRole -Filter "displayName eq 'X'" -Debug } | Should -Not -Throw
        }
    }
}
