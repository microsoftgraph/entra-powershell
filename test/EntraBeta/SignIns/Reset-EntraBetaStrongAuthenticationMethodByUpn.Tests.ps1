# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
BeforeAll {  
    if ((Get-Module -Name Microsoft.Entra.Beta.SignIns) -eq $null) {
        Import-Module Microsoft.Entra.Beta.SignIns
    }
    Import-Module (Join-Path $PSScriptRoot "..\..\Common-Functions.ps1") -Force
    $scriptblock = {
        return @(
            [PSCustomObject]@{
                "Id"                   = "bbbbbbbb-1111-2222-3333-cccccccccccc"
                "AdditionalProperties" = @{
                    "@odata.type"   = "#microsoft.graph.phoneAuthenticationMethod";
                    createdDateTime = "2023-11-21T12:43:51Z";
                }
            }
        )
    }
    Mock -CommandName Get-MgBetaUserAuthenticationMethod -MockWith $scriptblock -ModuleName Microsoft.Entra.Beta.SignIns
    Mock -CommandName Remove-MgBetaUserAuthenticationPhoneMethod -MockWith {} -ModuleName Microsoft.Entra.Beta.SignIns
    Mock -CommandName Get-EntraContext -MockWith { @{Scopes = @("UserAuthenticationMethod.ReadWrite.All") } } -ModuleName Microsoft.Entra.Beta.SignIns
}

Describe "Reset-EntraBetaStrongAuthenticationMethodByUpn" {
    Context "Test for Reset-EntraBetaStrongAuthenticationMethodByUpn" {
        It "Should Resets the strong authentication method" {
            $result = Reset-EntraBetaStrongAuthenticationMethodByUpn -UserPrincipalName 'Test_contoso.com#EXT#@M365x99297270.onmicrosoft.com'
            $result | Should -BeNullOrEmpty
       
            Should -Invoke -CommandName Get-MgBetaUserAuthenticationMethod -ModuleName Microsoft.Entra.Beta.SignIns -Times 1
        }
        It "Should fail when UserPrincipalName is empty" {
            { Reset-EntraBetaStrongAuthenticationMethodByUpn -UserPrincipalName } | Should -Throw "Missing an argument for parameter 'UserPrincipalName'*"
        }  
 
        It "Should set correct UserId" {
            Reset-EntraBetaStrongAuthenticationMethodByUpn -UserPrincipalName 'Test_contoso@M365x99297270.onmicrosoft.com'
            Should -Invoke -CommandName Get-MgBetaUserAuthenticationMethod -ModuleName Microsoft.Entra.Beta.SignIns -Times 1 -ParameterFilter {
                $userId | Should -Be 'Test_contoso@M365x99297270.onmicrosoft.com'
                $true
            }
        }
        It "Should set correct PhoneAuthenticationMethodId" {
            Reset-EntraBetaStrongAuthenticationMethodByUpn -UserPrincipalName 'Test_contoso@M365x99297270.onmicrosoft.com'
            Should -Invoke -CommandName Get-MgBetaUserAuthenticationMethod -ModuleName Microsoft.Entra.Beta.SignIns -Times 1
            Should -Invoke -CommandName Remove-MgBetaUserAuthenticationPhoneMethod -ModuleName Microsoft.Entra.Beta.SignIns -Times 1 -ParameterFilter {
                $userId | Should -Be 'Test_contoso@M365x99297270.onmicrosoft.com'
                $PhoneAuthenticationMethodId | Should -Be 'bbbbbbbb-1111-2222-3333-cccccccccccc'
                $true
            }
        }
        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Reset-EntraBetaStrongAuthenticationMethodByUpn"

            Reset-EntraBetaStrongAuthenticationMethodByUpn -UserPrincipalName 'Test_contoso@M365x99297270.onmicrosoft.com'
            Should -Invoke -CommandName Get-MgBetaUserAuthenticationMethod -ModuleName Microsoft.Entra.Beta.SignIns -Times 1 -ParameterFilter {
                $Headers.'User-Agent' | Should -Be $userAgentHeaderValue
                $true
            }
        }
        It "Should execute successfully without throwing an error" {
            # Disable confirmation prompts       
            $originalDebugPreference = $DebugPreference
            $DebugPreference = 'Continue'

            try {
                # Act & Assert: Ensure the function doesn't throw an exception
                { Reset-EntraBetaStrongAuthenticationMethodByUpn -UserPrincipalName 'Test_contoso@M365x99297270.onmicrosoft.com' -Debug } | Should -Not -Throw
            }
            finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        }    
    }
}

