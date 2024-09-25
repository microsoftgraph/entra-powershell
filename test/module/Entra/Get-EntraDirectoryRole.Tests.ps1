# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra) -eq $null){
        Import-Module Microsoft.Graph.Entra      
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force
    
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
    
    Mock -CommandName Get-MgDirectoryRole -MockWith $scriptblock -ModuleName Microsoft.Graph.Entra
  }
  
  Describe "Get-EntraDirectoryRole" {
    Context "Test for Get-EntraDirectoryRole" {
        It "Should return specific role" {
            $result = Get-EntraDirectoryRole -ObjectId "bbbbbbbb-1111-2222-3333-cccccccccccc"
            $result | Should -Not -BeNullOrEmpty
            $result.Id | should -Be "bbbbbbbb-1111-2222-3333-cccccccccccc"

            Should -Invoke -CommandName Get-MgDirectoryRole  -ModuleName Microsoft.Graph.Entra -Times 1
        }
        It "Should fail when ObjectId is empty" {
            { Get-EntraDirectoryRole -ObjectId "" } | Should -Throw "Cannot bind argument to parameter 'ObjectId' because it is an empty string."
        }
        It "Should return specific role by filter" {
            $result = Get-EntraDirectoryRole -Filter "DisplayName -eq 'Attribute Assignment Reader'"
            $result | Should -Not -BeNullOrEmpty
            $result.DisplayName | should -Be 'Attribute Assignment Reader'

            Should -Invoke -CommandName Get-MgDirectoryRole  -ModuleName Microsoft.Graph.Entra -Times 1
        }  
        It "Result should Contain ObjectId" {
            $result = Get-EntraDirectoryRole -ObjectId "bbbbbbbb-1111-2222-3333-cccccccccccc"
            $result.ObjectId | should -Be "bbbbbbbb-1111-2222-3333-cccccccccccc"
        } 
        It "Should contain DirectoryRoleId in parameters when passed ObjectId to it" {     
            $result = Get-EntraDirectoryRole -ObjectId "bbbbbbbb-1111-2222-3333-cccccccccccc"
            $params = Get-Parameters -data $result.Parameters
            $params.DirectoryRoleId | Should -Be "bbbbbbbb-1111-2222-3333-cccccccccccc"
        }
        It "Property parameter should work" {
            $result = Get-EntraDirectoryRole -ObjectId "bbbbbbbb-1111-2222-3333-cccccccccccc" -Property DisplayName
            $result | Should -Not -BeNullOrEmpty
            $result.DisplayName | Should -Be 'Attribute Assignment Reader'

            Should -Invoke -CommandName Get-MgDirectoryRole  -ModuleName Microsoft.Graph.Entra -Times 1
        }
        It "Should fail when Property is empty" {
            { Get-EntraDirectoryRole -ObjectId "bbbbbbbb-1111-2222-3333-cccccccccccc" -Property } | Should -Throw "Missing an argument for parameter 'Property'*"
        }
        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraDirectoryRole"
            $result = Get-EntraDirectoryRole -ObjectId "bbbbbbbb-1111-2222-3333-cccccccccccc"
            $result | Should -Not -BeNullOrEmpty
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraDirectoryRole"
            Should -Invoke -CommandName Get-MgDirectoryRole -ModuleName Microsoft.Graph.Entra -Times 1 -ParameterFilter {
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
                { Get-EntraDirectoryRole -ObjectId "bbbbbbbb-1111-2222-3333-cccccccccccc" -Debug } | Should -Not -Throw
            } finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        }   
    }
  }