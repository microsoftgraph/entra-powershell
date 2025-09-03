# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
BeforeAll {
    if ((Get-Module -Name Microsoft.Entra.Users) -eq $null) {
        Import-Module Microsoft.Entra.Users
    }
    Import-Module (Join-Path $PSScriptRoot "..\..\Common-Functions.ps1") -Force

    $scriptblock = {
        return @{
            value = @(
                @{
                    "Id"                              = "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
                    "DisplayName"                     = "Mock-User"
                    "OnPremisesImmutableId"           = $null
                    "DeletedDateTime"                 = $null
                    "OnPremisesSyncEnabled"           = $null
                    "OnPremisesLastSyncDateTime"      = $null
                    "OnPremisesProvisioningErrors"    = @{}
                    "MobilePhone"                     = "425-555-0100"
                    "BusinessPhones"                  = @("425-555-0100")
                    "ExternalUserState"               = $null
                    "ExternalUserStateChangeDateTime" = $null
                    "Parameters"                      = $args
                }
            )
        }
    }
    

    Mock -CommandName Invoke-GraphRequest -MockWith $scriptblock -ModuleName Microsoft.Entra.Users
    Mock -CommandName Get-EntraContext -MockWith { @{Scopes = @("User.Read.All") } } -ModuleName Microsoft.Entra.Users
}



Describe "Get-EntraUserDirectReport" {
    Context "Test for Get-EntraUserDirectReport" {
        It "should throw when not connected and not invoke graph call" {
            Mock -CommandName Get-EntraContext -MockWith { $null } -ModuleName Microsoft.Entra.Users
            { Get-EntraUserDirectReport -UserId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" } | Should -Throw "Not connected to Microsoft Graph*"
            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.Users -Times 0
        }
        
        It "Should return specific user direct report" {
            $result = Get-EntraUserDirectReport -UserId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
            $result | Should -Not -BeNullOrEmpty
            $result.Id | should -Be 'aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb'

            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.Users -Times 1
        }
        It "Should return specific user direct report with alias" {
            $result = Get-EntraUserDirectReport -ObjectId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
            $result | Should -Not -BeNullOrEmpty
            $result.Id | should -Be 'aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb'

            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.Users -Times 1
        }
        It "Should fail when UserId is empty" {
            { Get-EntraUserDirectReport -UserId } | Should -Throw "Missing an argument for parameter 'UserId'*"
        }

        It "Should return all user direct reports" {
            $result = Get-EntraUserDirectReport -UserId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -All 
            $result | Should -Not -BeNullOrEmpty
            $result.Id | should -Be 'aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb'

            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.Users -Times 1
        }
        It "Should fail when All is invalid" {
            { Get-EntraUserDirectReport -UserId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -All xyz } | Should -Throw "A positional parameter cannot be found that accepts argument 'xyz'.*"
        }
        It "Should return top 1 user direct report" {
            $result = Get-EntraUserDirectReport -UserId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -Top 1
            $result | Should -Not -BeNullOrEmpty
            $result.Id | should -Be 'aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb'

            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.Users -Times 1
        }
        It "Should fail when top is empty" {
            { Get-EntraUserDirectReport -UserId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -Top } | Should -Throw "Missing an argument for parameter 'Top'*"
        }
        It "Should fail when top is invalid" {
            { Get-EntraUserDirectReport -UserId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -Top xyz } | Should -Throw "Cannot process argument transformation on parameter 'Top'*"
        }
        It "Property parameter should work" {
            $result = Get-EntraUserDirectReport -UserId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -Property DisplayName
            $result | Should -Not -BeNullOrEmpty
            $result.DisplayName | Should -Be "Mock-User"

            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.Users -Times 1
        }
        It "Should fail when Property is empty" {
            { Get-EntraUserDirectReport -UserId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -Property } | Should -Throw "Missing an argument for parameter 'Property'*"
        }
        It "Result should contain Properties" {
            $result = Get-EntraUserDirectReport -UserId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
            $result.ObjectId | Should -Be "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
            $result.DeletionTimestamp | Should -Be $null
            $result.DirSyncEnabled | Should -Be $null
            $result.ImmutableId | Should -Be $null
            $result.LastDirSyncTime | Should -Be $null
            $result.Mobile | Should -Be "425-555-0100"
            $result.ProvisioningErrors | Should -BeNullOrEmpty
            $result.TelephoneNumber | Should -Be "425-555-0100"
            $result.UserState | Should -Be $null
            $result.UserStateChangedOn | Should -Be $null

        }
        It "Should contain UserId in parameters when passed UserId to it" { 

            $result = Get-EntraUserDirectReport -UserId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
            $params = Get-Parameters -data $result.Parameters
            $para = $params | ConvertTo-json | ConvertFrom-Json
            $para.URI  | Should -Match "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
        }
        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraUserDirectReport"
            $result = Get-EntraUserDirectReport -UserId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
            $result | Should -Not -BeNullOrEmpty
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraUserDirectReport"
            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.Users -Times 1 -ParameterFilter {
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
                { Get-EntraUserDirectReport -UserId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -Debug } | Should -Not -Throw
            }
            finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        }

    }

}

