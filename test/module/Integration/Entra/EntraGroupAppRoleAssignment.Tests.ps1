# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
Describe "The EntraGroupAppRoleAssignment command executing unmocked" {

    Context "When getting GroupAppRoleAssignment" {
        BeforeAll {
            $testReportPath = join-path $psscriptroot "..\setenv.ps1"
            . $testReportPath

            $thisTestInstanceId = New-Guid | Select-Object -expandproperty guid
            $global:displayName = 'DemoName' + $thisTestInstanceId
            
            $global:newGroup = New-EntraGroup -DisplayName $displayName -MailEnabled $false -SecurityEnabled $true -MailNickName $displayName
        }

        It "should successfully get a specific group by using an Id" {
            $group = Get-EntraGroup -ObjectId $newGroup.Id
            $group.Id | Should -Be $newGroup.Id
            $group.DisplayName | Should -Be $displayName
        }

        It "should successfully update a group display name" {
            $global:updatedDisplayName = "Demo Name 2"
            Set-EntraGroup -Id $newGroup.Id -DisplayName $updatedDisplayName
            $result = Get-EntraGroup -ObjectId $newGroup.Id
            $result.Id | Should -Contain $newGroup.Id
        }

        It "should successfully create application" {
            $types = @()
            $types += 'User'
            $approle = New-Object Microsoft.Open.MSGraph.Model.AppRole
            $approle.AllowedMemberTypes =  $types
            $approle.Description  = 'msiam_access'
            $approle.DisplayName  = 'msiam_access'
            $approle.Id = '643985ce-3eaf-4a67-9550-ecca25cb6814'
            $approle.Value = 'Application'
            $approle.IsEnabled = $true 
            $applicationDisplayName = "Demo new application" 
            $global:createdApplication = New-EntraApplication -DisplayName $applicationDisplayName -AppRoles $approle
            $createdApplication.DisplayName  | Should -Be $applicationDisplayName
        }

        It "should successfully get application" {
            $global:getCreatedApplication = Get-EntraApplication -ObjectId $createdApplication.Id
            $getCreatedApplication.DisplayName  | Should -Be $createdApplication.DisplayName
            $getCreatedApplication.Id  | Should -Be $createdApplication.Id
            $getCreatedApplication.AppId  | Should -Be $createdApplication.AppId
        }

        It "should successfully update application display name" {
            $global:updateApplicationDisplayName = "Update demo application"
            Set-EntraApplication -ObjectId $getCreatedApplication.Id -DisplayName $updateApplicationDisplayName
            
            $global:getUpdatedCreatedApplication = Get-EntraApplication -ObjectId $getCreatedApplication.Id
            $getUpdatedCreatedApplication.DisplayName  | Should -Be $updateApplicationDisplayName
            $getUpdatedCreatedApplication.Id  | Should -Be $getCreatedApplication.Id
            $getUpdatedCreatedApplication.AppId  | Should -Be $getCreatedApplication.AppId
        }

        It "should successfully create and get service principal" {
            $global:MyApp = Get-EntraApplication -Filter "DisplayName eq '$($getUpdatedCreatedApplication.DisplayName)'"
            
            New-EntraServicePrincipal -AccountEnabled $true -AppId $MyApp.AppId -AppRoleAssignmentRequired $true -DisplayName $MyApp.DisplayName -Tags {"WindowsAzureActiveDirectoryIntegratedApp"}
            $global:createdServicePrincipal = Get-EntraServicePrincipal -Filter "DisplayName eq '$($MyApp.DisplayName)'"
            $createdServicePrincipal.AppId | Should -Be $MyApp.AppId
            $createdServicePrincipal.DisplayName | Should -Be $MyApp.DisplayName
        }

        It "should successfully update the account of a service principal" {
            Set-EntraServicePrincipal -ObjectId $createdServicePrincipal.Id -AccountEnabled $False
            $disableServicePrincipal = Get-EntraServicePrincipal -Filter "DisplayName eq '$($MyApp.DisplayName)'"
            $disableServicePrincipal.AppId | Should -Be $MyApp.AppId
            $disableServicePrincipal.DisplayName | Should -Be $MyApp.DisplayName

            Set-EntraServicePrincipal -ObjectId $createdServicePrincipal.Id -AccountEnabled $True
            $global:updatedServicePrincipal = Get-EntraServicePrincipal -Filter "DisplayName eq '$($MyApp.DisplayName)'"
            $updatedServicePrincipal.AppId | Should -Be $MyApp.AppId
            $updatedServicePrincipal.DisplayName | Should -Be $MyApp.DisplayName
        }

        It "should successfully assign a group of users to an application" {
           New-EntraGroupAppRoleAssignment -ObjectId $newGroup.ObjectId -PrincipalId $newGroup.ObjectId -ResourceId $updatedServicePrincipal.ObjectId -Id $updatedServicePrincipal.Approles[0].id
        }

        It "should successfully retrieve application role assignments of a group" {
            $global:getGroupAppRoleAssignment = Get-EntraGroupAppRoleAssignment -ObjectId $newGroup.Id
            $getGroupAppRoleAssignment.ResourceDisplayName  | Should -Be $createdServicePrincipal.DisplayName
            $getGroupAppRoleAssignment.PrincipalDisplayName | Should -Be $updatedDisplayName
        }
        
        AfterAll {
            if ( $getGroupAppRoleAssignment) {
                Remove-EntraGroupAppRoleAssignment -ObjectId $newGroup.Id -AppRoleAssignmentId $getGroupAppRoleAssignment.Id | Out-Null
            }
            if ( $updatedServicePrincipal) {
                Remove-EntraServicePrincipal -ObjectId $updatedServicePrincipal.Id | Out-Null
            }
            if ( $getUpdatedCreatedApplication) {
                Remove-EntraApplication -ObjectId $getUpdatedCreatedApplication.Id | Out-Null
            }
            if ($newGroup) {
                Remove-EntraGroup -ObjectId $newGroup.Id | Out-Null
            }
        }
    }
}