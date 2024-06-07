BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra.Beta) -eq $null){
        Import-Module Microsoft.Graph.Entra.Beta       
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force
    
    Mock -CommandName Invoke-GraphRequest -MockWith {} -ModuleName Microsoft.Graph.Entra.Beta
}
Describe "Remove-EntraBetaObjectSetting" {
Context "Test for Remove-EntraBetaObjectSetting" {
        It "Should return empty object" {
            $result = Remove-EntraBetaObjectSetting -TargetType "Groups" -TargetObjectId "aaaaaaaa-5a8c-4f5a-a368-cccccccccccc" -Id "dddddddd-7902-4be2-a25b-dddddddddddd" 
            $result | Should -BeNullOrEmpty

            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }
        It "Should fail when TargetType is empty" {
            { $result = Remove-EntraBetaObjectSetting -TargetType  -TargetObjectId "aaaaaaaa-5a8c-4f5a-a368-cccccccccccc" -Id "dddddddd-7902-4be2-a25b-dddddddddddd" } | Should -Throw "Missing an argument for parameter 'TargetType'*"
        }
        It "Should fail when TargetType is invalid" {
            { $result = Remove-EntraBetaObjectSetting -TargetType  -TargetObjectId "aaaaaaaa-5a8c-4f5a-a368-cccccccccccc" -Id "dddddddd-7902-4be2-a25b-dddddddddddd" } | Should -Throw "Missing an argument for parameter 'TargetType'*"
        }
        It "Should fail when TargetObjectId is empty" {
            { $result = Remove-EntraBetaObjectSetting -TargetType "Groups" -TargetObjectId -Id "dddddddd-7902-4be2-a25b-dddddddddddd" } | Should -Throw "Missing an argument for parameter 'TargetObjectId'*"
        }
        It "Should fail when TargetObjectId is invalid" {
            { $result = Remove-EntraBetaObjectSetting -TargetType "Groups" -TargetObjectId -Id "dddddddd-7902-4be2-a25b-dddddddddddd" } | Should -Throw "Missing an argument for parameter 'TargetObjectId'*"
        }
        It "Should fail when Id is empty" {
            { $result = Remove-EntraBetaObjectSetting -TargetType "Groups" -TargetObjectId "aaaaaaaa-5a8c-4f5a-a368-cccccccccccc" -Id } | Should -Throw "Missing an argument for parameter 'Id'*"
        }
        It "Should fail when Id is invalid" {
            { $result = Remove-EntraBetaObjectSetting -TargetType "Groups" -TargetObjectId "aaaaaaaa-5a8c-4f5a-a368-cccccccccccc" -Id "" } | Should -Throw "Cannot bind argument to parameter 'Id' because it is an empty string*"
        }
        It "Should contain 'User-Agent' header" {
            Mock -CommandName Invoke-GraphRequest -MockWith {$args} -ModuleName Microsoft.Graph.Entra.Beta

            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Remove-EntraBetaObjectSetting"

            $template = Get-EntraBetaDirectorySettingTemplate | ? {$_.displayname -eq "group.unified.guest"}
            $settingsCopy = $template.CreateDirectorySetting()
            $settingsCopy["AllowToAddGuests"]=$False

            $result = Remove-EntraBetaObjectSetting -TargetType "Groups" -TargetObjectId "aaaaaaaa-5a8c-4f5a-a368-cccccccccccc" -Id "dddddddd-7902-4be2-a25b-dddddddddddd" 
            $params = Get-Parameters -data $result
            $para = $params | ConvertTo-json | ConvertFrom-json
            $para.Headers."User-Agent" | Should -Be $userAgentHeaderValue
        }
    }
}    