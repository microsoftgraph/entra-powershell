Describe "The Get-EntraApplication command executing unmocked" {

    Context "When creating applications" {
        BeforeAll {
            $testReportPath = join-path $psscriptroot "\setenv.ps1"
            Import-Module -Name $testReportPath
            $appId = $env:TEST_APPID
            $tenantId = $env:TEST_TENANTID
            $cert = $env:CERTIFICATETHUMBPRINT
            Connect-Entra -TenantId $tenantId  -AppId $appId -CertificateThumbprint $cert

            $thisTestInstanceId = New-Guid | select -expandproperty guid
        }

        It "should succeed when creating a new application" {
            $testAppName = 'SimpleTestApp' + $thisTestInstanceId
            $newApp = New-EntraApplication -DisplayName $testAppName 
            $newApp.DisplayName | Should -Be $testAppName
            { Get-EntraApplication -ObjectId $newApp.Id } | Should -Not -BeNullOrEmpty
        }

        AfterAll {
            foreach ($app in (Get-EntraApplication -All $true | Where-Object { $_.DisplayName -eq $testAppName})) {
                Remove-EntraApplication -ObjectId $app.Id | Out-Null
            }
        }
    }
}
