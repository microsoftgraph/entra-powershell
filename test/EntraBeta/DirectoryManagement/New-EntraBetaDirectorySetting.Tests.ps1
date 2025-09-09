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
                "DisplayName"            = "Password Rule Settings"
                "Id"                     = "bbbbbbbb-1111-2222-3333-cccccccccc55"
                "TemplateId"             = "bbbbbbbb-1111-2222-3333-cccccccccc56"
                "Values"                 = [PSCustomObject]@{
                                            "BannedPasswordCheckOnPremisesMode" = "Audit"
                                            "EnableBannedPasswordCheckOnPremises" = $true
                                            "EnableBannedPasswordCheck" = $true
                                            "LockoutDurationInSeconds" = 60
                                            "LockoutThreshold" = 10
                                            "BannedPasswordList" = $null 
                                           }
                "AdditionalProperties"   = [PSCustomObject]@{
                                            "@odata.context" = 'https://graph.microsoft.com/beta/`$metadata#settings/`$entity'
                                           }
                "Parameters"             = $args
            }
        )
    }    

    $scriptblock1 = {
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

    Mock -CommandName Get-MgBetaDirectorySettingTemplate -MockWith $scriptblock1 -ModuleName Microsoft.Entra.Beta.DirectoryManagement

    Mock -CommandName New-MgBetaDirectorySetting -MockWith $scriptblock -ModuleName Microsoft.Entra.Beta.DirectoryManagement

    Mock -CommandName Get-EntraContext -MockWith { @{
        Environment = @{ Name = "Global" }
        Scopes      = @('Directory.ReadWrite.All', 'Group.Read.All' , 'Group.ReadWrite.All')
    }} -ModuleName Microsoft.Entra.Beta.DirectoryManagement
}

Describe "New-EntraBetaDirectorySetting" {
    Context "Test for New-EntraBetaDirectorySetting" {
        It "Should throw when not connected and not invoke SDK" {
            $template = Get-EntraBetaDirectorySettingTemplate -Id "bbbbbbbb-1111-2222-3333-cccccccccc56"
            $settingsCopy = $template.CreateDirectorySetting()
            Mock -CommandName Get-EntraContext -MockWith { $null } -ModuleName Microsoft.Entra.Beta.DirectoryManagement
            { New-EntraBetaDirectorySetting -DirectorySetting $settingsCopy } | Should -Throw "Not connected to Microsoft Graph*"
            Should -Invoke -CommandName New-MgBetaDirectorySetting -ModuleName Microsoft.Entra.Beta.DirectoryManagement -Times 0
        }

        It "Should creates a directory settings object in Azure Active Directory (AD)" {
            $template = Get-EntraBetaDirectorySettingTemplate -Id "bbbbbbbb-1111-2222-3333-cccccccccc56"
            $settingsCopy = $template.CreateDirectorySetting()
            $result = New-EntraBetaDirectorySetting -DirectorySetting $settingsCopy
            $result | Should -Not -BeNullOrEmpty
            $result.DisplayName | should -Be "Password Rule Settings"
            $result.TemplateId | should -Be "bbbbbbbb-1111-2222-3333-cccccccccc56"
            $result.Id | should -Be "bbbbbbbb-1111-2222-3333-cccccccccc55"

            Should -Invoke -CommandName New-MgBetaDirectorySetting -ModuleName Microsoft.Entra.Beta.DirectoryManagement -Times 1
        }

        It "Should fail when DirectorySetting is empty" {
            { New-EntraBetaDirectorySetting -DirectorySetting  } | Should -Throw "Missing an argument for parameter 'DirectorySetting'*"
        }
    
        It "Should fail when DirectorySetting is Invalid" {
            {
                $template = Get-EntraBetaDirectorySettingTemplate -Id "bbbbbbbb-1111-2222-3333-cccccccccc56"
                $settingsCopy = $template
                New-EntraBetaDirectorySetting -DirectorySetting $settingsCopy } | Should -Throw "Cannot process argument transformation on parameter 'DirectorySetting'*"
        }
        
        It "Should contain BodyParameter in parameters when passed DirectorySetting to it" {
            $template = Get-EntraBetaDirectorySettingTemplate -Id "bbbbbbbb-1111-2222-3333-cccccccccc56"
            $settingsCopy = $template.CreateDirectorySetting()
            $result = New-EntraBetaDirectorySetting -DirectorySetting $settingsCopy
            $params = Get-Parameters -data $result.Parameters
            $params.BodyParameter | Should -Not -BeNullOrEmpty
        }
        
        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion New-EntraBetaDirectorySetting"
            $template = Get-EntraBetaDirectorySettingTemplate -Id "bbbbbbbb-1111-2222-3333-cccccccccc56"
            $settingsCopy = $template.CreateDirectorySetting()
            New-EntraBetaDirectorySetting -DirectorySetting $settingsCopy
 
            Should -Invoke -CommandName New-MgBetaDirectorySetting -ModuleName Microsoft.Entra.Beta.DirectoryManagement -Times 1 -ParameterFilter {
                $Headers.'User-Agent' | Should -Be $userAgentHeaderValue
                $true
            }
        }

        It "Should execute successfully without throwing an error " {
            $template = Get-EntraBetaDirectorySettingTemplate -Id "bbbbbbbb-1111-2222-3333-cccccccccc56"
            $settingsCopy = $template.CreateDirectorySetting()

            # Disable confirmation prompts       
            $originalDebugPreference = $DebugPreference
            $DebugPreference = 'Continue'
    
            try {
                # Act & Assert: Ensure the function doesn't throw an exception
                { New-EntraBetaDirectorySetting -DirectorySetting $settingsCopy -Debug } | Should -Not -Throw
            } finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        }
    }
}

