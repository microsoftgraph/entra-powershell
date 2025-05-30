# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
BeforeAll {  
    if ((Get-Module -Name Microsoft.Entra.Applications) -eq $null) {
        Import-Module Microsoft.Entra.Applications      
    }
    Import-Module (Join-Path $PSScriptRoot "..\..\Common-Functions.ps1") -Force

    $mockResponse = {
        return @{
            value = @(
                @{
                    Id                          = "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"          
                    ageGroup                    = $null
                    onPremisesLastSyncDateTime  = $null
                    creationType                = $null
                    preferredLanguage           = $null
                    mail                        = "admin@contonso.com"
                    securityIdentifier          = "S-1-12-1-1093396945-1080104032-2731339150-364051459"
                    consentProvidedForMinor     = $null
                    onPremisesUserPrincipalName = $null
                    Parameters                  = $args
                }
            )
        }
    }

    Mock -CommandName Invoke-GraphRequest -MockWith $mockResponse -ModuleName Microsoft.Entra.Applications
}

Describe "Get-EntraApplicationOwner" {
    Context "Test for Get-EntraApplicationOwner" {
        It "Should return application owner" {
            $result = Get-EntraApplicationOwner -ApplicationId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
            Write-Host $result
            $result | Should -Not -BeNullOrEmpty
            $result.Id | should -Be @('aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb')

            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.Applications -Times 1
        }
        It "Should fail when ApplicationId is empty" {
            { Get-EntraApplicationOwner -ApplicationId "" } | Should -Throw "Cannot validate argument on parameter 'ApplicationId'. The argument is null or empty. Provide an argument that is not null or empty, and then try the command again."
        }
        It "Should fail when ApplicationId is null" {
            { Get-EntraApplicationOwner -ApplicationId } | Should -Throw "Missing an argument for parameter 'ApplicationId'*"
        }
        It "Should fail when All has an argument" {
            { Get-EntraApplicationOwner -All $true } | Should -Throw "A positional parameter cannot be found that accepts argument 'True'.*"
        }
        It "Should fail when Top is empty" {
            { Get-EntraApplicationOwner -Top } | Should -Throw "Missing an argument for parameter 'Top'*"
        }
        It "Should fail when Top is invalid" {
            { Get-EntraApplicationOwner -Top XY } | Should -Throw "Cannot process argument transformation on parameter 'Top'*"
        } 
        It "Property parameter should work" {
            $result = Get-EntraApplicationOwner -ApplicationId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -Property Id 
            $result | Should -Not -BeNullOrEmpty
            $result.Id | Should -Be "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
        }
        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraApplicationOwner"
            $result = Get-EntraApplicationOwner -ApplicationId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
            $result | Should -Not -BeNullOrEmpty
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraApplicationOwner"    
            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.Applications -Times 1 -ParameterFilter {
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
                { Get-EntraApplicationOwner -ApplicationId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -Debug } | Should -Not -Throw
            }
            finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        } 
    }
}

