Describe "The EntraMSGroupLifecyclePolicy command executing unmocked" {

    Context "When getting groupLifecyclePolicy" {
        BeforeAll {
            $testReportPath = join-path $psscriptroot "\env.ps1"
            Import-Module -Name $testReportPath
            $appId = $env:TEST_APPID
            $tenantId = $env:TEST_TENANTID
            $cert = $env:CERTIFICATETHUMBPRINT
            Connect-Entra -TenantId $tenantId  -AppId $appId -CertificateThumbprint $cert

            $global:testGroupPolicy = New-EntraMSGroupLifecyclePolicy -GroupLifetimeInDays 99 -ManagedGroupTypes "Selected" -AlternateNotificationEmails "example@contoso.en"
        }

        It "should successfully retrieve properties of an groupLifecyclePolicy" {
            $groupLifecyclePolicy = Get-EntraMSGroupLifecyclePolicy -Id $testGroupPolicy.Id

            # Ensure that the retrieved group lifecycle policy matches the expected one
            $groupLifecyclePolicy.Id | Should -Be $testGroupPolicy.Id
            $groupLifecyclePolicy.GroupLifetimeInDays | Should -Be 99
            $groupLifecyclePolicy.ManagedGroupTypes | Should -Contain "Selected"
            $groupLifecyclePolicy.AlternateNotificationEmails | Should -Contain "example@contoso.en"
        }

        It "should successfully update group lifecycle policy" {
            $updatedGroupLifecyclePolicy = Set-EntraMSGroupLifecyclePolicy -Id $testGroupPolicy.Id -GroupLifetimeInDays 200 -AlternateNotificationEmails "admingroup@contoso.en" -ManagedGroupTypes "All"

            # Ensure that the retrieved group lifecycle policy matches the expected one
            $updatedGroupLifecyclePolicy.Id | Should -Be $testGroupPolicy.Id
            $updatedGroupLifecyclePolicy.GroupLifetimeInDays | Should -Be 200
            $updatedGroupLifecyclePolicy.ManagedGroupTypes | Should -Contain "All"
            $updatedGroupLifecyclePolicy.AlternateNotificationEmails | Should -Contain "admingroup@contoso.en"
        }

        # It "should throw an exception if a nonexistent ID parameter is specified" {
        #     $Id = (New-Guid).Guid
        #     Get-EntraMSGroupLifecyclePolicy -Id $Id -ErrorAction ignore 
        #     $errorMessage = $Error[0].Exception.Message
        #     $errorMessage | Should -match "([\da-fA-F]{8}-[\da-fA-F]{4}-[\da-fA-F]{4}-[\da-fA-F]{4}-[\da-fA-F]{12})"
        # }

        AfterAll {
                Remove-EntraMSGroupLifecyclePolicy -Id $testGroupPolicy.Id | Out-Null
        }
    }
}