# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra.Beta) -eq $null){
        Import-Module Microsoft.Graph.Entra.Beta    
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force

    Mock -CommandName Update-MgBetaOauth2PermissionGrant -MockWith {} -ModuleName Microsoft.Graph.Entra.Beta
}

Describe 'Update-EntraBetaOauth2PermissionGrant' {
    Mock -CommandName 'New-EntraCustomHeaders' -MockWith {
        return @{ "Authorization" = "Bearer token" }
    }

    Mock -CommandName 'Invoke-GraphRequest' -MockWith {
        return @{ "status" = "success" }
    }

    Context 'When OAuth2PermissionGrantId is provided' {
        It 'Should call Invoke-GraphRequest with correct parameters' {
            $OAuth2PermissionGrantId = '9NZRbmDg40WLpstnWGOz3bPoBg32YpRKr8_RV9A0geA'
            $Scope = 'User.Read.All'

            $expectedUri = "https://graph.microsoft.com/v1.0/oauth2PermissionGrants/$OAuth2PermissionGrantId"
            $expectedBody = @{ "scope" = $Scope }

            Update-EntraBetaOauth2PermissionGrant -OAuth2PermissionGrantId $OAuth2PermissionGrantId -Scope $Scope

            Assert-MockCalled -CommandName 'Invoke-GraphRequest' -Exactly 1 -Scope It -ParameterFilter {
                $params["Uri"] -eq $expectedUri -and
                $params["Method"] -eq "PATCH" -and
                $params["Body"]["scope"] -eq $Scope
            }
        }
        It "Should contain 'User-Agent' header" {
            $psVersion = $PSVersionTable.PSVersion.ToString()
            $entraVersion = (Get-Module -Name Microsoft.Graph.Entra).Version.ToString()
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Update-EntraBetaOauth2PermissionGrant"
    
            Update-EntraBetaOauth2PermissionGrant -OAuth2PermissionGrantId $OAuth2PermissionGrantId -Scope $Scope
    
            Assert-MockCalled -CommandName 'Invoke-GraphRequest' -Exactly 1 -Scope It -ParameterFilter {
                $params["Headers"]['User-Agent'] -eq $userAgentHeaderValue
            }
        }
    }

    Context 'When Scope is not provided' {
        It 'Should call Invoke-GraphRequest with correct parameters' {
            $OAuth2PermissionGrantId = '9NZRbmDg40WLpstnWGOz3bPoBg32YpRKr8_RV9A0geA'

            $expectedUri = "https://graph.microsoft.com/beta/oauth2PermissionGrants/$OAuth2PermissionGrantId"
            $expectedBody = @{}

            Update-EntraBetaOauth2PermissionGrant -OAuth2PermissionGrantId $OAuth2PermissionGrantId

            Assert-MockCalled -CommandName 'Invoke-GraphRequest' -Exactly 1 -Scope It -ParameterFilter {
                $params["Uri"] -eq $expectedUri -and
                $params["Method"] -eq "PATCH" -and
                $params["Body"].Count -eq 0
            }
        }
    }

    Context 'When OAuth2PermissionGrantId is not provided' {
        It 'Should fail when OAuth2PermissionGrantId is empty' {
            { Update-EntraBetaOauth2PermissionGrant -Scope 'User.Read' } | Should -Throw "Cannot bind argument to parameter 'OAuth2PermissionGrantId' because it is an empty string."
        }
    }
}