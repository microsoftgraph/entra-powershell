# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
BeforeAll {  
    if((Get-Module -Name Microsoft.Entra.Users) -eq $null){
        Import-Module Microsoft.Entra.Users      
    }
    Import-Module (Join-Path $PSScriptRoot "..\..\Common-Functions.ps1") -Force
    $scriptblock = {
    return @{
        value = @(
            @{
                id          = "00aa00aa-bb11-cc22-dd33-44ee44ee44e"
                country     = "United States"
                displayName = "Sara Davis"
                mail        = "z@microsoft.com"
               '@odata.type' = "#microsoft.graph.user"
            }
            @{
                id          = "10aa00aa-bb11-cc22-dd33-44ee44ee44e"
                mail        = "d@microsoft.com"
               '@odata.type' = "#microsoft.graph.group"
            }
        )
    }
}

    Mock -CommandName Invoke-GraphRequest -MockWith $scriptblock -ModuleName Microsoft.Entra.Users
}

Describe "Get-EntraUserSponsor" {
    Context "Test for Get-EntraUserSponsor" {
        It "Should fail when UserId is empty string value" {
            { Get-EntraUserSponsor -UserId "" } | Should -Throw "Cannot bind argument to parameter 'UserId' because it is an empty string."
        }

        It "Should fail when UserId is empty" {
            { Get-EntraUserSponsor -UserId } | Should -Throw "Missing an argument for parameter 'UserId'. Specify a parameter of type 'System.String' and try again."
        }

        It "Should return specific user sponsors" {
            $result = Get-EntraUserSponsor -UserId "00aa00aa-bb11-cc22-dd33-44ee44ee44e"
            $result | Should -Not -BeNullOrEmpty
            $result[0].id | should -Be "00aa00aa-bb11-cc22-dd33-44ee44ee44e"
            $result[0].country | should -Be "United States"
            $result[0].displayName | should -Be "Sara Davis"
            $result[0].mail | should -Be "z@microsoft.com"
            $result[0].'@odata.type'| should -Be  "#microsoft.graph.user"
            
            $result[1].id | should -Be "10aa00aa-bb11-cc22-dd33-44ee44ee44e"
            $result[1].mail | should -Be "d@microsoft.com"
            $result[1].'@odata.type'| should -Be  "#microsoft.graph.group"
            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.Users -Times 1
        }

        It "Should return top user sponsor" {
            $result = Get-EntraUserSponsor -UserId "00aa00aa-bb11-cc22-dd33-44ee44ee44e" -Top 1
            $result | Should -Not -BeNullOrEmpty

            Should -Invoke -CommandName Invoke-GraphRequest  -ModuleName Microsoft.Entra.Users -Times 1
        }

        It "Should fail when top is empty" {
            { Get-EntraUserSponsor -Top } | Should -Throw "Missing an argument for parameter 'Top'*"
        }

        It "Should fail when top is invalid" {
            { Get-EntraUserSponsor -Top HH } | Should -Throw "Cannot process argument transformation on parameter 'Top'*"
        }

        It 'should handle the Property parameter correctly' {
            $UserId = '00aa00aa-bb11-cc22-dd33-44ee44ee44e'
            $Property = @('id', 'mail')
            $result = Get-EntraUserSponsor -UserId $UserId -Property $Property
            $result | Should -Not -BeNullOrEmpty
            $result | ForEach-Object {
                $_.PSObject.Properties.Name | Should -Contain 'id'
                $_.PSObject.Properties.Name | Should -Contain 'mail'
            }
        }

        It 'should handle the All parameter correctly' {
            $UserId = '00aa00aa-bb11-cc22-dd33-44ee44ee44e'
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
                    Get-EntraUserSponsor -UserId "00aa00aa-bb11-cc22-dd33-44ee44ee44e" -Debug 
                } | Should -Not -Throw
            } finally {
                # Restore original confirmation preference
                $DebugPreference = $originalDebugPreference
            }
        }
    }
}