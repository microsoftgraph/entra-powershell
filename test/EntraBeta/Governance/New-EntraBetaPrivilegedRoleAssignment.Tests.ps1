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
            Scopes = @('PrivilegedAccess.ReadWrite.AzureAD')
        }
    } -ModuleName Microsoft.Entra.Beta.Governance

    Mock -CommandName New-MgBetaPrivilegedRoleAssignment -MockWith { @() } -ModuleName Microsoft.Entra.Beta.Governance
}

Describe "New-EntraBetaPrivilegedRoleAssignment" {
    Context "Connection and basic behavior" {
        It "Should throw when not connected and not invoke SDK" {
            Mock -CommandName Get-EntraContext -MockWith { $null } -ModuleName Microsoft.Entra.Beta.Governance
            Mock -CommandName New-MgBetaPrivilegedRoleAssignment -MockWith {} -ModuleName Microsoft.Entra.Beta.Governance

            { New-EntraBetaPrivilegedRoleAssignment -UserId u1 -RoleId r1 } | Should -Throw "Not connected to Microsoft Graph*"
            Should -Invoke -CommandName New-MgBetaPrivilegedRoleAssignment -ModuleName Microsoft.Entra.Beta.Governance -Times 0
        }

        It "Should return empty when SDK returns none" {
            $result = New-EntraBetaPrivilegedRoleAssignment -UserId u1 -RoleId r1
            $result | Should -BeNullOrEmpty
        }
    }

    Context "Parameter mapping" {
        It "Should pass mandatory parameters and optionals" {
            Mock -CommandName New-MgBetaPrivilegedRoleAssignment -MockWith { ,([pscustomobject]@{ Id = 'assign-1'; UserId = 'u1'; RoleId = 'r1' }) } -ModuleName Microsoft.Entra.Beta.Governance

            $exp = (Get-Date).AddHours(1)
            $res = New-EntraBetaPrivilegedRoleAssignment -UserId u1 -RoleId r1 -IsElevated $true -ResultMessage ok -ExpirationDateTime $exp -Debug

            Should -Invoke -CommandName New-MgBetaPrivilegedRoleAssignment -ModuleName Microsoft.Entra.Beta.Governance -Times 1 -ParameterFilter {
                $UserId | Should -Be 'u1'
                $RoleId | Should -Be 'r1'
                $IsElevated | Should -BeTrue
                $ResultMessage | Should -Be 'ok'
                $ExpirationDateTime | Should -Be $exp
                $true
            }

            # Output shaping
            $res[0].ObjectId | Should -Be 'assign-1'
        }
    }

    Context "Headers" {
        It "Should include 'User-Agent' header" {
            $expected = "PowerShell/$psVersion EntraPowershell/$entraVersion New-EntraBetaPrivilegedRoleAssignment"
            New-EntraBetaPrivilegedRoleAssignment -UserId u1 -RoleId r1

            Should -Invoke -CommandName New-MgBetaPrivilegedRoleAssignment -ModuleName Microsoft.Entra.Beta.Governance -Times 1 -ParameterFilter {
                $Headers.'User-Agent' | Should -Be $expected
                $true
            }
        }
    }
}
