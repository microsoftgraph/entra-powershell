# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra) -eq $null){
        
        Import-Module Microsoft.Graph.Entra      
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force
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
    
    Mock -CommandName Invoke-GraphRequest -MockWith $scriptblock -ModuleName Microsoft.Graph.Entra

}

Describe "EntraDirectoryRoleMember" {
    Context "Test for EntraDirectoryRoleMember" {
        It "Should return specific directory rolemember" {
            $result = (Get-EntraDirectoryRoleMember -ObjectId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb") | ConvertTo-json | ConvertFrom-json
            $result | Should -Not -BeNullOrEmpty
            $result.ObjectId | should -Be "00aa00aa-bb11-cc22-dd33-44ee44ee44ee"

            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Graph.Entra -Times 1
        }
        It "Should fail when ObjectId is empty" {
            { Get-EntraDirectoryRoleMember -ObjectId } | Should -Throw "Missing an argument for parameter 'ObjectId'*"
        }
        It "Should fail when ObjectId is invalid" {
            { Get-EntraDirectoryRoleMember -ObjectId "" } | Should -Throw "Cannot bind argument to parameter 'ObjectId' because it is an empty string.*"
        }
        It "Result should Contain Alias property" {
            $result = Get-EntraDirectoryRoleMember -ObjectId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
            $result.ObjectId | should -Be "00aa00aa-bb11-cc22-dd33-44ee44ee44ee"
            $result.DirSyncEnabled | should -Be $null
            $result.LastDirSyncTime | should -Be $null
            $result.Mobile | should -Be "425-555-0101"
            $result.ProvisioningErrors | Should -BeNullOrEmpty
            $result.TelephoneNumber | should -Be "425-555-0100"
        }
        It "Should contain ObjectId in URI" {
            $result = Get-EntraDirectoryRoleMember -ObjectId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" 
            $params = Get-Parameters -data $result.Parameters
            $Para= $params | ConvertTo-json | ConvertFrom-Json
            $Para.URI | Should -match "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
        }
        It "Property parameter should work" {
            $result = Get-EntraDirectoryRoleMember -ObjectId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -Property Id
            $result | Should -Not -BeNullOrEmpty
            $result.Id | Should -Be '00aa00aa-bb11-cc22-dd33-44ee44ee44ee'

            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Graph.Entra -Times 1
        }
        It "Should fail when Property is empty" {
             { Get-EntraDirectoryRoleMember -ObjectId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -Property } | Should -Throw "Missing an argument for parameter 'Property'*"
        }
        
        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraDirectoryRoleMember"

            $result = Get-EntraDirectoryRoleMember -ObjectId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" 
            $params = Get-Parameters -data $result.Parameters
            $Para= $params | ConvertTo-json | ConvertFrom-Json
            $Para.headers.'User-Agent' | Should -Be $userAgentHeaderValue
        }
        It "Should execute successfully without throwing an error" {
            # Disable confirmation prompts       
            $originalDebugPreference = $DebugPreference
            $DebugPreference = 'Continue'

            try {
                # Act & Assert: Ensure the function doesn't throw an exception
                { Get-EntraDirectoryRoleMember -ObjectId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"  -Debug } | Should -Not -Throw
            } finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        }
    }
}    