Describe "The EntraUser crud cmdlet execution" {
    Context "EntraUser crud cmdlets" {
        BeforeAll {
            $testReportPath = Join-Path $PSScriptRoot "\entraUser.ps1"
            Import-Module -Name $testReportPath
            $appId = $env:TEST_APPID
            $tenantId = $env:TEST_TENANTID
            $cert = $env:CERTIFICATETHUMBPRINT
            Connect-Entra -TenantId $tenantId  -AppId $appId -CertificateThumbprint $cert

            $thisTestInstanceId = New-Guid | Select-Object -expandproperty guid
            $testAppName = 'SimpleTestAppRead' + $thisTestInstanceId
            
        }

        it "Should use Get-EntraUser for Get all Users" {
            $users = Get-EntraUser 
            $users | Should -Not -BeNullOrEmpty
        }

    }
}