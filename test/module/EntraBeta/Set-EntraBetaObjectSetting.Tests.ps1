BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra.Beta) -eq $null){
        Import-Module Microsoft.Graph.Entra.Beta       
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force
    
    Mock -CommandName Invoke-GraphRequest -MockWith {} -ModuleName Microsoft.Graph.Entra.Beta
}
Describe "Set-EntraBetaObjectSetting" {
Context "Test for Set-EntraBetaObjectSetting" {
        It "Should return empty object" {
            $template = Get-EntraBetaDirectorySettingTemplate | ? {$_.displayname -eq "group.unified.guest"}
            $settingsCopy = $template.CreateDirectorySetting()
            $settingsCopy["AllowToAddGuests"]=$False

            $result = Set-EntraBetaObjectSetting -TargetType "Groups" -TargetObjectId "aaaaaaaa-5a8c-4f5a-a368-cccccccccccc" -Id "dddddddd-7902-4be2-a25b-dddddddddddd" -DirectorySetting $settingsCopy 
            $result | Should -BeNullOrEmpty

            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }
        It "Should fail when TargetType is empty" {
            { $result = Set-EntraBetaObjectSetting -TargetType  -TargetObjectId "aaaaaaaa-5a8c-4f5a-a368-cccccccccccc" -Id "dddddddd-7902-4be2-a25b-dddddddddddd" -DirectorySetting $settingsCopy } | Should -Throw "Missing an argument for parameter 'TargetType'*"
        }
        It "Should fail when TargetType is invalid" {
            { $result = Set-EntraBetaObjectSetting -TargetType  -TargetObjectId "aaaaaaaa-5a8c-4f5a-a368-cccccccccccc" -Id "dddddddd-7902-4be2-a25b-dddddddddddd" -DirectorySetting $settingsCopy } | Should -Throw "Missing an argument for parameter 'TargetType'*"
        }
        It "Should fail when TargetObjectId is empty" {
            { $result = Set-EntraBetaObjectSetting -TargetType "Groups" -TargetObjectId -Id "dddddddd-7902-4be2-a25b-dddddddddddd" -DirectorySetting $settingsCopy } | Should -Throw "Missing an argument for parameter 'TargetObjectId'*"
        }
        It "Should fail when TargetObjectId is invalid" {
            { $result = Set-EntraBetaObjectSetting -TargetType "Groups" -TargetObjectId -Id "dddddddd-7902-4be2-a25b-dddddddddddd" -DirectorySetting $settingsCopy } | Should -Throw "Missing an argument for parameter 'TargetObjectId'*"
        }
        It "Should fail when Id is empty" {
            { $result = Set-EntraBetaObjectSetting -TargetType "Groups" -TargetObjectId "aaaaaaaa-5a8c-4f5a-a368-cccccccccccc" -Id  -DirectorySetting $settingsCopy } | Should -Throw "Missing an argument for parameter 'Id'*"
        }
        It "Should fail when Id is invalid" {
            { $result = Set-EntraBetaObjectSetting -TargetType "Groups" -TargetObjectId "aaaaaaaa-5a8c-4f5a-a368-cccccccccccc" -Id "" -DirectorySetting $settingsCopy } | Should -Throw "Cannot bind argument to parameter 'Id' because it is an empty string*"
        }
        It "Should fail when DirectorySetting is empty" {
            { $result = Set-EntraBetaObjectSetting -TargetType "Groups" -TargetObjectId "aaaaaaaa-5a8c-4f5a-a368-cccccccccccc" -Id "dddddddd-7902-4be2-a25b-dddddddddddd" -DirectorySetting  } | Should -Throw "Missing an argument for parameter 'DirectorySetting'*"
        }
        It "Should fail when DirectorySetting is invalid" {
            { $result = Set-EntraBetaObjectSetting -TargetType "Groups" -TargetObjectId "aaaaaaaa-5a8c-4f5a-a368-cccccccccccc" -Id "dddddddd-7902-4be2-a25b-dddddddddddd" -DirectorySetting "" } | Should -Throw "Cannot process argument transformation on parameter 'DirectorySetting*"
        }
        It "Should contain 'User-Agent' header" {
            Mock -CommandName Invoke-GraphRequest -MockWith {$args} -ModuleName Microsoft.Graph.Entra.Beta

            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Set-EntraBetaObjectSetting"

            $template = Get-EntraBetaDirectorySettingTemplate | ? {$_.displayname -eq "group.unified.guest"}
            $settingsCopy = $template.CreateDirectorySetting()
            $settingsCopy["AllowToAddGuests"]=$False

            $result = Set-EntraBetaObjectSetting -TargetType "Groups" -TargetObjectId "aaaaaaaa-5a8c-4f5a-a368-cccccccccccc" -Id "dddddddd-7902-4be2-a25b-dddddddddddd" -DirectorySetting $settingsCopy 
            $params = Get-Parameters -data $result
            $para = $params | ConvertTo-json | ConvertFrom-json
            $para.Headers."User-Agent" | Should -Be $userAgentHeaderValue
        }
    }
}    