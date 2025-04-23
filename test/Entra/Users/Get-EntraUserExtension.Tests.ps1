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
                "userPrincipalName" = "SawyerM@contoso.com"
                "id"                = "acc9f0a1-9075-464f-9fe7-049bf1ae6481"
                "employeeId"        = "EK123456"
                "createdDateTime"   = "10/28/2024 4:16:02 PM"
            }
        )
    }

    Mock -CommandName Invoke-GraphRequest -MockWith $scriptblock -ModuleName Microsoft.Entra.Users
    Mock -CommandName Get-EntraContext -MockWith { @{Scopes = @("User.ReadWrite.All") } } -ModuleName Microsoft.Entra.Users
}

Describe "Get-EntraUserExtension" {
    Context "Test for Get-EntraUserExtension" {

        It "Should fail when UserId is empty" {
            { Get-EntraUserExtension -UserId } | Should -Throw "Missing an argument for parameter 'UserId'. Specify a parameter of type 'System.String' and try again."
        }

        It "Should return specific user sponsors" {
            $result = Get-EntraUserExtension -UserId "acc9f0a1-9075-464f-9fe7-049bf1ae6481"
            $result | Should -Not -BeNullOrEmpty
            $result.id | should -Be "acc9f0a1-9075-464f-9fe7-049bf1ae6481"
            $result.userPrincipalName | should -Be "SawyerM@contoso.com"
            $result.employeeId | should -Be "EK123456"
            $result.createdDateTime | should -Be "10/28/2024 4:16:02 PM"
            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.Users -Times 1
        }

        It "Should return top user sponsor" {
            $result = Get-EntraUserExtension -UserId "acc9f0a1-9075-464f-9fe7-049bf1ae6481" -Top 1
            $result | Should -Not -BeNullOrEmpty

            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.Users -Times 1
        }

        It 'should handle the Property parameter correctly' {
            $UserId = 'acc9f0a1-9075-464f-9fe7-049bf1ae6481'
            $Property = @('id', 'employeeId')
            $result = Get-EntraUserExtension -UserId $UserId -Property $Property
            $result | Should -Not -BeNullOrEmpty
            $result | ForEach-Object {
                $_.PSObject.Properties.Name | Should -Contain 'id'
                $_.PSObject.Properties.Name | Should -Contain 'employeeId'
            }
        }

        It "Should execute successfully without throwing an error " {
            # Disable confirmation prompts       
            $originalDebugPreference = $DebugPreference
            $DebugPreference = 'Continue'
    
            try {
                # Act & Assert: Ensure the function doesn't throw an exception
                { 
                    Get-EntraUserExtension -UserId "acc9f0a1-9075-464f-9fe7-049bf1ae6481" -Debug 
                } | Should -Not -Throw
            }
            finally {
                # Restore original confirmation preference
                $DebugPreference = $originalDebugPreference
            }
        }
    }
}
