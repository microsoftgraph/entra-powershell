# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
BeforeAll {  
    if ((Get-Module -Name Microsoft.Entra.DirectoryManagement) -eq $null) {
        
        Import-Module Microsoft.Entra.DirectoryManagement      
    }
    Import-Module (Join-Path $PSScriptRoot "..\..\Common-Functions.ps1") -Force
    $scriptblock = {
        return @{
            value = @(
                @{
                    "Id"                           = "00aa00aa-bb11-cc22-dd33-44ee44ee44ee" 
                    "OnPremisesSyncEnabled"        = $null
                    "userPrincipalName"            = "Adams@M365x99297270.OnMicrosoft.com"
                    "accountEnabled"               = $true
                    "usageLocation"                = "DE"
                    "displayName"                  = "Mock-App"
                    "userType"                     = "User"
                    "OnPremisesLastSyncDateTime"   = $null
                    "onPremisesProvisioningErrors" = @{}
                    "Parameters"                   = $args
                }
            )
        }
    }
    
    Mock -CommandName Invoke-GraphRequest -MockWith $scriptblock -ModuleName Microsoft.Entra.DirectoryManagement

    Mock -CommandName Get-EntraContext -MockWith { @{
        Environment = @{ Name = "Global" }
        Scopes      = @('Directory.Read.All')
    }} -ModuleName Microsoft.Entra.DirectoryManagement
}


Describe "Get-EntraDirectoryObject" {
    Context "Test for Get-EntraDirectoryObject" {
        It "Should throw when not connected and not invoke graph call" {
            Mock -CommandName Get-EntraContext -MockWith { $null } -ModuleName Microsoft.Entra.DirectoryManagement
            { Get-EntraDirectoryObject -DirectoryObjectIds "00aa00aa-bb11-cc22-dd33-44ee44ee44ee" } | Should -Throw "Not connected to Microsoft Graph*"
            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.DirectoryManagement -Times 0
        }

        It "Should return specific object by objectId" {
            $result = Get-EntraDirectoryObject -DirectoryObjectIds '00aa00aa-bb11-cc22-dd33-44ee44ee44ee'
            $result | Should -Not -BeNullOrEmpty
            $result.Id | should -Be '00aa00aa-bb11-cc22-dd33-44ee44ee44ee'
            $result.displayName | should -Be 'Mock-App'
            $result.userType | should -Be 'User'

            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.DirectoryManagement -Times 1
        }
        It "Should fail when -DirectoryObjectIds is empty" {
            { Get-EntraDirectoryObject -DirectoryObjectIds } | Should -Throw "Missing an argument for parameter 'DirectoryObjectIds'*"
        }
        It "Should fail when ObjectId is invalid" {
            { Get-EntraDirectoryObject -DirectoryObjectIds "" } | Should -Throw "Cannot bind argument to parameter 'DirectoryObjectIds' because it is an empty string*"
        }
        It "Should return specific object by objectId and Types" {
            $result = Get-EntraDirectoryObject -DirectoryObjectIds "00aa00aa-bb11-cc22-dd33-44ee44ee44ee" -ObjectTypes "User"
            $result | Should -Not -BeNullOrEmpty
            $result.userType | should -Be 'User'

            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.DirectoryManagement -Times 1
        }

        It "Should contain Ids in parameters when passed Id to it" {              
            $result = Get-EntraDirectoryObject -DirectoryObjectIds "00aa00aa-bb11-cc22-dd33-44ee44ee44ee"
            $params = Get-Parameters -data $result.Parameters
            $para = $params | ConvertTo-json | ConvertFrom-Json
            $para.Body.Ids | Should -Be "00aa00aa-bb11-cc22-dd33-44ee44ee44ee"
        }
        It "Property parameter should work" {
            $result = Get-EntraDirectoryObject -DirectoryObjectIds "00aa00aa-bb11-cc22-dd33-44ee44ee44ee" -Property displayName 
            $result | Should -Not -BeNullOrEmpty
            $result.displayName | Should -Be "Mock-App"

            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.DirectoryManagement -Times 1
        }

        It "Should fail when Property is empty" {
            { Get-EntraDirectoryObject -DirectoryObjectIds "00aa00aa-bb11-cc22-dd33-44ee44ee44ee" -Property } | Should -Throw "Missing an argument for parameter 'Property'*"
        }
        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraDirectoryObject"

            $result = Get-EntraDirectoryObject -DirectoryObjectIds "00aa00aa-bb11-cc22-dd33-44ee44ee44ee"
            $result | Should -Not -BeNullOrEmpty

            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraDirectoryObject"

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
                { Get-EntraDirectoryObject -DirectoryObjectIds "00aa00aa-bb11-cc22-dd33-44ee44ee44ee" -Debug } | Should -Not -Throw
            }
            finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        }

    }

}    
