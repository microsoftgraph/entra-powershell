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
                    id            = "acc9f0a1-9075-464f-9fe7-049bf1ae6481"
                    country       = "United States"
                    displayName   = "Sara Davis"
                    mail          = "sarad@contoso.com"
                    '@odata.type' = "#microsoft.graph.user"
                }
                @{
                    id            = "d32766cb-1420-4c0c-986a-d67bedc4014e"
                    mail          = "d@microsoft.com"
                    '@odata.type' = "#microsoft.graph.group"
                }
            )
        }
    }

    Mock -CommandName Invoke-GraphRequest -MockWith $scriptblock -ModuleName Microsoft.Entra.Users
    Mock -CommandName Get-EntraContext -MockWith { @{Scopes = @("User.Read.All") } } -ModuleName Microsoft.Entra.Users
}

Describe "Get-EntraUserSponsor" {
    Context "Test for Get-EntraUserSponsor" {
        It "should throw when not connected and not invoke graph call" {
            Mock -CommandName Get-EntraContext -MockWith { $null } -ModuleName Microsoft.Entra.Users
            { Get-EntraUserSponsor -UserId "acc9f0a1-9075-464f-9fe7-049bf1ae6481" } | Should -Throw "Not connected to Microsoft Graph*"
            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.Users -Times 0
        }

        It "Should fail when UserId is empty" {
            { Get-EntraUserSponsor -UserId } | Should -Throw "Missing an argument for parameter 'UserId'. Specify a parameter of type 'System.String' and try again."
        }

        It "Should return specific user sponsors" {
            $result = Get-EntraUserSponsor -UserId "acc9f0a1-9075-464f-9fe7-049bf1ae6481"
            $result | Should -Not -BeNullOrEmpty
            $result[0].id | should -Be "acc9f0a1-9075-464f-9fe7-049bf1ae6481"
            $result[0].country | should -Be "United States"
            $result[0].displayName | should -Be "Sara Davis"
            $result[0].mail | should -Be "sarad@contoso.com"
            $result[0].'@odata.type' | should -Be "#microsoft.graph.user"
            
            $result[1].id | should -Be "d32766cb-1420-4c0c-986a-d67bedc4014e"
            $result[1].mail | should -Be "d@microsoft.com"
            $result[1].'@odata.type' | should -Be "#microsoft.graph.group"
            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.Users -Times 1
        }

        It "Should return top user sponsor" {
            $result = Get-EntraUserSponsor -UserId "acc9f0a1-9075-464f-9fe7-049bf1ae6481" -Top 1
            $result | Should -Not -BeNullOrEmpty

            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.Users -Times 1
        }

        It "Should fail when top is empty" {
            { Get-EntraUserSponsor -Top } | Should -Throw "Missing an argument for parameter 'Top'*"
        }

        It "Should fail when top is invalid" {
            { Get-EntraUserSponsor -Top HH } | Should -Throw "Cannot process argument transformation on parameter 'Top'*"
        }

        It 'should handle the Property parameter correctly' {
            $UserId = 'acc9f0a1-9075-464f-9fe7-049bf1ae6481'
            $Property = @('id', 'mail')
            $result = Get-EntraUserSponsor -UserId $UserId -Property $Property
            $result | Should -Not -BeNullOrEmpty
            $result | ForEach-Object {
                $_.PSObject.Properties.Name | Should -Contain 'id'
                $_.PSObject.Properties.Name | Should -Contain 'mail'
            }
        }

        It 'should handle the All parameter correctly' {
            $UserId = 'acc9f0a1-9075-464f-9fe7-049bf1ae6481'
            $result = Get-EntraUserSponsor -UserId $UserId -All
            $result | Should -Not -BeNullOrEmpty
        }

        It "Should execute successfully without throwing an error " {
            # Disable confirmation prompts       
            $originalDebugPreference = $DebugPreference
            $DebugPreference = 'Continue'
    
            try {
                # Act & Assert: Ensure the function doesn't throw an exception
                { 
                    Get-EntraUserSponsor -UserId "acc9f0a1-9075-464f-9fe7-049bf1ae6481" -Debug 
                } | Should -Not -Throw
            }
            finally {
                # Restore original confirmation preference
                $DebugPreference = $originalDebugPreference
            }
        }
    }
}