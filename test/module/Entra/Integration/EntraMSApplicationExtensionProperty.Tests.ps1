Describe "The EntraMSApplicationExtensionProperty command executing unmocked" {

    Context "When getting ApplicationExtensionProperty" {
        BeforeAll {
            $testReportPath = Join-Path $PSScriptRoot "\env.ps1"
            Import-Module -Name $testReportPath

            $appId = $env:TEST_APPID
            $tenantId = $env:TEST_TENANTID
            $cert = $env:CERTIFICATETHUMBPRINT

            # Validate required environment variables
            if (-not $appId -or -not $tenantId -or -not $cert) {
                throw "Required environment variables are not set."
            }

            # Connect to Entra service
            Connect-Entra -TenantId $tenantId -AppId $appId -CertificateThumbprint $cert

            # Create an application
            $thisTestInstanceId = New-Guid | Select-Object -expandproperty guid
            $testApplicationName = 'Test Demo Name' + $thisTestInstanceId
            $global:newMSApplication = New-EntraMSApplication -DisplayName $testApplicationName
            Write-Host "Id :$($newMSApplication.Id)"
            Write-Host "AppId :$($newMSApplication.AppId)"

            # Create an extension property
            $global:newMSApplicationExtensionProperty = New-EntraMSApplicationExtensionProperty -ObjectId $newMSApplication.Id -DataType "string" -Name "NewAttribute" -TargetObjects "Application"
            Write-Host "ObjectId :$($newMSApplicationExtensionProperty.ObjectId)"
            Write-Host "Name :$($newMSApplicationExtensionProperty.Name)"
        }

        It "should successfully get application extension property" {
            # Get application extension property using object id 
            $applicationExtensionProperty = Get-EntraMSApplicationExtensionProperty -ObjectId $newMSApplicationExtensionProperty.ObjectId
            $applicationExtensionProperty.ObjectId | Should -Be $newMSApplicationExtensionProperty.ObjectId
            $applicationExtensionProperty.Name | Should -Be $newMSApplicationExtensionProperty.Name
            Write-Host $applicationExtensionProperty
        }

        AfterAll {
            if ($newMSGroup) {
                Remove-EntraMSApplication -ObjectId $newMSApplication.ObjectId | Out-Null
            }
            if ($testGroupPolicy) {
                # Remove-EntraMSApplicationExtensionProperty -ObjectId $newMSApplicationExtensionProperty.ObjectId -ExtensionPropertyId "344ed560-f8e7-410e-ab9f-c79df5c36" | Out-Null
            }
        }
    }
}
