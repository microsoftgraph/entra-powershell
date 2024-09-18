# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra.Beta) -eq $null){
        Import-Module Microsoft.Graph.Entra.Beta    
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force

    Mock -CommandName Update-MgBetaGroup -MockWith {} -ModuleName Microsoft.Graph.Entra.Beta
}

Describe "Set-EntraBetaGroup" {
    Context "Test for Set-EntraBetaGroup" {
        It "Should return empty object" {
            $result = Set-EntraBetaGroup -Id "00aa00aa-bb11-cc22-dd33-44ee44ee44ee" -Description "Update Group" -DisplayName "Update My Test san" -MailEnabled $false -MailNickname "Update nickname" -SecurityEnabled $true
            $result | Should -BeNullOrEmpty

            Should -Invoke -CommandName Update-MgBetaGroup -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }

        It "Should fail when ObjectId is empty" {
            { Set-EntraBetaGroup -Id } | Should -Throw "Missing an argument for parameter 'Id'*"
        } 

        It "Should fail when ObjectId is invalid" {
            { Set-EntraBetaGroup -Id "" } | Should -Throw "Cannot bind argument to parameter 'Id' because it is an empty string.*"
        } 

        It "Should fail when Description is empty" {
            { Set-EntraBetaGroup -Id "00aa00aa-bb11-cc22-dd33-44ee44ee44ee" -Description  } | Should -Throw "Missing an argument for parameter 'Description'.*"
        } 

        It "Should fail when DisplayName is empty" {
            { Set-EntraBetaGroup -Id "00aa00aa-bb11-cc22-dd33-44ee44ee44ee" -DisplayName  } | Should -Throw "Missing an argument for parameter 'DisplayName'.*"
        } 

        It "Should fail when MailEnabled is empty" {
            { Set-EntraBetaGroup -Id "00aa00aa-bb11-cc22-dd33-44ee44ee44ee" -MailEnabled  } | Should -Throw "Missing an argument for parameter*"
        } 

        It "Should fail when MailEnabled is invalid" {
            { Set-EntraBetaGroup -Id "00aa00aa-bb11-cc22-dd33-44ee44ee44ee" -MailEnabled ""} | Should -Throw "Cannot process argument transformation on parameter 'MailEnabled'.*"
        } 

        It "Should fail when MailNickname is empty" {
            { Set-EntraBetaGroup -Id "00aa00aa-bb11-cc22-dd33-44ee44ee44ee" -MailNickname  } | Should -Throw "Missing an argument for parameter*"
        } 

        It "Should fail when SecurityEnabled is empty" {
            { Set-EntraBetaGroup -Id "00aa00aa-bb11-cc22-dd33-44ee44ee44ee" -SecurityEnabled  } | Should -Throw "Missing an argument for parameter*"
        } 

        It "Should contain GroupId in parameters when passed ObjectId to it" {
            Mock -CommandName Update-MgBetaGroup -MockWith {$args} -ModuleName Microsoft.Graph.Entra.Beta

            $result = Set-EntraBetaGroup -Id "00aa00aa-bb11-cc22-dd33-44ee44ee44ee"
            $params = Get-Parameters -data $result
            $params.GroupId | Should -Be "00aa00aa-bb11-cc22-dd33-44ee44ee44ee"
        }        

        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Set-EntraBetaGroup"
            $result = Set-EntraBetaGroup -Id "00aa00aa-bb11-cc22-dd33-44ee44ee44ee"
            $result | Should -BeNullOrEmpty
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Set-EntraBetaGroup"
            Should -Invoke -CommandName Update-MgBetaGroup -ModuleName Microsoft.Graph.Entra.Beta -Times 1 -ParameterFilter {
                $Headers.'User-Agent' | Should -Be $userAgentHeaderValue
                $true
            }
        } 

        It "Should execute successfully without throwing an error " {
            # Disable confirmation prompts       
            $originalDebugPreference = $DebugPreference
            $DebugPreference = 'Continue'
    
            try {
                # Act & Assert: Ensure the function doesn't throw an exception
                { Set-EntraBetaGroup -Id "00aa00aa-bb11-cc22-dd33-44ee44ee44ee" -Debug } | Should -Not -Throw
            } finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        } 
    }
}