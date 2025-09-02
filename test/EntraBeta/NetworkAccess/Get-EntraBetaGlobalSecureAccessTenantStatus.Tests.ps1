# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.
#  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
BeforeAll {
    if ((Get-Module -Name Microsoft.Entra.Beta.NetworkAccess) -eq $null) {
        Import-Module Microsoft.Entra.Beta.NetworkAccess
    }
    Import-Module (Join-Path $PSScriptRoot "..\..\Common-Functions.ps1") -Force

    Mock -CommandName Invoke-GraphRequest -MockWith { @{ value = @{ state = 'enabled' } } } -ModuleName Microsoft.Entra.Beta.NetworkAccess

    Mock -CommandName Get-EntraContext -MockWith {
        @{
            Environment = @{
                Name = "Global"
            }
            Scopes = @("NetworkAccessPolicy.ReadWrite.All", "Application.ReadWrite.All", "NetworkAccess.ReadWrite.All")
        }
    } -ModuleName Microsoft.Entra.NetworkAccess
}

Describe "Get-EntraBetaGlobalSecureAccessTenantStatus" {
    It "Should throw when not connected and not call Graph" {
        Mock -CommandName Get-EntraContext -MockWith { $null } -ModuleName Microsoft.Entra.Beta.NetworkAccess
        { Get-EntraBetaGlobalSecureAccessTenantStatus } | Should -Throw "Not connected to Microsoft Graph*"
        Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.Beta.NetworkAccess -Times 0
    }

    It "Should GET tenant status and return response" {
        $out = Get-EntraBetaGlobalSecureAccessTenantStatus
        $out | Should -Not -BeNullOrEmpty

        Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.Beta.NetworkAccess -Times 1 -ParameterFilter {
            $Method -eq 'GET' -and $Uri -eq "/beta/networkAccess/tenantStatus" -and $Headers.'User-Agent' -like "PowerShell/* EntraPowershell/* Get-EntraBetaGlobalSecureAccessTenantStatus"
        }
    }
}
