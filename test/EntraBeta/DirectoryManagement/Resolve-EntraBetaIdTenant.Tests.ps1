# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.
#  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

BeforeAll {  
    if ((Get-Module -Name Microsoft.Entra.Beta.DirectoryManagement) -eq $null) {
        Import-Module Microsoft.Entra.Beta.DirectoryManagement
    }
    Import-Module (Join-Path $PSScriptRoot "..\..\Common-Functions.ps1") -Force

    Mock -CommandName Get-MgContext -MockWith {  @{Scopes = @("CrossTenantInformation.ReadBasic.All")} } -ModuleName Microsoft.Entra.Beta.DirectoryManagement
    Mock -CommandName Get-MgEnvironment -MockWith { @{GraphEndpoint = "https://graph.microsoft.com"; AzureADEndpoint = "https://login.microsoftonline.com"} } -ModuleName Microsoft.Entra.Beta.DirectoryManagement
    Mock -CommandName Invoke-MgGraphRequest -ModuleName Microsoft.Entra.Beta.DirectoryManagement -MockWith { @{tenantId = "12345678-1234-1234-1234-123456789abc"; displayName = "Test Tenant"; defaultDomainName = "test.onmicrosoft.com"; federationBrandName = "TestBrand"} }
    Mock -CommandName Invoke-RestMethod -ModuleName Microsoft.Entra.Beta.DirectoryManagement -MockWith {@{issuer = "https://login.microsoftonline.com/12345/v2.0"; tenant_region_scope = "US"} }
}

Describe "Resolve-EntraBetaIdTenant" {
    Context "Valid Inputs" {
        It "Should resolve tenant by GUID" {
            $result = Resolve-EntraBetaIdTenant -TenantId "12345678-1234-1234-1234-123456789abc"
            
            $result.Result | Should -Be "Resolved"
            $result.TenantId | Should -Be "12345678-1234-1234-1234-123456789abc"
            $result.DisplayName | Should -Be "Test Tenant"

            Should -Invoke -CommandName Invoke-MgGraphRequest -ModuleName Microsoft.Entra.Beta.DirectoryManagement  -Times 1
        }

        It "Should resolve tenant by domain name" {
            $result = Resolve-EntraBetaIdTenant -DomainName "test.onmicrosoft.com"

            $result.Result | Should -Be "Resolved"
            $result.DefaultDomainName | Should -Be "test.onmicrosoft.com"

            Should -Invoke -CommandName Invoke-MgGraphRequest -ModuleName Microsoft.Entra.Beta.DirectoryManagement  -Times 1
        }

        It "Should resolve tenant with OIDC metadata" {
            $result = Resolve-EntraBetaIdTenant -DomainName "test.onmicrosoft.com"

            $result.OidcMetadataResult | Should -Be "Resolved"
            $result.OidcMetadataTenantId | Should -Be "12345"
            $result.OidcMetadataTenantRegionScope | Should -Be "US"

            Should -Invoke -CommandName Invoke-RestMethod -ModuleName Microsoft.Entra.Beta.DirectoryManagement  -Times 1
        }

        
         It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Resolve-EntraBetaIdTenant"

            Resolve-EntraBetaIdTenant -DomainName "Contoso.com"

            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Resolve-EntraBetaIdTenant"

            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.Beta.DirectoryManagement -Times 1 -ParameterFilter {
            $Headers.'User-Agent' | Should -Be $userAgentHeaderValue
            $true
            }
        } 
    }

    Context "Invalid Inputs" {
    
        It "Should throw an exception for invalid tenant Id" {
             {Resolve-EntraBetaIdTenant -TenantId "12345"} | Should -Throw "Cannot validate argument on parameter 'TenantId'. Invalid GUID format for TenantId"
         }
    }
}

