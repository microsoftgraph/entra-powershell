# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

Describe "Get-EntraBetaCrossTenantAccessActivity" {
    BeforeAll {
        if((Get-Module -Name Microsoft.Entra.Beta.Reports) -eq $null){
            Import-Module Microsoft.Entra.Beta.Reports    
        }
        Import-Module (Join-Path $PSScriptRoot "..\..\Common-Functions.ps1") -Force

        Mock -CommandName Get-EntraContext -ModuleName Microsoft.Entra.Beta.Reports  -MockWith {@{tenantId = "12345678-1234-1234-1234-123456789abc"; displayName = "Test Tenant"; defaultDomainName = "test.onmicrosoft.com"; federationBrandName = "TestBrand"}}
        Mock Invoke-GraphRequest -ModuleName Microsoft.Entra.Beta.Reports {
            return [PSCustomObject]@{
                'value' = @(
                    [PSCustomObject]@{ id = "00000003-0000-0000-c000-000000000001" }
                    [PSCustomObject]@{ id = "00000003-0000-0000-c000-000000000002" }
                )
                '@odata.context' = "https://graph.microsoft.com/beta/`$metadata#auditLogs/signIns"
                '@odata.nextLink' = "https://graph.microsoft.com/beta/auditLogs/signIns?`$top=2&`$skiptoken=305e4b930704dcf74ca3b809620741"
            }
        }
    }

    It "Should throw when not connected and not invoke graph call" {
        Mock -CommandName Get-EntraContext -MockWith { $null } -ModuleName Microsoft.Entra.Beta.Reports
        { Get-EntraBetaCrossTenantAccessActivity } | Should -Throw "Not connected to Microsoft Graph*"
        Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.Beta.Reports -Times 0
    }

    It "Calls Get-EntraBetaCrossTenantAccessActivity with no parameters" {
        Mock Get-EntraBetaCrossTenantAccessActivity {
            @{
                ExternalTenantId          = "12345678-90ab-cdef-1234-567890abcdef"
                ExternalTenantName        = "Contoso Ltd."
                ExternalDefaultDomain     = "contoso.onmicrosoft.com"
                ExternalTenantRegionScope = "EU"
                AccessDirection           = "Outbound"
                UserDisplayName           = "John Doe"
                UserPrincipalName         = "jdoe@contoso.com"
                UserId                    = "abcdef12-3456-7890-abcd-ef1234567890"
                UserType                  = "guest"
                CrossTenantAccessType     = "b2b"
                AppDisplayName            = "ContosoApp"
                AppId                     = "fedcba98-7654-3210-fedc-ba9876543210"
                ResourceDisplayName       = "Azure AD"
                ResourceId                = "00000003-0000-0000-c000-000000000001"
                SignInId                  = "11223344-5566-7788-99aa-bbccddeeff00"
                CreatedDateTime           = "3/15/2025 10:45:00 AM"
                StatusCode                = 200
                StatusReason              = "Success"
            }
        } -Verifiable

        $result = Get-EntraBetaCrossTenantAccessActivity

        Should -Invoke -CommandName Get-EntraBetaCrossTenantAccessActivity -Times 1
        $result.ExternalTenantId | Should -Be "12345678-90ab-cdef-1234-567890abcdef"
        $result.UserPrincipalName | Should -Be "jdoe@contoso.com"
    }

    It "Calls Get-EntraBetaCrossTenantAccessActivity with -SummaryStats switch" {
        Mock Get-EntraBetaCrossTenantAccessActivity {
            @{
                ExternalTenantId          = "12345678-90ab-cdef-1234-567890abcdef"
                ExternalTenantName        = "Contoso Ltd."
                ExternalTenantRegionScope = "EU"
                AccessDirection           = "Outbound"
                SignIns                   = 23
                SuccessSignIns            = 20
                FailedSignIns             = 3
                UniqueUsers               = 5
                UniqueResources           = 8
            }
        }

        $result = Get-EntraBetaCrossTenantAccessActivity -SummaryStats

        $result.ExternalTenantId | Should -Be "12345678-90ab-cdef-1234-567890abcdef"
        $result.ExternalTenantName | Should -Be "Contoso Ltd."
        $result.ExternalTenantRegionScope | Should -Be "EU"
        $result.AccessDirection | Should -Be "Outbound"
        $result.SignIns | Should -Be 23
        $result.SuccessSignIns | Should -Be 20
        $result.FailedSignIns | Should -Be 3
        $result.UniqueUsers | Should -Be 5
        $result.UniqueResources | Should -Be 8
    }

    It "Handles empty response gracefully" {
        Mock Get-EntraBetaCrossTenantAccessActivity { @{} }

        $result = Get-EntraBetaCrossTenantAccessActivity

        $result | Should -BeOfType Hashtable
        $result.Keys.Count | Should -Be 0
    }

    It "Ensures ExternalTenantId is a valid GUID and not empty when passed" {
        Mock Get-EntraBetaCrossTenantAccessActivity {
            @{
                ExternalTenantId = "a1b2c3d4-e5f6-7890-abcd-ef1234567890"
                ExternalTenantName = "Fabrikam Inc."
            }
        }

        $result = Get-EntraBetaCrossTenantAccessActivity -ExternalTenantId "a1b2c3d4-e5f6-7890-abcd-ef1234567890"

        $result.ExternalTenantId | Should -Match "^[a-fA-F0-9]{8}-[a-fA-F0-9]{4}-[a-fA-F0-9]{4}-[a-fA-F0-9]{4}-[a-fA-F0-9]{12}$"  # Valid GUID pattern
        $result.ExternalTenantId.Length | Should -Be 36
    }

    It "Should contain 'User-Agent' header" {
            Mock -CommandName Invoke-GraphRequest -MockWith { return 
            [PSCustomObject]@{
                value = @()
                '@odata.context' = "https://graph.microsoft.com/beta/`$metadata#auditLogs/signIns"
                '@odata.nextLink' = "https://graph.microsoft.com/beta/auditLogs/signIns?`$skiptoken=1234"
              }
            }-ModuleName Microsoft.Entra.Beta.Reports
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraBetaCrossTenantAccessActivity"
            $result =  Get-EntraBetaCrossTenantAccessActivity
            
            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.Beta.Reports -Times 1 -ParameterFilter {
                $Headers.'User-Agent' | Should -Be $userAgentHeaderValue
                $true
            }    
    }
}
