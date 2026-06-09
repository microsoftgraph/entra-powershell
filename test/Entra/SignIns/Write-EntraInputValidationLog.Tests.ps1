# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

BeforeAll {
    $binPath = Join-Path $PSScriptRoot "..\..\..\bin"
    Import-Module (Join-Path $binPath "Microsoft.Entra.Authentication.psd1") -Force
    Import-Module (Join-Path $binPath "Microsoft.Entra.SignIns.psd1") -Force
    Import-Module (Join-Path $PSScriptRoot "..\..\Common-Functions.ps1") -Force

    Mock -CommandName Get-EntraContext -MockWith { @{Scopes = @("Policy.Read.All") } } -ModuleName Microsoft.Entra.SignIns
    Mock -CommandName Out-File -ModuleName Microsoft.Entra.SignIns
    Mock -CommandName Write-EventLog -ModuleName Microsoft.Entra.SignIns
}

Describe "Get-EntraPolicy - Input Validation Logging" {
    Context "When an invalid Top value is provided" {
        It "Should log validation failure for Top value of 0" {
            Mock -CommandName Out-File -ModuleName Microsoft.Entra.SignIns
            Get-EntraPolicy -Top 0 -ErrorAction SilentlyContinue
            Should -Invoke -CommandName Out-File -ModuleName Microsoft.Entra.SignIns -Times 1
        }
    }
}
