# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra.Beta) -eq $null){
        Import-Module Microsoft.Graph.Entra.Beta       
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force
    $TemplateScriptblock = {
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
    Mock -CommandName Get-MgBetaDirectorySettingTemplate -MockWith $TemplateScriptblock -ModuleName Microsoft.Graph.Entra.Beta
    Mock -CommandName Invoke-GraphRequest -MockWith {} -ModuleName Microsoft.Graph.Entra.Beta
}
Describe "Set-EntraBetaObjectSetting" {
    Context "Test for Set-EntraBetaObjectSetting" {
        It "Should return empty object" {
            $template = Get-EntraBetaDirectorySettingTemplate | Where-Object {$_.displayname -eq "group.unified.guest"}
            $settingsCopy = $template.CreateDirectorySetting()
            $settingsCopy["AllowToAddGuests"]=$False

            $result = Set-EntraBetaObjectSetting -TargetType "Groups" -TargetObjectId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -Id "00aa00aa-bb11-cc22-dd33-44ee44ee44ee" -DirectorySetting $settingsCopy 
            $result | Should -BeNullOrEmpty

            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }
        It "Should fail when TargetType is empty" {
            $template = Get-EntraBetaDirectorySettingTemplate | Where-Object {$_.displayname -eq "group.unified.guest"}
            $settingsCopy = $template.CreateDirectorySetting()
            $settingsCopy["AllowToAddGuests"]=$False
            { Set-EntraBetaObjectSetting -TargetType  -TargetObjectId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -Id "00aa00aa-bb11-cc22-dd33-44ee44ee44ee" -DirectorySetting $settingsCopy } | Should -Throw "Missing an argument for parameter 'TargetType'*"
        }
        It "Should fail when TargetType is invalid" {
            $template = Get-EntraBetaDirectorySettingTemplate | Where-Object {$_.displayname -eq "group.unified.guest"}
            $settingsCopy = $template.CreateDirectorySetting()
            $settingsCopy["AllowToAddGuests"]=$False
            { Set-EntraBetaObjectSetting -TargetType  -TargetObjectId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -Id "00aa00aa-bb11-cc22-dd33-44ee44ee44ee" -DirectorySetting $settingsCopy } | Should -Throw "Missing an argument for parameter 'TargetType'*"
        }
        It "Should fail when TargetObjectId is empty" {
            $template = Get-EntraBetaDirectorySettingTemplate | Where-Object {$_.displayname -eq "group.unified.guest"}
            $settingsCopy = $template.CreateDirectorySetting()
            $settingsCopy["AllowToAddGuests"]=$False
            { Set-EntraBetaObjectSetting -TargetType "Groups" -TargetObjectId -Id "dddddddd-7902-4be2-a25b-dddddddddddd" -DirectorySetting $settingsCopy } | Should -Throw "Missing an argument for parameter 'TargetObjectId'*"
        }
        It "Should fail when TargetObjectId is invalid" {
            $template = Get-EntraBetaDirectorySettingTemplate | Where-Object {$_.displayname -eq "group.unified.guest"}
            $settingsCopy = $template.CreateDirectorySetting()
            $settingsCopy["AllowToAddGuests"]=$False
            { Set-EntraBetaObjectSetting -TargetType "Groups" -TargetObjectId -Id "dddddddd-7902-4be2-a25b-dddddddddddd" -DirectorySetting $settingsCopy } | Should -Throw "Missing an argument for parameter 'TargetObjectId'*"
        }
        It "Should fail when Id is empty" {
            $template = Get-EntraBetaDirectorySettingTemplate | Where-Object {$_.displayname -eq "group.unified.guest"}
            $settingsCopy = $template.CreateDirectorySetting()
            $settingsCopy["AllowToAddGuests"]=$False
            { Set-EntraBetaObjectSetting -TargetType "Groups" -TargetObjectId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -Id  -DirectorySetting $settingsCopy } | Should -Throw "Missing an argument for parameter 'Id'*"
        }
        It "Should fail when Id is invalid" {
            $template = Get-EntraBetaDirectorySettingTemplate | Where-Object {$_.displayname -eq "group.unified.guest"}
            $settingsCopy = $template.CreateDirectorySetting()
            $settingsCopy["AllowToAddGuests"]=$False
            { Set-EntraBetaObjectSetting -TargetType "Groups" -TargetObjectId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -Id "" -DirectorySetting $settingsCopy } | Should -Throw "Cannot bind argument to parameter 'Id' because it is an empty string*"
        }
        It "Should fail when DirectorySetting is empty" {
            { Set-EntraBetaObjectSetting -TargetType "Groups" -TargetObjectId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -Id "00aa00aa-bb11-cc22-dd33-44ee44ee44ee" -DirectorySetting  } | Should -Throw "Missing an argument for parameter 'DirectorySetting'*"
        }
        It "Should fail when DirectorySetting is invalid" {
            { Set-EntraBetaObjectSetting -TargetType "Groups" -TargetObjectId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -Id "00aa00aa-bb11-cc22-dd33-44ee44ee44ee" -DirectorySetting "" } | Should -Throw "Cannot process argument transformation on parameter 'DirectorySetting*"
        }
        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Set-EntraBetaObjectSetting"
            $template = Get-EntraBetaDirectorySettingTemplate | Where-Object {$_.displayname -eq "group.unified.guest"}
            $settingsCopy = $template.CreateDirectorySetting()
            $settingsCopy["AllowToAddGuests"]=$False

            Set-EntraBetaObjectSetting -TargetType "Groups" -TargetObjectId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -Id "00aa00aa-bb11-cc22-dd33-44ee44ee44ee" -DirectorySetting $settingsCopy 
           

            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Set-EntraBetaObjectSetting"
            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Graph.Entra.Beta -Times 1 -ParameterFilter {
                $Headers.'User-Agent' | Should -Be $userAgentHeaderValue
                $true
            }
        }
        It "Should execute successfully without throwing an error" {
            # Disable confirmation prompts       
            $originalDebugPreference = $DebugPreference
            $DebugPreference = 'Continue'
            $template = Get-EntraBetaDirectorySettingTemplate | Where-Object {$_.displayname -eq "group.unified.guest"}
            $settingsCopy = $template.CreateDirectorySetting()
            $settingsCopy["AllowToAddGuests"]=$False

            try {
                # Act & Assert: Ensure the function doesn't throw an exception
                { Set-EntraBetaObjectSetting -TargetType "Groups" -TargetObjectId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -Id "00aa00aa-bb11-cc22-dd33-44ee44ee44ee" -DirectorySetting $settingsCopy  -Debug } | Should -Not -Throw
            } finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        } 
    }
}    