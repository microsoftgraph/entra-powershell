Describe "The EntraMSLifecyclePolicyGroup command executing unmocked" {

    Context "When getting LifecyclePolicyGroup" {
        BeforeAll {
            $testReportPath = Join-Path $PSScriptRoot "\env.ps1"
            Import-Module -Name $testReportPath

            $appId = $env:TEST_APPID
            $tenantId = $env:TEST_TENANTID
            $cert = $env:CERTIFICATETHUMBPRINT

            Connect-Entra -TenantId $tenantId -AppId $appId -CertificateThumbprint $cert

            # Create a group with Description parameter.
            $thisTestInstanceId = New-Guid | Select-Object -expandproperty guid
            $testName = 'Demo Help Group' + $thisTestInstanceId
            $testNickname = "helpDeskAdminGroup"
            $global:newMSGroup = New-EntraMSGroup -DisplayName $testName -MailEnabled $false -MailNickname $testNickname -SecurityEnabled $true
            Write-host $newMSGroup

            $global:testGroupPolicy = New-EntraMSGroupLifecyclePolicy -GroupLifetimeInDays 99 -ManagedGroupTypes "Selected" -AlternateNotificationEmails "example@contoso.un"
            Write-host $testGroupPolicy

            $global:testLifePolicyGroup = Add-EntraMSLifecyclePolicyGroup -Id $testGroupPolicy.Id -GroupId $newMSGroup.Id
            Write-host $testLifePolicyGroup
        }

        It "should successfully retrieve details of a LifecyclePolicyGroup" {
            $lifecyclePolicyGroup = Get-EntraMSLifecyclePolicyGroup -Id $testLifePolicyGroup.Id

            # Ensure that the retrieved group lifecycle policy matches the expected one
            $lifecyclePolicyGroup.Id | Should -Be $testLifePolicyGroup.Id
            Write-Host $lifecyclePolicyGroup
        }

        AfterAll {
            Remove-EntraMSLifecyclePolicyGroup -Id $testLifePolicyGroup.Id -GroupId $newMSGroup.Id | Out-Null
        }
    }
}
