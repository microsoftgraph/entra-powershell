# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.
#  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
BeforeAll {
    if ((Get-Module -Name Microsoft.Entra.Beta.NetworkAccess) -eq $null) {
        Import-Module Microsoft.Entra.Beta.NetworkAccess
    }
    Import-Module (Join-Path $PSScriptRoot "..\..\Common-Functions.ps1") -Force

    Mock -CommandName Invoke-GraphRequest -MockWith { @{ } } -ModuleName Microsoft.Entra.Beta.NetworkAccess

    Mock -CommandName Get-EntraContext -MockWith {
        @{
            Environment = @{
                Name = "Global"
            }
            Scopes = @("NetworkAccessPolicy.ReadWrite.All", "Application.ReadWrite.All", "NetworkAccess.ReadWrite.All")
        }
    } -ModuleName Microsoft.Entra.NetworkAccess
}

Describe "Enable-EntraBetaGlobalSecureAccessTenant" {
    It "Should throw when not connected and not call Graph" {
        Mock -CommandName Get-EntraContext -MockWith { $null } -ModuleName Microsoft.Entra.Beta.NetworkAccess
        { Enable-EntraBetaGlobalSecureAccessTenant } | Should -Throw "Not connected to Microsoft Graph*"
        Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.Beta.NetworkAccess -Times 0
    }

    It "Should POST onboard and output success message" {
        $out = Enable-EntraBetaGlobalSecureAccessTenant
        $out | Should -Be "Global Secure Access Tenant has been successfully enabled."

        Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.Beta.NetworkAccess -Times 1 -ParameterFilter {
            $Method -eq 'POST' -and $Uri -eq "/beta/networkAccess/microsoft.graph.networkaccess.onboard" -and $Headers.'User-Agent' -like "PowerShell/* EntraPowershell/* Enable-EntraBetaGlobalSecureAccessTenant"
        }
    }
}
