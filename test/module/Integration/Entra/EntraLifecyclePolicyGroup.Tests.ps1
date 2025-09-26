# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
Describe "The EntraLifecyclePolicyGroup command executing unmocked" {

    Context "When getting LifecyclePolicyGroup" {
        BeforeAll {
            $testReportPath = join-path $psscriptroot "..\setenv.ps1"
            . $testReportPath

            $thisTestInstanceId = New-Guid | Select-Object -ExpandProperty Guid
            $global:displayName = 'Demo Help Group' + $thisTestInstanceId
            $testNickname = "test" + $thisTestInstanceId
            $global:newMSGroup = New-EntraGroup -DisplayName $displayName -MailEnabled $false -MailNickname $testNickname -SecurityEnabled $true -GroupTypes "unified"
            Start-Sleep -Seconds 10
        }

        It "should successfully get a specific group by using an group Id" {
            $group = Get-EntraGroup -ObjectId $newMSGroup.Id
            $group.ObjectId | Should -Be $newMSGroup.Id
            $group.DisplayName | Should -Be $displayName
        }

        It "should successfully update a group display name" {
            $updatedDisplayName = "Update Help Group Name"
            Set-EntraGroup -Id $newMSGroup.Id -DisplayName $updatedDisplayName
            $result = Get-EntraGroup -ObjectId $newMSGroup.Id
            $result.Id | Should -Contain $newMSGroup.Id
        }

        It "should successfully Create a lifecycle policy" {
            try {
                $existingPolicy = Get-EntraGroupLifecyclePolicy
                Remove-EntraGroupLifecyclePolicy -Id $existingPolicy.Id
            }
            catch {}
            $global:testGroupPolicy = New-EntraGroupLifecyclePolicy -GroupLifetimeInDays 99 -ManagedGroupTypes "Selected" -AlternateNotificationEmails "example@contoso.un"
        }

        It "should successfully retrieve properties of an groupLifecyclePolicy" {
            $groupLifecyclePolicy = Get-EntraGroupLifecyclePolicy -Id $testGroupPolicy.Id

            $groupLifecyclePolicy.Id | Should -Be $testGroupPolicy.Id
            $groupLifecyclePolicy.GroupLifetimeInDays | Should -Be 99
            $groupLifecyclePolicy.ManagedGroupTypes | Should -Contain "Selected"
            $groupLifecyclePolicy.AlternateNotificationEmails | Should -Contain "example@contoso.un"
        }

        It "should successfully update groupLifecyclePolicy" {
            $alternateNotificationEmails = "admingroup@contoso.en"
            $global:updatedGroupLifecyclePolicy = Set-EntraGroupLifecyclePolicy -Id $testGroupPolicy.Id -GroupLifetimeInDays 200 -AlternateNotificationEmails $alternateNotificationEmails -ManagedGroupTypes "Selected"

            $updatedGroupLifecyclePolicy.Id | Should -Be $testGroupPolicy.Id
            $updatedGroupLifecyclePolicy.GroupLifetimeInDays | Should -Be 200
            $updatedGroupLifecyclePolicy.ManagedGroupTypes | Should -Contain "Selected"
            $updatedGroupLifecyclePolicy.AlternateNotificationEmails | Should -Contain $alternateNotificationEmails
        }

        It "should successfully associate the group with the lifecycle policy" {
            $testLifePolicyGroup = Add-EntraLifecyclePolicyGroup -Id $testGroupPolicy.Id -GroupId $newMSGroup.Id
            $testLifePolicyGroup.ObjectId | Should -BeNullOrEmpty
        }

        It "should successfully retrieve details of a LifecyclePolicyGroup" {
            $global:lifecyclePolicyGroup = Get-EntraLifecyclePolicyGroup -Id $newMSGroup.Id
            $lifecyclePolicyGroup.ObjectId | Should -Be $testGroupPolicy.Id
            $lifecyclePolicyGroup.GroupLifetimeInDays | Should -Be 200
            $lifecyclePolicyGroup.ManagedGroupTypes | Should -Contain "Selected"
            $lifecyclePolicyGroup.AlternateNotificationEmails | Should -Contain $updatedGroupLifecyclePolicy.AlternateNotificationEmails
        }

        AfterAll {
            if ($lifecyclePolicyGroup) {
                Remove-EntraLifecyclePolicyGroup -Id $lifecyclePolicyGroup.Id -GroupId $newMSGroup.Id | Out-Null
            }
            if ($updatedGroupLifecyclePolicy) {
                Remove-EntraGroupLifecyclePolicy -Id $updatedGroupLifecyclePolicy.Id | Out-Null
            }
            if ($newMSGroup) {
                Remove-EntraGroup -ObjectId $newMSGroup.Id | Out-Null
            }
        }
    }
}
