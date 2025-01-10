# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
BeforeAll {  
    if((Get-Module -Name Microsoft.Entra.Beta.Groups) -eq $null){
        Import-Module Microsoft.Entra.Beta.Groups      
    }
    Import-Module (Join-Path $PSScriptRoot "..\..\Common-Functions.ps1") -Force
    
    $scriptblock = {
        return @(
            [PSCustomObject]@{
              "Id"                           = "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
              "DeletedDateTime"              = "10-05-2024 04:27:17"
              "CreatedDateTime"              = "07-07-2023 14:31:41"
              "DisplayName"                  = "Mock-App"
              "MailNickname"                 = "Demo-Mock-App"
              "GroupTypes"                   = "Unified"
              "SecurityEnabled"              = $False
              "MailEnabled"                  = $True
              "Visibility"                   = "Public"
              "AdditionalProperties"         = @{"@odata.context" = "https://graph.microsoft.com/beta/`$metadata#groups/`$entity"}
              "Parameters"                   = $args
            }
        )
    }

    Mock -CommandName Get-MgBetaDirectoryDeletedItemAsGroup -MockWith $scriptblock -ModuleName Microsoft.Entra.Beta.Groups
}

Describe "Get-EntraBetaDeletedGroup" {
Context "Test for Get-EntraBetaDeletedGroup" {
        It "Should return specific Deleted Group" {
            $result = Get-EntraBetaDeletedGroup -GroupId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
            $result | Should -Not -BeNullOrEmpty
            $result.Id | Should -Be "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
            $result.DisplayName | Should -Be "Mock-App"
            $result.GroupTypes | Should -Be "Unified"

            Should -Invoke -CommandName Get-MgBetaDirectoryDeletedItemAsGroup  -ModuleName Microsoft.Entra.Beta.Groups -Times 1
        }
        It "Should return specific Deleted Group with alias" {
            $result = Get-EntraBetaDeletedGroup -Id "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
            $result | Should -Not -BeNullOrEmpty
            $result.Id | Should -Be "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
            $result.DisplayName | Should -Be "Mock-App"
            $result.GroupTypes | Should -Be "Unified"

            Should -Invoke -CommandName Get-MgBetaDirectoryDeletedItemAsGroup  -ModuleName Microsoft.Entra.Beta.Groups -Times 1
        }
        It "Should fail when GroupId is empty" {
            { Get-EntraBetaDeletedGroup -GroupId    } | Should -Throw "Missing an argument for parameter 'GroupId'*"
        }
        It "Should fail when GroupId is invalid" {
            { Get-EntraBetaDeletedGroup -GroupId  ""} | Should -Throw "Cannot bind argument to parameter 'GroupId' because it is an empty string."
        }
         It "Should return All deleted groups" {
            $result = Get-EntraBetaDeletedGroup  -All
            $result | Should -Not -BeNullOrEmpty

            Should -Invoke -CommandName Get-MgBetaDirectoryDeletedItemAsGroup  -ModuleName Microsoft.Entra.Beta.Groups -Times 1
        }
        It "Should fail when All is invalid" {
            { Get-EntraBetaDeletedGroup -GroupId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -All xyz } | Should -Throw "A positional parameter cannot be found that accepts argument 'xyz'.*"
        }
        It "Should return top 1 deleted group" {
            $result = Get-EntraBetaDeletedGroup -Top 1
            $result | Should -Not -BeNullOrEmpty
            $result.Id | Should -Be "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
            $result.DisplayName | Should -Be "Mock-App"
            $result.GroupTypes | Should -Be "Unified"

            Should -Invoke -CommandName Get-MgBetaDirectoryDeletedItemAsGroup  -ModuleName Microsoft.Entra.Beta.Groups -Times 1
        }
        It "Should fail when Top is empty" {
            { Get-EntraBetaDeletedGroup -GroupId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -Top } | Should -Throw "Missing an argument for parameter 'Top'*"
        }
        It "Should fail when Top is invalid" {
            { Get-EntraBetaDeletedGroup -GroupId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -Top xyz } | Should -Throw "Cannot process argument transformation on parameter 'Top'*"
        }
        It "Should return specific deleted group by filter" {
            $result = Get-EntraBetaDeletedGroup -Filter "DisplayName eq 'Mock-App'"
            $result | Should -Not -BeNullOrEmpty
            $result.Id | Should -Be "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
            $result.DisplayName | Should -Be "Mock-App"
            $result.GroupTypes | Should -Be "Unified"

            Should -Invoke -CommandName Get-MgBetaDirectoryDeletedItemAsGroup  -ModuleName Microsoft.Entra.Beta.Groups -Times 1
        }
        It "Should fail when filter is empty" {
            { Get-EntraBetaDeletedGroup -Filter  } | Should -Throw "Missing an argument for parameter 'Filter'*"
        }
        It "Should return specific deleted groupn by SearchString" {
            $result = Get-EntraBetaDeletedGroup -SearchString "Demo-Mock-App"
            $result | Should -Not -BeNullOrEmpty
            $result.Id | Should -Be "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
            $result.MailNickname | Should -Be "Demo-Mock-App"
            $result.DisplayName | Should -Be "Mock-App"

            Should -Invoke -CommandName Get-MgBetaDirectoryDeletedItemAsGroup  -ModuleName Microsoft.Entra.Beta.Groups -Times 1
        }
        It "Should fail when searchstring is empty" {
            { Get-EntraBetaDeletedGroup -SearchString  } | Should -Throw "Missing an argument for parameter 'SearchString'*"
        }
        It "Property parameter should work" {
            $result = Get-EntraBetaDeletedGroup -GroupId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -Property DisplayName
            $result | Should -Not -BeNullOrEmpty
            $result.DisplayName | Should -Be 'Mock-App'

            Should -Invoke -CommandName Get-MgBetaDirectoryDeletedItemAsGroup -ModuleName Microsoft.Entra.Beta.Groups -Times 1
        }
        It "Should fail when Property is empty" {
             { Get-EntraBetaDeletedGroup -GroupId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -Property } | Should -Throw "Missing an argument for parameter 'Property'*"
        }
        It "Should contain GroupId in parameters when passed Id to it" {              
            $result = Get-EntraBetaDeletedGroup -GroupId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
            $params = Get-Parameters -data $result.Parameters
            $params.DirectoryObjectId | Should -Be "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
        }
        It "Should contain Filter in parameters when passed SearchString to it" {              
            $result = Get-EntraBetaDeletedGroup -SearchString "Demo-Mock-App"
            $params = Get-Parameters -data $result.Parameters
            $params.Filter | Should -Match "Mock-App"
        }
        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraBetaDeletedGroup"
            $result = Get-EntraBetaDeletedGroup -GroupId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
            $result | Should -Not -BeNullOrEmpty
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraBetaDeletedGroup"
            Should -Invoke -CommandName Get-MgBetaDirectoryDeletedItemAsGroup -ModuleName Microsoft.Entra.Beta.Groups -Times 1 -ParameterFilter {
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
                { Get-EntraBetaDeletedGroup -GroupId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -Debug } | Should -Not -Throw
            } finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        }
    }
}    

