# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

BeforeAll {  
    if((Get-Module -Name Microsoft.Entra.DirectoryManagement) -eq $null){
        Import-Module Microsoft.Entra.DirectoryManagement      
    }
    Import-Module (Join-Path $PSScriptRoot "..\..\Common-Functions.ps1") -Force
    
    $scriptblock = {
        # Write-Host "Mocking Get-EntraDirectoryRole with parameters: $($args | ConvertTo-Json -Depth 3)"
        return @(
            [PSCustomObject]@{
              "DeletedDateTime" = $null
              "Description"     = "Read custom security attribute keys and values for supported Microsoft Entra objects."
              "DisplayName"     = "Attribute Assignment Reader"
              "Id"              = "bbbbbbbb-1111-2222-3333-cccccccccccc"
              "RoleTemplateId"  = "aaaaaaaa-1111-2222-3333-cccccccccccc"
              "Members"         = $null
              "ScopedMembers"   = $null
              "Parameters"      = $args
            }
        )
    }
    
    Mock -CommandName Get-MgDirectoryRole -MockWith $scriptblock -ModuleName Microsoft.Entra.DirectoryManagement

    Mock -CommandName Get-EntraContext -MockWith { @{
        Environment = @{ Name = "Global" }
        Scopes      = @('RoleManagement.Read.Directory')
    }} -ModuleName Microsoft.Entra.DirectoryManagement
  }
  
  Describe "Get-EntraDirectoryRole" {
    Context "Test for Get-EntraDirectoryRole" {
        It "Should throw when not connected and not invoke SDK call" {
            Mock -CommandName Get-EntraContext -MockWith { $null } -ModuleName Microsoft.Entra.DirectoryManagement
            { Get-EntraDirectoryRole -DirectoryRoleId "bbbbbbbb-1111-2222-3333-cccccccccccc" } | Should -Throw "Not connected to Microsoft Graph*"
            Should -Invoke -CommandName Get-MgDirectoryRole  -ModuleName Microsoft.Entra.DirectoryManagement -Times 0
        }
        
        It "Should return specific role" {
            $result = Get-EntraDirectoryRole -DirectoryRoleId "bbbbbbbb-1111-2222-3333-cccccccccccc"
            $result | Should -Not -BeNullOrEmpty
            $result.Id | should -Be "bbbbbbbb-1111-2222-3333-cccccccccccc"

            Should -Invoke -CommandName Get-MgDirectoryRole  -ModuleName Microsoft.Entra.DirectoryManagement -Times 1
        }
        It "Should execute successfully with Alias" {
            $result = Get-EntraDirectoryRole -ObjectId "bbbbbbbb-1111-2222-3333-cccccccccccc"
            $result | Should -Not -BeNullOrEmpty
            $result.Id | should -Be "bbbbbbbb-1111-2222-3333-cccccccccccc"

            Should -Invoke -CommandName Get-MgDirectoryRole  -ModuleName Microsoft.Entra.DirectoryManagement -Times 1
        }
        It "Should fail when DirectoryRoleId is empty" {
            { Get-EntraDirectoryRole -DirectoryRoleId "" } | Should -Throw "Cannot bind argument to parameter 'DirectoryRoleId' because it is an empty string."
        }
        It "Should return specific role by filter" {
            $result = Get-EntraDirectoryRole -Filter "DisplayName -eq 'Attribute Assignment Reader'"
            $result | Should -Not -BeNullOrEmpty
            $result.DisplayName | should -Be 'Attribute Assignment Reader'

            Should -Invoke -CommandName Get-MgDirectoryRole  -ModuleName Microsoft.Entra.DirectoryManagement -Times 1
        }  
        It "Result should Contain DirectoryRoleId" {
            $result = Get-EntraDirectoryRole -DirectoryRoleId "bbbbbbbb-1111-2222-3333-cccccccccccc"
            $result.ObjectId | should -Be "bbbbbbbb-1111-2222-3333-cccccccccccc"
        } 
        It "Should contain DirectoryRoleId in parameters when passed DirectoryRoleId to it" {     
            $result = Get-EntraDirectoryRole -DirectoryRoleId "bbbbbbbb-1111-2222-3333-cccccccccccc"
            $params = Get-Parameters -data $result.Parameters
            $params.DirectoryRoleId | Should -Be "bbbbbbbb-1111-2222-3333-cccccccccccc"
        }
        It "Property parameter should work" {
            $result = Get-EntraDirectoryRole -DirectoryRoleId "bbbbbbbb-1111-2222-3333-cccccccccccc" -Property DisplayName
            $result | Should -Not -BeNullOrEmpty
            $result.DisplayName | Should -Be 'Attribute Assignment Reader'

            Should -Invoke -CommandName Get-MgDirectoryRole  -ModuleName Microsoft.Entra.DirectoryManagement -Times 1
        }
        It "Should fail when Property is empty" {
            { Get-EntraDirectoryRole -DirectoryRoleId "bbbbbbbb-1111-2222-3333-cccccccccccc" -Property } | Should -Throw "Missing an argument for parameter 'Property'*"
        }
        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraDirectoryRole"
            $result = Get-EntraDirectoryRole -DirectoryRoleId "bbbbbbbb-1111-2222-3333-cccccccccccc"
            $result | Should -Not -BeNullOrEmpty
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraDirectoryRole"
            Should -Invoke -CommandName Get-MgDirectoryRole -ModuleName Microsoft.Entra.DirectoryManagement -Times 1 -ParameterFilter {
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
                { Get-EntraDirectoryRole -DirectoryRoleId "bbbbbbbb-1111-2222-3333-cccccccccccc" -Debug } | Should -Not -Throw
            } finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        }   
    }
  }

