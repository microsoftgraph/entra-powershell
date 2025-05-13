# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
BeforeAll {
    if ((Get-Module -Name Microsoft.Entra.Users) -eq $null) {
        Import-Module Microsoft.Entra.Users
    }
    Import-Module (Join-Path $PSScriptRoot "..\..\Common-Functions.ps1") -Force

    $scriptblock = {
        # Write-Host "Mocking Get-EntraUserOwnedObject with parameters: $($args | ConvertTo-Json -Depth 3)"

        return @{
            value = @(
                @{
                    Id                    = "00aa00aa-bb11-cc22-dd33-44ee44ee44ee"
                    applicationTemplateId = "00001111-aaaa-2222-bbbb-3333cccc4444"
                    appId                 = "11112222-bbbb-3333-cccc-4444dddd5555"
                    displayName           = "ToGraph_443DEM"
                    signInAudience        = "AzureADMyOrg"
                    publisherDomain       = "contoso.com"
                    Parameters            = $args
                }
            )
        }
    }

    Mock -CommandName Invoke-GraphRequest -MockWith $scriptblock -ModuleName Microsoft.Entra.Users
    Mock -CommandName Get-EntraContext -MockWith { @{Scopes = @("User.Read.All") } } -ModuleName Microsoft.Entra.Users
}

Describe "Get-EntraUserOwnedObject" {
    Context "Test for Get-EntraUserOwnedObject" {
        It "Should return specific User" {
            $result = Get-EntraUserOwnedObject -UserId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
            
            $result | Should -Not -BeNullOrEmpty
            $result.Id | should -Be "00aa00aa-bb11-cc22-dd33-44ee44ee44ee"
            $result.applicationTemplateId | Should -Be "00001111-aaaa-2222-bbbb-3333cccc4444"
            $result.appId | Should -Be "11112222-bbbb-3333-cccc-4444dddd5555"
            $result.signInAudience | Should -Be "AzureADMyOrg"
            $result.publisherDomain | Should -Be "contoso.com"
            $result.DisplayName | Should -Be "ToGraph_443DEM"


            should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.Users -Times 1
        }
        It "Should return specific User with alias" {
            $result = Get-EntraUserOwnedObject -ObjectId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
            
            $result | Should -Not -BeNullOrEmpty
            $result.Id | should -Be "00aa00aa-bb11-cc22-dd33-44ee44ee44ee"
            $result.applicationTemplateId | Should -Be "00001111-aaaa-2222-bbbb-3333cccc4444"
            $result.appId | Should -Be "11112222-bbbb-3333-cccc-4444dddd5555"
            $result.signInAudience | Should -Be "AzureADMyOrg"
            $result.publisherDomain | Should -Be "contoso.com"
            $result.DisplayName | Should -Be "ToGraph_443DEM"


            should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.Users -Times 1
        }

        It "Should fail when UserId is empty" {
            { Get-EntraUserOwnedObject -UserId } | Should -Throw "Missing an argument for parameter 'UserId'. Specify a parameter of type 'System.String' and try again."
        }

        It "Should return top user" {
            $result = Get-EntraUserOwnedObject -UserId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -Top 1
            $result | Should -Not -BeNullOrEmpty

            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.Users -Times 1
        }    

        It "Should fail when top is empty" {
            { Get-EntraUserOwnedObject -UserId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -Top } | Should -Throw "Missing an argument for parameter 'Top'*"
        }  

        It "Should fail when top is invalid" {
            { Get-EntraUserOwnedObject -UserId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -Top XY } | Should -Throw "Cannot process argument transformation on parameter 'Top'*"
        } 

        It "Should return all contact" {
            $result = Get-EntraUserOwnedObject -UserId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -All
            $result | Should -Not -BeNullOrEmpty            
            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.Users -Times 1
        }

        It "Should fail when All has an argument" {
            { Get-EntraUserOwnedObject -UserId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -All $true } | Should -Throw "A positional parameter cannot be found that accepts argument 'True'.*"
        }

        It "Should contain UserId in parameters when passed UserId to it" {
            $result = Get-EntraUserOwnedObject -UserId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
            $params = Get-Parameters -data $result.Parameters
            $params.Uri | Should -Match "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
        }

        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraUserOwnedObject"

            $result = Get-EntraUserOwnedObject -UserId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
            $result | Should -Not -BeNullOrEmpty

            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraUserOwnedObject"

            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.Users -Times 1 -ParameterFilter {
                $Headers.'User-Agent' | Should -Be $userAgentHeaderValue
                $true
            }
        } 

        It "Property parameter should work" {
            $result = Get-EntraUserOwnedObject -UserId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -Property displayName 
            $result | Should -Not -BeNullOrEmpty
            $result.displayName | Should -Be "ToGraph_443DEM"

            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.Users -Times 1
        }

        It "Should fail when Property is empty" {
            { Get-EntraUserOwnedObject -UserId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -Property } | Should -Throw "Missing an argument for parameter 'Property'*"
        }

        It "Should execute successfully without throwing an error" {
            # Disable confirmation prompts       
            $originalDebugPreference = $DebugPreference
            $DebugPreference = 'Continue'

            try {
                # Act & Assert: Ensure the function doesn't throw an exception
                { Get-EntraUserOwnedObject -UserId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -Debug } | Should -Not -Throw
            }
            finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        }   

    }
}

