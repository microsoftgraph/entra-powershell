# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

BeforeAll {  
    if ((Get-Module -Name Microsoft.Entra.Beta.Applications) -eq $null) {
        Import-Module Microsoft.Entra.Beta.Applications    
    }
    Import-Module (Join-Path $PSScriptRoot "..\..\Common-Functions.ps1") -Force

    Mock -CommandName Remove-MgBetaServicePrincipalPasswordSingleSignOnCredential -MockWith {} -ModuleName Microsoft.Entra.Beta.Applications
    Mock -CommandName Get-EntraContext -MockWith { @{Scopes = @("Application.ReadWrite.All") } } -ModuleName Microsoft.Entra.Beta.Applications
}

Describe "Remove-EntraBetaPasswordSingleSignOnCredential" {
    Context "Test for Remove-EntraBetaPasswordSingleSignOnCredential" {
        It "Should remove password single-sign-on credentials" {
            $result = Remove-EntraBetaPasswordSingleSignOnCredential -ServicePrincipalId "aaaabbbb-0000-cccc-1111-dddd2222eeee" -PasswordSSOObjectId "bbbbcccc-1111-dddd-2222-eeee3333ffff"
            $result | Should -BeNullOrEmpty

            Should -Invoke -CommandName Remove-MgBetaServicePrincipalPasswordSingleSignOnCredential -ModuleName Microsoft.Entra.Beta.Applications -Times 1
        }

        It "Should fail when ServicePrincipalId is empty" {
            { Remove-EntraBetaPasswordSingleSignOnCredential -ServicePrincipalId -PasswordSSOObjectId "bbbbcccc-1111-dddd-2222-eeee3333ffff" } | Should -Throw "Missing an argument for parameter 'ServicePrincipalId'*"
        }   

        It "Should fail when ServicePrincipalId is invalid" {
            { Remove-EntraBetaPasswordSingleSignOnCredential -ServicePrincipalId "" -PasswordSSOObjectId "bbbbcccc-1111-dddd-2222-eeee3333ffff" } | Should -Throw "Cannot validate argument on parameter 'ServicePrincipalId'. The argument is null or empty. Provide an argument that is not null or empty, and then try the command again."
        }   

        It "Should fail when PasswordSSOObjectId is empty" {
            { Remove-EntraBetaPasswordSingleSignOnCredential -ServicePrincipalId "aaaabbbb-0000-cccc-1111-dddd2222eeee" -PasswordSSOObjectId } | Should -Throw "Missing an argument for parameter 'PasswordSSOObjectId'*"
        }   

        It "Should contain ServicePrincipalId in parameters when passed ServicePrincipalId to it" {
            Mock -CommandName Remove-MgBetaServicePrincipalPasswordSingleSignOnCredential -MockWith { $args } -ModuleName Microsoft.Entra.Beta.Applications

            $result = Remove-EntraBetaPasswordSingleSignOnCredential -ServicePrincipalId "aaaabbbb-0000-cccc-1111-dddd2222eeee" -PasswordSSOObjectId "bbbbcccc-1111-dddd-2222-eeee3333ffff"
            $params = Get-Parameters -data $result
            $params.ServicePrincipalId | Should -Be "aaaabbbb-0000-cccc-1111-dddd2222eeee"
        }

        It "Should contain Id in parameters when passed PasswordSSOObjectId to it" {
            Mock -CommandName Remove-MgBetaServicePrincipalPasswordSingleSignOnCredential -MockWith { $args } -ModuleName Microsoft.Entra.Beta.Applications

            $result = Remove-EntraBetaPasswordSingleSignOnCredential -ServicePrincipalId "aaaabbbb-0000-cccc-1111-dddd2222eeee" -PasswordSSOObjectId "bbbbcccc-1111-dddd-2222-eeee3333ffff"
            $params = Get-Parameters -data $result
            $params.Id | Should -Be "bbbbcccc-1111-dddd-2222-eeee3333ffff"
        }

        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Remove-EntraBetaPasswordSingleSignOnCredential"
            $result = Remove-EntraBetaPasswordSingleSignOnCredential -ServicePrincipalId "aaaabbbb-0000-cccc-1111-dddd2222eeee" -PasswordSSOObjectId "bbbbcccc-1111-dddd-2222-eeee3333ffff"
            $result | Should -BeNullOrEmpty
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Remove-EntraBetaPasswordSingleSignOnCredential"
            Should -Invoke -CommandName Remove-MgBetaServicePrincipalPasswordSingleSignOnCredential -ModuleName Microsoft.Entra.Beta.Applications -Times 1 -ParameterFilter {
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
                { Remove-EntraBetaPasswordSingleSignOnCredential -ServicePrincipalId "aaaabbbb-0000-cccc-1111-dddd2222eeee" -PasswordSSOObjectId "bbbbcccc-1111-dddd-2222-eeee3333ffff" -Debug } | Should -Not -Throw
            }
            finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        } 
    }
}

