# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

BeforeAll{
    if ((Get-Module -Name Microsoft.Entra.Users) -eq $null) {
        Import-Module Microsoft.Entra.Users      
    }
    Import-Module (Join-Path $PSScriptRoot "..\..\Common-Functions.ps1") -Force

    $scriptblock = {
        @{
            Name  = "newPassword"
            Value = "Mufu9887"
        },
        @{
            Name  = "@odata.context"
            Value = 'https://graph.microsoft.com/v1.0/$metadata#microsoft.graph.passwordResetResponse'
        }
    }

    Mock -CommandName Invoke-GraphRequest -MockWith $scriptblock -ModuleName Microsoft.Entra.Users
}
Describe "Tests for Update-EntraUserFromFederated"{
    It "Result should not be empty"{
        $result = Update-EntraUserFromFederated -UserPrincipalName "sawyerM@contoso.com"
        $result | Should -Not -BeNullOrEmpty
        Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.Users -Times 1
    }
   
<#     It "Should fail when UserPrincipalName is empty" {
        { Update-EntraUserFromFederated -UserPrincipalName "" } | Should -Throw "Cannot bind argument to parameter 'UserPrincipalName'*"
    }
    It "Should fail when UserPrincipalName is null" {
        { Update-EntraUserFromFederated -UserPrincipalName } | Should -Throw "Missing an argument for parameter 'UserPrincipalName'*"
    }    
    It "Should fail when UserPrincipalName is not passed" {
        { Update-EntraUserFromFederated } | Should -Throw "Missing an argument for parameter 'UserPrincipalName'*"
    }    
    It "Should fail when invalid parameter is passed" {
        { Update-EntraUserFromFederated -xyz } | Should -Throw "A parameter cannot be found that matches parameter name 'xyz'*"
    } #>

    It "Should contain 'User-Agent' header" {
        $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Update-EntraUserFromFederated"
        $result = Update-EntraUserFromFederated -UserPrincipalName "sawyerM@contoso.com"
        $result | Should -Not -BeNullOrEmpty
        $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Update-EntraUserFromFederated"
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
            { Update-EntraUserFromFederated -Top 1 -Debug } | Should -Not -Throw
        } finally {
            # Restore original confirmation preference            
            $DebugPreference = $originalDebugPreference        
        }
    } 
}



