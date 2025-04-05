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
                    "Id"                   = "83ec0ff5-f16a-4ba3-b8db-74919eda4926"
                    "AdditionalProperties" = @{
                        "@odata.type"       = "#microsoft.graph.user"
                        "businessPhones"    = @("425-555-0100")
                        "displayName"       = "MOD Administrator"
                        "givenName"         = "MOD"
                        "mail"              = "admin@contoso.com"
                        "mobilePhone"       = "425-555-0101"
                        "preferredLanguage" = "en"
                        "surname"           = "Administrator"
                        "userPrincipalName" = "admin@contoso.com"
                    }
                    "Parameters"           = $args
                }
            )
        }    
    }
    Mock -CommandName Invoke-GraphRequest -MockWith $mockResponse -ModuleName Microsoft.Entra.Groups
}
  
Describe "Get-EntraGroupOwner" {
    Context "Test for Get-EntraGroupOwner" {
        It "Get a group owner by GroupId" {
            $result = Get-EntraGroupOwner -GroupId "83ec0ff5-f16a-4ba3-b8db-74919eda4926"
            $result | Should -Not -BeNullOrEmpty
            $result.Id | should -Be '83ec0ff5-f16a-4ba3-b8db-74919eda4926'
            $result.DeletedDateTime | should -BeNullOrEmpty

            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.Groups -Times 1
        }
        It "Get a group owner by alias" {
            $result = Get-EntraGroupOwner -ObjectId "83ec0ff5-f16a-4ba3-b8db-74919eda4926"
            $result | Should -Not -BeNullOrEmpty
            $result.Id | should -Be '83ec0ff5-f16a-4ba3-b8db-74919eda4926'
            $result.DeletedDateTime | should -BeNullOrEmpty

            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.Groups -Times 1
        }

        It "Should fail when GroupId is empty" {
            { Get-EntraGroupOwner -GroupId } | Should -Throw "Missing an argument for parameter 'GroupId'*"
        }

        It "Gets all group owners" {
            $result = Get-EntraGroupOwner -GroupId "83ec0ff5-f16a-4ba3-b8db-74919eda4926" -All 
            $result | Should -Not -BeNullOrEmpty            
            
            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.Groups -Times 1
        }

        It "Should fail when All has an argument" {
            { Get-EntraGroupOwner -GroupId "83ec0ff5-f16a-4ba3-b8db-74919eda4926" -All $true } | Should -Throw "A positional parameter cannot be found that accepts argument 'True'.*"
        }  
        
        It "Gets two group owners" {
            $result = Get-EntraGroupOwner -GroupId "83ec0ff5-f16a-4ba3-b8db-74919eda4926" -Top 2
            $result | Should -Not -BeNullOrEmpty

            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.Groups -Times 1
        }  

        It "Should fail when top is empty" {
            { Get-EntraGroupOwner -GroupId "83ec0ff5-f16a-4ba3-b8db-74919eda4926" -Top } | Should -Throw "Missing an argument for parameter 'Top'*"
        }  

        It "Should fail when top is invalid" {
            { Get-EntraGroupOwner -GroupId "83ec0ff5-f16a-4ba3-b8db-74919eda4926" -Top XY } | Should -Throw "Cannot process argument transformation on parameter 'Top'*"
        }  

        It "Result should Contain GroupId" {
            $result = Get-EntraGroupOwner -GroupId "83ec0ff5-f16a-4ba3-b8db-74919eda4926"
            $result.ObjectId | should -Be "83ec0ff5-f16a-4ba3-b8db-74919eda4926"
        } 

        It "Should contain GroupId in parameters when passed GroupId to it" {
            $result = Get-EntraGroupOwner -GroupId "83ec0ff5-f16a-4ba3-b8db-74919eda4926"
            $params = Get-Parameters -data $result.Parameters
            $groupId = $params | ConvertTo-json | ConvertFrom-Json
            $groupId.Uri -match "83ec0ff5-f16a-4ba3-b8db-74919eda4926" | Should -BeTrue
        }

        It "Property parameter should work" {
            $result = Get-EntraGroupOwner -GroupId "83ec0ff5-f16a-4ba3-b8db-74919eda4926" -Property Id 
            $result | Should -Not -BeNullOrEmpty
            $result.Id | Should -Be "83ec0ff5-f16a-4ba3-b8db-74919eda4926"

            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.Groups -Times 1
        }

        It "Should fail when Property is empty" {
            { Get-EntraGroupOwner -GroupId "83ec0ff5-f16a-4ba3-b8db-74919eda4926" -Property } | Should -Throw "Missing an argument for parameter 'Property'*"
        }

        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraGroupOwner"

            $result = Get-EntraGroupOwner -GroupId "83ec0ff5-f16a-4ba3-b8db-74919eda4926"
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
                { Get-EntraGroupOwner -GroupId "83ec0ff5-f16a-4ba3-b8db-74919eda4926" -Debug } | Should -Not -Throw
            }
            finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        }   
    }
}

