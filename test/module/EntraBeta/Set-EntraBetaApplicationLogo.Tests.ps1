# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra.Beta) -eq $null){
        Import-Module Microsoft.Graph.Entra.Beta      
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force

    Mock -CommandName Invoke-GraphRequest -MockWith {} -ModuleName Microsoft.Graph.Entra.Beta
}

Describe "Set-EntraBetaApplicationLogo"{
    Context "Test for Set-EntraBetaApplicationLogo" {
        It "Should return empty object"{
            $result = Set-EntraBetaApplicationLogo -ObjectId "aaaabbbb-0000-cccc-1111-dddd2222eeee" -FilePath "https://th.bing.com/th?q=Perennial+Garden+Ideas&w=138&h=138&c=7&o=5&dpr=1.3&pid=1.7&mkt=en-IN&cc=IN&setlang=en&adlt=moderate"
            $result | Should -BeNullOrEmpty
            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }
        It "Should fail when ObjectId is empty" {
            { Set-EntraBetaApplicationLogo -ObjectId ""  } | Should -Throw "Cannot bind argument to parameter 'ObjectId'*"
        }
        It "Should fail when ObjectId is null" {
            { Set-EntraBetaApplicationLogo -ObjectId } | Should -Throw "Missing an argument for parameter 'ObjectId'*"
        }    
        It "Should fail when filepath invalid"{
            { Set-EntraBetaApplicationLogo -ObjectId "aaaabbbb-0000-cccc-1111-dddd2222eeee" -FilePath "sdd" } | Should -Throw "FilePath is invalid"
        }    
        It "Should contain 'User-Agent' header" {
            Mock -CommandName Invoke-GraphRequest -MockWith {$args} -ModuleName Microsoft.Graph.Entra.Beta
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Set-EntraBetaApplicationLogo"
            $result = Set-EntraBetaApplicationLogo -ObjectId "aaaabbbb-0000-cccc-1111-dddd2222eeee" -FilePath "https://th.bing.com/th?q=Perennial+Garden+Ideas&w=138&h=138&c=7&o=5&dpr=1.3&pid=1.7&mkt=en-IN&cc=IN&setlang=en&adlt=moderate"
            $params = Get-Parameters -data $result
            $params.Headers["User-Agent"] | Should -Be $userAgentHeaderValue
        }
        It "Should execute successfully without throwing an error " {
            # Disable confirmation prompts       
            $originalDebugPreference = $DebugPreference
            $DebugPreference = 'Continue'
    
            try {
                # Act & Assert: Ensure the function doesn't throw an exception
                { Set-EntraBetaApplicationLogo -ObjectId "aaaabbbb-0000-cccc-1111-dddd2222eeee" -FilePath "https://th.bing.com/th?q=Perennial+Garden+Ideas&w=138&h=138&c=7&o=5&dpr=1.3&pid=1.7&mkt=en-IN&cc=IN&setlang=en&adlt=moderate" -Debug } | Should -Not -Throw
            } finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        } 
    }
}