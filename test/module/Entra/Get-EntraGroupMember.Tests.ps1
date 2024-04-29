BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra) -eq $null){
        Import-Module Microsoft.Graph.Entra        
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force
    
        $mockResponse = @{
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
    Mock -CommandName  Invoke-GraphRequest -MockWith {$mockResponse} -ModuleName Microsoft.Graph.Entra
}
  
Describe "Get-EntraGroupMember" {
    Context "Test for Get-EntraGroupMember" {
        It "Get a group member by ID" {
            $result = Get-EntraGroupMember -ObjectId "0bdddeb1-88a6-4251-aaa5-98b48271158b"
            $result | Should -Not -BeNullOrEmpty
            $result.Id | should -Be '996d39aa-fdac-4d97-aa3d-c81fb47362ac'
            $result.DeletedDateTime | should -BeNullOrEmpty

            Should -Invoke -CommandName  Invoke-GraphRequest -ModuleName Microsoft.Graph.Entra -Times 1
        }

        It "Should fail when ObjectId is empty" {
            { Get-EntraGroupMember -ObjectId } | Should -Throw "Missing an argument for parameter 'ObjectId'*"
        }

        It "Should fail when ObjectId is invalid" {
            { Get-EntraGroupMember -ObjectId "" } | Should -Throw "Cannot bind argument to parameter 'ObjectId' because it is an empty string."
        }

        It "Get all members within a group by group ID" {
            $result = Get-EntraGroupMember -ObjectId "0bdddeb1-88a6-4251-aaa5-98b48271158b" -All $true
            $result | Should -Not -BeNullOrEmpty            
            
            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Graph.Entra -Times 1
        }

        It "Should fail when All is empty" {
            { Get-EntraGroupMember -ObjectId "0bdddeb1-88a6-4251-aaa5-98b48271158b" -All } | Should -Throw "Missing an argument for parameter 'All'*"
        }  
        
        It "Should fail when All is invalid" {
            { Get-EntraGroupMember -ObjectId "0bdddeb1-88a6-4251-aaa5-98b48271158b" -All XY } | Should -Throw "Cannot process argument transformation on parameter 'All'*"
        }       
        
        It "Get two group member" {
            $result = Get-EntraGroupMember -ObjectId "0bdddeb1-88a6-4251-aaa5-98b48271158b" -Top 2
            $result | Should -Not -BeNullOrEmpty

            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Graph.Entra -Times 1
        }  

        It "Should fail when top is empty" {
            { Get-EntraGroupMember -ObjectId "0bdddeb1-88a6-4251-aaa5-98b48271158b" -Top } | Should -Throw "Missing an argument for parameter 'Top'*"
        }  

        It "Should fail when top is invalis" {
            { Get-EntraGroupMember -ObjectId "0bdddeb1-88a6-4251-aaa5-98b48271158b" -Top XY} | Should -Throw "Cannot process argument transformation on parameter 'Top'*"
        }  

        It "Result should Contain ObjectId" {
            $result = Get-EntraGroupMember -ObjectId "0bdddeb1-88a6-4251-aaa5-98b48271158b"
            $result.ObjectId | should -Be "996d39aa-fdac-4d97-aa3d-c81fb47362ac"
        } 
    }
}