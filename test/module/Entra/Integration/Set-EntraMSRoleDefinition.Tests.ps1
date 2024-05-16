Describe "The Set-EntraMSRoleDefination command executing unmocked" {

    Context "When getting MSRoleDefination" {
        BeforeAll {
            $testReportPath = join-path $psscriptroot "\setenv.ps1"
            Import-Module -Name $testReportPath
            $appId = $env:TEST_APPID
            $tenantId = $env:TEST_TENANTID
            $cert = $env:CERTIFICATETHUMBPRINT
            Connect-Entra -TenantId $tenantId  -AppId $appId -CertificateThumbprint $cert
        }
            #create new role defination 
        It "should successfully create new ms role defination " {
            $thisTestInstanceId = New-Guid | select -expandproperty guid
            $testName = 'SimpleRoleDefination' + $thisTestInstanceId
            $RolePermissions = New-object Microsoft.Open.MSGraph.Model.RolePermission
            $RolePermissions.AllowedResourceActions =  @("microsoft.directory/applications/basic/read")
           $global:newmsRoleDefinition = New-EntraMSRoleDefinition -RolePermissions $RolePermissions -IsEnabled $false -DisplayName $testName
    
        }
        It "should successfully update the msrole defination with expected properties when the msrole defination ID parameter is used" {
            $thisTestInstanceId = New-Guid | select -expandproperty guid
            $global:newmsrolename = 'SimpleRoleDefinationUpdated' + $thisTestInstanceId
            Set-EntraMSRoleDefinition -Id $newmsRoleDefinition.Id -DisplayName $newmsrolename | Should -BeNullOrEmpty
        }
        It "should successfully retrieve details of a MS role defination" {    
            $app = Get-EntraMSRoleDefinition -Id $newmsRoleDefinition.Id
            $app | Should -Not -BeNullOrEmpty
            $app.Id | Should -Be $newmsRoleDefinition.Id
            $app.DisplayName | Should -Be $newmsrolename
        }
        It "should throw an exception if a nonexistent object ID parameter is specified" {
            $Id = (New-Guid).Guid
            Get-EntraMSRoleDefinition -Id $Id -ErrorAction Stop
            $Error[0] | Should -match "Resource '([^']+)' does not exist"
        }

        AfterAll {
                Remove-EntraMSRoleDefinition -Id $newmsRoleDefinition.Id | Out-Null
            }
            
    }    


}
      
