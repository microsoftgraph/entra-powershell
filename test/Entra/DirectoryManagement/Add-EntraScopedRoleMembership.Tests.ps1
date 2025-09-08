# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
BeforeAll{
    if ((Get-Module -Name Microsoft.Entra.DirectoryManagement) -eq $null) {
        Import-Module Microsoft.Entra.DirectoryManagement      
    }
    Import-Module (Join-Path $PSScriptRoot "..\..\Common-Functions.ps1") -Force

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

    Mock -CommandName Invoke-GraphRequest -MockWith $scriptblock -ModuleName Microsoft.Entra.DirectoryManagement

    Mock -CommandName Get-EntraContext -MockWith { @{
        Environment = @{ Name = "Global" }
        Scopes      = @("RoleManagement.ReadWrite.Directory")
    }} -ModuleName Microsoft.Entra.DirectoryManagement
}
Describe "Tests for Add-EntraScopedRoleMembership"{
    It "Result should not be empty"{
        $result = Add-EntraScopedRoleMembership -AdministrativeUnitId $unitObjId -RoleObjectId $roleObjId -RoleMemberInfo $RoleMember
        $result | Should -Not -BeNullOrEmpty
        $result.Id | should -Be @('NewDummyId')
        Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.DirectoryManagement -Times 1
    }
    It "Result should not be empty with ObjectId"{
        $result = Add-EntraScopedRoleMembership -ObjectId $unitObjId -RoleObjectId $roleObjId -RoleMemberInfo $RoleMember
        $result | Should -Not -BeNullOrEmpty
        $result.Id | should -Be @('NewDummyId')
        Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.DirectoryManagement -Times 1
    }
    It "Should fail when AdministrativeUnitId is invalid" {
        { Add-EntraScopedRoleMembership -AdministrativeUnitId "" } | Should -Throw "Cannot bind argument to parameter 'AdministrativeUnitId'*"
    }
    It "Should fail when AdministrativeUnitId is empty" {
        { Add-EntraScopedRoleMembership -AdministrativeUnitId } | Should -Throw "Missing an argument for parameter 'AdministrativeUnitId'*"
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
        $result = Add-EntraScopedRoleMembership -AdministrativeUnitId $unitObjId -RoleObjectId $roleObjId -RoleMemberInfo $RoleMember
        $params = Get-Parameters -data $result.Parameters
        $a= $params | ConvertTo-json | ConvertFrom-Json
        $a.headers.'User-Agent' | Should -Be $userAgentHeaderValue
    }
    It "Should execute successfully without throwing an error " {
        # Disable confirmation prompts       
        $originalDebugPreference = $DebugPreference
        $DebugPreference = 'Continue'

        try {
            # Act & Assert: Ensure the function doesn't throw an exception
            { Add-EntraScopedRoleMembership -AdministrativeUnitId $unitObjId -RoleObjectId $roleObjId -RoleMemberInfo $RoleMember -Debug } | Should -Not -Throw
        } finally {
            # Restore original confirmation preference            
            $DebugPreference = $originalDebugPreference        
        }
    } 
}

