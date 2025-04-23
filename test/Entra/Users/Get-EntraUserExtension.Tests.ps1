# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
BeforeAll {  
    if ((Get-Module -Name Microsoft.Entra.Users) -eq $null) {
        Import-Module Microsoft.Entra.Users      
    }
    Import-Module (Join-Path $PSScriptRoot "..\..\Common-Functions.ps1") -Force

    # Update the mock response to match the expected structure
    $mockResponse = [PSCustomObject]@{
        "value" = @(
            [PSCustomObject]@{
                "userPrincipalName" = "SawyerM@contoso.com"
                "id"                = "acc9f0a1-9075-464f-9fe7-049bf1ae6481"
                "employeeId"        = "EK123456"
                "createdDateTime"   = "10/28/2024 4:16:02 PM"
            }
        )
    }
    
    Mock -CommandName Invoke-MgGraphRequest -MockWith { $mockResponse } -ModuleName Microsoft.Entra.Users
    Mock -CommandName Get-EntraContext -MockWith { @{Scopes = @("User.ReadWrite.All") } } -ModuleName Microsoft.Entra.Users
}

Describe "Get-EntraUserExtension" {
    Context "Test for Get-EntraUserExtension" {

        It "Should fail when UserId is empty" {
            { Get-EntraUserExtension -UserId } | Should -Throw "Missing an argument for parameter 'UserId'. Specify a parameter of type 'System.String' and try again."
        }

        It "Should return specific user extensions" {
            $result = Get-EntraUserExtension -UserId "SawyerM@contoso.com"
            $result | Should -Not -BeNullOrEmpty  # Changed from BeNullOrEmpty to Not-BeNullOrEmpty
            $result.id | Should -Be "acc9f0a1-9075-464f-9fe7-049bf1ae6481"
            $result.userPrincipalName | Should -Be "SawyerM@contoso.com"
            $result.employeeId | Should -Be "EK123456"
            $result.createdDateTime | Should -Be "10/28/2024 4:16:02 PM"
            Should -Invoke -CommandName Invoke-MgGraphRequest -ModuleName Microsoft.Entra.Users -Times 1
        }

        It 'should handle the Property parameter correctly' {
            $UserId = 'SawyerM@contoso.com'
            $Property = @('id', 'employeeId')
            $result = Get-EntraUserExtension -UserId $UserId -Property $Property
            $result | Should -Not -BeNullOrEmpty  # Changed from BeNullOrEmpty
            $result | ForEach-Object {
                $_.PSObject.Properties.Name | Should -Contain 'id'
                $_.PSObject.Properties.Name | Should -Contain 'employeeId'
            }
        }

        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraUserExtension"
        
            $result = Get-EntraUserExtension -UserId "SawyerM@contoso.com"
            $result | Should -Not -BeNullOrEmpty  # Changed from BeNullOrEmpty
        
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraUserExtension"
        
            Should -Invoke -CommandName Invoke-MgGraphRequest -ModuleName Microsoft.Entra.Users -Times 1 -ParameterFilter {
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
                { 
                    Get-EntraUserExtension -UserId "SawyerM@contoso.com" -Debug 
                } | Should -Not -Throw
            }
            finally {
                # Restore original confirmation preference
                $DebugPreference = $originalDebugPreference
            }
        }
    }
}
