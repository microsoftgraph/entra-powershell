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

    Mock -CommandName Update-MgBetaPrivilegedRoleAssignmentRequest -MockWith { @() } -ModuleName Microsoft.Entra.Beta.Governance
}

Describe "Set-EntraBetaPrivilegedRoleAssignmentRequest" {
    Context "Connection and basic behavior" {
        It "Should throw when not connected and not invoke SDK" {
            Mock -CommandName Get-EntraContext -MockWith { $null } -ModuleName Microsoft.Entra.Beta.Governance
            Mock -CommandName Update-MgBetaPrivilegedRoleAssignmentRequest -MockWith {} -ModuleName Microsoft.Entra.Beta.Governance

            { Set-EntraBetaPrivilegedRoleAssignmentRequest -ProviderId MockRoles -Id req-1 } | Should -Throw "Not connected to Microsoft Graph*"
            Should -Invoke -CommandName Update-MgBetaPrivilegedRoleAssignmentRequest -ModuleName Microsoft.Entra.Beta.Governance -Times 0
        }

        It "Should return empty when SDK returns none" {
            $result = Set-EntraBetaPrivilegedRoleAssignmentRequest -ProviderId MockRoles -Id req-1
            $result | Should -BeNullOrEmpty
        }
    }

    Context "Parameter mapping" {
        It "Should pass Id, ProviderId, and optional fields" {
            $schedule = New-Object Microsoft.Open.MSGraph.Model.AzureADMSPrivilegedSchedule
            Set-EntraBetaPrivilegedRoleAssignmentRequest -ProviderId MockRoles -Id req-1 -AssignmentState Active -Decision Approve -Reason "ok" -Schedule $schedule

            Should -Invoke -CommandName Update-MgBetaPrivilegedRoleAssignmentRequest -ModuleName Microsoft.Entra.Beta.Governance -Times 1 -ParameterFilter {
                $PrivilegedRoleAssignmentRequestId | Should -Be 'req-1'
                $ProviderId | Should -Be 'MockRoles'
                $AssignmentState | Should -Be 'Active'
                $Decision | Should -Be 'Approve'
                $Reason | Should -Be 'ok'
                $Schedule | Should -Not -BeNullOrEmpty
                $true
            }
        }
    }

    Context "Headers and output" {
        It "Should include 'User-Agent' header" {
            $expected = "PowerShell/$psVersion EntraPowershell/$entraVersion Set-EntraBetaPrivilegedRoleAssignmentRequest"
            Set-EntraBetaPrivilegedRoleAssignmentRequest -ProviderId MockRoles -Id req-1

            Should -Invoke -CommandName Update-MgBetaPrivilegedRoleAssignmentRequest -ModuleName Microsoft.Entra.Beta.Governance -Times 1 -ParameterFilter {
                $Headers.'User-Agent' | Should -Be $expected
                $true
            }
        }

        It "Should add ObjectId alias on results when SDK returns an object" {
            Mock -CommandName Update-MgBetaPrivilegedRoleAssignmentRequest -MockWith { ,([pscustomobject]@{ Id = 'req-1'; Status = 'Approved' }) } -ModuleName Microsoft.Entra.Beta.Governance

            $res = Set-EntraBetaPrivilegedRoleAssignmentRequest -ProviderId MockRoles -Id req-1
            $res | Should -Not -BeNullOrEmpty
            $res[0].ObjectId | Should -Be 'req-1'
        }

        It "Should execute with -Debug without throwing" {
            { Set-EntraBetaPrivilegedRoleAssignmentRequest -ProviderId MockRoles -Id req-1 -Debug } | Should -Not -Throw
        }
    }
}
