# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
BeforeAll {  
    if ((Get-Module -Name Microsoft.Entra.Applications) -eq $null) {
        Import-Module Microsoft.Entra.Applications
    }
    Import-Module (Join-Path $PSScriptRoot "..\..\Common-Functions.ps1") -Force

    Mock -CommandName Remove-MgServicePrincipalOwnerByRef -MockWith {} -ModuleName Microsoft.Entra.Applications
    Mock -CommandName Get-EntraContext -MockWith { @{Scopes = @("Application.ReadWrite.All") } } -ModuleName Microsoft.Entra.Applications
}

Describe "Remove-EntraServicePrincipalOwner" {
    Context "Test for Remove-EntraServicePrincipalOwner" {
        It "Should return empty object" {
            $result = Remove-EntraServicePrincipalOwner -ServicePrincipalId "bbbbbbbb-1111-2222-3333-cccccccccccc" -OwnerId "aaaaaaaa-0b0b-1c1c-2d2d-333333333333"
            $result | Should -BeNullOrEmpty
            Should -Invoke -CommandName Remove-MgServicePrincipalOwnerByRef -ModuleName Microsoft.Entra.Applications -Times 1
        }
        It "Should update the parameter with Alias" {
            $result = Remove-EntraServicePrincipalOwner -ObjectId "bbbbbbbb-1111-2222-3333-cccccccccccc" -OwnerId "aaaaaaaa-0b0b-1c1c-2d2d-333333333333"
            $result | Should -BeNullOrEmpty
            Should -Invoke -CommandName Remove-MgServicePrincipalOwnerByRef -ModuleName Microsoft.Entra.Applications -Times 1
        }
        It "Should fail when ServicePrincipalId is empty" {
            { Remove-EntraServicePrincipalOwner -ServicePrincipalId -OwnerId "aaaaaaaa-0b0b-1c1c-2d2d-333333333333" } | Should -Throw "Missing an argument for parameter 'ServicePrincipalId'.*"                
        } 
        It "Should fail when ServicePrincipalId is invalid" {
            { Remove-EntraServicePrincipalOwner -ServicePrincipalId "" -OwnerId "aaaaaaaa-0b0b-1c1c-2d2d-333333333333" } | Should -Throw "Cannot validate argument on parameter 'ServicePrincipalId'. The argument is null or empty. Provide an argument that is not null or empty, and then try the command again."
        }
        It "Should fail when OwnerId is empty" {
            { Remove-EntraServicePrincipalOwner -ServicePrincipalId "bbbbbbbb-1111-2222-3333-cccccccccccc" -OwnerId } | Should -Throw "Missing an argument for parameter 'OwnerId'.*"
        }
        It "Should fail when OwnerId is invalid" {
            { Remove-EntraServicePrincipalOwner -ServicePrincipalId "bbbbbbbb-1111-2222-3333-cccccccccccc" -OwnerId "" } | Should -Throw "Cannot validate argument on parameter 'OwnerId'. The argument is null or empty. Provide an argument that is not null or empty, and then try the command again."
        }
        It "Should contain ServicePrincipalId in parameters when passed ServicePrincipalId to it" {
            Mock -CommandName Remove-MgServicePrincipalOwnerByRef -MockWith { $args } -ModuleName Microsoft.Entra.Applications

            $result = Remove-EntraServicePrincipalOwner -ServicePrincipalId "bbbbbbbb-1111-2222-3333-cccccccccccc" -OwnerId "aaaaaaaa-0b0b-1c1c-2d2d-333333333333"
            $params = Get-Parameters -data $result
            $params.ServicePrincipalId | Should -Be "bbbbbbbb-1111-2222-3333-cccccccccccc"
        }
        It "Should contain DirectoryObjectId in parameters when passed OwnerId to it" {
            Mock -CommandName Remove-MgServicePrincipalOwnerByRef -MockWith { $args } -ModuleName Microsoft.Entra.Applications

            $result = Remove-EntraServicePrincipalOwner -ServicePrincipalId "bbbbbbbb-1111-2222-3333-cccccccccccc" -OwnerId "aaaaaaaa-0b0b-1c1c-2d2d-333333333333"
            $params = Get-Parameters -data $result
            $params.DirectoryObjectId | Should -Be "aaaaaaaa-0b0b-1c1c-2d2d-333333333333"
        }

        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Remove-EntraServicePrincipalOwner"

            Remove-EntraServicePrincipalOwner -ServicePrincipalId "bbbbbbbb-1111-2222-3333-cccccccccccc" -OwnerId "aaaaaaaa-0b0b-1c1c-2d2d-333333333333"
            
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Remove-EntraServicePrincipalOwner"

            Should -Invoke -CommandName Remove-MgServicePrincipalOwnerByRef -ModuleName Microsoft.Entra.Applications -Times 1 -ParameterFilter {
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
                { Remove-EntraServicePrincipalOwner -ServicePrincipalId "bbbbbbbb-1111-2222-3333-cccccccccccc" -OwnerId "aaaaaaaa-0b0b-1c1c-2d2d-333333333333" -Debug } | Should -Not -Throw
            }
            finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        }    
    }
}

