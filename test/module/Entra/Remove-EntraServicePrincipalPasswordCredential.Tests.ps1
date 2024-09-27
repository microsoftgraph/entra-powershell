# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra) -eq $null){
        Import-Module Microsoft.Graph.Entra
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force

    Mock -CommandName Remove-MgServicePrincipalPassword -MockWith {} -ModuleName Microsoft.Graph.Entra
}

Describe "Remove-EntraServicePrincipalPasswordCredential" {
    Context "Test for Remove-EntraServicePrincipalPasswordCredential" {
        It "Should return empty object" {
            $result = Remove-EntraServicePrincipalPasswordCredential -ObjectID "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -KeyId "aaaaaaaa-0b0b-1c1c-2d2d-333333333333"
            $result | Should -BeNullOrEmpty

            Should -Invoke -CommandName Remove-MgServicePrincipalPassword -ModuleName Microsoft.Graph.Entra -Times 1
        }
        It "Should fail when ObjectID is empty" {
            { Remove-EntraServicePrincipalPasswordCredential -ObjectID  -KeyId "aaaaaaaa-0b0b-1c1c-2d2d-333333333333" } | should -Throw "Missing an argument for parameter 'ObjectID'.*"
        }   
        It "Should fail when ObjectID is invalid" {
            {Remove-EntraServicePrincipalPasswordCredential -ObjectID "" -KeyId "aaaaaaaa-0b0b-1c1c-2d2d-333333333333" } | should -Throw "Cannot bind argument to parameter 'ObjectID'*"
        }  
        It "Should fail when KeyId is empty" {
            {Remove-EntraServicePrincipalPasswordCredential -ObjectID "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -KeyId   } | should -Throw "Missing an argument for parameter 'KeyId'.*"
        }   
        It "Should fail when KeyId is invalid" {
            { Remove-EntraServicePrincipalPasswordCredential -ObjectID "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -KeyId ""} | should -Throw "Cannot bind argument to parameter 'KeyId'*"
        }  
        It "Should contain ServicePrincipalId in parameters when passed ObjectId to it" {
            Mock -CommandName Remove-MgServicePrincipalPassword -MockWith {$args} -ModuleName Microsoft.Graph.Entra

            $result = Remove-EntraServicePrincipalPasswordCredential -ObjectID "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -KeyId "aaaaaaaa-0b0b-1c1c-2d2d-333333333333"
            $params = Get-Parameters -data $result
            $params.ServicePrincipalId | Should -Be "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
        }
        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Remove-EntraServicePrincipalPasswordCredential"

            Remove-EntraServicePrincipalPasswordCredential -ObjectID "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -KeyId "aaaaaaaa-0b0b-1c1c-2d2d-333333333333"

            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Remove-EntraServicePrincipalPasswordCredential"

            Should -Invoke -CommandName Remove-MgServicePrincipalPassword -ModuleName Microsoft.Graph.Entra -Times 1 -ParameterFilter {
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
                { Remove-EntraServicePrincipalPasswordCredential -ObjectID "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -KeyId "aaaaaaaa-0b0b-1c1c-2d2d-333333333333" -Debug } | Should -Not -Throw
            } finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        }    
    }
}