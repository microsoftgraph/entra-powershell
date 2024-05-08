BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra) -eq $null){
        Import-Module Microsoft.Graph.Entra        
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force
    
        $mockResponse = {
            return @{
                value = @(
                    @{
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
        }
    Mock -CommandName  Invoke-GraphRequest -MockWith $mockResponse -ModuleName Microsoft.Graph.Entra
}
  
Describe "Get-EntraGroupOwner" {
    Context "Test for Get-EntraGroupOwner" {
        It "Get a group owner by Id" {
            $result = Get-EntraGroupOwner -ObjectId "996d39aa-fdac-4d97-aa3d-c81fb47362ac"
            $result | Should -Not -BeNullOrEmpty
            $result.Id | should -Be '996d39aa-fdac-4d97-aa3d-c81fb47362ac'
            $result.DeletedDateTime | should -BeNullOrEmpty

            Should -Invoke -CommandName  Invoke-GraphRequest -ModuleName Microsoft.Graph.Entra -Times 1
        }

        It "Should fail when ObjectId is empty" {
            { Get-EntraGroupOwner -ObjectId } | Should -Throw "Missing an argument for parameter 'ObjectId'*"
        }

        It "Should fail when ObjectId is invalid" {
            { Get-EntraGroupOwner -ObjectId "" } | Should -Throw "Cannot bind argument to parameter 'ObjectId' because it is an empty string."
        }

        It "Gets all group owners" {
            $result = Get-EntraGroupOwner -ObjectId "996d39aa-fdac-4d97-aa3d-c81fb47362ac" -All $true
            $result | Should -Not -BeNullOrEmpty            
            
            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Graph.Entra -Times 1
        }

        It "Should fail when All is empty" {
            { Get-EntraGroupOwner -ObjectId "996d39aa-fdac-4d97-aa3d-c81fb47362ac" -All } | Should -Throw "Missing an argument for parameter 'All'*"
        }  
        
        It "Should fail when All is invalid" {
            { Get-EntraGroupOwner -ObjectId "996d39aa-fdac-4d97-aa3d-c81fb47362ac" -All XY } | Should -Throw "Cannot process argument transformation on parameter 'All'*"
        }       
        
        It "Gets two group owners" {
            $result = Get-EntraGroupOwner -ObjectId "996d39aa-fdac-4d97-aa3d-c81fb47362ac" -Top 2
            $result | Should -Not -BeNullOrEmpty

            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Graph.Entra -Times 1
        }  

        It "Should fail when top is empty" {
            { Get-EntraGroupOwner -ObjectId "996d39aa-fdac-4d97-aa3d-c81fb47362ac" -Top } | Should -Throw "Missing an argument for parameter 'Top'*"
        }  

        It "Should fail when top is invalid" {
            { Get-EntraGroupOwner -ObjectId "996d39aa-fdac-4d97-aa3d-c81fb47362ac" -Top XY} | Should -Throw "Cannot process argument transformation on parameter 'Top'*"
        }  

        It "Result should Contain ObjectId" {
            $result = Get-EntraGroupOwner -ObjectId "996d39aa-fdac-4d97-aa3d-c81fb47362ac"
            $result.ObjectId | should -Be "996d39aa-fdac-4d97-aa3d-c81fb47362ac"
        } 

        It "Should contain GroupId in parameters when passed ObjectId to it" {
            $result = Get-EntraGroupOwner -ObjectId "996d39aa-fdac-4d97-aa3d-c81fb47362ac"
            $params = Get-Parameters -data $result.Parameters
            $groupId= $params | ConvertTo-json | ConvertFrom-Json
            $groupId.Uri -match "996d39aa-fdac-4d97-aa3d-c81fb47362ac" | Should -BeTrue
        }

        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraGroupOwner"

            $result = Get-EntraGroupOwner -ObjectId "996d39aa-fdac-4d97-aa3d-c81fb47362ac"
            $params = Get-Parameters -data $result.Parameters
            $userAgent= $params | ConvertTo-json | ConvertFrom-Json
            $userAgent.headers.'User-Agent' | Should -Be $userAgentHeaderValue
        }    
    }
}