# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra) -eq $null){
        Import-Module Microsoft.Graph.Entra      
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force

    Mock -CommandName Invoke-GraphRequest -MockWith {} -ModuleName Microsoft.Graph.Entra
}

Describe "Set-EntraApplicationLogo"{
    Context "Test for Set-EntraApplicationLogo" {
        It "Should return empty object"{
            $result = Set-EntraApplicationLogo -ObjectId "bbbbbbbb-1111-2222-3333-cccccccccccc" -FilePath "https://th.bing.com/th?q=Application+Garden+Ideas&w=138&h=138&c=7&o=5&dpr=1.3&pid=1.7&mkt=en-IN&cc=IN&setlang=en&adlt=moderate"
            $result | Should -BeNullOrEmpty
            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Graph.Entra -Times 1
        }
        It "Should fail when ObjectId is empty" {
            { Set-EntraApplicationLogo -ObjectId ""  } | Should -Throw "Cannot bind argument to parameter 'ObjectId'*"
        }
        It "Should fail when ObjectId is null" {
            { Set-EntraApplicationLogo -ObjectId } | Should -Throw "Missing an argument for parameter 'ObjectId'*"
        }    
        It "Should fail when filepath invalid"{
            { Set-EntraApplicationLogo -ObjectId f82a3f32-6bb6-404b-843c-5512fb3b35b8 -FilePath "sdd" } | Should -Throw "FilePath is invalid"
        }    
        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Set-EntraApplicationLogo"

            Set-EntraApplicationLogo -ObjectId "bbbbbbbb-1111-2222-3333-cccccccccccc" -FilePath "https://th.bing.com/th?q=Application+Garden+Ideas&w=138&h=138&c=7&o=5&dpr=1.3&pid=1.7&mkt=en-IN&cc=IN&setlang=en&adlt=moderate"

            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Set-EntraApplicationLogo"

            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Graph.Entra -Times 1 -ParameterFilter {
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
                { Set-EntraApplicationLogo -ObjectId "bbbbbbbb-1111-2222-3333-cccccccccccc" -FilePath "https://th.bing.com/th?q=Application+Garden+Ideas&w=138&h=138&c=7&o=5&dpr=1.3&pid=1.7&mkt=en-IN&cc=IN&setlang=en&adlt=moderate" -Debug } | Should -Not -Throw
            } finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        }  
    }
}