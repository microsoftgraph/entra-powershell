# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra) -eq $null){
        Import-Module Microsoft.Graph.Entra      
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force

    Mock -CommandName New-MgApplicationOwnerByRef -MockWith {} -ModuleName Microsoft.Graph.Entra
}
  
Describe "Add-EntraApplicationOwner" {
    Context "Test for Add-EntraApplicationOwner" { 
        It "Should return empty object"{
            $result = Add-EntraApplicationOwner -ObjectId "aaaaaaaa-1111-2222-3333-cccccccccccc" -RefObjectId "bbbbbbbb-1111-2222-3333-cccccccccccc"
            $result | Should -BeNullOrEmpty           

            Should -Invoke -CommandName New-MgApplicationOwnerByRef -ModuleName Microsoft.Graph.Entra -Times 1
        }       
        It "Should fail when parameters are empty" {
            { Add-EntraApplicationOwner -ObjectId "" -RefObjectId "" } | Should -Throw "Cannot bind argument to parameter*"
        }
        It "Should contain ApplicationId in parameters when passed ObjectId to it" {              
            Mock -CommandName New-MgApplicationOwnerByRef -MockWith {$args} -ModuleName Microsoft.Graph.Entra

            $result = Add-EntraApplicationOwner -ObjectId "aaaaaaaa-1111-2222-3333-cccccccccccc" -RefObjectId "bbbbbbbb-1111-2222-3333-cccccccccccc"
            $params = Get-Parameters -data $result
            $params.ApplicationId | Should -Be "aaaaaaaa-1111-2222-3333-cccccccccccc"
        }
        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Add-EntraApplicationOwner"
            Add-EntraApplicationOwner -ObjectId "aaaaaaaa-1111-2222-3333-cccccccccccc" -RefObjectId "bbbbbbbb-1111-2222-3333-cccccccccccc" 
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Add-EntraApplicationOwner"
            Should -Invoke -CommandName New-MgApplicationOwnerByRef -ModuleName Microsoft.Graph.Entra -Times 1 -ParameterFilter {
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
                { Add-EntraApplicationOwner -ObjectId "aaaaaaaa-1111-2222-3333-cccccccccccc" -RefObjectId "bbbbbbbb-1111-2222-3333-cccccccccccc" -Debug } | Should -Not -Throw
            } finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        }
    }
}