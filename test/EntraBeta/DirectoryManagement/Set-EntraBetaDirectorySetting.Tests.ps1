# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

BeforeAll {  
    if((Get-Module -Name Microsoft.Entra.Beta.DirectoryManagement) -eq $null){
        Import-Module Microsoft.Entra.Beta.DirectoryManagement    
    }
    Import-Module (Join-Path $PSScriptRoot "..\..\Common-Functions.ps1") -Force

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

    Mock -CommandName Get-MgBetaDirectorySettingTemplate -MockWith $scriptblock -ModuleName Microsoft.Entra.Beta.DirectoryManagement

    Mock -CommandName Update-MgBetaDirectorySetting -MockWith {} -ModuleName Microsoft.Entra.Beta.DirectoryManagement

    Mock -CommandName Get-EntraContext -MockWith { @{
        Environment = @{ Name = "Global" }
        Scopes      = @('Directory.ReadWrite.All', 'Policy.ReadWrite.Authorization')
    }} -ModuleName Microsoft.Entra.Beta.DirectoryManagement
}

Describe "Set-EntraBetaDirectorySetting" {
    Context "Test for Set-EntraBetaDirectorySetting" {
        It "Should updates a directory setting in Azure Active Directory (AD)" {
            $template = Get-EntraBetaDirectorySettingTemplate -Id "aaaabbbb-0000-cccc-1111-dddd2222eeee"
            $settingsCopy = $template.CreateDirectorySetting()
            $settingsCopy["EnableBannedPasswordCheckOnPremises"] = "False"
            $result = Set-EntraBetaDirectorySetting -Id "bbbbcccc-1111-dddd-2222-eeee3333ffff" -DirectorySetting $settingsCopy 
            $result | Should -BeNullOrEmpty

            Should -Invoke -CommandName Update-MgBetaDirectorySetting -ModuleName Microsoft.Entra.Beta.DirectoryManagement -Times 1
        }

        It "Should fail when Id is empty" {
            {   $template = Get-EntraBetaDirectorySettingTemplate -Id "aaaabbbb-0000-cccc-1111-dddd2222eeee"
                $settingsCopy = $template.CreateDirectorySetting()
                $settingsCopy["EnableBannedPasswordCheckOnPremises"] = "False"
                Set-EntraBetaDirectorySetting -Id  -DirectorySetting $settingsCopy } | Should -Throw "Missing an argument for parameter 'Id'*"
        } 

        It "Should fail when Id is invalid" {
            {   $template = Get-EntraBetaDirectorySettingTemplate -Id "aaaabbbb-0000-cccc-1111-dddd2222eeee"
                $settingsCopy = $template.CreateDirectorySetting()
                $settingsCopy["EnableBannedPasswordCheckOnPremises"] = "False"
                Set-EntraBetaDirectorySetting -Id "" -DirectorySetting $settingsCopy } | Should -Throw "Cannot bind argument to parameter 'Id' because it is an empty string.*"
        } 

        It "Should fail when DirectorySetting is empty" {
            {   $template = Get-EntraBetaDirectorySettingTemplate -Id "aaaabbbb-0000-cccc-1111-dddd2222eeee"
                $settingsCopy = $template.CreateDirectorySetting()
                $settingsCopy["EnableBannedPasswordCheckOnPremises"] = "False"
                Set-EntraBetaDirectorySetting -Id "bbbbcccc-1111-dddd-2222-eeee3333ffff" -DirectorySetting  } | Should -Throw "Missing an argument for parameter 'DirectorySetting'*"
        } 

        It "Should fail when DirectorySetting is invalid" {
            { Set-EntraBetaDirectorySetting -Id "bbbbcccc-1111-dddd-2222-eeee3333ffff" -DirectorySetting "" } | Should -Throw "Cannot process argument transformation on parameter 'DirectorySetting'.*"
        } 

        It "Should contain BodyParameter in parameters when passed DirectorySetting to it" {
            Mock -CommandName Update-MgBetaDirectorySetting -MockWith {$args} -ModuleName Microsoft.Entra.Beta.DirectoryManagement

            $template = Get-EntraBetaDirectorySettingTemplate -Id "aaaabbbb-0000-cccc-1111-dddd2222eeee"
            $settingsCopy = $template.CreateDirectorySetting()
            $settingsCopy["EnableBannedPasswordCheckOnPremises"] = "False"
            $result = Set-EntraBetaDirectorySetting -Id "bbbbcccc-1111-dddd-2222-eeee3333ffff" -DirectorySetting $settingsCopy 
            $params = Get-Parameters -data $result
            $params.BodyParameter | Should -Not -BeNullOrEmpty
        }        
        
        It "Should contain DirectorySettingId in parameters when passed Id to it" {
            Mock -CommandName Update-MgBetaDirectorySetting -MockWith {$args} -ModuleName Microsoft.Entra.Beta.DirectoryManagement

            $template = Get-EntraBetaDirectorySettingTemplate -Id "aaaabbbb-0000-cccc-1111-dddd2222eeee"
            $settingsCopy = $template.CreateDirectorySetting()
            $settingsCopy["EnableBannedPasswordCheckOnPremises"] = "False"
            $result = Set-EntraBetaDirectorySetting -Id "bbbbcccc-1111-dddd-2222-eeee3333ffff" -DirectorySetting $settingsCopy 
            $params = Get-Parameters -data $result
            $params.DirectorySettingId | Should -Be "bbbbcccc-1111-dddd-2222-eeee3333ffff"
        }        

        It "Should contain 'User-Agent' header" {
            Mock -CommandName Update-MgBetaDirectorySetting -MockWith {$args} -ModuleName Microsoft.Entra.Beta.DirectoryManagement
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Set-EntraBetaDirectorySetting"
            $template = Get-EntraBetaDirectorySettingTemplate -Id "aaaabbbb-0000-cccc-1111-dddd2222eeee"
            $settingsCopy = $template.CreateDirectorySetting()
            $settingsCopy["EnableBannedPasswordCheckOnPremises"] = "False"
            Set-EntraBetaDirectorySetting -Id "bbbbcccc-1111-dddd-2222-eeee3333ffff" -DirectorySetting $settingsCopy
 
            Should -Invoke -CommandName Update-MgBetaDirectorySetting -ModuleName Microsoft.Entra.Beta.DirectoryManagement -Times 1 -ParameterFilter {
                $Headers.'User-Agent' | Should -Be $userAgentHeaderValue
                $true
            }
        }

        It "Should execute successfully without throwing an error " {
            $template = Get-EntraBetaDirectorySettingTemplate -Id "aaaabbbb-0000-cccc-1111-dddd2222eeee"
            $settingsCopy = $template.CreateDirectorySetting()
            $settingsCopy["EnableBannedPasswordCheckOnPremises"] = "False"
            # Disable confirmation prompts       
            $originalDebugPreference = $DebugPreference
            $DebugPreference = 'Continue'
    
            try {
                # Act & Assert: Ensure the function doesn't throw an exception
                { Set-EntraBetaDirectorySetting -Id "bbbbcccc-1111-dddd-2222-eeee3333ffff" -DirectorySetting $settingsCopy -Debug } | Should -Not -Throw
            } finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        } 
    }
}

