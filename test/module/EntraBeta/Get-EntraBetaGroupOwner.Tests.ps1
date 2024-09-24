# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra.Beta) -eq $null){
        Import-Module Microsoft.Graph.Entra.Beta        
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force

        $mockResponse = {
            return @{
                value = @(
                    @{
                    "DeletedDateTime"       = $null
                    "Id"                    = "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
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
    Mock -CommandName  Invoke-GraphRequest -MockWith $mockResponse -ModuleName Microsoft.Graph.Entra.Beta
}

Describe "Get-EntraBetaGroupOwner" {
    Context "Test for Get-EntraBetaGroupOwner" {
        It "Get a group owner by Id" {
            $result = Get-EntraBetaGroupOwner -ObjectId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
            $result | Should -Not -BeNullOrEmpty
            $result.Id | should -Be 'aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb'
            $result.DeletedDateTime | should -BeNullOrEmpty

            Should -Invoke -CommandName  Invoke-GraphRequest -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }

        It "Should fail when ObjectId is empty" {
            { Get-EntraBetaGroupOwner -ObjectId } | Should -Throw "Missing an argument for parameter 'ObjectId'*"
        }

        It "Should fail when ObjectId is invalid" {
            { Get-EntraBetaGroupOwner -ObjectId "" } | Should -Throw "Cannot bind argument to parameter 'ObjectId' because it is an empty string."
        }

        It "Gets all group owners" {
            $result = Get-EntraBetaGroupOwner -ObjectId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -All 
            $result | Should -Not -BeNullOrEmpty            

            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }

        It "Should fail when All has an argument" {
            { Get-EntraBetaGroupOwner -All $true} | Should -Throw "A positional parameter cannot be found that accepts argument 'True'."
        }

        It "Gets two group owners" {
            $result = Get-EntraBetaGroupOwner -ObjectId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -Top 2
            $result | Should -Not -BeNullOrEmpty

            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }  

        It "Should fail when top is empty" {
            { Get-EntraBetaGroupOwner -ObjectId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -Top } | Should -Throw "Missing an argument for parameter 'Top'*"
        }  

        It "Should fail when top is invalid" {
            { Get-EntraBetaGroupOwner -ObjectId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -Top XY} | Should -Throw "Cannot process argument transformation on parameter 'Top'*"
        }  

        It "Result should Contain ObjectId" {
            $result = Get-EntraBetaGroupOwner -ObjectId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
            $result.ObjectId | should -Be "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
        } 

        It "Should contain GroupId in parameters when passed ObjectId to it" {
            $result = Get-EntraBetaGroupOwner -ObjectId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
            $params = Get-Parameters -data $result.Parameters
            $groupId= $params | ConvertTo-json | ConvertFrom-Json
            $groupId.Uri -match "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" | Should -BeTrue
        }

        It "Should contain 'User-Agent' header" {
        
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraBetaGroupOwner"
            $result = Get-EntraBetaGroupOwner -ObjectId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
            $result | Should -Not -BeNullOrEmpty
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraBetaGroupOwner"
            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Graph.Entra.Beta -Times 1 -ParameterFilter {
               $Headers.'User-Agent' | Should -Be $userAgentHeaderValue
               $true
           }
       } 
       It "Property parameter should work" {
        $result = Get-EntraBetaGroupOwner -ObjectId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -Property Id
        $result | Should -Not -BeNullOrEmpty
        $result.Id | Should -Be 'aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb'

        Should -Invoke -CommandName Invoke-GraphRequest  -ModuleName Microsoft.Graph.Entra.Beta -Times 1
       }

       It "Should fail when Property is empty" {
        { Get-EntraBetaGroupOwner -ObjectId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -Property } | Should -Throw "Missing an argument for parameter 'Property'.*"
       }

       It "Should execute successfully without throwing an error " {
        # Disable confirmation prompts       
        $originalDebugPreference = $DebugPreference
        $DebugPreference = 'Continue'

        try {
            # Act & Assert: Ensure the function doesn't throw an exception
            { Get-EntraBetaGroupOwner -ObjectId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -Debug } | Should -Not -Throw
        } finally {
            # Restore original confirmation preference            
            $DebugPreference = $originalDebugPreference        
        }
    }
}
}