# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.
#  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

BeforeAll {  
    if ((Get-Module -Name Microsoft.Entra.Beta.DirectoryManagement) -eq $null) {
        Import-Module Microsoft.Entra.Beta.DirectoryManagement
    }
    Import-Module (Join-Path $PSScriptRoot "..\..\Common-Functions.ps1") -Force

    Mock -CommandName Test-EntraBetaModulePrerequisites -MockWith { return $true } -ModuleName Microsoft.Entra.Beta.DirectoryManagement
    Mock -CommandName Get-MgContext -MockWith {  @{Scopes = @("CrossTenantInformation.ReadBasic.All")} }
    Mock -CommandName Get-MgEnvironment -MockWith { @{GraphEndpoint = "https://graph.microsoft.com"; AzureADEndpoint = "https://login.microsoftonline.com"} }
    Mock -CommandName Invoke-MgGraphRequest -ModuleName Microsoft.Entra.Beta.DirectoryManagement -MockWith { @{tenantId = "12345"; displayName = "Test Tenant"; defaultDomainName = "test.onmicrosoft.com"; federationBrandName = "TestBrand"} }
    Mock -CommandName Invoke-RestMethod -ModuleName Microsoft.Entra.Beta.DirectoryManagement -MockWith {@{issuer = "https://login.microsoftonline.com/12345/v2.0"; tenant_region_scope = "US"} }
}

Describe "Resolve-EntraBetaIdTenant" {
    Context "Valid Inputs" {
        It "Should resolve tenant by GUID" {
            $result = Resolve-EntraBetaIdTenant -TenantId "12345678-1234-1234-1234-123456789abc"
            
            $result.Result | Should -Be "Resolved"
            $result.TenantId | Should -Be "12345"
            $result.DisplayName | Should -Be "Test Tenant"

            Should -Invoke -CommandName Invoke-MgGraphRequest -ModuleName Microsoft.Entra.Beta.DirectoryManagement  -Times 1
        }

        It "Should resolve tenant by domain name" {
            $result = Resolve-EntraBetaIdTenant -TenantId "test.onmicrosoft.com"

            $result.Result | Should -Be "Resolved"
            $result.DefaultDomainName | Should -Be "test.onmicrosoft.com"

            Should -Invoke -CommandName Invoke-MgGraphRequest -ModuleName Microsoft.Entra.Beta.DirectoryManagement  -Times 1
        }

        It "Should resolve tenant with OIDC metadata" {
            $result = Resolve-EntraBetaIdTenant -TenantId "test.onmicrosoft.com"

            $result.OidcMetadataResult | Should -Be "Resolved"
            $result.OidcMetadataTenantId | Should -Be "12345"
            $result.OidcMetadataTenantRegionScope | Should -Be "US"

            Should -Invoke -CommandName Invoke-RestMethod -ModuleName Microsoft.Entra.Beta.DirectoryManagement  -Times 1
        }
    }

    Context "Invalid Inputs" {
        
        It "Should return Skipped for invalid tenant Id" {
            $result = Resolve-EntraBetaIdTenant -TenantId "invalid_tenant_id"

            $result.ValueFormat | Should -Be "Unknown"
            $result.Status | Should -Be "Skipped"

            Should -Invoke -CommandName Invoke-MgGraphRequest -ModuleName Microsoft.Entra.Beta.DirectoryManagement  -Times 0
        }

        It "Should fail when TenantId is empty" {
            { Resolve-EntraBetaIdTenant -TenantId } | Should -Throw "Missing an argument for parameter 'TenantValue'*"
        }

         It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Resolve-EntraBetaIdTenant"

            Resolve-EntraBetaIdTenant -TenantId "Contoso.com"

            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Resolve-EntraBetaIdTenant"

            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.Beta.DirectoryManagement -Times 1 -ParameterFilter {
            $Headers.'User-Agent' | Should -Be $userAgentHeaderValue
            $true
            }
        } 
    }
}

