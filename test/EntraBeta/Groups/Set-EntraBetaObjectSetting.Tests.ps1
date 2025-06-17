# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
BeforeAll {  
    if ((Get-Module -Name Microsoft.Entra.Beta.Groups) -eq $null) {
        Import-Module Microsoft.Entra.Beta.Groups       
    }
    if ((Get-Module -Name Microsoft.Entra.Beta.DirectoryManagement) -eq $null) {
        Import-Module Microsoft.Entra.Beta.DirectoryManagement       
    }
    Import-Module (Join-Path $PSScriptRoot "..\..\Common-Functions.ps1") -Force

    $TemplateScriptblock = {
        return @(
            [PSCustomObject]@{
                "DisplayName" = "Group.Unified.Guest"
                "Id"          = "bbbbbbbb-1111-2222-3333-cccccccccc55"
                "Description" = "Settings for a specific Unified Group"
                "Parameters"  = $args
                "Values"      = @(
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
    Mock -CommandName Get-MgBetaDirectorySettingTemplate -MockWith $TemplateScriptblock -ModuleName Microsoft.Entra.Beta.DirectoryManagement
    Mock -CommandName Invoke-GraphRequest -MockWith {} -ModuleName Microsoft.Entra.Beta.Groups
    Mock -CommandName Get-EntraContext -MockWith { @{Scopes = @("Directory.ReadWrite.All") } } -ModuleName Microsoft.Entra.Beta.Groups
}
Describe "Set-EntraBetaObjectSetting" {
    Context "Test for Set-EntraBetaObjectSetting" {
        It "Should return empty object" {
            $template = Get-EntraBetaDirectorySettingTemplate | Where-Object { $_.displayname -eq "group.unified.guest" }
            $settingsCopy = $template.CreateDirectorySetting()
            $settingsCopy["AllowToAddGuests"] = $False

            $result = Set-EntraBetaObjectSetting -TargetType "Groups" -TargetObjectId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -Id "aaaaaaaa-1111-2222-3333-cccccccccccc" -DirectorySetting $settingsCopy 
            $result | Should -BeNullOrEmpty

            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.Beta.Groups -Times 1
        }
        It "Should fail when TargetType is empty" {
            $template = Get-EntraBetaDirectorySettingTemplate | Where-Object { $_.displayname -eq "group.unified.guest" }
            $settingsCopy = $template.CreateDirectorySetting()
            $settingsCopy["AllowToAddGuests"] = $False
            { Set-EntraBetaObjectSetting -TargetType -TargetObjectId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -Id "aaaaaaaa-1111-2222-3333-cccccccccccc" -DirectorySetting $settingsCopy } | Should -Throw "Missing an argument for parameter 'TargetType'*"
        }
        It "Should fail when TargetType is invalid" {
            $template = Get-EntraBetaDirectorySettingTemplate | Where-Object { $_.displayname -eq "group.unified.guest" }
            $settingsCopy = $template.CreateDirectorySetting()
            $settingsCopy["AllowToAddGuests"] = $False
            { Set-EntraBetaObjectSetting -TargetType -TargetObjectId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -Id "aaaaaaaa-1111-2222-3333-cccccccccccc" -DirectorySetting $settingsCopy } | Should -Throw "Missing an argument for parameter 'TargetType'*"
        }
        It "Should fail when TargetObjectId is empty" {
            $template = Get-EntraBetaDirectorySettingTemplate | Where-Object { $_.displayname -eq "group.unified.guest" }
            $settingsCopy = $template.CreateDirectorySetting()
            $settingsCopy["AllowToAddGuests"] = $False
            { Set-EntraBetaObjectSetting -TargetType "Groups" -TargetObjectId -Id "dddddddd-7902-4be2-a25b-dddddddddddd" -DirectorySetting $settingsCopy } | Should -Throw "Missing an argument for parameter 'TargetObjectId'*"
        }
        It "Should fail when TargetObjectId is invalid" {
            $template = Get-EntraBetaDirectorySettingTemplate | Where-Object { $_.displayname -eq "group.unified.guest" }
            $settingsCopy = $template.CreateDirectorySetting()
            $settingsCopy["AllowToAddGuests"] = $False
            { Set-EntraBetaObjectSetting -TargetType "Groups" -TargetObjectId -Id "dddddddd-7902-4be2-a25b-dddddddddddd" -DirectorySetting $settingsCopy } | Should -Throw "Missing an argument for parameter 'TargetObjectId'*"
        }
        It "Should fail when Id is empty" {
            $template = Get-EntraBetaDirectorySettingTemplate | Where-Object { $_.displayname -eq "group.unified.guest" }
            $settingsCopy = $template.CreateDirectorySetting()
            $settingsCopy["AllowToAddGuests"] = $False
            { Set-EntraBetaObjectSetting -TargetType "Groups" -TargetObjectId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -Id -DirectorySetting $settingsCopy } | Should -Throw "Missing an argument for parameter 'Id'*"
        }

        It "Should fail when DirectorySetting is empty" {
            { Set-EntraBetaObjectSetting -TargetType "Groups" -TargetObjectId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -Id "aaaaaaaa-1111-2222-3333-cccccccccccc" -DirectorySetting } | Should -Throw "Missing an argument for parameter 'DirectorySetting'*"
        }

        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Set-EntraBetaObjectSetting"
            $template = Get-EntraBetaDirectorySettingTemplate | Where-Object { $_.displayname -eq "group.unified.guest" }
            $settingsCopy = $template.CreateDirectorySetting()
            $settingsCopy["AllowToAddGuests"] = $False

            Set-EntraBetaObjectSetting -TargetType "Groups" -TargetObjectId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -Id "aaaaaaaa-1111-2222-3333-cccccccccccc" -DirectorySetting $settingsCopy 
           

            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Set-EntraBetaObjectSetting"
            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.Beta.Groups -Times 1 -ParameterFilter {
                $Headers.'User-Agent' | Should -Be $userAgentHeaderValue
                $true
            }
        }
        It "Should execute successfully without throwing an error" {
            # Disable confirmation prompts       
            $originalDebugPreference = $DebugPreference
            $DebugPreference = 'Continue'
            $template = Get-EntraBetaDirectorySettingTemplate | Where-Object { $_.displayname -eq "group.unified.guest" }
            $settingsCopy = $template.CreateDirectorySetting()
            $settingsCopy["AllowToAddGuests"] = $False

            try {
                # Act & Assert: Ensure the function doesn't throw an exception
                { Set-EntraBetaObjectSetting -TargetType "Groups" -TargetObjectId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -Id "aaaaaaaa-1111-2222-3333-cccccccccccc" -DirectorySetting $settingsCopy -Debug } | Should -Not -Throw
            }
            finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        } 
    }
}    

