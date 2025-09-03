# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
BeforeAll {  
    if ((Get-Module -Name Microsoft.Entra.Users) -eq $null) {
        Import-Module Microsoft.Entra.Users      
    }
    Import-Module (Join-Path $PSScriptRoot "..\..\Common-Functions.ps1") -Force
    
    $scriptblock = {
        return @(
            [PSCustomObject]@{
                "Id"                   = "ffffffff-5555-6666-7777-aaaaaaaaaaaa"
                "DeletedDateTime"      = $null
                "AdditionalProperties" = @{
                    "@odata.type"            = "#microsoft.graph.device"
                    "accountEnabled"         = $true
                    "deviceId"               = "00001111-aaaa-2222-bbbb-3333cccc4444"
                    "displayName"            = "Mock-App"
                    "isCompliant"            = $false
                    "isManaged"              = $true
                    "operatingSystem"        = "WINDOWS"
                    "operatingSystemVersion" = "10.0.22621.1700"
                    "systemLabels"           = @{}
                    "extensionAttributes"    = $null
                }
                "Parameters"           = $args
            }
        )
    }

    Mock -CommandName Get-MgUserRegisteredDevice -MockWith $scriptblock -ModuleName Microsoft.Entra.Users
    Mock -CommandName Get-EntraContext -MockWith { @{Scopes = @("User.Read.All") } } -ModuleName Microsoft.Entra.Users
}

Describe "Get-EntraUserRegisteredDevice" {
    Context "Test for Get-EntraUserRegisteredDevice" {
        It "should throw when not connected and not invoke SDK" {
            Mock -CommandName Get-EntraContext -MockWith { $null } -ModuleName Microsoft.Entra.Users
            { Get-EntraUserRegisteredDevice -UserId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" } | Should -Throw "Not connected to Microsoft Graph*"
            Should -Invoke -CommandName Get-MgUserRegisteredDevice -ModuleName Microsoft.Entra.Users -Times 0
        }

        It "Should return specific user registered device" {
            $result = Get-EntraUserRegisteredDevice -UserId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
            $result | Should -Not -BeNullOrEmpty
            $result.Id | Should -Be "ffffffff-5555-6666-7777-aaaaaaaaaaaa"
            $result.AdditionalProperties.deviceId | Should -Be "00001111-aaaa-2222-bbbb-3333cccc4444"
            $result.AdditionalProperties.displayName | Should -Be "Mock-App"

            Should -Invoke -CommandName Get-MgUserRegisteredDevice -ModuleName Microsoft.Entra.Users -Times 1
        }
        It "Should return specific user registered device with alias" {
            $result = Get-EntraUserRegisteredDevice -ObjectId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
            $result | Should -Not -BeNullOrEmpty
            $result.Id | Should -Be "ffffffff-5555-6666-7777-aaaaaaaaaaaa"
            $result.AdditionalProperties.deviceId | Should -Be "00001111-aaaa-2222-bbbb-3333cccc4444"
            $result.AdditionalProperties.displayName | Should -Be "Mock-App"

            Should -Invoke -CommandName Get-MgUserRegisteredDevice -ModuleName Microsoft.Entra.Users -Times 1
        }
        It "Should fail when ObjectlId is empty" {
            { Get-EntraUserRegisteredDevice -UserId } | Should -Throw "Missing an argument for parameter 'UserId'*"
        }

        It "Should return All user registered devices" {
            $result = Get-EntraUserRegisteredDevice -UserId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -All
            $result | Should -Not -BeNullOrEmpty
            $result.Id | Should -Be "ffffffff-5555-6666-7777-aaaaaaaaaaaa"
            $result.AdditionalProperties.deviceId | Should -Be "00001111-aaaa-2222-bbbb-3333cccc4444"
            $result.AdditionalProperties.displayName | Should -Be "Mock-App"

            Should -Invoke -CommandName Get-MgUserRegisteredDevice -ModuleName Microsoft.Entra.Users -Times 1
        }
        It "Should fail when All is invalid" {
            { Get-EntraUserRegisteredDevice -UserId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -All xyz } | Should -Throw "A positional parameter cannot be found that accepts argument 'xyz'.*"
        }
        It "Should return top 1 user registered device" {
            $result = Get-EntraUserRegisteredDevice -UserId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -Top 1
            $result | Should -Not -BeNullOrEmpty
            $result.Id | Should -Be "ffffffff-5555-6666-7777-aaaaaaaaaaaa"
            $result.AdditionalProperties.deviceId | Should -Be "00001111-aaaa-2222-bbbb-3333cccc4444"
            $result.AdditionalProperties.displayName | Should -Be "Mock-App"

            Should -Invoke -CommandName Get-MgUserRegisteredDevice -ModuleName Microsoft.Entra.Users -Times 1
        }
        It "Should fail when Top is empty" {
            { Get-EntraUserRegisteredDevice -UserId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -Top } | Should -Throw "Missing an argument for parameter 'Top'*"
        }
        It "Should fail when Top is invalid" {
            { Get-EntraUserRegisteredDevice -UserId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -Top xyz } | Should -Throw "Cannot process argument transformation on parameter 'Top'*"
        }
        It "Property parameter should work" {
            $result = Get-EntraUserRegisteredDevice -UserId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -Property DisplayName
            $result | Should -Not -BeNullOrEmpty
            $result.AdditionalProperties.displayName | Should -Be "Mock-App"

            Should -Invoke -CommandName Get-MgUserRegisteredDevice -ModuleName Microsoft.Entra.Users -Times 1
        }
        It "Should fail when Property is empty" {
            { Get-EntraUserRegisteredDevice -UserId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -Property } | Should -Throw "Missing an argument for parameter 'Property'*"
        }
        It "Should contain UserId in parameters when passed UserId to it" {              
            $result = Get-EntraUserRegisteredDevice -UserId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
            $params = Get-Parameters -data $result.Parameters
            $params.UserId | Should -Be "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
        }
        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraUserRegisteredDevice"
            $result = Get-EntraUserRegisteredDevice -UserId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
            $result | Should -Not -BeNullOrEmpty
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraUserRegisteredDevice"
            Should -Invoke -CommandName Get-MgUserRegisteredDevice -ModuleName Microsoft.Entra.Users -Times 1 -ParameterFilter {
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
                { Get-EntraUserRegisteredDevice -UserId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -Debug } | Should -Not -Throw
            }
            finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        }

    }
}
 

