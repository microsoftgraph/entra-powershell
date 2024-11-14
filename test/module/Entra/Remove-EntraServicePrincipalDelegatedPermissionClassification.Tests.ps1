# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra) -eq $null){
        Import-Module Microsoft.Graph.Entra
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force

    Mock -CommandName Remove-MgServicePrincipalDelegatedPermissionClassification -MockWith {} -ModuleName Microsoft.Graph.Entra
}

Describe "Remove-EntraServicePrincipalDelegatedPermissionClassification" {
    Context "Test for Remove-EntraServicePrincipalDelegatedPermissionClassification" {
        It "Should return empty object" {
            $result = Remove-EntraServicePrincipalDelegatedPermissionClassification -ServicePrincipalId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -Id "00001111-aaaa-2222-bbbb-3333cccc4444"
            $result | Should -BeNullOrEmpty

            Should -Invoke -CommandName Remove-MgServicePrincipalDelegatedPermissionClassification -ModuleName Microsoft.Graph.Entra -Times 1
        }
        It "Should fail when ServicePrincipalId is empty" {
            { Remove-EntraServicePrincipalDelegatedPermissionClassification -ServicePrincipalId  -Id "00001111-aaaa-2222-bbbb-3333cccc4444" } | should -Throw "Missing an argument for parameter 'ServicePrincipalId'.*"
        }   
        It "Should fail when ServicePrincipalId is invalid" {
            { Remove-EntraServicePrincipalDelegatedPermissionClassification -ServicePrincipalId "" -Id "00001111-aaaa-2222-bbbb-3333cccc4444" } | should -Throw "Cannot bind argument to parameter 'ServicePrincipalId'*"
        }  
        It "Should fail when Id is empty" {
            {  Remove-EntraServicePrincipalDelegatedPermissionClassification -ServicePrincipalId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -Id  } | should -Throw "Missing an argument for parameter 'Id'.*"
        }   
        It "Should fail when Id is invalid" {
            {  Remove-EntraServicePrincipalDelegatedPermissionClassification -ServicePrincipalId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -Id "" } | should -Throw "Cannot bind argument to parameter 'Id'*"
        }  
        It "Should contain DelegatedPermissionClassificationId in parameters when passed Id to it" {
            Mock -CommandName Remove-MgServicePrincipalDelegatedPermissionClassification -MockWith {$args} -ModuleName Microsoft.Graph.Entra

            $result =  Remove-EntraServicePrincipalDelegatedPermissionClassification -ServicePrincipalId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -Id "00001111-aaaa-2222-bbbb-3333cccc4444"
            $params = Get-Parameters -data $result
            $params.DelegatedPermissionClassificationId | Should -Be "00001111-aaaa-2222-bbbb-3333cccc4444"
        }
        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Remove-EntraServicePrincipalDelegatedPermissionClassification"

            Remove-EntraServicePrincipalDelegatedPermissionClassification -ServicePrincipalId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -Id "00001111-aaaa-2222-bbbb-3333cccc4444"

            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Remove-EntraServicePrincipalDelegatedPermissionClassification"

            Should -Invoke -CommandName Remove-MgServicePrincipalDelegatedPermissionClassification -ModuleName Microsoft.Graph.Entra -Times 1 -ParameterFilter {
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
                { Remove-EntraServicePrincipalDelegatedPermissionClassification -ServicePrincipalId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -Id "00001111-aaaa-2222-bbbb-3333cccc4444" -Debug } | Should -Not -Throw
            } finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        } 
    }
}