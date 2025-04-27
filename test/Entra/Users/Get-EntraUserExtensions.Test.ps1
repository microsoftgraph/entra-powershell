# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
BeforeAll {
    if ((Get-Module -Name Microsoft.Entra.Users) -eq $null) {
        Import-Module Microsoft.Entra.Users      
    }
    Import-Module (Join-Path $PSScriptRoot "..\..\Common-Functions.ps1") -Force

    $scriptblock = {
        @{
            "userPrincipalName"           = "SawyerM@contoso.com"
            "onPremisesDistinguishedName" = $null
            "createdDateTime"             = "2023-10-01T00:00:00Z"
            "employeeId"                  = $null
            "id"                          = "aaaaaaaa-2222-3333-4444-bbbbbbbbbbbb"
        }
    }

    Mock -CommandName Invoke-MgGraphRequest -MockWith $scriptblock -ModuleName Microsoft.Entra.Users
    Mock -CommandName Get-EntraContext -MockWith { @{Scopes = @("User.Read.All") } } -ModuleName Microsoft.Entra.Users
}
Describe "Tests for Get-EntraUserExtension" {
    It "Result should not be empty" {
        $result = Get-EntraUserExtension -UserId "SawyerM@contoso.com"
        $result | Should -Not -BeNullOrEmpty
        Should -Invoke -CommandName Invoke-MgGraphRequest -ModuleName Microsoft.Entra.Users -Times 1
    }
    It "Result should not be empty objectId" {
        $result = Get-EntraUserExtension -ObjectId "SawyerM@contoso.com"
        $result | Should -Not -BeNullOrEmpty
        Should -Invoke -CommandName Invoke-MgGraphRequest -ModuleName Microsoft.Entra.Users -Times 1
    }    

    It "Should fail when UserId is null" {
        { Get-EntraUserExtension -UserId } | Should -Throw "Missing an argument for parameter 'UserId'*"
    }

    It "Should contain 'User-Agent' header" {
        $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraUserExtension"
        $result = Get-EntraUserExtension -UserId "SawyerM@contoso.com"
        $result | Should -Not -BeNullOrEmpty
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
            { Get-EntraUserExtension -UserId "SawyerM@contoso.com" } | Should -Not -Throw
        }
        finally {
            # Restore original confirmation preference            
            $DebugPreference = $originalDebugPreference        
        }
    } 
}

