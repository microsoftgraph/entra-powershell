# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
Describe "The EntraApplicationExtensionProperty command executing unmocked" {

    Context "When getting ApplicationExtensionProperty" {
        BeforeAll {
            $testReportPath = join-path $psscriptroot "..\setenv.ps1"
            . $testReportPath
            
            $thisTestInstanceId = New-Guid | Select-Object -expandproperty guid
            $testApplicationName = 'Test Demo Name' + $thisTestInstanceId
            $global:newMSApplication = New-EntraApplication -DisplayName $testApplicationName
        }
        
        It "should successfully get an application by display name" {
            $application = Get-EntraApplication -Filter "DisplayName eq '$($newMSApplication.DisplayName)'"
            $application.ObjectId | Should -Be $newMSApplication.Id
            $application.AppId | Should -Be $newMSApplication.AppId
            $application.DisplayName | Should -Be $newMSApplication.DisplayName
        }

        It "should successfully update a application display name" {
            $updatedDisplayName = "Update Application Name"
            Set-EntraApplication -ObjectId $newMSApplication.ObjectId -DisplayName $updatedDisplayName
            $result = Get-EntraApplication -Filter "AppId eq '$($newMSApplication.AppId)'"
            $result.ObjectId | Should -Be $newMSApplication.Id
            $result.AppId | Should -Be $newMSApplication.AppId
            $result.DisplayName | Should -Be "Update Application Name"
        }

        It "should successfully create application extension property" {
            $global:newMSApplicationExtensionProperty = New-EntraApplicationExtensionProperty -ObjectId $newMSApplication.Id -DataType "string" -Name "NewAttribute" -TargetObjects "Application"
        }

        It "should successfully get application extension property" {
            $applicationExtensionProperty = Get-EntraApplicationExtensionProperty -ObjectId $newMSApplication.Id
            $applicationExtensionProperty.ObjectId | Should -Be $newMSApplicationExtensionProperty.Id
            $applicationExtensionProperty.Name | Should -Be $newMSApplicationExtensionProperty.Name
           
        }

        AfterAll {
            if ($newMSApplicationExtensionProperty) {
                Remove-EntraApplicationExtensionProperty -ObjectId $newMSApplication.Id -ExtensionPropertyId $newMSApplicationExtensionProperty.Id | Out-Null
            }
            if ($newMSApplication) {
                Remove-EntraApplication -ObjectId $newMSApplication.Id | Out-Null
            }
        }
    }
}
