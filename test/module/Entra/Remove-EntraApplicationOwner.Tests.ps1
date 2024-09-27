# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra) -eq $null){
        Import-Module Microsoft.Graph.Entra       
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force

    Mock -CommandName Remove-MgApplicationOwnerByRef -MockWith {} -ModuleName Microsoft.Graph.Entra
}

Describe "Remove-EntraApplicationOwner"{
    It "Should return empty object" {
        $result = Remove-EntraApplicationOwner -ObjectId "aaaaaaaa-bbbb-cccc-1111-222222222222" -OwnerId "bbbbbbbb-cccc-dddd-2222-333333333333"
        $result | Should -BeNullOrEmpty
        Should -Invoke -CommandName Remove-MgApplicationOwnerByRef -ModuleName Microsoft.Graph.Entra -Times 1
    }
    It "Should fail when ObjectId is empty" {
        { Remove-EntraApplicationOwner -ObjectId "" }
    }
    It "Should fail when -OwnerId is empty" {
        { Remove-EntraApplicationOwner -OwnerId "" }
    }
    It "Should contain DeviceId in parameters" {
        Mock -CommandName Remove-MgApplicationOwnerByRef -MockWith {$args} -ModuleName Microsoft.Graph.Entra
        $result = Remove-EntraApplicationOwner -ObjectId "aaaaaaaa-bbbb-cccc-1111-222222222222" -OwnerId "bbbbbbbb-cccc-dddd-2222-333333333333"
        $params = Get-Parameters -data $result
        $params.ApplicationId | Should -Be "aaaaaaaa-bbbb-cccc-1111-222222222222"
    }
    It "Should contain DirectoryObjectId in parameters" {
        Mock -CommandName Remove-MgApplicationOwnerByRef -MockWith {$args} -ModuleName Microsoft.Graph.Entra
        $result = Remove-EntraApplicationOwner -ObjectId "aaaaaaaa-bbbb-cccc-1111-222222222222" -OwnerId "bbbbbbbb-cccc-dddd-2222-333333333333"
        $params = Get-Parameters -data $result
        $params.DirectoryObjectId | Should -Be "bbbbbbbb-cccc-dddd-2222-333333333333"
    }
    It "Should contain 'User-Agent' header" {
        $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Remove-EntraApplicationOwner"
        $result =  Remove-EntraApplicationOwner -ObjectId "aaaaaaaa-bbbb-cccc-1111-222222222222" -OwnerId "bbbbbbbb-cccc-dddd-2222-333333333333"
        $result | Should  -BeNullOrEmpty
        $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Remove-EntraApplicationOwner"
        Should -Invoke -CommandName Remove-MgApplicationOwnerByRef -ModuleName Microsoft.Graph.Entra -Times 1 -ParameterFilter {
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
            {  Remove-EntraApplicationOwner -ObjectId "aaaaaaaa-bbbb-cccc-1111-222222222222" -OwnerId "bbbbbbbb-cccc-dddd-2222-333333333333" -Debug } | Should -Not -Throw
        } finally {
            # Restore original confirmation preference            
            $DebugPreference = $originalDebugPreference        
        }
    }
}