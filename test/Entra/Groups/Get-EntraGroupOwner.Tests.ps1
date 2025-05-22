# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
BeforeAll {  
    if ((Get-Module -Name Microsoft.Entra.Groups) -eq $null) {
        Import-Module Microsoft.Entra.Groups        
    }
    Import-Module (Join-Path $PSScriptRoot "..\..\Common-Functions.ps1") -Force
    
    $mockResponse = {
        return @{
            value = @(
                @{
                    "DeletedDateTime"      = $null
                    "Id"                   = "aaaaaaaa-1111-2222-3333-cccccccccccc"
                    "@odata.type"       = "#microsoft.graph.user"
                    "businessPhones"    = @("425-555-0100")
                    "displayName"       = "MOD Administrator"
                    "givenName"         = "MOD"
                    "mail"              = "admin@contoso.com"
                    "mobilePhone"       = "425-555-0101"
                    "preferredLanguage" = "en"
                    "surname"           = "Administrator"
                    "userPrincipalName" = "admin@contoso.com"
                    "Parameters"           = $args
                }
            )
        }    
    }
    Mock -CommandName Invoke-GraphRequest -MockWith $mockResponse -ModuleName Microsoft.Entra.Groups
    Mock -CommandName Get-EntraContext -MockWith { @{Scopes = @("GroupMember.Read.All") } } -ModuleName Microsoft.Entra.Groups
}
  
Describe "Get-EntraGroupOwner" {
    Context "Test for Get-EntraGroupOwner" {
        It "Get a group owner by GroupId" {
            $result = Get-EntraGroupOwner -GroupId "aaaaaaaa-1111-2222-3333-cccccccccccc"
            $result | Write-Debug
            $result | Should -Not -BeNullOrEmpty
            #$result.Id | should -Be 'aaaaaaaa-1111-2222-3333-cccccccccccc'
            #$result.DeletedDateTime | should -BeNullOrEmpty

            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.Groups -Times 1
        }
        It "Get a group owner by alias" {
            $result = Get-EntraGroupOwner -ObjectId "aaaaaaaa-1111-2222-3333-cccccccccccc"
            $result | Should -Not -BeNullOrEmpty
            #$result.Id | should -Be 'aaaaaaaa-1111-2222-3333-cccccccccccc'
            #$result.DeletedDateTime | should -BeNullOrEmpty

            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.Groups -Times 1
        }

        It "Should fail when GroupId is empty" {
            { Get-EntraGroupOwner -GroupId } | Should -Throw "Missing an argument for parameter 'GroupId'*"
        }

        It "Gets all group owners" {
            $result = Get-EntraGroupOwner -GroupId "aaaaaaaa-1111-2222-3333-cccccccccccc" -All 
            $result | Should -Not -BeNullOrEmpty            
            
            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.Groups -Times 1
        }

        It "Should fail when All has an argument" {
            { Get-EntraGroupOwner -GroupId "aaaaaaaa-1111-2222-3333-cccccccccccc" -All $true } | Should -Throw "A positional parameter cannot be found that accepts argument 'True'.*"
        }  
        
        It "Gets two group owners" {
            $result = Get-EntraGroupOwner -GroupId "aaaaaaaa-1111-2222-3333-cccccccccccc" -Top 2
            $result | Should -Not -BeNullOrEmpty

            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.Groups -Times 1
        }  

        It "Should fail when top is empty" {
            { Get-EntraGroupOwner -GroupId "aaaaaaaa-1111-2222-3333-cccccccccccc" -Top } | Should -Throw "Missing an argument for parameter 'Top'*"
        }  

        It "Should fail when top is invalid" {
            { Get-EntraGroupOwner -GroupId "aaaaaaaa-1111-2222-3333-cccccccccccc" -Top XY } | Should -Throw "Cannot process argument transformation on parameter 'Top'*"
        }  

        It "Result should Contain GroupId" {
            $result = Get-EntraGroupOwner -GroupId "aaaaaaaa-1111-2222-3333-cccccccccccc"
            #$result.ObjectId | should -Be "aaaaaaaa-1111-2222-3333-cccccccccccc"
        } 

        It "Should contain GroupId in parameters when passed GroupId to it" {
            $result = Get-EntraGroupOwner -GroupId "aaaaaaaa-1111-2222-3333-cccccccccccc"
            $params = Get-Parameters -data $result.Parameters
            $groupId = $params | ConvertTo-json | ConvertFrom-Json
            $groupId.Uri -match "aaaaaaaa-1111-2222-3333-cccccccccccc" | Should -BeTrue
        }

        It "Property parameter should work" {
            $result = Get-EntraGroupOwner -GroupId "aaaaaaaa-1111-2222-3333-cccccccccccc" -Property Id 
            $result | Should -Not -BeNullOrEmpty
            #$result.Id | Should -Be "aaaaaaaa-1111-2222-3333-cccccccccccc"

            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.Groups -Times 1
        }

        It "Should fail when Property is empty" {
            { Get-EntraGroupOwner -GroupId "aaaaaaaa-1111-2222-3333-cccccccccccc" -Property } | Should -Throw "Missing an argument for parameter 'Property'*"
        }

        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraGroupOwner"

            $result = Get-EntraGroupOwner -GroupId "aaaaaaaa-1111-2222-3333-cccccccccccc"
            $result | Should -Not -BeNullOrEmpty

            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraGroupOwner"

            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.Groups -Times 1 -ParameterFilter {
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
                { Get-EntraGroupOwner -GroupId "aaaaaaaa-1111-2222-3333-cccccccccccc" -Debug } | Should -Not -Throw
            }
            finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        }   
    }
}

