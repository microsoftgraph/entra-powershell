# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

BeforeAll {
    if ($null -eq (Get-Module -Name Microsoft.Entra.DirectoryManagement)) {
        Import-Module Microsoft.Entra.DirectoryManagement
    }
    Import-Module (Join-Path $PSScriptRoot "..\..\Common-Functions.ps1") -Force

    Mock -CommandName Get-EntraContext -MockWith { @{Scopes = @("Directory.ReadWrite.All") } } -ModuleName Microsoft.Entra.DirectoryManagement
    Mock -CommandName New-EntraCustomHeaders -MockWith { @{"User-Agent" = "Test"} } -ModuleName Microsoft.Entra.DirectoryManagement
    Mock -CommandName Out-File -ModuleName Microsoft.Entra.DirectoryManagement
    Mock -CommandName Write-EventLog -ModuleName Microsoft.Entra.DirectoryManagement

    $scriptblock = {
        return [PSCustomObject]@{
            "Features" = [PSCustomObject]@{
                "BlockCloudObjectTakeoverThroughHardMatchEnabled" = $false
                "PasswordSyncEnabled" = $false
            }
        }
    }
    Mock -CommandName Get-MgDirectoryOnPremiseSynchronization -MockWith $scriptblock -ModuleName Microsoft.Entra.DirectoryManagement
}

Describe "Get-EntraDirSyncFeature - Input Validation Logging" {
    Context "When an invalid Feature value is provided" {
        It "Should produce a Write-Error for invalid Feature name" {
            Get-EntraDirSyncFeature -Feature "NonExistentFeature" -ErrorAction SilentlyContinue -ErrorVariable testErr
            $testErr | Should -Not -BeNullOrEmpty
            "$testErr" | Should -BeLike "*Invalid value for parameter*"
        }
    }
}

Describe "Set-EntraDirSyncFeature - Input Validation Logging" {
    Context "When an empty feature string is provided" {
        It "Should throw for empty string in Features parameter" {
            { Set-EntraDirSyncFeature -Features @("") -Enabled $true } | Should -Throw "*non-empty string*"
        }

        It "Should throw for whitespace-only string in Features parameter" {
            { Set-EntraDirSyncFeature -Features @("  ") -Enabled $true } | Should -Throw "*non-empty string*"
        }
    }
}
