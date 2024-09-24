BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra.Beta) -eq $null){
        Import-Module Microsoft.Graph.Entra.Beta    
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force
    
    $scriptblock = {
        return @(
            [PSCustomObject]@{
                Id = "X8Wu1RItQkSNL8zKldQ5DmAn38eBLPdOtXhbU5K1cd8"
                ServicePlans = @("COMMON_DEFENDER_PLATFORM_FOR_OFFICE", "Bing_Chat_Enterprise", "MESH_IMMERSIVE_FOR_TEAMS", "PURVIEW_DISCOVERY")
                SkuId = "c7df2760-2c81-4ef7-b578-5b5392b571df"
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
            $result = Get-EntraBetaUserLicenseDetail -ObjectId "996d39aa-fdac-4d97-aa3d-c81fb47362ac"

            $result | Should -Not -BeNullOrEmpty
            $result.Id | should -Be "X8Wu1RItQkSNL8zKldQ5DmAn38eBLPdOtXhbU5K1cd8"
            $result.ServicePlans | Should -Be @("COMMON_DEFENDER_PLATFORM_FOR_OFFICE", "Bing_Chat_Enterprise", "MESH_IMMERSIVE_FOR_TEAMS", "PURVIEW_DISCOVERY")
            $result.SkuId | Should -Be "c7df2760-2c81-4ef7-b578-5b5392b571df"
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
            $result = Get-EntraBetaUserLicenseDetail -ObjectId "996d39aa-fdac-4d97-aa3d-c81fb47362ac"
            $params = Get-Parameters -data $result.Parameters
            $params.UserId | Should -Be "996d39aa-fdac-4d97-aa3d-c81fb47362ac"
        }

        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraBetaUserLicenseDetail"

            $result = Get-EntraBetaUserLicenseDetail -ObjectId "996d39aa-fdac-4d97-aa3d-c81fb47362ac"
            $params = Get-Parameters -data $result.Parameters

            $params.Headers["User-Agent"] | Should -Be $userAgentHeaderValue
        }
    
    }
}