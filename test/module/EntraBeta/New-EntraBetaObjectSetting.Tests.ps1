BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra.Beta) -eq $null){
        Import-Module Microsoft.Graph.Entra.Beta       
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force
    
    $scriptblock = {
        return @(
            [PSCustomObject]@{
              "Id"                           = "dddddddd-7902-4be2-a25b-dddddddddddd"
              "templateId"                   = "dddddddd-1111-2222-3333-aaaaaaaaaaaa"
              "@odata.context"               = "https://graph.microsoft.com/beta/$metadata#settings/$entity"
              "displayName"                  = $null
              "values"                       = @{
                                                    "name"  = "AllowToAddGuests"
                                                    "value" = $False
                                                }
              "Parameters"                   = $args
            }
        )
    }

    Mock -CommandName Invoke-GraphRequest -MockWith $scriptblock -ModuleName Microsoft.Graph.Entra.Beta
}
Describe "New-EntraBetaObjectSetting" {
Context "Test for New-EntraBetaObjectSetting" {
        It "Should return created object setting" {
            $template = Get-EntraBetaDirectorySettingTemplate | ? {$_.displayname -eq "group.unified.guest"}
            $settingsCopy = $template.CreateDirectorySetting()
            $settingsCopy["AllowToAddGuests"]=$False

            $result = New-EntraBetaObjectSetting -TargetType "Groups" -TargetObjectId "aaaaaaaa-5a8c-4f5a-a368-cccccccccccc" -DirectorySetting $settingsCopy 
            $result | Should -Not -BeNullOrEmpty
            $result.Id | Should -Be "dddddddd-7902-4be2-a25b-dddddddddddd"
            $result.templateId | Should -be "dddddddd-1111-2222-3333-aaaaaaaaaaaa"

            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }
        It "Should fail when TargetType is empty" {
            { $result = New-EntraBetaObjectSetting -TargetType  -TargetObjectId "aaaaaaaa-5a8c-4f5a-a368-cccccccccccc" -DirectorySetting $settingsCopy } | Should -Throw "Missing an argument for parameter 'TargetType'*"
        }
        It "Should fail when TargetType is invalid" {
            { $result = New-EntraBetaObjectSetting -TargetType  -TargetObjectId "aaaaaaaa-5a8c-4f5a-a368-cccccccccccc" -DirectorySetting $settingsCopy } | Should -Throw "Missing an argument for parameter 'TargetType'*"
        }
        It "Should fail when TargetObjectId is empty" {
            { $result = New-EntraBetaObjectSetting -TargetType "Groups" -TargetObjectId  -DirectorySetting $settingsCopy } | Should -Throw "Missing an argument for parameter 'TargetObjectId'*"
        }
        It "Should fail when TargetObjectId is invalid" {
            { $result = New-EntraBetaObjectSetting -TargetType "Groups" -TargetObjectId  -DirectorySetting $settingsCopy } | Should -Throw "Missing an argument for parameter 'TargetObjectId'*"
        }
        It "Should fail when DirectorySetting is empty" {
            { $result = New-EntraBetaObjectSetting -TargetType "Groups" -TargetObjectId "aaaaaaaa-5a8c-4f5a-a368-cccccccccccc"  -DirectorySetting  } | Should -Throw "Missing an argument for parameter 'DirectorySetting'*"
        }
        It "Should fail when DirectorySetting is invalid" {
            { $result = New-EntraBetaObjectSetting -TargetType "Groups" -TargetObjectId "aaaaaaaa-5a8c-4f5a-a368-cccccccccccc" -DirectorySetting "" } | Should -Throw "Cannot process argument transformation on parameter 'DirectorySetting*"
        }
        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion New-EntraBetaObjectSetting"

            $template = Get-EntraBetaDirectorySettingTemplate | ? {$_.displayname -eq "group.unified.guest"}
            $settingsCopy = $template.CreateDirectorySetting()
            $settingsCopy["AllowToAddGuests"]=$False

            $result = New-EntraBetaObjectSetting -TargetType "Groups" -TargetObjectId "aaaaaaaa-5a8c-4f5a-a368-cccccccccccc" -DirectorySetting $settingsCopy 
            $params = Get-Parameters -data $result.Parameters
            $para = $params | ConvertTo-json | ConvertFrom-json
            $para.Headers."User-Agent" | Should -Be $userAgentHeaderValue
        }
    }
}    