# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

BeforeAll {
    if ($null -eq (Get-Module -Name Microsoft.Entra.Applications)) {
        Import-Module Microsoft.Entra.Applications
    }
    Import-Module (Join-Path $PSScriptRoot "..\..\Common-Functions.ps1") -Force

    Mock -CommandName Get-EntraContext -MockWith { @{Scopes = @("Application.ReadWrite.All") } } -ModuleName Microsoft.Entra.Applications
    Mock -CommandName New-EntraCustomHeaders -MockWith { @{"User-Agent" = "Test"} } -ModuleName Microsoft.Entra.Applications
    Mock -CommandName Out-File -ModuleName Microsoft.Entra.Applications
    Mock -CommandName Write-EventLog -ModuleName Microsoft.Entra.Applications
    Mock -CommandName New-MgServicePrincipal -ModuleName Microsoft.Entra.Applications
}

Describe "New-EntraServicePrincipal - Input Validation Logging" {
    Context "When AccountEnabled has invalid boolean value" {
        It "Should log validation failure and throw for non-boolean AccountEnabled" {
            { New-EntraServicePrincipal -AppId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -AccountEnabled "notaboolean" } | Should -Throw "*Invalid input for AccountEnabled*"
        }
    }
}

Describe "Get-EntraApplicationLogo - Input Validation Logging" {
    Context "When FilePath is invalid" {
        It "Should log validation failure for non-existent file path" {
            Mock -CommandName Out-File -ModuleName Microsoft.Entra.Applications
            Get-EntraApplicationLogo -ApplicationId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -FilePath "C:\nonexistent\path\logo.xyz" -ErrorAction SilentlyContinue
            Should -Invoke -CommandName Out-File -ModuleName Microsoft.Entra.Applications -Times 1
        }
    }
}

Describe "New-EntraApplication - Input Validation Logging" {
    Context "When legalAgeGroupRule has invalid value" {
        BeforeAll {
            Mock -CommandName New-MgApplication -ModuleName Microsoft.Entra.Applications
        }
        It "Should produce error for invalid legalAgeGroupRule value" {
            $parentalSettings = [PSCustomObject]@{ legalAgeGroupRule = "InvalidValue" }
            New-EntraApplication -DisplayName "TestApp" -ParentalControlSettings $parentalSettings -ErrorAction SilentlyContinue -ErrorVariable testErr
            $testErr | Should -Not -BeNullOrEmpty
            "$testErr" | Should -BeLike "*legalAgeGroupRule*"
        }
    }
}
