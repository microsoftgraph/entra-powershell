Describe "The EntraGroup command executing unmocked" {

    Context "When getting user and group" {
        BeforeAll {
            $testReportPath = join-path $psscriptroot "\setenv.ps1"
            Import-Module -Name $testReportPath
            $appId = $env:TEST_APPID
            $tenantId = $env:TEST_TENANTID
            $cert = $env:CERTIFICATETHUMBPRINT
            Connect-Entra -TenantId $tenantId  -AppId $appId -CertificateThumbprint $cert

            $thisTestInstanceId = New-Guid | Select-Object -expandproperty guid
            $testName = 'Demo Name' + $thisTestInstanceId

            #create test group 
            $global:newGroup = New-EntraGroup -DisplayName $testName -MailEnabled $false -SecurityEnabled $true -MailNickName "NotSet" 
        }

        It "should successfully get a specific group by using an Id" {
            $group = Get-EntraGroup -ObjectId $newGroup.Id
            $group.Id | Should -Be $newGroup.Id
            $group.DisplayName | Should -Be $testName
        }

        It "should successfully update a group display name" {
            Set-EntraGroup -ObjectId $newGroup.Id -DisplayName "Demo Name 2"
            $result = Get-EntraGroup -ObjectId $newGroup.Id
            $result.Id | Should -Contain $newGroup.Id
        }

        AfterAll {
            Remove-EntraGroup -ObjectId $newGroup.Id | Out-Null
        }
    }
}