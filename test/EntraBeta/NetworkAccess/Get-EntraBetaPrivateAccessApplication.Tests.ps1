# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.
#  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
BeforeAll {
    if ((Get-Module -Name Microsoft.Entra.Beta.NetworkAccess) -eq $null) {
        Import-Module Microsoft.Entra.Beta.NetworkAccess
    }
    Import-Module (Join-Path $PSScriptRoot "..\..\Common-Functions.ps1") -Force

    Mock -CommandName Invoke-GraphRequest -MockWith {} -ModuleName Microsoft.Entra.Beta.NetworkAccess

    Mock -CommandName Get-EntraContext -MockWith {
        @{
            Environment = @{
                Name = "Global"
            }
            Scopes = @("NetworkAccessPolicy.ReadWrite.All", "Application.ReadWrite.All", "NetworkAccess.ReadWrite.All")
        }
    } -ModuleName Microsoft.Entra.NetworkAccess
}

Describe "Get-EntraBetaPrivateAccessApplication" {
    Context "Connection checks" {
        It "Should throw when not connected and not call Graph" {
            Mock -CommandName Get-EntraContext -MockWith { $null } -ModuleName Microsoft.Entra.Beta.NetworkAccess

            { Get-EntraBetaPrivateAccessApplication } | Should -Throw "Not connected to Microsoft Graph*"
            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.Beta.NetworkAccess -Times 0
        }
    }

    Context "All apps" {
        It "Should GET all private access applications" {
            Get-EntraBetaPrivateAccessApplication

            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.Beta.NetworkAccess -Times 1 -ParameterFilter {
                $Method -eq 'GET' -and $Uri -like "/beta/applications*" -and $Headers.'User-Agent' -like "PowerShell/* EntraPowershell/* Get-EntraBetaPrivateAccessApplication"
            }
        }
    }

    Context "By id and by name" {
        It "Should GET app by id" {
            Get-EntraBetaPrivateAccessApplication -ApplicationId "app-1"

            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.Beta.NetworkAccess -Times 1 -ParameterFilter {
                $Method -eq 'GET' -and $Uri -eq "/beta/applications/app-1/?`$select=displayName,appId,id,tags,createdDateTime,servicePrincipalType,createdDateTime,servicePrincipalNames"
            }
        }

        It "Should GET app by name" {
            Get-EntraBetaPrivateAccessApplication -ApplicationName "MyApp"

            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.Beta.NetworkAccess -Times 1 -ParameterFilter {
                $Method -eq 'GET' -and $Uri -like "/beta/applications?*DisplayName eq 'MyApp'*"
            }
        }
    }
}
