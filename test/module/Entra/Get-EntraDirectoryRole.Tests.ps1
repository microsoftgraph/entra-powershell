# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

BeforeAll {  
    if ((Get-Module -Name Microsoft.Graph.Entra) -eq $null) {
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
        It "Should fail when ObjectId is invalid" {
            { Get-EntraDirectoryRole -ObjectId "" } | Should -Throw "Cannot bind argument to parameter 'ObjectId' because it is an empty string."
        }
        It "Should fail when ObjectId is empty" {
            { Get-EntraDirectoryRole -ObjectId } | Should -Throw "Missing an argument for parameter 'ObjectId'*"
        }
        It "Should return specific role by filter" {
            $result = Get-EntraDirectoryRole -Filter "DisplayName -eq 'Attribute Assignment Reader'"
            $result | Should -Not -BeNullOrEmpty
            $result.DisplayName | should -Be 'Attribute Assignment Reader'

            Should -Invoke -CommandName Get-MgDirectoryRole  -ModuleName Microsoft.Graph.Entra -Times 1
        }  
        It "Should fail when filter is empty" {
            { Get-EntraDirectoryRole -Filter } | Should -Throw "Missing an argument for parameter 'Filter'*"
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
        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraDirectoryRole"

            $result = Get-EntraDirectoryRole -ObjectId "bbbbbbbb-1111-2222-3333-cccccccccccc"
            $params = Get-Parameters -data $result.Parameters
            $params.Headers["User-Agent"] | Should -Be $userAgentHeaderValue
        }     
    }
}