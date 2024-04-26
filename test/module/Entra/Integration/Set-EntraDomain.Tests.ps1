Describe "The Get-EntraDomain command executing unmocked" {

    Context "When getting domains" {
        BeforeAll {
            $testReportPath = join-path $psscriptroot "\setenv.ps1"
            Import-Module -Name $testReportPath
            $appId = $env:TEST_APPID
            $tenantId = $env:TEST_TENANTID
            $cert = $env:CERTIFICATETHUMBPRINT
            Connect-Entra -TenantId $tenantId  -AppId $appId -CertificateThumbprint $cert

            # $thisTestInstanceId = New-Guid | select -expandproperty guid
            # $testDomainName = 'sampledomain.com'
            $global:testDomainName = 'M365x99297270.mail.onmicrosoft.com' 
            # $global:testDomain = New-EntraDomain -Name $testDomainName -SupportedServices @("Email", "OfficeCommunicationsOnline")
        }

        It "should successfully update the application with expected properties when the domain Name parameter is used" {
            
            # Set-EntraDomain -Name $testDomain.Name | Should -BeNullOrEmpty
            # Confirm-EntraDomain -Name $testDomainName | Should -BeNullOrEmpty
            Set-EntraDomain -Name $testDomainName | Should -BeNullOrEmpty
            # Confirm-EntraDomain -Name $testDomainName | Should -BeNullOrEmpty
            
            # $app = Get-EntraDomain -Name $testDomain.Name
             $app = Get-EntraDomain -Name $testDomainName
            $app.ObjectId | Should -Be $testDomainName
        }

        # AfterAll {
        #         Remove-EntraDomain -Name $testDomain.Name | Out-Null
        #     }
            
        
    }
}
