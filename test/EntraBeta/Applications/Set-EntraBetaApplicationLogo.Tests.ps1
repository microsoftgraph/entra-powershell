# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

BeforeAll {  
    if ((Get-Module -Name Microsoft.Entra.Beta.Applications) -eq $null) {
        Import-Module Microsoft.Entra.Beta.Applications      
    }
    Import-Module (Join-Path $PSScriptRoot "..\..\Common-Functions.ps1") -Force

    Mock -CommandName Invoke-GraphRequest -MockWith {} -ModuleName Microsoft.Entra.Beta.Applications
    Mock -CommandName Get-EntraContext -MockWith { @{Scopes = @("Application.ReadWrite.All") } } -ModuleName Microsoft.Entra.Beta.Applications
}

Describe "Set-EntraBetaApplicationLogo" {
    Context "Test for Set-EntraBetaApplicationLogo" {
        It "Should return empty object" {
            $result = Set-EntraBetaApplicationLogo -ApplicationId "aaaabbbb-0000-cccc-1111-dddd2222eeee" -FilePath "https://th.bing.com/th?q=Perennial+Garden+Ideas&w=138&h=138&c=7&o=5&dpr=1.3&pid=1.7&mkt=en-IN&cc=IN&setlang=en&adlt=moderate"
            $result | Should -BeNullOrEmpty
            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.Beta.Applications -Times 1
        }
        It "Should fail when ApplicationId is empty" {
            { Set-EntraBetaApplicationLogo -ApplicationId "" } | Should -Throw "Cannot validate argument on parameter 'ApplicationId'. The argument is null or empty. Provide an argument that is not null or empty, and then try the command again."
        }
        It "Should fail when ApplicationId is null" {
            { Set-EntraBetaApplicationLogo -ApplicationId } | Should -Throw "Missing an argument for parameter 'ApplicationId'*"
        }    
        It "Should fail when filepath invalid" {
            { Set-EntraBetaApplicationLogo -ApplicationId "aaaabbbb-0000-cccc-1111-dddd2222eeee" -FilePath "sdd" } | Should -Throw "FilePath is invalid"
        }    
        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Set-EntraBetaApplicationLogo"
            $result = Set-EntraBetaApplicationLogo -ApplicationId "aaaabbbb-0000-cccc-1111-dddd2222eeee" -FilePath "https://th.bing.com/th?q=Perennial+Garden+Ideas&w=138&h=138&c=7&o=5&dpr=1.3&pid=1.7&mkt=en-IN&cc=IN&setlang=en&adlt=moderate"
            $result | Should -BeNullOrEmpty
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Set-EntraBetaApplicationLogo"
            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.Beta.Applications -Times 1 -ParameterFilter {
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
                { Set-EntraBetaApplicationLogo -ApplicationId "aaaabbbb-0000-cccc-1111-dddd2222eeee" -FilePath "https://th.bing.com/th?q=Perennial+Garden+Ideas&w=138&h=138&c=7&o=5&dpr=1.3&pid=1.7&mkt=en-IN&cc=IN&setlang=en&adlt=moderate" -Debug } | Should -Not -Throw
            }
            finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        } 
    }
}

