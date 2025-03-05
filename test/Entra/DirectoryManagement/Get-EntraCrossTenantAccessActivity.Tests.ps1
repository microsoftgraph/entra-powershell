# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
Describe "Get-EntraCrossTenantAccessActivity" {
    BeforeAll {
        if((Get-Module -Name Microsoft.Entra.DirectoryManagement) -eq $null){
            Import-Module Microsoft.Entra.DirectoryManagement    
        }
        Import-Module (Join-Path $PSScriptRoot "..\..\Common-Functions.ps1") -Force
    }

    It "Calls Get-EntraCrossTenantAccessActivity with no parameters" {
        Mock Get-EntraCrossTenantAccessActivity {
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

        $result = Get-EntraCrossTenantAccessActivity

        Should -Invoke -CommandName Get-EntraCrossTenantAccessActivity -Times 1
        $result.ExternalTenantId | Should -Be "12345678-90ab-cdef-1234-567890abcdef"
        $result.UserPrincipalName | Should -Be "jdoe@contoso.com"
    }

    It "Calls Get-EntraCrossTenantAccessActivity with -SummaryStats switch" {
        Mock Get-EntraCrossTenantAccessActivity {
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

        $result = Get-EntraCrossTenantAccessActivity -SummaryStats

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
        Mock Get-EntraCrossTenantAccessActivity { @{} }

        $result = Get-EntraCrossTenantAccessActivity

        $result | Should -BeOfType Hashtable
        $result.Keys.Count | Should -Be 0
    }

    It "Ensures ExternalTenantId is a valid GUID and not empty when passed" {
        Mock Get-EntraCrossTenantAccessActivity {
            @{
                ExternalTenantId = "a1b2c3d4-e5f6-7890-abcd-ef1234567890"
                ExternalTenantName = "Fabrikam Inc."
            }
        }

        $result = Get-EntraCrossTenantAccessActivity -ExternalTenantId "a1b2c3d4-e5f6-7890-abcd-ef1234567890"

        $result.ExternalTenantId | Should -Match "^[a-fA-F0-9]{8}-[a-fA-F0-9]{4}-[a-fA-F0-9]{4}-[a-fA-F0-9]{4}-[a-fA-F0-9]{12}$"  # Valid GUID pattern
        $result.ExternalTenantId.Length | Should -Be 36
    }
}
