# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra.Beta) -eq $null){
        Import-Module Microsoft.Graph.Entra.Beta    
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force

    Mock -CommandName Update-MgBetaUser -MockWith {} -ModuleName Microsoft.Graph.Entra.Beta
}

Describe "Set-EntraBetaUser" {
    Context "Test for Set-EntraBetaUser" {
        It "Should update a user" {
            $result = Set-EntraBetaUser -ObjectId "00aa00aa-bb11-cc22-dd33-44ee44ee44ee" -Displayname "dummy1"
            $result | Should -BeNullOrEmpty

            Should -Invoke -CommandName Update-MgBetaUser -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }

        It "Should fail when ObjectId is empty" {
            { Set-EntraBetaUser -ObjectId   } | Should -Throw "Missing an argument for parameter 'ObjectId'*"
        } 

        It "Should fail when ObjectId is invalid" {
            { Set-EntraBetaUser -ObjectId ""  } | Should -Throw "Cannot bind argument to parameter 'ObjectId' because it is an empty string.*"
        } 

        It "Should fail when DisplayName is empty" {
            { Set-EntraBetaUser -ObjectId "00aa00aa-bb11-cc22-dd33-44ee44ee44ee" -Displayname  } | Should -Throw "Missing an argument for parameter 'DisplayName'.*"
        }

        It "Should fail when UserPrincipalName is empty" {
            { Set-EntraBetaUser -ObjectId "00aa00aa-bb11-cc22-dd33-44ee44ee44ee" -UserPrincipalName } | Should -Throw "Missing an argument for parameter 'UserPrincipalName'*"
        } 
        
        It "Should contain UserId in parameters when passed Id to it" {
            Mock -CommandName Update-MgBetaUser -MockWith {$args} -ModuleName Microsoft.Graph.Entra.Beta

            $result = Set-EntraBetaUser -ObjectId "00aa00aa-bb11-cc22-dd33-44ee44ee44ee" -Displayname "dummy1"
            $params = Get-Parameters -data $result
            $params.UserId | Should -Be "00aa00aa-bb11-cc22-dd33-44ee44ee44ee"
        }        

        It "Should contain 'User-Agent' header" {
            Mock -CommandName Update-MgBetaUser -MockWith {$args} -ModuleName Microsoft.Graph.Entra.Beta

            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Set-EntraBetaUser"
            $result = Set-EntraBetaUser -ObjectId "00aa00aa-bb11-cc22-dd33-44ee44ee44ee" -Displayname "dummy1"
            $params = Get-Parameters -data $result
            $params.Headers["User-Agent"] | Should -Be $userAgentHeaderValue
        }

        It "Should execute successfully without throwing an error " {
            # Disable confirmation prompts       
            $originalDebugPreference = $DebugPreference
            $DebugPreference = 'Continue'
    
            try {
                # Act & Assert: Ensure the function doesn't throw an exception
                { Set-EntraBetaUser -ObjectId "00aa00aa-bb11-cc22-dd33-44ee44ee44ee" -Displayname "dummy1" -Debug } | Should -Not -Throw
            } finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        } 
    }
}