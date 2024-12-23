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
Describe "New-EntraAdministrativeUnitMember tests"{
    It "Should return empty object"{
        $result = New-EntraAdministrativeUnitMember -AdministrativeUnitId "f306a126-cf2e-439d-b20f-95ce4bcb7ffa" -RefObjectId "d6873b36-81d6-4c5e-bec0-9e3ca2c86846"
        $result | Should -BeNullOrEmpty
        Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Graph.Entra -Times 1
    }
    It "Should return empty object with ObjectId"{
        $result = New-EntraAdministrativeUnitMember -ObjectId "f306a126-cf2e-439d-b20f-95ce4bcb7ffa" -RefObjectId "d6873b36-81d6-4c5e-bec0-9e3ca2c86846"
        $result | Should -BeNullOrEmpty
        Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Graph.Entra -Times 1
    }
    It "Should fail when AdministrativeUnitId is empty"{
        {  New-EntraAdministrativeUnitMember -AdministrativeUnitId "" } | Should -Throw "Cannot bind argument to parameter 'AdministrativeUnitId'*"
    }
    It "Should fail when AdministrativeUnitId is null"{
        {  New-EntraAdministrativeUnitMember -AdministrativeUnitId  } | Should -Throw "Missing an argument for parameter 'AdministrativeUnitId'*"
    }
    It "Should fail when RefObjectId is empty"{
        {  New-EntraAdministrativeUnitMember -RefObjectId "" } | Should -Throw "Cannot bind argument to parameter 'RefObjectId'*"
    }
    It "Should fail when RefObjectId is null"{
        {  New-EntraAdministrativeUnitMember -RefObjectId  } | Should -Throw "Missing an argument for parameter 'RefObjectId'*"
    }
    It "Should fail when invalid paramter is passed"{
        { New-EntraAdministrativeUnitMember -Demo } | Should -Throw "A parameter cannot be found that matches parameter name 'Demo'*"
    }
    It "Should contain 'User-Agent' header" {        
        $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion New-EntraAdministrativeUnitMember"
        New-EntraAdministrativeUnitMember -AdministrativeUnitId "aaaaaaaa-1111-2222-3333-cccccccccccc" -RefObjectId "bbbbbbbb-1111-2222-3333-cccccccccccc"
        $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion New-EntraAdministrativeUnitMember"
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
            { New-EntraAdministrativeUnitMember -AdministrativeUnitId "f306a126-cf2e-439d-b20f-95ce4bcb7ffa" -RefObjectId "d6873b36-81d6-4c5e-bec0-9e3ca2c86846" -Debug } | Should -Not -Throw
        } finally {
            # Restore original confirmation preference            
            $DebugPreference = $originalDebugPreference        
        }
    }
}