Describe "The EntraMSLifecyclePolicyGroup command executing unmocked" {

    Context "When getting LifecyclePolicyGroup" {
        BeforeAll {
            $testReportPath = Join-Path $PSScriptRoot "\setenv.ps1"
            Import-Module -Name $testReportPath

            $appId = $env:TEST_APPID
            $tenantId = $env:TEST_TENANTID
            $cert = $env:CERTIFICATETHUMBPRINT

            if (-not $appId -or -not $tenantId -or -not $cert) {
                throw "Required environment variables are not set."
            }

            Connect-Entra -TenantId $tenantId -AppId $appId -CertificateThumbprint $cert

            $thisTestInstanceId = New-Guid | Select-Object -ExpandProperty Guid
            $global:displayName = 'Demo Help Group' + $thisTestInstanceId
            $testNickname = "testhelpDeskAdminGroup"
            $global:newMSGroup = New-EntraMSGroup -DisplayName $displayName -MailEnabled $false -MailNickname $testNickname -SecurityEnabled $true -GroupTypes "unified"
            Start-Sleep -Seconds 10
        }

        It "should successfully get a specific group by using an group Id" {
            $group = Get-EntraMSGroup -Id $newMSGroup.Id
            $group.ObjectId | Should -Be $newMSGroup.Id
            $group.DisplayName | Should -Be $displayName
        }

        It "should successfully update a group display name" {
            $updatedDisplayName = "Update Help Group Name"
            Set-EntraMSGroup -Id $newMSGroup.Id -DisplayName $updatedDisplayName
            $result = Get-EntraGroup -ObjectId $newMSGroup.Id
            $result.Id | Should -Contain $newMSGroup.Id
        }

        It "should successfully Create a lifecycle policy" {
            $global:testGroupPolicy = New-EntraMSGroupLifecyclePolicy -GroupLifetimeInDays 99 -ManagedGroupTypes "Selected" -AlternateNotificationEmails "example@contoso.un"
        }

        It "should successfully retrieve properties of an groupLifecyclePolicy" {
            $groupLifecyclePolicy = Get-EntraMSGroupLifecyclePolicy -Id $testGroupPolicy.Id

            $groupLifecyclePolicy.Id | Should -Be $testGroupPolicy.Id
            $groupLifecyclePolicy.GroupLifetimeInDays | Should -Be 99
            $groupLifecyclePolicy.ManagedGroupTypes | Should -Contain "Selected"
            $groupLifecyclePolicy.AlternateNotificationEmails | Should -Contain "example@contoso.un"
        }

        It "should successfully update groupLifecyclePolicy" {
            $alternateNotificationEmails = "admingroup@contoso.en"
            $global:updatedGroupLifecyclePolicy = Set-EntraMSGroupLifecyclePolicy -Id $testGroupPolicy.Id -GroupLifetimeInDays 200 -AlternateNotificationEmails $alternateNotificationEmails -ManagedGroupTypes "Selected"
            Start-Sleep -Seconds 10

            $updatedGroupLifecyclePolicy.Id | Should -Be $testGroupPolicy.Id
            $updatedGroupLifecyclePolicy.GroupLifetimeInDays | Should -Be 200
            $updatedGroupLifecyclePolicy.ManagedGroupTypes | Should -Contain "Selected"
            $updatedGroupLifecyclePolicy.AlternateNotificationEmails | Should -Contain $alternateNotificationEmails
        }

        It "should successfully associate the group with the lifecycle policy" {
            $testLifePolicyGroup = Add-EntraMSLifecyclePolicyGroup -Id $testGroupPolicy.Id -GroupId $newMSGroup.Id
            $testLifePolicyGroup.ObjectId | Should -BeNullOrEmpty
            Start-Sleep -Seconds 10
        }

        It "should successfully retrieve details of a LifecyclePolicyGroup" {
            $global:lifecyclePolicyGroup = Get-EntraMSLifecyclePolicyGroup -Id $newMSGroup.Id
            $lifecyclePolicyGroup.ObjectId | Should -Be $testGroupPolicy.Id
            $lifecyclePolicyGroup.GroupLifetimeInDays | Should -Be 200
            $lifecyclePolicyGroup.ManagedGroupTypes | Should -Contain "Selected"
            $lifecyclePolicyGroup.AlternateNotificationEmails | Should -Contain $updatedGroupLifecyclePolicy.AlternateNotificationEmails
        }

        AfterAll {
            if ($lifecyclePolicyGroup) {
                Remove-EntraMSLifecyclePolicyGroup -Id $lifecyclePolicyGroup.Id -GroupId $newMSGroup.Id | Out-Null
            }
            if ($updatedGroupLifecyclePolicy) {
                Remove-EntraMSGroupLifecyclePolicy -Id $updatedGroupLifecyclePolicy.Id | Out-Null
            }
            if ($newMSGroup) {
                Remove-EntraMSGroup -Id $newMSGroup.Id | Out-Null
            }
        }
    }
}
