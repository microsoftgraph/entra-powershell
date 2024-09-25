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
        $result = Add-EntraAdministrativeUnitMember -ObjectId "aaaaaaaa-1111-2222-3333-cccccccccccc" -RefObjectId "bbbbbbbb-1111-2222-3333-cccccccccccc"
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
        $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Add-EntraAdministrativeUnitMember"
        Add-EntraAdministrativeUnitMember -ObjectId "aaaaaaaa-1111-2222-3333-cccccccccccc" -RefObjectId "bbbbbbbb-1111-2222-3333-cccccccccccc"
        $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Add-EntraAdministrativeUnitMember"
        Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Graph.Entra -Times 1 -ParameterFilter {
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
            { Add-EntraAdministrativeUnitMember -ObjectId "aaaaaaaa-1111-2222-3333-cccccccccccc" -RefObjectId "bbbbbbbb-1111-2222-3333-cccccccccccc" -Debug } | Should -Not -Throw
        } finally {
            # Restore original confirmation preference            
            $DebugPreference = $originalDebugPreference        
        }
    }
}