Describe "The Set-EntraMSRoleAssignment command executing unmocked" {

    Context "When getting MSRoleAssignment" {
        BeforeAll {
            $testReportPath = join-path $psscriptroot "\setenv.ps1"
            Import-Module -Name $testReportPath
            $appId = $env:TEST_APPID
            $tenantId = $env:TEST_TENANTID
            $cert = $env:CERTIFICATETHUMBPRINT
            Connect-Entra -TenantId $tenantId  -AppId $appId -CertificateThumbprint $cert
        }    
            #create new user
        It "should successfully create new user " {
            $thisTestInstanceId = New-Guid | select -expandproperty guid
            $testName = 'SampleUser' + $thisTestInstanceId
            $PasswordProfile = New-Object -TypeName Microsoft.Open.AzureAD.Model.PasswordProfile
            $PasswordProfile.Password = "Pass@1234"
            $global:newUser = New-EntraUser -AccountEnabled $true -DisplayName $testName -PasswordProfile $PasswordProfile -MailNickName $testName -UserPrincipalName $testName"@M365x99297270.OnMicrosoft.com"
        }
            #create new role defination 
        It "should successfully create new ms role defination " {
            $thisTestInstanceId = New-Guid | select -expandproperty guid
            $testName = 'SampleRoleDefination' + $thisTestInstanceId
            $RolePermissions = New-object Microsoft.Open.MSGraph.Model.RolePermission
            $RolePermissions.AllowedResourceActions =  @("microsoft.directory/applications/basic/read")
            $global:newmsRoleDefinition = New-EntraMSRoleDefinition -RolePermissions $RolePermissions -IsEnabled $false -DisplayName $testName
        }

            #create new role assignment 
        It "should successfully create new ms role assignment " {
            $thisTestInstanceId = New-Guid | select -expandproperty guid
            $testName = 'SampleRoleDefination' + $thisTestInstanceId
            $RolePermissions = New-object Microsoft.Open.MSGraph.Model.RolePermission
            $RolePermissions.AllowedResourceActions =  @("microsoft.directory/applications/basic/read")
            $global:newmsRoleAssignment = New-EntraMSRoleAssignment -RoleDefinitionId $newmsRoleDefinition.Id -PrincipalId $newUser.Id -DirectoryScopeId '/'
        }
        It "should successfully get the msrole assignment " {
            $PrincipalId = $newUser.Id
            $assignment = Get-EntraMSRoleAssignment -Filter "principalId eq '$PrincipalId'" 
            $assignment.Id | Should -Be $newmsRoleAssignment.Id
            $assignment.PrincipalId | Should -Be $newmsRoleAssignment.PrincipalId
            $assignment.RoleDefinitionId | Should -Be $newmsRoleAssignment.RoleDefinitionId

        }
        It "should throw an exception if a nonexistent object ID parameter is specified" {
            $Id = (New-Guid).Guid
            Get-EntraMSRoleAssignment -Filter "principalId eq '$Id'" -ErrorAction Stop
            $Error[0] | Should -match "Resource '([^']+)' does not exist"
        }

        AfterAll {
               
                Remove-EntraMSRoleAssignment -Id $newmsRoleAssignment.Id | Out-Null
                Remove-EntraMSRoleDefinition -Id $newmsRoleDefinition.Id | Out-Null
                Remove-EntraUser -ObjectId $newUser.ObjectId | Out-Null
            }
            
    }    


}