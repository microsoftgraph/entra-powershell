Describe "The EntraMSApplication command executing unmocked" {

    Context "When getting application" {
        BeforeAll {
            $testReportPath = join-path $psscriptroot "\env.ps1"
            Import-Module -Name $testReportPath
            $appId = $env:TEST_APPID
            $tenantId = $env:TEST_TENANTID
            $cert = $env:CERTIFICATETHUMBPRINT
            Connect-Entra -TenantId $tenantId  -AppId $appId -CertificateThumbprint $cert

            $thisTestInstanceId = New-Guid | Select-Object -expandproperty guid
            $testApplicationName = 'Demo Name' + $thisTestInstanceId

            # Create an application
            $global:newMSApplication = New-EntraMSApplication -DisplayName $testApplicationName
        }

        It "should successfully get an application by display name" {
            $application = Get-EntraMSApplication -Filter "DisplayName eq '$($newMSApplication.DisplayName)'"
            $application.ObjectId | Should -Be $newMSApplication.Id
            $application.AppId | Should -Be $newMSApplication.AppId
            $application.DisplayName | Should -Be $newMSApplication.DisplayName
        }

        It "should successfully update a application display name" {
            Set-EntraMSApplication -ObjectId $newMSApplication.ObjectId -DisplayName "Update Application Name"
            $result = Get-EntraMSApplication -Filter "AppId eq '$($newMSApplication.AppId)'"
            $result.ObjectId | Should -Be $newMSApplication.Id
            $result.AppId | Should -Be $newMSApplication.AppId
            $result.DisplayName | Should -Be "Update Application Name"
        }

        AfterAll {
            Remove-EntraMSApplication -ObjectId $newMSApplication.ObjectId
        }
    }
}