Describe "The Get-EntraApplication command executing unmocked" {

    Context "When getting applications" {
        BeforeAll {
            $testReportPath = join-path $psscriptroot "\setenv.ps1"
            Import-Module -Name $testReportPath
            $appId = $env:TEST_APPID
            $tenantId = $env:TEST_TENANTID
            $cert = $env:CERTIFICATETHUMBPRINT
            Connect-Entra -TenantId $tenantId  -AppId $appId -CertificateThumbprint $cert

            $thisTestInstanceId = New-Guid | select -expandproperty guid
            $testAppName = 'SimpleTestAppRead' + $thisTestInstanceId
            $testApp = New-EntraApplication -DisplayName $testAppName
        }

        It "should successfully update the application with expected properties when the application ID parameter is used" {
            $thisTestInstanceId = New-Guid | select -expandproperty guid
            $newAppName = 'SimpleTestAppUpdate' + $thisTestInstanceId
            Set-EntraApplication -ObjectId $testApp.Id -DisplayName $newAppName | Should -BeNullOrEmpty
            
            $app = Get-EntraApplication -ObjectId $testApp.Id
            $app.Id | Should -Be $testApp.Id
            $app.DisplayName | Should -Be $newAppName
        }

        AfterAll {
            foreach ($app in (Get-EntraApplication -All $true | Where-Object { $_.DisplayName -eq $newAppName})) {
                Remove-EntraApplication -ObjectId $app.Id | Out-Null
            }
            
        }
    }
}
