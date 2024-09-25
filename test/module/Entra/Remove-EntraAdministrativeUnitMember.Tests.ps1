# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra) -eq $null){
        Import-Module Microsoft.Graph.Entra
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force

    Mock -CommandName Invoke-GraphRequest -MockWith {} -ModuleName Microsoft.Graph.Entra

    $auId = "bbbbbbbb-1111-1111-1111-cccccccccccc"
    $memId = "bbbbbbbb-2222-2222-2222-cccccccccccc"
}

Describe "Test for Remove-EntraAdministrativeUnitMember" {
    It "Should return empty object" {
        $result = Remove-EntraAdministrativeUnitMember -ObjectId $auId -MemberId $memId
        $result | Should -BeNullOrEmpty
        Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Graph.Entra -Times 1
    }
    It "Should fail when ObjectId is empty" {
        { Remove-EntraAdministrativeUnitMember -ObjectId "" } | Should -Throw "Cannot bind argument to parameter 'ObjectId'*"
    }
    It "Should fail when ObjectId is null" {
        { Remove-EntraAdministrativeUnitMember -ObjectId } | Should -Throw "Missing an argument for parameter 'ObjectId'*"
    }
    It "Should fail when MemberId is empty" {
        { Remove-EntraAdministrativeUnitMember -MemberId "" } | Should -Throw "Cannot bind argument to parameter 'MemberId'*"
    }
    It "Should fail when MemberId is null" {
        { Remove-EntraAdministrativeUnitMember -MemberId } | Should -Throw "Missing an argument for parameter 'MemberId'*"
    }
    It "Should fail when invalid parameter is passed" {
        { Remove-EntraAdministrativeUnitMember -xyz } | Should -Throw "A parameter cannot be found that matches parameter name 'xyz'*"
    }
    It "Should contain 'User-Agent' header" {
        $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Remove-EntraAdministrativeUnitMember"

        Remove-EntraAdministrativeUnitMember -ObjectId $auId -MemberId $memId

        $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Remove-EntraAdministrativeUnitMember"

        Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Graph.Entra -Times 1 -ParameterFilter {
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
            { Remove-EntraAdministrativeUnitMember -ObjectId $auId -MemberId $memId -Debug } | Should -Not -Throw
        } finally {
            # Restore original confirmation preference            
            $DebugPreference = $originalDebugPreference        
        }
    }   
}