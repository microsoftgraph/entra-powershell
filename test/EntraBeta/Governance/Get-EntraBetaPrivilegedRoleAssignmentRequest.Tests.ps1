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

    Mock -CommandName Get-MgBetaPrivilegedRoleAssignmentRequest -MockWith { @() } -ModuleName Microsoft.Entra.Beta.Governance
}

Describe "Get-EntraBetaPrivilegedRoleAssignmentRequest" {
    Context "Connection and basic behavior" {
        It "Should throw when not connected and not invoke SDK" {
            Mock -CommandName Get-EntraContext -MockWith { $null } -ModuleName Microsoft.Entra.Beta.Governance
            Mock -CommandName Get-MgBetaPrivilegedRoleAssignmentRequest -MockWith {} -ModuleName Microsoft.Entra.Beta.Governance

            { Get-EntraBetaPrivilegedRoleAssignmentRequest -ProviderId MockRoles -Filter "status eq 'Pending'" } | Should -Throw "Not connected to Microsoft Graph*"
            Should -Invoke -CommandName Get-MgBetaPrivilegedRoleAssignmentRequest -ModuleName Microsoft.Entra.Beta.Governance -Times 0
        }

        It "Should return empty when SDK returns none" {
            $result = Get-EntraBetaPrivilegedRoleAssignmentRequest -ProviderId MockRoles -Filter "status eq 'Pending'"
            $result | Should -BeNullOrEmpty
        }
    }

    Context "Parameter mapping" {
        It "Should pass Filter, ProviderId, and Top to SDK" {
            Get-EntraBetaPrivilegedRoleAssignmentRequest -ProviderId MockRoles -Filter "status eq 'Approved'" -Top 5

            Should -Invoke -CommandName Get-MgBetaPrivilegedRoleAssignmentRequest -ModuleName Microsoft.Entra.Beta.Governance -Times 1 -ParameterFilter {
                $ProviderId | Should -Be 'MockRoles'
                $Filter | Should -Be "status eq 'Approved'"
                $Top | Should -Be 5
                $true
            }
        }

        It "Should pass Id as PrivilegedRoleAssignmentRequestId" {
            Get-EntraBetaPrivilegedRoleAssignmentRequest -ProviderId MockRoles -Id "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"

            Should -Invoke -CommandName Get-MgBetaPrivilegedRoleAssignmentRequest -ModuleName Microsoft.Entra.Beta.Governance -Times 1 -ParameterFilter {
                $PrivilegedRoleAssignmentRequestId | Should -Be "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
                $ProviderId | Should -Be 'MockRoles'
                $true
            }
        }

        It "Should pass Property to SDK" {
            Get-EntraBetaPrivilegedRoleAssignmentRequest -ProviderId MockRoles -Property id,assignmentState

            Should -Invoke -CommandName Get-MgBetaPrivilegedRoleAssignmentRequest -ModuleName Microsoft.Entra.Beta.Governance -Times 1 -ParameterFilter {
                ($Property -join ',') | Should -Be 'id,assignmentState'
                $true
            }
        }
    }

    Context "Headers and output" {
        It "Should include 'User-Agent' header" {
            $expected = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraBetaPrivilegedRoleAssignmentRequest"
            Get-EntraBetaPrivilegedRoleAssignmentRequest -ProviderId MockRoles -Filter "status eq 'X'"

            Should -Invoke -CommandName Get-MgBetaPrivilegedRoleAssignmentRequest -ModuleName Microsoft.Entra.Beta.Governance -Times 1 -ParameterFilter {
                $Headers.'User-Agent' | Should -Be $expected
                $true
            }
        }

        It "Should add ObjectId alias on results" {
            Mock -CommandName Get-MgBetaPrivilegedRoleAssignmentRequest -MockWith { ,([pscustomobject]@{ Id = 'req-1'; Status = 'Pending' }) } -ModuleName Microsoft.Entra.Beta.Governance

            $res = Get-EntraBetaPrivilegedRoleAssignmentRequest -ProviderId MockRoles -Id 'req-1'
            $res | Should -Not -BeNullOrEmpty
            $res[0].ObjectId | Should -Be 'req-1'
        }

        It "Should execute with -Debug without throwing" {
            { Get-EntraBetaPrivilegedRoleAssignmentRequest -ProviderId MockRoles -Filter "status eq 'X'" -Debug } | Should -Not -Throw
        }
    }
}
