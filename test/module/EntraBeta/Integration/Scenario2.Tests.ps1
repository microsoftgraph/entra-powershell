BeforeAll {
    $testReportPath = join-path $psscriptroot "\setenv.ps1"
    Import-Module -Name $testReportPath
    $appId = $env:TEST_APPID
    $tenantId = $env:TEST_TENANTID
    $cert = $env:CERTIFICATETHUMBPRINT
    Connect-Entra -TenantId $tenantId  -AppId $appId -CertificateThumbprint $cert
}
Describe "Integration Testing" {

    Context "Scen1: Assign Entra roles including assign roles with different scopes"{
        It "Get user and role"{
            $thisTestInstanceId = New-Guid | Select-Object -expandproperty guid
            $testUserName = 'SimpleTestUsers' + $thisTestInstanceId
            # Create new User
            $PasswordProfile = New-Object -TypeName Microsoft.Open.AzureAD.Model.PasswordProfile
            $PasswordProfile.Password = "Pass@1234"                
            $global:NewUser = New-EntraBetaUser -AccountEnabled $true -DisplayName $testUserName -PasswordProfile $PasswordProfile -MailNickName $testUserName -UserPrincipalName "$testUserName@M365x99297270.OnMicrosoft.com" 

            $global:role = Get-EntraBetaDirectoryRole | Where-Object {$_.DisplayName -eq "Application Administrator"}
        }
        It "Assign Entra roles"{
            $scope = "/"
            # Assign the role to the user with the defined scope
            $params = @{
                RoleDefinitionId = $role.Id
                PrincipalId = $NewUser.Id
                DirectoryScopeId = $scope
            }
            $global:newRole=New-EntraBetaRoleAssignment @params
        }
        It "Verification of assigned role Creation"{
            $global:assignedRole = Get-EntraBetaRoleAssignment -Filter "PrincipalId eq '$($NewUser.Id)'"
            $assignedRole.Id | Should -Be $newRole.Id
        }
    } 
    Context "Create custom roles"{
        It "Creating custom roles"{
            $RolePermissions = New-object Microsoft.Open.MSGraph.Model.RolePermission
            $RolePermissions.AllowedResourceActions =  @("microsoft.directory/applications/basic/read")
            $params = @{
                RolePermissions = $RolePermissions
                IsEnabled = $false
                DisplayName = 'SimpleTestRoleDefinition'
                ResourceScopes = '/'
            }
            $global:customRole=New-EntraBetaRoleDefinition @params
        }
        It "Verification of custom role created"{
            $global:getRole = Get-EntraBetaRoleDefinition -Filter "DisplayName eq 'SimpleTestRoleDefinition'"
            $getRole.Id | Should -Contain $customRole.Id
        }
    }
    Context "Add or deactivate custom security attribute definitions in Microsoft Entra ID"{
        It "Adding custom security attribute definitions"{
            $thisTestInstanceId = Get-Random -Minimum 10000 -Maximum 100000
            $testName = 'TestDefinition' + $thisTestInstanceId
            $AttributeSet  = Get-EntraBetaAttributeSet -Id 'Testing'
            $params = @{
                Name = $testName 
                Description = 'Target completion' 
                Type = 'String' 
                Status = 'Available' 
                AttributeSet = $AttributeSet.Id 
                IsCollection = $False 
                IsSearchable = $True 
                UsePreDefinedValuesOnly = $True
            }
            $global:Definition = New-EntraBetaCustomSecurityAttributeDefinition  @params
        }
        It "Deactivate custom security attribute definition"{
            $params = @{
                Id = $Definition.Id 
                Description = 'Target completion' 
                Status = 'Deprecated' 
            }
            Set-EntraBetaCustomSecurityAttributeDefinition @params
        }
        It "Verification of deactivation of custom security attribute definition"{
            $global:getDefinition = Get-EntraBetaCustomSecurityAttributeDefinition -Id $Definition.Id
            $getDefinition.Status | Should -Be 'Deprecated' 
        }
    }
    AfterAll {
        Remove-EntraBetaRoleAssignment -Id $assignedRole.Id
        foreach ($user in (Get-EntraBetaUser -SearchString "SimpleTestUsers")) {
            Remove-EntraBetaUser -ObjectId $user.Id | Out-Null
        }
        Remove-EntraBetaRoleDefinition -Id $getRole.Id

    }
}