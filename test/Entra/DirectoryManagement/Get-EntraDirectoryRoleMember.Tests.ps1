# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
BeforeAll {  
    if((Get-Module -Name Microsoft.Entra.DirectoryManagement) -eq $null){
        
        Import-Module Microsoft.Entra.DirectoryManagement      
    }
    Import-Module (Join-Path $PSScriptRoot "..\..\Common-Functions.ps1") -Force
    $scriptblock = {
        return @{
            value = @(
                @{
                    "Id"                               = "00aa00aa-bb11-cc22-dd33-44ee44ee44ee" 
                    "OnPremisesSyncEnabled"            = $null
                    "OnPremisesLastSyncDateTime"       = $null
                    "mobilePhone"                      = "425-555-0101"
                    "onPremisesProvisioningErrors"     = @{}
                    "businessPhones"                   = @("425-555-0100")
                    "Parameters"                       = $args
                }
            )
        }
    }
    
    Mock -CommandName Invoke-GraphRequest -MockWith $scriptblock -ModuleName Microsoft.Entra.DirectoryManagement

    Mock -CommandName Get-EntraContext -MockWith { @{
        Environment = @{ Name = "Global" }
        Scopes      = @('RoleManagement.Read.Directory')
    }} -ModuleName Microsoft.Entra.DirectoryManagement
}

Describe "EntraDirectoryRoleMember" {
    Context "Test for EntraDirectoryRoleMember" {
        It "Should return specific directory rolemember" {
            $result = (Get-EntraDirectoryRoleMember -DirectoryRoleId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb") | ConvertTo-json | ConvertFrom-json
            $result | Should -Not -BeNullOrEmpty
            $result.ObjectId | should -Be "00aa00aa-bb11-cc22-dd33-44ee44ee44ee"

            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.DirectoryManagement -Times 1
        }
        It "Should return specific directory rolemember with alias" {
            $result = (Get-EntraDirectoryRoleMember -ObjectId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb") | ConvertTo-json | ConvertFrom-json
            $result | Should -Not -BeNullOrEmpty
            $result.ObjectId | should -Be "00aa00aa-bb11-cc22-dd33-44ee44ee44ee"

            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.DirectoryManagement -Times 1
        }
        It "Should fail when DirectoryRoleId is empty" {
            { Get-EntraDirectoryRoleMember -DirectoryRoleId } | Should -Throw "Missing an argument for parameter 'DirectoryRoleId'*"
        }
        It "Should fail when DirectoryRoleId is invalid" {
            { Get-EntraDirectoryRoleMember -DirectoryRoleId "" } | Should -Throw "Cannot bind argument to parameter 'DirectoryRoleId' because it is an empty string.*"
        }
        It "Result should Contain Alias property" {
            $result = Get-EntraDirectoryRoleMember -DirectoryRoleId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
            $result.ObjectId | should -Be "00aa00aa-bb11-cc22-dd33-44ee44ee44ee"
            $result.DirSyncEnabled | should -Be $null
            $result.LastDirSyncTime | should -Be $null
            $result.Mobile | should -Be "425-555-0101"
            $result.ProvisioningErrors | Should -BeNullOrEmpty
            $result.TelephoneNumber | should -Be "425-555-0100"
        }
        It "Should contain DirectoryRoleId in URI" {
            $result = Get-EntraDirectoryRoleMember -DirectoryRoleId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" 
            $params = Get-Parameters -data $result.Parameters
            $Para= $params | ConvertTo-json | ConvertFrom-Json
            $Para.URI | Should -match "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
        }
        It "Property parameter should work" {
            $result = Get-EntraDirectoryRoleMember -DirectoryRoleId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -Property Id
            $result | Should -Not -BeNullOrEmpty
            $result.Id | Should -Be '00aa00aa-bb11-cc22-dd33-44ee44ee44ee'

            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.DirectoryManagement -Times 1
        }
        It "Should fail when Property is empty" {
             { Get-EntraDirectoryRoleMember -DirectoryRoleId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -Property } | Should -Throw "Missing an argument for parameter 'Property'*"
        }
        
        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraDirectoryRoleMember"

            Get-EntraDirectoryRoleMember -DirectoryRoleId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
            
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraDirectoryRoleMember"

            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.DirectoryManagement -Times 1 -ParameterFilter {
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
                { Get-EntraDirectoryRoleMember -DirectoryRoleId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"  -Debug } | Should -Not -Throw
            } finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        }
    }
}    

