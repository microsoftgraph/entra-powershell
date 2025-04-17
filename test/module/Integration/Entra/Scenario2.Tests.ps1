# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
BeforeAll {
    $testReportPath = join-path $psscriptroot "..\setenv.ps1"
    . $testReportPath
    $password = $env:USER_PASSWORD
}
Describe "Integration Testing" {

    Context "Scen1: Assign Entra roles including assign roles with different scopes"{
        It "Get user and role"{
            $domain = (Get-EntraTenantDetail).VerifiedDomains.Name
            $thisTestInstanceId = (New-Guid).Guid.ToString()
            $thisTestInstanceId = $thisTestInstanceId.Substring($thisTestInstanceId.Length - 5)
            $testUserName = 'SimpleTestUsers' + $thisTestInstanceId
            # Create new User
            $PasswordProfile = New-Object -TypeName Microsoft.Open.AzureAD.Model.PasswordProfile
            $PasswordProfile.Password = $password                
            $global:NewUser = New-EntraUser -AccountEnabled $true -DisplayName $testUserName -PasswordProfile $PasswordProfile -MailNickName $testUserName -UserPrincipalName "$testUserName@$domain"

            $global:role = Get-EntraDirectoryRole | Where-Object {$_.DisplayName -eq "Application Administrator"}
        }
        It "Assign Entra roles"{
            $scope = "/"
            # Assign the role to the user with the defined scope
            $params = @{
                RoleDefinitionId = $role.Id
                PrincipalId = $NewUser.Id
                DirectoryScopeId = $scope
            }
            $global:newRole=New-EntraRoleAssignment @params
        }
        It "Verification of assigned role Creation"{
            $global:assignedRole = Get-EntraRoleAssignment -Filter "PrincipalId eq '$($NewUser.Id)'"
            $assignedRole.Id | Should -Be $newRole.Id
        }
    } 
    # Context "Create custom roles"{
    #     It "Creating custom roles"{
    #         $RolePermissions = New-object Microsoft.Open.MSGraph.Model.RolePermission
    #         $RolePermissions.AllowedResourceActions =  @("microsoft.directory/applications/basic/read")
    #         $params = @{
    #             RolePermissions = $RolePermissions
    #             IsEnabled = $false
    #             DisplayName = 'SimpleTestRoleDefinition'
    #             ResourceScopes = '/'
    #         }
    #         $global:customRole=New-EntraRoleDefinition @params
    #     }
    #     It "Verification of custom role created"{
    #         $global:getRole = Get-EntraRoleDefinition -Filter "DisplayName eq 'SimpleTestRoleDefinition'"
    #         $getRole.Id | Should -Contain $customRole.Id
    #     }
    # }
    Context "Add or deactivate custom security attribute definitions in Microsoft Entra ID"{
        It "Adding custom security attribute definitions"{
            $thisTestInstanceId = Get-Random -Minimum 10000 -Maximum 100000
            $testName = 'TestDefinition' + $thisTestInstanceId
            $AttributeSet  = Get-EntraAttributeSet -Id 'Testing'
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
            $global:Definition = New-EntraCustomSecurityAttributeDefinition  @params
        }
        It "Deactivate custom security attribute definition"{
            $params = @{
                Id = $Definition.Id 
                Description = 'Target completion' 
                Status = 'Deprecated' 
            }
            Set-EntraCustomSecurityAttributeDefinition @params
        }
        It "Verification of deactivation of custom security attribute definition"{
            $global:getDefinition = Get-EntraCustomSecurityAttributeDefinition -Id $Definition.Id
            $getDefinition.Status | Should -Be 'Deprecated' 
        }
    }
    AfterAll {
        Remove-EntraRoleAssignment -Id $assignedRole.Id
        foreach ($user in (Get-EntraUser -SearchString "SimpleTestUsers")) {
            Remove-EntraUser -ObjectId $user.Id | Out-Null
        }
        # Remove-EntraRoleDefinition -Id $getRole.Id

    }
}
