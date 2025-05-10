BeforeAll {  
    if ((Get-Module -Name Microsoft.Entra.Applications) -eq $null) {
        Import-Module Microsoft.Entra.Applications      
    }
    Import-Module (Join-Path $PSScriptRoot "..\..\Common-Functions.ps1") -Force

    $scriptblock = {
        @{
            "PasswordCredentials" = @(
                @{
                    "CustomKeyIdentifier" = { 116, 101, 115, 116 }
                    "DisplayName"         = "Test"
                    "EndDateTime"         = "10/23/2024 11:36:56 AM"
                    "KeyId"               = "aaaaaaaa-0b0b-1c1c-2d2d-333333333333"
                    "StartDateTime"       = "11/22/2023 11:35:16 AM"
                    "Hint"                = "123"
                    "SecretText"          = ""
                    "Parameters"          = $args
                }
            )            
        }
    }

    Mock -CommandName Get-MgApplication -MockWith $scriptblock -ModuleName Microsoft.Entra.Applications
}

Describe "Get-EntraApplicationPasswordCredential" {
    Context "Test for Get-EntraApplicationPasswordCredential" {
        It "Should not return empty" {
            $result = Get-EntraApplicationPasswordCredential -ApplicationId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
            $result | Should -Not -BeNullOrEmpty
            Should -Invoke -CommandName Get-MgApplication -ModuleName Microsoft.Entra.Applications -Times 1
        }
        It "Should fail when ApplicationId is empty" {
            { Get-EntraApplicationPasswordCredential -ApplicationId "" } | Should -Throw "Cannot validate argument on parameter 'ApplicationId'. The argument is null or empty. Provide an argument that is not null or empty, and then try the command again."
        }
        It "Should fail when ApplicationId is null" {
            { Get-EntraApplicationPasswordCredential -ApplicationId } | Should -Throw "Missing an argument for parameter 'ApplicationId'*"
        }
        It "Should fail when invalid parameter is passed" {
            { Get-EntraApplicationPasswordCredential -DisplayName "abc" } | Should -Throw "A parameter cannot be found that matches parameter name 'DisplayName'*"
        }
        It "Property parameter should work" {
            $result = Get-EntraApplicationPasswordCredential -ApplicationId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -Property DisplayName 
            $result | Should -Not -BeNullOrEmpty
            $result.DisplayName | Should -Be "Test"

            Should -Invoke -CommandName Get-MgApplication -ModuleName Microsoft.Entra.Applications -Times 1
        }

        It "Should fail when Property is empty" {
            { Get-EntraApplicationPasswordCredential -ApplicationId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -Property } | Should -Throw "Missing an argument for parameter 'Property'*"
        }

        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraApplicationPasswordCredential"
            $result = Get-EntraApplicationPasswordCredential -ApplicationId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
            $result | Should -Not -BeNullOrEmpty
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraApplicationPasswordCredential"    
            Should -Invoke -CommandName Get-MgApplication -ModuleName Microsoft.Entra.Applications -Times 1 -ParameterFilter {
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
                { Get-EntraApplicationPasswordCredential -ApplicationId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -Debug } | Should -Not -Throw
            }
            finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        } 
    }
}

