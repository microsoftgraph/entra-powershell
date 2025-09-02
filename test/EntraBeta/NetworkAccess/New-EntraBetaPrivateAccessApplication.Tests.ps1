# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.
#  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
BeforeAll {
    if ((Get-Module -Name Microsoft.Entra.Beta.NetworkAccess) -eq $null) {
        Import-Module Microsoft.Entra.Beta.NetworkAccess
    }
    Import-Module (Join-Path $PSScriptRoot "..\..\Common-Functions.ps1") -Force

    Mock -CommandName Get-EntraEnvironment -MockWith { @{ GraphEndpoint = 'https://graph.microsoft.com' } } -ModuleName Microsoft.Entra.Beta.NetworkAccess

    # default empty response
    Mock -CommandName Invoke-GraphRequest -MockWith { @{ application = @{ objectId = 'new-app-id' } } } -ModuleName Microsoft.Entra.Beta.NetworkAccess

    Mock -CommandName Get-EntraContext -MockWith {
        @{
            Environment = @{
                Name = "Global"
            }
            Scopes = @("NetworkAccessPolicy.ReadWrite.All", "Application.ReadWrite.All", "NetworkAccess.ReadWrite.All")
        }
    } -ModuleName Microsoft.Entra.Beta.NetworkAccess
}

Describe "New-EntraBetaPrivateAccessApplication" {
    It "Should throw when not connected and not call Graph" {
        Mock -CommandName Get-EntraContext -MockWith { $null } -ModuleName Microsoft.Entra.Beta.NetworkAccess

        { New-EntraBetaPrivateAccessApplication -ApplicationName 'MyApp' } | Should -Throw "Not connected to Microsoft Graph*"
        Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.Beta.NetworkAccess -Times 0
    }

    It "Should create app and patch ZTNA settings" {
        New-EntraBetaPrivateAccessApplication -ApplicationName 'MyApp'

        # instantiate template
        Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.Beta.NetworkAccess -ParameterFilter {
            $Method -eq 'POST' -and $Uri -eq '/beta/applicationTemplates/8adf8e6e-67b2-4cf2-a259-e3dc5476c621/instantiate'
        } -Times 1

        # patch app settings
        Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.Beta.NetworkAccess -ParameterFilter {
            $Method -eq 'PATCH' -and $Uri -eq "/beta/applications/new-app-id/"
        } -Times 1
    }

    It "Should assign connector group when ConnectorGroupId is provided" {
        New-EntraBetaPrivateAccessApplication -ApplicationName 'MyApp' -ConnectorGroupId 'cg1'

        Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.Beta.NetworkAccess -ParameterFilter {
            $Method -eq 'PUT' -and $Uri -eq "/beta/applications/new-app-id/connectorGroup/`$ref"
        } -Times 1
    }
}
