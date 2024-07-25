# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

BeforeAll {
    if ((Get-Module -Name Microsoft.Graph.Entra) -eq $null) {
        Import-Module Microsoft.Graph.Entra      
    }

    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force

    $ScriptBlock = {
        
        $response = @{
            '@odata.context' = 'https://graph.microsoft.com/v1.0/$metadata#policies/homeRealmDiscoveryPolicies/$entity'            
            }

            return $response
            
    }
    Mock -CommandName Invoke-GraphRequest -MockWith $ScriptBlock -ModuleName Microsoft.Graph.Entra
}
Describe "Test for Remove-EntraPolicy" {
    It "Should return empty object" {
        $result = Remove-EntraPolicy -Id bbbbbbbb-1111-1111-1111-cccccccccccc
        #$result | Should -BeNullOrEmpty
        Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Graph.Entra -Times 2
    }
    It "Should fail when -Id is empty" {
        { Remove-EntraPolicy -Id "" } | Should -Throw "Cannot bind argument to parameter 'Id'*"
    }
    It "Should fail when Id is null" {
        { Remove-EntraPolicy -Id } | Should -Throw "Missing an argument for parameter 'Id'*"
    }
    It "Should fail when invalid parameter is passed" {
        { Remove-EntraPolicy -xyz } | Should -Throw "A parameter cannot be found that matches parameter name 'xyz'*"
    }
}

