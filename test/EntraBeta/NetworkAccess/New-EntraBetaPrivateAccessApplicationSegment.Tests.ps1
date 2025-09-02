# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.
#  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
BeforeAll {
    if ((Get-Module -Name Microsoft.Entra.Beta.NetworkAccess) -eq $null) {
        Import-Module Microsoft.Entra.Beta.NetworkAccess
    }
    Import-Module (Join-Path $PSScriptRoot "..\..\Common-Functions.ps1") -Force

    Mock -CommandName Invoke-GraphRequest -MockWith { @{ id = 'seg1' } } -ModuleName Microsoft.Entra.Beta.NetworkAccess

    Mock -CommandName Get-EntraContext -MockWith {
        @{
            Environment = @{
                Name = "Global"
            }
            Scopes = @("NetworkAccessPolicy.ReadWrite.All", "Application.ReadWrite.All", "NetworkAccess.ReadWrite.All")
        }
    } -ModuleName Microsoft.Entra.NetworkAccess
}

Describe "New-EntraBetaPrivateAccessApplicationSegment" {
    It "Should throw when not connected and not call Graph" {
        Mock -CommandName Get-EntraContext -MockWith { $null } -ModuleName Microsoft.Entra.Beta.NetworkAccess

        { New-EntraBetaPrivateAccessApplicationSegment -ApplicationId app1 -DestinationHost 'api.contoso.com' -DestinationType 'dnsSuffix' } | Should -Throw "Not connected to Microsoft Graph*"
        Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.Beta.NetworkAccess -Times 0
    }

    It "Should POST segment with dnsSuffix" {
        New-EntraBetaPrivateAccessApplicationSegment -ApplicationId app1 -DestinationHost 'api.contoso.com' -DestinationType 'dnsSuffix'

        Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.Beta.NetworkAccess -Times 1 -ParameterFilter {
            $Method -eq 'POST' -and $Uri -eq "/beta/applications/app1/onPremisesPublishing/segmentsConfiguration/microsoft.graph.ipSegmentConfiguration/applicationSegments/"
        }
    }

    It "Should POST segment with IP details and ports/protocol" {
        New-EntraBetaPrivateAccessApplicationSegment -ApplicationId app1 -DestinationHost '10.0.0.1' -DestinationType 'ipAddress' -Ports 80,443 -Protocol TCP

        Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.Beta.NetworkAccess -Times 1 -ParameterFilter {
            $Method -eq 'POST' -and $Uri -eq "/beta/applications/app1/onPremisesPublishing/segmentsConfiguration/microsoft.graph.ipSegmentConfiguration/applicationSegments/"
        }
    }
}
