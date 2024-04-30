Describe "The EntraMSLifecyclePolicyGroup command executing unmocked" {

    Context "When getting LifecyclePolicyGroup" {
        BeforeAll {
            $testReportPath = Join-Path $PSScriptRoot "\env.ps1"
            Import-Module -Name $testReportPath

            $appId = $env:TEST_APPID
            $tenantId = $env:TEST_TENANTID
            $cert = $env:CERTIFICATETHUMBPRINT

            # Validate required environment variables
            if (-not $appId -or -not $tenantId -or -not $cert) {
                throw "Required environment variables are not set."
            }

            # Connect to Entra service
            Connect-Entra -TenantId $tenantId -AppId $appId -CertificateThumbprint $cert

            # Create a group with Description parameter.
            $thisTestInstanceId = New-Guid | Select-Object -ExpandProperty Guid
            $testName = 'Demo Help Group' + $thisTestInstanceId
            $testNickname = "testhelpDeskAdminGroup"
            $global:newMSGroup = New-EntraMSGroup -DisplayName $testName -MailEnabled $false -MailNickname $testNickname -SecurityEnabled $true -GroupTypes "unified"
            Write-Host "Group Id:$($newMSGroup.Id)" 
            # Validate group creation
            if (-not $newMSGroup) {
                throw "Failed to create a new group."
            }
            Start-Sleep -Seconds 10

            # Create a lifecycle policy
            $global:testGroupPolicy = New-EntraMSGroupLifecyclePolicy -GroupLifetimeInDays 99 -ManagedGroupTypes "Selected" -AlternateNotificationEmails "example@contoso.un"
            Write-Host "Policy Id:$($testGroupPolicy.Id)"
            # Validate policy creation
            if (-not $testGroupPolicy) {
                throw "Failed to create a new group lifecycle policy."
            }
            Start-Sleep -Seconds 10
        }

        It "should successfully retrieve details of a LifecyclePolicyGroup" {
            # Associate the group with the lifecycle policy
            $testLifePolicyGroup = Add-EntraMSLifecyclePolicyGroup -Id $testGroupPolicy.Id -GroupId $newMSGroup.Id
            Write-Host "Lifecycle Policy Group Id:$($testLifePolicyGroup.Id)"  
            $testLifePolicyGroup.ObjectId | Should -BeNullOrEmpty
            
            # Get lifecycle policy group using group id 
            $lifecyclePolicyGroup = Get-EntraMSLifecyclePolicyGroup -Id $newMSGroup.Id
            $lifecyclePolicyGroup.ObjectId | Should -Be $testGroupPolicy.Id
            $lifecyclePolicyGroup.GroupLifetimeInDays | Should -Be 99
            $lifecyclePolicyGroup.ManagedGroupTypes | Should -Contain "Selected"
            $lifecyclePolicyGroup.AlternateNotificationEmails | Should -Contain "example@contoso.un"
            Write-Host $lifecyclePolicyGroup
        }

        AfterAll {
            if ($newMSGroup) {
                Remove-EntraMSGroup -Id $newMSGroup.Id | Out-Null
            }
            if ($testGroupPolicy) {
                Remove-EntraMSGroupLifecyclePolicy -Id $testGroupPolicy.Id | Out-Null
            }
            if ($testLifePolicyGroup) {
                Remove-EntraMSLifecyclePolicyGroup -Id $testLifePolicyGroup.Id -GroupId $newMSGroup.Id | Out-Null
            }
        }
    }
}
