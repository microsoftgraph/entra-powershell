# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
BeforeAll {    
    if((Get-Module -Name Microsoft.Graph.Entra) -eq $null){
        Import-Module Microsoft.Graph.Entra
    }

    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force

    Mock -CommandName Invoke-GraphRequest -MockWith {} -ModuleName Microsoft.Graph.Entra
}
Describe "Add-EntraAdministrativeUnitMember tests"{
    It "Should return empty object"{
        $result = Add-EntraAdministrativeUnitMember -ObjectId "f306a126-cf2e-439d-b20f-95ce4bcb7ffa" -RefObjectId "d6873b36-81d6-4c5e-bec0-9e3ca2c86846"
        $result | Should -BeNullOrEmpty
        Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Graph.Entra -Times 1
    }
    It "Should fail when ObjectId is empty"{
        {  Add-EntraAdministrativeUnitMember -ObjectId "" } | Should -Throw "Cannot bind argument to parameter 'ObjectId'*"
    }
    It "Should fail when ObjectId is null"{
        {  Add-EntraAdministrativeUnitMember -ObjectId  } | Should -Throw "Missing an argument for parameter 'ObjectId'*"
    }
    It "Should fail when RefObjectId is empty"{
        {  Add-EntraAdministrativeUnitMember -RefObjectId "" } | Should -Throw "Cannot bind argument to parameter 'RefObjectId'*"
    }
    It "Should fail when RefObjectId is null"{
        {  Add-EntraAdministrativeUnitMember -RefObjectId  } | Should -Throw "Missing an argument for parameter 'RefObjectId'*"
    }
    It "Should fail when invalid paramter is passed"{
        { Add-EntraAdministrativeUnitMember -Demo } | Should -Throw "A parameter cannot be found that matches parameter name 'Demo'*"
    }
    It "Should contain 'User-Agent' header" {
        Mock -CommandName Invoke-GraphRequest -MockWith {$args} -ModuleName Microsoft.Graph.Entra
        $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Add-EntraAdministrativeUnitMember"
        $result = Add-EntraAdministrativeUnitMember -ObjectId "f306a126-cf2e-439d-b20f-95ce4bcb7ffa" -RefObjectId "d6873b36-81d6-4c5e-bec0-9e3ca2c86846"
        $params = Get-Parameters -data $result
        $params.Headers["User-Agent"] | Should -Be $userAgentHeaderValue
    }
}