# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra.Beta) -eq $null){
        Import-Module Microsoft.Graph.Entra.Beta    
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force

    Mock -CommandName Remove-MgBetaServicePrincipalPasswordSingleSignOnCredential -MockWith {} -ModuleName Microsoft.Graph.Entra.Beta
}

Describe "Remove-EntraBetaPasswordSingleSignOnCredential" {
    Context "Test for Remove-EntraBetaPasswordSingleSignOnCredential" {
        It "Should remove password single-sign-on credentials" {
            $result = Remove-EntraBetaPasswordSingleSignOnCredential -ObjectId "aaaabbbb-0000-cccc-1111-dddd2222eeee"  -PasswordSSOObjectId "bbbbcccc-1111-dddd-2222-eeee3333ffff"
            $result | Should -BeNullOrEmpty

            Should -Invoke -CommandName Remove-MgBetaServicePrincipalPasswordSingleSignOnCredential -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }

        It "Should fail when ObjectId is empty" {
            { Remove-EntraBetaPasswordSingleSignOnCredential -ObjectId   -PasswordSSOObjectId "bbbbcccc-1111-dddd-2222-eeee3333ffff" } | Should -Throw "Missing an argument for parameter 'ObjectId'*"
        }   

        It "Should fail when ObjectId is invalid" {
            { Remove-EntraBetaPasswordSingleSignOnCredential -ObjectId ""  -PasswordSSOObjectId "bbbbcccc-1111-dddd-2222-eeee3333ffff" } | Should -Throw "Cannot bind argument to parameter 'ObjectId' because it is an empty string."
        }   

        It "Should fail when PasswordSSOObjectId is empty" {
            { Remove-EntraBetaPasswordSingleSignOnCredential -ObjectId "aaaabbbb-0000-cccc-1111-dddd2222eeee" -PasswordSSOObjectId  } | Should -Throw "Missing an argument for parameter 'PasswordSSOObjectId'*"
        }   

        It "Should contain ServicePrincipalId in parameters when passed ObjectId to it" {
            Mock -CommandName Remove-MgBetaServicePrincipalPasswordSingleSignOnCredential -MockWith {$args} -ModuleName Microsoft.Graph.Entra.Beta

            $result = Remove-EntraBetaPasswordSingleSignOnCredential -ObjectId "aaaabbbb-0000-cccc-1111-dddd2222eeee"  -PasswordSSOObjectId "bbbbcccc-1111-dddd-2222-eeee3333ffff"
            $params = Get-Parameters -data $result
            $params.ServicePrincipalId | Should -Be "aaaabbbb-0000-cccc-1111-dddd2222eeee"
        }

        It "Should contain Id in parameters when passed PasswordSSOObjectId to it" {
            Mock -CommandName Remove-MgBetaServicePrincipalPasswordSingleSignOnCredential -MockWith {$args} -ModuleName Microsoft.Graph.Entra.Beta

            $result = Remove-EntraBetaPasswordSingleSignOnCredential -ObjectId "aaaabbbb-0000-cccc-1111-dddd2222eeee"  -PasswordSSOObjectId "bbbbcccc-1111-dddd-2222-eeee3333ffff"
            $params = Get-Parameters -data $result
            $params.Id | Should -Be "bbbbcccc-1111-dddd-2222-eeee3333ffff"
        }

        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Remove-EntraBetaPasswordSingleSignOnCredential"
            $result =  Remove-EntraBetaPasswordSingleSignOnCredential -ObjectId "aaaabbbb-0000-cccc-1111-dddd2222eeee"  -PasswordSSOObjectId "bbbbcccc-1111-dddd-2222-eeee3333ffff"
            $result | Should -BeNullOrEmpty
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Remove-EntraBetaPasswordSingleSignOnCredential"
            Should -Invoke -CommandName Remove-MgBetaServicePrincipalPasswordSingleSignOnCredential -ModuleName Microsoft.Graph.Entra.Beta -Times 1 -ParameterFilter {
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
                { Remove-EntraBetaPasswordSingleSignOnCredential -ObjectId "aaaabbbb-0000-cccc-1111-dddd2222eeee"  -PasswordSSOObjectId "bbbbcccc-1111-dddd-2222-eeee3333ffff" -Debug } | Should -Not -Throw
            } finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        } 
    }
}