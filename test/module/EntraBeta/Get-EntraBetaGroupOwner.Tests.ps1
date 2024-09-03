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
            $result = Get-EntraBetaGroupOwner -ObjectId "996d39aa-fdac-4d97-aa3d-c81fb47362ac" -All
            $result | Should -Not -BeNullOrEmpty            

            Should -Invoke -CommandName Get-MgBetaGroupOwner -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }

        It "Should fail when All has an argument" {
            { Get-EntraBetaGroupOwner -ObjectId "996d39aa-fdac-4d97-aa3d-c81fb47362ac" -All $true } | Should -Throw "A positional parameter cannot be found that accepts argument 'True'."
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

        It "Should execute successfully without throwing an error " {
            # Disable confirmation prompts       
            $originalDebugPreference = $DebugPreference
            $DebugPreference = 'Continue'
    
            try {
                # Act & Assert: Ensure the function doesn't throw an exception
                { Get-EntraBetaGroupOwner -ObjectId "996d39aa-fdac-4d97-aa3d-c81fb47362ac" -Debug } | Should -Not -Throw
            } finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        }
    }
}