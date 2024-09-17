# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra.Beta) -eq $null){
        Import-Module Microsoft.Graph.Entra.Beta    
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force
    
    $scriptblock = {
        return @(
            [PSCustomObject]@{
                "DisplayName"          = "Application"
                "Id"                   = "bbbbbbbb-1111-2222-3333-cccccccccc55"
                "TemplateId"           = "bbbbbbbb-1111-2222-3333-cccccccccc56"
                "Values"               = @("EnableAccessCheckForPrivilegedApplicationUpdates")
                "AdditionalProperties" = @{"[@odata.context" = "https://graph.microsoft.com/beta/`$metadata#settings/`$entity"}
                "Parameters"           = $args
            }
        )
    }    
    Mock -CommandName Get-MgBetaDirectorySetting -MockWith $scriptblock -ModuleName Microsoft.Graph.Entra.Beta
}
  
Describe "Get-EntraBetaDirectorySetting" {
    Context "Test for Get-EntraBetaDirectorySetting" {
        It "Should gets a directory setting from Azure Active Directory (AD)" {
            $result = Get-EntraBetaDirectorySetting -Id "bbbbbbbb-1111-2222-3333-cccccccccc55"
            $result | Should -Not -BeNullOrEmpty
            $result.Id | should -Be 'bbbbbbbb-1111-2222-3333-cccccccccc55'
            $result.DisplayName | should -Be "Application"
            $result.TemplateId | should -Be "bbbbbbbb-1111-2222-3333-cccccccccc56"
            $result.Values | should -Be @("EnableAccessCheckForPrivilegedApplicationUpdates")

            Should -Invoke -CommandName Get-MgBetaDirectorySetting -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }

        It "Should fail when Id is empty" {
            { Get-EntraBetaDirectorySetting -Id  } | Should -Throw "Missing an argument for parameter 'Id'*"
        }

        It "Should fail when Id is invalid" {
            { Get-EntraBetaDirectorySetting -Id "" } | Should -Throw "Cannot bind argument to parameter 'Id' because it is an empty string."
        }

        It "Should return all group" {
            $result = Get-EntraBetaDirectorySetting -All
            $result | Should -Not -BeNullOrEmpty            
            
            Should -Invoke -CommandName Get-MgBetaDirectorySetting -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }

        It "Should fail when All has an argument" {
            { Get-EntraBetaDirectorySetting -All $true } | Should -Throw "A positional parameter cannot be found that accepts argument 'True'."
        }
        
        It "Should return top group" {
            $result = Get-EntraBetaDirectorySetting -Top 1
            $result | Should -Not -BeNullOrEmpty

            Should -Invoke -CommandName Get-MgBetaDirectorySetting -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }  

        It "Should fail when top is empty" {
            { Get-EntraBetaDirectorySetting -Top } | Should -Throw "Missing an argument for parameter 'Top'*"
        }  

        It "Should fail when top is invalid" {
            { Get-EntraBetaDirectorySetting -Top y } | Should -Throw "Cannot process argument transformation on parameter 'Top'*"
        }  

        It "Should contain DirectorySettingId in parameters when passed Id to it" {
            $result = Get-EntraBetaDirectorySetting -Id "bbbbbbbb-1111-2222-3333-cccccccccc55"
            $params = Get-Parameters -data $result.Parameters
            $params.DirectorySettingId | Should -Be "bbbbbbbb-1111-2222-3333-cccccccccc55"
        }

        It "Property parameter should work" {
            $result = Get-EntraBetaDirectorySetting -Id "bbbbbbbb-1111-2222-3333-cccccccccc55" -Property DisplayName
            $result | Should -Not -BeNullOrEmpty
            $result.DisplayName | Should -Be 'Application'

            Should -Invoke -CommandName Get-MgBetaDirectorySetting  -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }
        It "Should fail when Property is empty" {
            { Get-EntraBetaDirectorySetting -Id "bbbbbbbb-1111-2222-3333-cccccccccc55" -Property } | Should -Throw "Missing an argument for parameter 'Property'*"
        }

        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraBetaDirectorySetting"
            $result= Get-EntraBetaDirectorySetting -Id "bbbbbbbb-1111-2222-3333-cccccccccc55"
            $result | Should -Not -BeNullOrEmpty
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraBetaDirectorySetting"
            Should -Invoke -CommandName Get-MgBetaDirectorySetting -ModuleName Microsoft.Graph.Entra.Beta -Times 1 -ParameterFilter {
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
                { Get-EntraBetaDirectorySetting -Id "bbbbbbbb-1111-2222-3333-cccccccccc55" -Debug } | Should -Not -Throw
            } finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        }
    }
}