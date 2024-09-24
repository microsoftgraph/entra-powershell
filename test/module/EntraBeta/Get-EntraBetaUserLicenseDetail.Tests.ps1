# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra.Beta) -eq $null){
        Import-Module Microsoft.Graph.Entra.Beta    
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force
    
    $scriptblock = {
        return @(
            [PSCustomObject]@{
                Id = "A1bC2dE3fH4iJ5kL6mN7oP8qR9sT0u"
                ServicePlans = @("COMMON_DEFENDER_PLATFORM_FOR_OFFICE", "Bing_Chat_Enterprise", "MESH_IMMERSIVE_FOR_TEAMS", "PURVIEW_DISCOVERY")
                SkuId = "aaaaaaaa-0b0b-1c1c-2d2d-333333333333"
                SkuPartNumber = "ENTERPRISEPREMIUM"
                AdditionalProperties = @{}
                parameters = $args
            }
        )
    }

    Mock -CommandName Get-MgBetaUserLicenseDetail -MockWith $scriptblock -ModuleName Microsoft.Graph.Entra.Beta
}
  
Describe "Get-EntraBetaUserLicenseDetail" {
    Context "Test for Get-EntraBetaUserLicenseDetail" {
        It "Should return specific User License Detail" {
            $result = Get-EntraBetaUserLicenseDetail -ObjectId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"

            $result | Should -Not -BeNullOrEmpty
            $result.Id | should -Be "A1bC2dE3fH4iJ5kL6mN7oP8qR9sT0u"
            $result.ServicePlans | Should -Be @("COMMON_DEFENDER_PLATFORM_FOR_OFFICE", "Bing_Chat_Enterprise", "MESH_IMMERSIVE_FOR_TEAMS", "PURVIEW_DISCOVERY")
            $result.SkuId | Should -Be "aaaaaaaa-0b0b-1c1c-2d2d-333333333333"
            $result.SkuPartNumber | Should -Be "ENTERPRISEPREMIUM"
            $result.AdditionalProperties | Should -BeOfType [System.Collections.Hashtable]

            Should -Invoke -CommandName Get-MgBetaUserLicenseDetail -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }

        It "Should fail when ObjectId is empty string" {
            { Get-EntraBetaUserLicenseDetail -ObjectId "" } | Should -Throw "Cannot bind argument to parameter 'ObjectId' because it is an empty string."
        }   

        It "Should fail when ObjectId is empty" {
            { Get-EntraBetaUserLicenseDetail -ObjectId } | Should -Throw "Missing an argument for parameter 'ObjectId'. Specify a parameter of type 'System.String' and try again."
        }

        It "Should fail when invalid parameter is passed" {
            { Get-EntraBetaUserLicenseDetail -Power "abc" } | Should -Throw "A parameter cannot be found that matches parameter name 'Power'*"
        }  

        It "Should contain UserId in parameters when passed ObjectId to it" {              
            $result = Get-EntraBetaUserLicenseDetail -ObjectId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
            $params = Get-Parameters -data $result.Parameters
            $params.UserId | Should -Be "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
        }
        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraBetaUserLicenseDetail"
            $result = Get-EntraBetaUserLicenseDetail -ObjectId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
            $result | Should -Not -BeNullOrEmpty
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraBetaUserLicenseDetail"
            Should -Invoke -CommandName Get-MgBetaUserLicenseDetail -ModuleName Microsoft.Graph.Entra.Beta -Times 1 -ParameterFilter {
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
                { Get-EntraBetaUserLicenseDetail -ObjectId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -Debug } | Should -Not -Throw
            } finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        }
    }
}