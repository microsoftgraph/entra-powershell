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

        It "should successfully read the application with expected properties when the application ID parameter is used" {
            $app = Get-EntraApplication -ObjectId $testApp.Id
            $app.Id | Should -Be $testApp.Id
            $app.DisplayName | Should -Be $testAppName
        }

        It "should throw an exception if a nonexistent object ID parameter is specified" {
            $Id = (New-Guid).Guid
            Get-EntraApplication -ObjectId $Id -ErrorAction Stop
            $Error[0] | Should -match "Resource '([^']+)' does not exist"
        }

        AfterAll {
            foreach ($app in (Get-EntraApplication -All $true | Where-Object { $_.DisplayName -eq $testAppName})) {
                Remove-EntraApplication -ObjectId $app.Id | Out-Null
            }
            
        }
    }
}
