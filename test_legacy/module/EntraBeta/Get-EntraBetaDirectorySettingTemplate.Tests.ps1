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
                "DisplayName"     = "Group.Unified.Guest"
                "Id"              = "bbbbbbbb-1111-2222-3333-cccccccccc55"
                "Description"     = "Settings for a specific Unified Group"
                "Parameters"      = $args
                "Values"          = @(
                    [PSCustomObject]@{
                        "Name"         = "AllowToAddGuests"
                        "Description"  = ""
                        "Type"         = ""
                        "DefaultValue" = $true
                    }
                )
            }
        )
    }    
    Mock -CommandName Get-MgBetaDirectorySettingTemplate -MockWith $scriptblock -ModuleName Microsoft.Graph.Entra.Beta
}
  
Describe "Get-EntraBetaDirectorySettingTemplate" {
    Context "Test for Get-EntraBetaDirectorySettingTemplate" {
        It "Should gets a directory setting template from Azure Active Directory (AD)." {
            $result = Get-EntraBetaDirectorySettingTemplate -Id "bbbbbbbb-1111-2222-3333-cccccccccc55"
            $result | Should -Not -BeNullOrEmpty
            $result.Id | should -Be 'bbbbbbbb-1111-2222-3333-cccccccccc55'
            $result.DisplayName | should -Be "Group.Unified.Guest"
            $result.Description | should -Be "Settings for a specific Unified Group"

            Should -Invoke -CommandName Get-MgBetaDirectorySettingTemplate -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }

        It "Should fail when Id is empty" {
            { Get-EntraBetaDirectorySettingTemplate -Id  } | Should -Throw "Missing an argument for parameter 'Id'*"
        }

        It "Should fail when Id is invalid" {
            { Get-EntraBetaDirectorySettingTemplate -Id "" } | Should -Throw "Cannot bind argument to parameter 'Id' because it is an empty string."
        }

        It "Should contain DirectorySettingTemplateId in parameters when passed Id to it" {
            $result = Get-EntraBetaDirectorySettingTemplate -Id "bbbbbbbb-1111-2222-3333-cccccccccc55"
            $result | Should -Not -BeNullOrEmpty
            Should -Invoke -CommandName Get-MgBetaDirectorySettingTemplate -ModuleName Microsoft.Graph.Entra.Beta -Times 1 -ParameterFilter {
            $DirectorySettingTemplateId | Should -Be "bbbbbbbb-1111-2222-3333-cccccccccc55" 
            $true
            }
        }
        It "Property parameter should work" {
            $result = Get-EntraBetaDirectorySettingTemplate -Id "bbbbbbbb-1111-2222-3333-cccccccccc55" -Property DisplayName
            $result | Should -Not -BeNullOrEmpty
            $result.DisplayName | Should -Be 'Group.Unified.Guest'

            Should -Invoke -CommandName Get-MgBetaDirectorySettingTemplate  -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }
        It "Should fail when Property is empty" {
            { Get-EntraBetaDirectorySettingTemplate -Id "bbbbbbbb-1111-2222-3333-cccccccccc55" -Property } | Should -Throw "Missing an argument for parameter 'Property'*"
        }

        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraBetaDirectorySettingTemplate"
            $result = Get-EntraBetaDirectorySettingTemplate -Id "bbbbbbbb-1111-2222-3333-cccccccccc55"
            $result | Should -Not -BeNullOrEmpty
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraBetaDirectorySettingTemplate"
            Should -Invoke -CommandName Get-MgBetaDirectorySettingTemplate -ModuleName Microsoft.Graph.Entra.Beta -Times 1 -ParameterFilter {
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
                { Get-EntraBetaDirectorySettingTemplate -Id "bbbbbbbb-1111-2222-3333-cccccccccc55" -Debug } | Should -Not -Throw
            } finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        }
    }
}