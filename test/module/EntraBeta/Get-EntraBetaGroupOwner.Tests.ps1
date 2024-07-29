BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra.Beta) -eq $null){
        Import-Module Microsoft.Graph.Entra.Beta    
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force

    $scriptblock = {
        return @(
            [PSCustomObject]@{
                "DeletedDateTime"       = $null
                "Id"                    = "996d39aa-fdac-4d97-aa3d-c81fb47362ac"
                "AdditionalProperties"  = @{
                    "@odata.type"       = "#microsoft.graph.user"
                    "businessPhones"    = @("425-555-0100")
                    "displayName"       = "MOD Administrator"
                    "givenName"         = "MOD"
                    "mail"              = "admin@M365x99297270.onmicrosoft.com"
                    "mobilePhone"       = "425-555-0101"
                    "preferredLanguage" = "en"
                    "surname"           = "Administrator"
                    "userPrincipalName" = "admin@M365x99297270.onmicrosoft.com"
                    }
                "Parameters"             = $args
                }
            )

        }
    Mock -CommandName  Get-MgBetaGroupOwner -MockWith $scriptblock -ModuleName Microsoft.Graph.Entra.Beta
}

Describe "Get-EntraBetaGroupOwner" {
    Context "Test for Get-EntraBetaGroupOwner" {
        It "Get a group owner by Id" {
            $result = Get-EntraBetaGroupOwner -ObjectId "996d39aa-fdac-4d97-aa3d-c81fb47362ac"
            $result | Should -Not -BeNullOrEmpty
            $result.Id | should -Be '996d39aa-fdac-4d97-aa3d-c81fb47362ac'
            $result.DeletedDateTime | should -BeNullOrEmpty

            Should -Invoke -CommandName  Get-MgBetaGroupOwner -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }

        It "Should fail when ObjectId is empty" {
            { Get-EntraBetaGroupOwner -ObjectId } | Should -Throw "Missing an argument for parameter 'ObjectId'*"
        }

        It "Should fail when ObjectId is invalid" {
            { Get-EntraBetaGroupOwner -ObjectId "" } | Should -Throw "Cannot bind argument to parameter 'ObjectId' because it is an empty string."
        }

        It "Gets all group owners" {
            $result = Get-EntraBetaGroupOwner -ObjectId "996d39aa-fdac-4d97-aa3d-c81fb47362ac" -All $true
            $result | Should -Not -BeNullOrEmpty            

            Should -Invoke -CommandName Get-MgBetaGroupOwner -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }

        It "Should fail when All is empty" {
            { Get-EntraBetaGroupOwner -ObjectId "996d39aa-fdac-4d97-aa3d-c81fb47362ac" -All } | Should -Throw "Missing an argument for parameter 'All'*"
        }  

        It "Should fail when All is invalid" {
            { Get-EntraBetaGroupOwner -ObjectId "996d39aa-fdac-4d97-aa3d-c81fb47362ac" -All XY } | Should -Throw "Cannot process argument transformation on parameter 'All'*"
        }       

        It "Gets two group owners" {
            $result = Get-EntraBetaGroupOwner -ObjectId "996d39aa-fdac-4d97-aa3d-c81fb47362ac" -Top 2
            $result | Should -Not -BeNullOrEmpty

            Should -Invoke -CommandName Get-MgBetaGroupOwner -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }  

        It "Should fail when top is empty" {
            { Get-EntraBetaGroupOwner -ObjectId "996d39aa-fdac-4d97-aa3d-c81fb47362ac" -Top } | Should -Throw "Missing an argument for parameter 'Top'*"
        }  

        It "Should fail when top is invalid" {
            { Get-EntraBetaGroupOwner -ObjectId "996d39aa-fdac-4d97-aa3d-c81fb47362ac" -Top XY} | Should -Throw "Cannot process argument transformation on parameter 'Top'*"
        }  

        It "Result should Contain ObjectId" {
            $result = Get-EntraBetaGroupOwner -ObjectId "996d39aa-fdac-4d97-aa3d-c81fb47362ac"
            $result.ObjectId | should -Be "996d39aa-fdac-4d97-aa3d-c81fb47362ac"
        } 

        It "Should contain GroupId in parameters when passed ObjectId to it" {
            $result = Get-EntraBetaGroupOwner -ObjectId "996d39aa-fdac-4d97-aa3d-c81fb47362ac"
            $params = Get-Parameters -data $result.Parameters
            $params.GroupId | should -Be "996d39aa-fdac-4d97-aa3d-c81fb47362ac"
        }

        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraBetaGroupOwner"

            $result = Get-EntraBetaGroupOwner -ObjectId "996d39aa-fdac-4d97-aa3d-c81fb47362ac"
            $params = Get-Parameters -data $result.Parameters
            $params.headers.'User-Agent' | Should -Be $userAgentHeaderValue
        }    
    }
}