# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra) -eq $null){
        Import-Module Microsoft.Graph.Entra
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force

    Mock -CommandName Remove-MgServicePrincipalOwnerByRef -MockWith {} -ModuleName Microsoft.Graph.Entra
}

Describe "Remove-EntraServicePrincipalOwner" {
    Context "Test for Remove-EntraServicePrincipalOwner" {
        It "Should return empty object" {
            $result = Remove-EntraServicePrincipalOwner -ObjectId "bbbbbbbb-1111-2222-3333-cccccccccccc" -OwnerId "aaaaaaaa-0b0b-1c1c-2d2d-333333333333"
            $result | Should -BeNullOrEmpty
            Should -Invoke -CommandName Remove-MgServicePrincipalOwnerByRef -ModuleName Microsoft.Graph.Entra -Times 1
        }

        It "Should fail when ObjectId is empty" {
            { Remove-EntraServicePrincipalOwner -ObjectId  -OwnerId "aaaaaaaa-0b0b-1c1c-2d2d-333333333333" }| Should -Throw "Missing an argument for parameter 'ObjectId'.*"                
        } 
        It "Should fail when ObjectId is invalid" {
            { Remove-EntraServicePrincipalOwner -ObjectId "" -OwnerId "aaaaaaaa-0b0b-1c1c-2d2d-333333333333"} | Should -Throw "Cannot bind argument to parameter 'ObjectId' because it is an empty string.*"
        }
        It "Should fail when OwnerId is empty" {
            { Remove-EntraServicePrincipalOwner -ObjectId "bbbbbbbb-1111-2222-3333-cccccccccccc" -OwnerId } | Should -Throw "Missing an argument for parameter 'OwnerId'.*"
        }
        It "Should fail when OwnerId is invalid" {
            { Remove-EntraServicePrincipalOwner -ObjectId "bbbbbbbb-1111-2222-3333-cccccccccccc" -OwnerId ""} | Should -Throw "Cannot bind argument to parameter 'OwnerId' because it is an empty string."
        }
        It "Should contain ServicePrincipalId in parameters when passed ObjectId to it" {
            Mock -CommandName Remove-MgServicePrincipalOwnerByRef -MockWith {$args} -ModuleName Microsoft.Graph.Entra

            $result = Remove-EntraServicePrincipalOwner -ObjectId "bbbbbbbb-1111-2222-3333-cccccccccccc" -OwnerId "aaaaaaaa-0b0b-1c1c-2d2d-333333333333"
            $params = Get-Parameters -data $result
            $params.ServicePrincipalId | Should -Be "bbbbbbbb-1111-2222-3333-cccccccccccc"
        }
        It "Should contain DirectoryObjectId in parameters when passed OwnerId to it" {
            Mock -CommandName Remove-MgServicePrincipalOwnerByRef -MockWith {$args} -ModuleName Microsoft.Graph.Entra

            $result = Remove-EntraServicePrincipalOwner -ObjectId "bbbbbbbb-1111-2222-3333-cccccccccccc" -OwnerId "aaaaaaaa-0b0b-1c1c-2d2d-333333333333"
            $params = Get-Parameters -data $result
            $params.DirectoryObjectId | Should -Be "aaaaaaaa-0b0b-1c1c-2d2d-333333333333"
        }
        It "Should contain 'User-Agent' header" {
            Mock -CommandName Remove-MgServicePrincipalOwnerByRef -MockWith {$args} -ModuleName Microsoft.Graph.Entra

            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Remove-EntraServicePrincipalOwner"

            $result = Remove-EntraServicePrincipalOwner -ObjectId "bbbbbbbb-1111-2222-3333-cccccccccccc" -OwnerId "aaaaaaaa-0b0b-1c1c-2d2d-333333333333"
            $params = Get-Parameters -data $result
            $params.Headers["User-Agent"] | Should -Be $userAgentHeaderValue
        } 

        It "Should execute successfully without throwing an error" {
            # Disable confirmation prompts       
            $originalDebugPreference = $DebugPreference
            $DebugPreference = 'Continue'

            try {
                # Act & Assert: Ensure the function doesn't throw an exception
                {  Remove-EntraServicePrincipalOwner -ObjectId "bbbbbbbb-1111-2222-3333-cccccccccccc" -OwnerId "aaaaaaaa-0b0b-1c1c-2d2d-333333333333" -Debug } | Should -Not -Throw
            } finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        }    
    }
}