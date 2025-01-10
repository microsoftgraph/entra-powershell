# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
BeforeAll {
    if ((Get-Module -Name Microsoft.Graph.Entra) -eq $null) {
        Import-Module Microsoft.Graph.Entra
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force

    $scriptblock = {
        # Write-Host "Mocking Get-EntraUserLicenseDetail with parameters: $($args | ConvertTo-Json -Depth 3)"
        return @(
            [PSCustomObject]@{
                Id = "X8Wu1RItQkSNL8zKldQ5DmAn38eBLPdOtXhbU5K1cd8"
                ServicePlans = @("COMMON_DEFENDER_PLATFORM_FOR_OFFICE", "Bing_Chat_Enterprise", "MESH_IMMERSIVE_FOR_TEAMS", "PURVIEW_DISCOVERY")
                SkuId = "00001111-aaaa-2222-bbbb-3333cccc4444"
                SkuPartNumber = "ENTERPRISEPREMIUM"
                AdditionalProperties = @{}
                parameters = $args
            }
        )

    }

    Mock -CommandName Get-MgUserLicenseDetail -MockWith $scriptblock -ModuleName Microsoft.Graph.Entra
}

Describe "Get-EntraUserLicenseDetail" {
    Context "Test for Get-EntraUserLicenseDetail" {
        It "Should return specific User" {
            $result = Get-EntraUserLicenseDetail -UserId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
            $result | Should -Not -BeNullOrEmpty
            $result.Id | should -Be "X8Wu1RItQkSNL8zKldQ5DmAn38eBLPdOtXhbU5K1cd8"
            $result.ServicePlans | Should -Be @("COMMON_DEFENDER_PLATFORM_FOR_OFFICE", "Bing_Chat_Enterprise", "MESH_IMMERSIVE_FOR_TEAMS", "PURVIEW_DISCOVERY")
            $result.SkuId | Should -Be "00001111-aaaa-2222-bbbb-3333cccc4444"
            $result.SkuPartNumber | Should -Be "ENTERPRISEPREMIUM"
            $result.AdditionalProperties | Should -BeOfType [System.Collections.Hashtable]

            should -Invoke -CommandName Get-MgUserLicenseDetail -ModuleName Microsoft.Graph.Entra -Times 1
        }
        It "Should return specific User with alias" {
            $result = Get-EntraUserLicenseDetail -ObjectId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
            $result | Should -Not -BeNullOrEmpty
            $result.Id | should -Be "X8Wu1RItQkSNL8zKldQ5DmAn38eBLPdOtXhbU5K1cd8"
            $result.ServicePlans | Should -Be @("COMMON_DEFENDER_PLATFORM_FOR_OFFICE", "Bing_Chat_Enterprise", "MESH_IMMERSIVE_FOR_TEAMS", "PURVIEW_DISCOVERY")
            $result.SkuId | Should -Be "00001111-aaaa-2222-bbbb-3333cccc4444"
            $result.SkuPartNumber | Should -Be "ENTERPRISEPREMIUM"
            $result.AdditionalProperties | Should -BeOfType [System.Collections.Hashtable]

            should -Invoke -CommandName Get-MgUserLicenseDetail -ModuleName Microsoft.Graph.Entra -Times 1
        }

        It "Should fail when UserId is empty string value" {
            { Get-EntraUserLicenseDetail -UserId "" } | Should -Throw "Cannot bind argument to parameter 'UserId' because it is an empty string."
        }

        It "Should fail when UserId is empty" {
            { Get-EntraUserLicenseDetail -UserId } | Should -Throw "Missing an argument for parameter 'UserId'. Specify a parameter of type 'System.String' and try again."
        }

        It "Should contain UserId in parameters when passed UserId to it" {
            $result = Get-EntraUserLicenseDetail -UserId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
            $params = Get-Parameters -data $result.Parameters
            $params.UserId | Should -Match "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
        }
        It "Property parameter should work" {
            $result = Get-EntraUserLicenseDetail -UserId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -Property Id
            $result | Should -Not -BeNullOrEmpty
            $result.Id | Should -Be 'X8Wu1RItQkSNL8zKldQ5DmAn38eBLPdOtXhbU5K1cd8'

            Should -Invoke -CommandName Get-MgUserLicenseDetail -ModuleName Microsoft.Graph.Entra -Times 1
        }
        It "Should fail when Property is empty" {
             { Get-EntraUserLicenseDetail -UserId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -Property } | Should -Throw "Missing an argument for parameter 'Property'*"
        }
        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraUserLicenseDetail"

            $result = Get-EntraUserLicenseDetail -UserId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
            $result | Should -Not -BeNullOrEmpty
            
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraUserLicenseDetail"

            Should -Invoke -CommandName Get-MgUserLicenseDetail -ModuleName Microsoft.Graph.Entra -Times 1 -ParameterFilter {
                $Headers.'User-Agent' | Should -Be $userAgentHeaderValue
                $true
            }
        }
        It "Should execute successfully without throwing an error" {
            # Disable confirmation prompts       
            $originalDebugPreference = $DebugPreference
            $DebugPreference = 'Continue'

            try {
                # Act & Assert: Ensure the function doesn't throw an exception
                { Get-EntraUserLicenseDetail -UserId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -Debug } | Should -Not -Throw
            } finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        }
    }
}