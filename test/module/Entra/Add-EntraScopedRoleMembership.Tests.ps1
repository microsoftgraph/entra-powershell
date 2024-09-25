# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
BeforeAll{
    if ((Get-Module -Name Microsoft.Graph.Entra) -eq $null) {
        Import-Module Microsoft.Graph.Entra      
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force

    $userObjId = "aaaaaaaa-1111-2222-3333-bbbbbbbbbbbb"
    $roleObjId = "aaaaaaaa-2222-3333-4444-bbbbbbbbbbbb"
    $unitObjId = "aaaaaaaa-3333-4444-5555-bbbbbbbbbbbb"
    $RoleMember = New-Object -TypeName Microsoft.Open.MSGraph.Model.MsRoleMemberInfo
    $RoleMember.Id = $userObjId

    $scriptblock = {
        @{
            "administrativeUnitId" = $unitObjId
            "roleId" = $roleObjId
            "roleMemberInfo" = @(
                @{
                    "id" = $userObjId
                    "userPrincipalName" = "Dummy"
                    "displayName" = "Dummy"
                }
            )
            "id" = "NewDummyId"
            "Parameters" = $args
        }
    }

    Mock -CommandName Invoke-GraphRequest -MockWith $scriptblock -ModuleName Microsoft.Graph.Entra
}
Describe "Tests for Add-EntraScopedRoleMembership"{
    It "Result should not be empty"{
        $result = Add-EntraScopedRoleMembership -ObjectId $unitObjId -RoleObjectId $roleObjId -RoleMemberInfo $RoleMember
        $result | Should -Not -BeNullOrEmpty
        $result.Id | should -Be @('NewDummyId')
        Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Graph.Entra -Times 1
    }
    It "Should fail when ObjectId is invalid" {
        { Add-EntraScopedRoleMembership -ObjectId "" } | Should -Throw "Cannot bind argument to parameter 'ObjectId'*"
    }
    It "Should fail when ObjectId is empty" {
        { Add-EntraScopedRoleMembership -ObjectId } | Should -Throw "Missing an argument for parameter 'ObjectId'*"
    }
    It "Should fail when RoleMemberInfo is invalid" {
        { Add-EntraScopedRoleMembership -RoleMemberInfo "" } | Should -Throw "Cannot process argument transformation on parameter 'RoleMemberInfo'*"
    }
    It "Should fail when RoleMemberInfo is empty" {
        { Add-EntraScopedRoleMembership -RoleMemberInfo } | Should -Throw "Missing an argument for parameter 'RoleMemberInfo'*"
    }
    It "Should fail when invalid parameter is passed" {
        { Add-EntraScopedRoleMembership -xyz } | Should -Throw "A parameter cannot be found that matches parameter name 'xyz'*"
    }
    It "Should contain 'User-Agent' header" {
        $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Add-EntraScopedRoleMembership"
        Add-EntraScopedRoleMembership -ObjectId $unitObjId -RoleObjectId $roleObjId -RoleMemberInfo $RoleMember
        $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Add-EntraScopedRoleMembership"
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
            { Add-EntraScopedRoleMembership -ObjectId $unitObjId -RoleObjectId $roleObjId -RoleMemberInfo $RoleMember -Debug } | Should -Not -Throw
        } finally {
            # Restore original confirmation preference            
            $DebugPreference = $originalDebugPreference        
        }
    } 
}