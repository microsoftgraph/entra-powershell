Describe "The EntraMSApplicationExtensionProperty command executing unmocked" {

    Context "When getting ApplicationExtensionProperty" {
        BeforeAll {
            $testReportPath = Join-Path $PSScriptRoot "\setenv.ps1"
            Import-Module -Name $testReportPath

            $appId = $env:TEST_APPID
            $tenantId = $env:TEST_TENANTID
            $cert = $env:CERTIFICATETHUMBPRINT

            if (-not $appId -or -not $tenantId -or -not $cert) {
                throw "Required environment variables are not set."
            }

            Connect-Entra -TenantId $tenantId -AppId $appId -CertificateThumbprint $cert
            
            $thisTestInstanceId = New-Guid | Select-Object -expandproperty guid
            $testApplicationName = 'Test Demo Name' + $thisTestInstanceId
            $global:newMSApplication = New-EntraMSApplication -DisplayName $testApplicationName
        }
        
        It "should successfully get an application by display name" {
            $application = Get-EntraMSApplication -Filter "DisplayName eq '$($newMSApplication.DisplayName)'"
            $application.ObjectId | Should -Be $newMSApplication.Id
            $application.AppId | Should -Be $newMSApplication.AppId
            $application.DisplayName | Should -Be $newMSApplication.DisplayName
        }

        It "should successfully update a application display name" {
            $updatedDisplayName = "Update Application Name"
            Set-EntraMSApplication -ObjectId $newMSApplication.ObjectId -DisplayName $updatedDisplayName
            $result = Get-EntraMSApplication -Filter "AppId eq '$($newMSApplication.AppId)'"
            $result.ObjectId | Should -Be $newMSApplication.Id
            $result.AppId | Should -Be $newMSApplication.AppId
            $result.DisplayName | Should -Be "Update Application Name"
        }

        It "should successfully create application extension property" {
            $global:newMSApplicationExtensionProperty = New-EntraMSApplicationExtensionProperty -ObjectId $newMSApplication.Id -DataType "string" -Name "NewAttribute" -TargetObjects "Application"
        }

        It "should successfully get application extension property" {
            $applicationExtensionProperty = Get-EntraMSApplicationExtensionProperty -ObjectId $newMSApplication.Id
            $applicationExtensionProperty.ObjectId | Should -Be $newMSApplicationExtensionProperty.Id
            $applicationExtensionProperty.Name | Should -Be $newMSApplicationExtensionProperty.Name
           
        }

        AfterAll {
            if ($newMSApplicationExtensionProperty) {
                Remove-EntraMSApplicationExtensionProperty -ObjectId $newMSApplication.Id -ExtensionPropertyId $newMSApplicationExtensionProperty.Id | Out-Null
            }
            if ($newMSApplication) {
                Remove-EntraMSApplication -ObjectId $newMSApplication.Id | Out-Null
            }
        }
    }
}
