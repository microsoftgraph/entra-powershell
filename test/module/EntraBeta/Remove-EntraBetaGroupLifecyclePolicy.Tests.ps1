# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra.Beta) -eq $null){
        Import-Module Microsoft.Graph.Entra.Beta    
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force

    Mock -CommandName Remove-MgBetaGroupLifecyclePolicy -MockWith {} -ModuleName Microsoft.Graph.Entra.Beta
}

Describe "Remove-EntraBetaGroupLifecyclePolicy" {
    Context "Test for Remove-EntraBetaGroupLifecyclePolicy" {
        It "Should return empty Id" {
            $result = Remove-EntraBetaGroupLifecyclePolicy -Id "a47d4510-08c8-4437-99e9-71ca88e7af0f"
            $result | Should -BeNullOrEmpty

            Should -Invoke -CommandName Remove-MgBetaGroupLifecyclePolicy -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }

        It "Should fail when Id is empty" {
            { Remove-EntraBetaGroupLifecyclePolicy -Id } | Should -Throw "Missing an argument for parameter 'Id'*"
        }   

        It "Should fail when Id is invalid" {
            { Remove-EntraBetaGroupLifecyclePolicy -Id "" } | Should -Throw "Cannot bind argument to parameter 'Id' because it is an empty string."
        }  

        It "Should contain GroupLifecyclePolicyId in parameters when passed Id to it" {
            Mock -CommandName Remove-MgBetaGroupLifecyclePolicy -MockWith {$args} -ModuleName Microsoft.Graph.Entra.Beta

            $result = Remove-EntraBetaGroupLifecyclePolicy -Id "a47d4510-08c8-4437-99e9-71ca88e7af0f"
            $params = Get-Parameters -data $result
            $params.GroupLifecyclePolicyId | Should -Be "a47d4510-08c8-4437-99e9-71ca88e7af0f"
        }

        It "Should contain 'User-Agent' header" {
            Mock -CommandName Remove-MgBetaGroupLifecyclePolicy -MockWith {$args} -ModuleName Microsoft.Graph.Entra.Beta

            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Remove-EntraBetaGroupLifecyclePolicy"
            $result = Remove-EntraBetaGroupLifecyclePolicy -Id "a47d4510-08c8-4437-99e9-71ca88e7af0f"
            $params = Get-Parameters -data $result
            $params.Headers["User-Agent"] | Should -Be $userAgentHeaderValue
        } 

        # It "Should execute successfully without throwing an error " {
        #     # Disable confirmation prompts       
        #     $originalDebugPreference = $DebugPreference
        #     $DebugPreference = 'Continue'
    
        #     try {
        #         # Act & Assert: Ensure the function doesn't throw an exception
        #         { Get-EntraBetaAuditSignInLogs -Top 1 -Debug } | Should -Not -Throw
        #     } finally {
        #         # Restore original confirmation preference            
        #         $DebugPreference = $originalDebugPreference        
        #     }
        # } 
    }
}