# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

BeforeAll {
    if ($null -eq (Get-Module -Name Microsoft.Entra.Users)) {
        Import-Module Microsoft.Entra.Users
    }
    Import-Module (Join-Path $PSScriptRoot "..\..\Common-Functions.ps1") -Force

    Mock -CommandName Get-EntraContext -MockWith { @{Scopes = @("User.Read.All") } } -ModuleName Microsoft.Entra.Users
    Mock -CommandName Out-File -ModuleName Microsoft.Entra.Users
    Mock -CommandName Write-EventLog -ModuleName Microsoft.Entra.Users

    $userMock = {
        return [PSCustomObject]@{
            Id = "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
            DisplayName = "Test User"
            UserPrincipalName = "testuser@contoso.com"
            AdditionalProperties = @{
                "extension_aaaaaaaa00001111_customProp" = "value1"
            }
        }
    }
    Mock -CommandName Invoke-GraphRequest -MockWith $userMock -ModuleName Microsoft.Entra.Users
}

Describe "Get-EntraUserExtension - Input Validation Logging" {
    Context "When invalid properties are specified" {
        It "Should produce an error for invalid property names" {
            Mock -CommandName Invoke-GraphRequest -MockWith {
                return [PSCustomObject]@{
                    value = @(
                        [PSCustomObject]@{ name = "extension_aaaa_prop1"; dataType = "String" }
                    )
                }
            } -ModuleName Microsoft.Entra.Users
            $result = Get-EntraUserExtension -UserId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -Property "nonExistentProp123" -ErrorAction SilentlyContinue -ErrorVariable testErr
            $testErr | Should -Not -BeNullOrEmpty
            "$testErr" | Should -BeLike "*Invalid property*"
        }
    }
}
