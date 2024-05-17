Describe "The Get-EntraApplication command executing unmocked" {

    Context "When creating applications" {
        BeforeAll {
            $testReportPath = join-path $psscriptroot "\setenv.ps1"
            Import-Module -Name $testReportPath
            $appId = $env:TEST_APPID
            $tenantId = $env:TEST_TENANTID
            $cert = $env:CERTIFICATETHUMBPRINT
            Connect-Entra -TenantId $tenantId  -AppId $appId -CertificateThumbprint $cert

            
        }
        It "Creating Applications and attaching secrets to that newly created application " {
             # Create New application
            $thisTestInstanceId = New-Guid | select -expandproperty guid
            $global:testAppName = 'SimpleTestApp' + $thisTestInstanceId
            $global:newApp = New-EntraApplication -DisplayName $testAppName -AvailableToOtherTenants $true -ReplyUrls @("https://yourapp.com") 
            $newApp.DisplayName | Should -Be $testAppName

            $Result = New-EntraApplicationPasswordCredential -ObjectId $newApp.Id -CustomKeyIdentifier "MySecret" 
            write-host "application password credentials"
            write-host  $Result

            # Retrive application password credentials and verify keyId is present or not
            # $Result1 = Get-EntraApplicationPasswordCredential -ObjectId $newApp.Id
            # $Result1.KeyId | Should -be $Result.KeyId

            # Retrive new application and verify keyId is present or not
            $App = Get-EntraApplication -ObjectId $newApp.Id 
            write-host "Retrived application details"
            $App.PasswordCredentials.KeyId | Should -be $Result.KeyId
        }
        It "Create Service Principal to the newly created application" {
            $application = Get-EntraApplication -Filter "DisplayName eq '$testAppName'"

            # Create service Principal for new application
            $global:NewServicePrincipal = New-EntraServicePrincipal -AppId $application.AppId

            # Get created service principal
            $RetriveServicePrincipal = Get-EntraServicePrincipal -ObjectId $NewServicePrincipal.ObjectId
            write-host 

            $RetriveServicePrincipal.AppId | Should -Be $application.AppId


        }

        AfterAll {
            
                Remove-EntraServicePrincipal -ObjectId $NewServicePrincipal.ObjectId 
                Remove-EntraApplication -ObjectId $newApp.Id | Out-Null
                 
        
        }

    }
}
