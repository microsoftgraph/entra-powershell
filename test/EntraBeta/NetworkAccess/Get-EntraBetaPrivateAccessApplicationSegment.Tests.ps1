# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.
#  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
BeforeAll {
    if ((Get-Module -Name Microsoft.Entra.Beta.NetworkAccess) -eq $null) {
        Import-Module Microsoft.Entra.Beta.NetworkAccess
    }
    Import-Module (Join-Path $PSScriptRoot "..\..\Common-Functions.ps1") -Force

    Mock -CommandName Invoke-GraphRequest -MockWith { @{ value = @() } } -ModuleName Microsoft.Entra.Beta.NetworkAccess

    Mock -CommandName Get-EntraContext -MockWith {
        @{
            Environment = @{
                Name = "Global"
            }
            Scopes = @("NetworkAccessPolicy.ReadWrite.All", "Application.ReadWrite.All", "NetworkAccess.ReadWrite.All")
        }
    } -ModuleName Microsoft.Entra.NetworkAccess
}

Describe "Get-EntraBetaPrivateAccessApplicationSegment" {
    It "Should throw when not connected and not call Graph" {
        Mock -CommandName Get-EntraContext -MockWith { $null } -ModuleName Microsoft.Entra.Beta.NetworkAccess
        { Get-EntraBetaPrivateAccessApplicationSegment -ApplicationId app1 } | Should -Throw "Not connected to Microsoft Graph*"
        Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.Beta.NetworkAccess -Times 0
    }

    It "Should GET all segments by application id" {
        Get-EntraBetaPrivateAccessApplicationSegment -ApplicationId app1

        Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.Beta.NetworkAccess -Times 1 -ParameterFilter {
            $Method -eq 'GET' -and $Uri -eq "/beta/applications/app1/onPremisesPublishing/segmentsConfiguration/microsoft.graph.ipSegmentConfiguration/applicationSegments"
        }
    }

    It "Should GET a single segment by id" {
        Get-EntraBetaPrivateAccessApplicationSegment -ApplicationId app1 -ApplicationSegmentId seg1

        Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.Beta.NetworkAccess -Times 1 -ParameterFilter {
            $Method -eq 'GET' -and $Uri -eq "/beta/applications/app1/onPremisesPublishing/segmentsConfiguration/microsoft.graph.ipSegmentConfiguration/applicationSegments/seg1"
        }
    }
}
