Describe "The EntraMSGroup command executing unmocked" {

    Context "When getting user and group" {
        BeforeAll {
            $testReportPath = join-path $psscriptroot "\env.ps1"
            Import-Module -Name $testReportPath
            $appId = $env:TEST_APPID
            $tenantId = $env:TEST_TENANTID
            $cert = $env:CERTIFICATETHUMBPRINT
            Connect-Entra -TenantId $tenantId  -AppId $appId -CertificateThumbprint $cert

            $thisTestInstanceId = New-Guid | Select-Object -expandproperty guid
            $testName = 'Demo Help Group' + $thisTestInstanceId
            $testNickname = "helpDeskAdminGroup"

            #Create a group with Description parameter.
            $global:newMSGroup = New-EntraMSGroup -DisplayName $testName -MailEnabled $False -MailNickname $testNickname -SecurityEnabled $True
        }

        It "should successfully get a specific group by using an Id" {
            $group = Get-EntraMSGroup -Id $newMSGroup.Id
            $group.ObjectId | Should -Be $newMSGroup.Id
            $group.DisplayName | Should -Be $testName
        }

        It "should successfully update a group display name" {
            Set-EntraMSGroup -Id $newMSGroup.Id -DisplayName "Update Help Group Name"
            $result = Get-EntraGroup -ObjectId $newMSGroup.Id
            $result.Id | Should -Contain $newMSGroup.Id
        }

        AfterAll {
            Remove-EntraMSGroup -Id $newMSGroup.Id | Out-Null
        }
    }
}