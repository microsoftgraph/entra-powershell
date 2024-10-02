# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
Describe "The EntraBetaObjectSetting commands executing unmocked" {

    Context "When Changing group settings" {
        BeforeAll {
            $testReportPath = join-path $psscriptroot "..\setenv.ps1"
            . $testReportPath

            $thisTestInstanceId = New-Guid | Select-Object -expandproperty guid
            $testGroupName = 'SimpleTestAppRead' + $thisTestInstanceId
            $global:testGroup = New-EntraBetaGroup -DisplayName $testGroupName -MailEnabled $false -SecurityEnabled $true -MailNickName $testGroupName -Description $testGroupName
        }

        It "Should successfully block guest access" {
            $template = Get-EntraBetaDirectorySettingTemplate | ? {$_.displayname -eq "group.unified.guest"} 
            $settingsCopy = $template.CreateDirectorySetting()
            $settingsCopy["AllowToAddGuests"]=$False

            $groupID= (Get-EntraBetaGroup -ObjectId $testGroup.Id).ObjectId 
            $global:newObjectSetting = New-EntraBetaObjectSetting -TargetType Groups -TargetObjectId $groupID -DirectorySetting $settingsCopy

            $ObjectSettings = Get-EntraBetaObjectSetting -TargetType Groups -TargetObjectId $testGroup.Id
            $ObjectSettings.values.value | Should -be 'False'
        }

        It "Should successfully allow guest access" {
            $template = Get-EntraBetaDirectorySettingTemplate | ? {$_.displayname -eq "group.unified.guest"} 
            $settingsCopy = $template.CreateDirectorySetting()
            $settingsCopy["AllowToAddGuests"]=$True

            $groupID= (Get-EntraBetaGroup -ObjectId $testGroup.Id).ObjectId 
            Set-EntraBetaObjectSetting -TargetType Groups -TargetObjectId $groupID -DirectorySetting $settingsCopy -Id $newObjectSetting.Id

            $ObjectSettings = Get-EntraBetaObjectSetting -TargetType Groups -TargetObjectId $testGroup.Id
            $ObjectSettings.values.value | Should -be 'True'
        }

        AfterAll {
            $groupId = (Get-EntraBetaGroup -ObjectId $testGroup.Id).ObjectId 
            Remove-EntraBetaObjectSetting -TargetType Groups -TargetObjectId $groupId -Id $newObjectSetting.Id
            $ObjectSettings = Get-EntraBetaObjectSetting -TargetType Groups -TargetObjectId $testGroup.Id
            $ObjectSettings | Should -BeNullorEmpty

            Remove-EntraBetaGroup -ObjectId $groupId
        }
    }
}