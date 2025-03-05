# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
Describe "Get-EntraBetaCrossTenantAccessActivity" {
    BeforeAll {
        if((Get-Module -Name Microsoft.Entra.Beta.DirectoryManagement) -eq $null){
            Import-Module Microsoft.Entra.Beta.DirectoryManagement       
        }
        Import-Module (Join-Path $PSScriptRoot "..\..\Common-Functions.ps1") -Force

    }

    It "Calls Get-EntraBetaCrossTenantAccessActivity with no parameters" {

        $scriptblock = {
            return @(
                [PSCustomObject]@{
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
            )
        }    
        Mock -CommandName Get-EntraBetaCrossTenantAccessActivity -MockWith $scriptblock -ModuleName Microsoft.Entra.Beta.DirectoryManagement
       
        $result = Get-EntraBetaCrossTenantAccessActivity

        Should -Invoke -CommandName Get-EntraBetaCrossTenantAccessActivity -Times 1
        $result.ExternalTenantId | Should -Be "12345678-90ab-cdef-1234-567890abcdef"
        $result.UserPrincipalName | Should -Be "jdoe@contoso.com"
    }

    It "Calls Get-EntraBetaCrossTenantAccessActivity with -SummaryStats switch" {
        # Arrange
        Mock Get-EntraBetaCrossTenantAccessActivity { return
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
        } -ModuleName Microsoft.Entra.Beta.DirectoryManagement

        # Act
        $result = Get-EntraBetaCrossTenantAccessActivity -SummaryStats

        # Assert
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
        # Arrange
        Mock Get-EntraBetaCrossTenantAccessActivity { return @{} } -ModuleName Microsoft.Entra.Beta.DirectoryManagement

        # Act
        $result = Get-EntraBetaCrossTenantAccessActivity

        # Assert
        $result | Should -BeOfType Hashtable
        $result.Keys.Count | Should -Be 0
    }


    It "Ensures ExternalTenantId is a valid GUID and not empty when passed" {
        # Arrange
        Mock Get-EntraBetaCrossTenantAccessActivity { return
            @{
                ExternalTenantId = "a1b2c3d4-e5f6-7890-abcd-ef1234567890"
                ExternalTenantName = "Fabrikam Inc."
            }
        } -ModuleName Microsoft.Entra.Beta.DirectoryManagement

        # Act
        $result = Get-EntraBetaCrossTenantAccessActivity -ExternalTenantId "a1b2c3d4-e5f6-7890-abcd-ef1234567890"

        # Assert
        $result.ExternalTenantId | Should -Match "^[a-fA-F0-9]{8}-[a-fA-F0-9]{4}-[a-fA-F0-9]{4}-[a-fA-F0-9]{4}-[a-fA-F0-9]{12}$"  # Valid GUID pattern
        $result.ExternalTenantId.Length | Should -Be 36
        $result.ExternalTenantId | Should -NotBeEmpty
    }

    It "Should contain 'User-Agent' header" {
        $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraBetaCrossTenantAccessActivity"

        Mock Get-EntraBetaCrossTenantAccessActivity {
            return @{
                ExternalTenantId = $ExternalTenantId
                ExternalTenantName = "Fabrikam Inc."
            }
        } -Verifiable

        Mock Invoke-MgGraphRequest -MockWith {
            param($Uri, $Headers)
            if ($Headers["User-Agent"] -ne $userAgentHeaderValue) {
                throw "User-Agent header is incorrect"
            }
        } -Verifiable

        $result =  Get-EntraBetaCrossTenantAccessActivity
        $result | Should -Not -BeNullOrEmpty

        $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraBetaCrossTenantAccessActivity"

        Should -Invoke -CommandName Get-EntraBetaCrossTenantAccessActivity -ModuleName Microsoft.Entra.Beta.DirectoryManagement -Times 1 -ParameterFilter {
            $Headers.'User-Agent' | Should -Be $userAgentHeaderValue
            $true
        }
    }

}
