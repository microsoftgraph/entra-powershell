# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
BeforeAll {
    $testReportPath = join-path $psscriptroot "..\setenv.ps1"
    . $testReportPath
    $password = $env:USER_PASSWORD
}
Describe "Integration Testing" {

    Context "Scen1: Creating Applications and attaching secrets to that newly created application"{
        It "Creating New Application"{
            $thisTestInstanceId = New-Guid | Select-Object -expandproperty guid
            $global:testAppName = 'SimpleTestApp' + $thisTestInstanceId
            $global:newApp = New-EntraBetaApplication -DisplayName $testAppName
            $newApp.DisplayName | Should -Be $testAppName
        }
        It "Attaching a Secret to the Application"{
            $global:Result = New-EntraBetaApplicationPasswordCredential -ObjectId $newApp.Id -CustomKeyIdentifier "MySecret"
        }
        It "Verification of Application Creation"{
            $global:application = Get-EntraBetaApplication -ObjectId $newApp.Id 
            $application.DisplayName | Should -Be $testAppName
        }
        It "Verification of Attached Secret"{
            $application.PasswordCredentials.KeyId | Should -be $Result.KeyId
        }
    }  
    Context "Scen3: Create Service Principal to the newly created application"{
        It "Creation of the Service Principal"{
            $global:newServicePrincipal = New-EntraBetaServicePrincipal -AppId $newApp.AppId
            $newServicePrincipal.AppId | Should -Be $application.AppId
        }
    }
    Context "Scen2: Create Gallery application and setup PreferredSingleSignOn Mode to the application"{
        It "Setting PreferredSingleSignOn Mode to the application"{
            Set-EntraBetaServicePrincipal -ObjectId $newServicePrincipal.ObjectId -PreferredSingleSignOnMode 'password'
        }
        It "Verification of ServicePricipal Creation and Updated PreferredSingleSignOn"{
            $global:servicePrincipal= Get-EntraBetaServicePrincipal -ObjectId $newServicePrincipal.ObjectId
            $servicePrincipal.DisplayName | Should -Be $testAppName
            $servicePrincipal.PreferredSingleSignOnMode | Should -Be 'password'
        }
    } 
    Context "Scen4: Configure App ID URI and Redirect URIs on the newly created application"{
        It "Configuring the App ID URI and Redirect URI"{
            Set-EntraBetaApplication -ObjectId $newApp.Id -IdentifierUris @("IdentifierUri.com") -Web @{RedirectUris = 'https://contoso.com'}
        }
        It "Verifying the App ID URI configuration and Redirect URI"{
            $updatedApp = Get-EntraBetaApplication -ObjectId $newApp.Id | ConvertTo-json | ConvertFrom-json
            $updatedApp.IdentifierUris | Should -Be "IdentifierUri.com"
            $updatedApp.Web.RedirectUris | Should -Be "https://contoso.com"
        }
    } 
    Context "Scen5: Create AppRoles to the Application"{
        It "Create Approles"{
            $types = @()
            $types += 'Application'
            $approle = New-Object Microsoft.Open.MSGraph.Model.AppRole
            $approle.AllowedMemberTypes =  $types
            $approle.Description = 'msiam_access'
            $approle.DisplayName = 'msiam_access'
            $approle.Id = '643985ce-3eaf-4a67-9550-ecca25cb6814'
            $approle.Value = 'Application'
            $approle.IsEnabled = $true

             # Assign approles to existing applictaion
            $global:AppUpdate = Set-EntraBetaApplication -ObjectId $newApp.Id -AppRoles $approle
        }
        It "Verification of created Approles"{
            $global:updatedApp = Get-EntraBetaApplication -ObjectId $newApp.Id
            $updatedApp.AppRoles.DisplayName | Should -Be 'msiam_access'
            $updatedApp.AppRoles.Id | Should -Be '643985ce-3eaf-4a67-9550-ecca25cb6814'
            $updatedApp.AppRoles.Value | Should -Be 'Application'
        }
    }
    Context "Scen6: Assign user and groups to the newly created Service Principal and set right AppRole to it"{
        It "Creating user"{
            $domain = (Get-EntraBetaTenantDetail).VerifiedDomains.Name
            $thisTestInstanceId = (New-Guid).Guid.ToString()
            $thisTestInstanceId = $thisTestInstanceId.Substring($thisTestInstanceId.Length - 5)
            $user = 'SimpleTestUserss' + $thisTestInstanceId
            $PasswordProfile = New-Object -TypeName Microsoft.Open.AzureAD.Model.PasswordProfile
            $PasswordProfile.Password = $password
            $global:existingUser = New-EntraBetaUser -AccountEnabled $true -DisplayName $user -PasswordProfile $PasswordProfile -MailNickName $user -UserPrincipalName "$user@$domain"
        }
        It "Assigning users to the Service Principal and setting the correct AppRole for the Service Principal"{
            $global:existUser =  Get-EntraBetaUser -ObjectId $existingUser.Id
            Add-EntraBetaServicePrincipalOwner -ObjectId $servicePrincipal.Id -RefObjectId $existUser.Id
            
            $global:AppRoletoServicePrincipal = New-EntraBetaServiceAppRoleAssignment -ObjectId $servicePrincipal.Id -ResourceId $servicePrincipal.Id -Id $updatedApp.AppRoles.Id -PrincipalId $existUser.ObjectId
        }
        It "Verification of assigned group to service principal"{
            $PrincipalOwners= Get-EntraBetaServicePrincipalOwner -ObjectId $servicePrincipal.Id
            $PrincipalOwners.Id | Should -Contain $existUser.Id

            $RoleAssignment = Get-EntraBetaServiceAppRoleAssignment -ObjectId $servicePrincipal.Id
            $RoleAssignment.AppRoleId | Should -Be $AppRoletoServicePrincipal.AppRoleId
        }
    }
    Context "Scen7: Create a new user and add that user to an existing group"{
        It "Creating the user"{
            $domain = (Get-EntraBetaTenantDetail).VerifiedDomains.Name
            $thisTestInstanceId = (New-Guid).Guid.ToString()
            $thisTestInstanceId = $thisTestInstanceId.Substring($thisTestInstanceId.Length - 5)
            $user = 'SimpleTestUserss' + $thisTestInstanceId
            $PasswordProfile = New-Object -TypeName Microsoft.Open.AzureAD.Model.PasswordProfile
            $PasswordProfile.Password = $password
            $global:NewUser = New-EntraBetaUser -AccountEnabled $true -DisplayName $user -PasswordProfile $PasswordProfile -MailNickName $user -UserPrincipalName "$user@$domain"
        }
        It "Creating a new Group"{
            $testGrpName = 'SimpleTestGroup' + $thisTestInstanceId
            $global:ExistingGroup = New-EntraBetaGroup -DisplayName $testGrpName -MailEnabled $false -SecurityEnabled $true -MailNickName "NickName" 
        }
        It "Adding the user to an existing group"{
            $global:ExistGroup = Get-EntraBetaGroup -ObjectId $ExistingGroup.Id
            Add-EntraBetaGroupMember -ObjectId $ExistGroup.ObjectId -RefObjectId $NewUser.ObjectId
        }
        It "Verification of new user's addition to the existing group"{
            $GetMemb = Get-EntraBetaGroupMember -ObjectId $ExistGroup.ObjectId 
            $GetMemb.Id | Should -Contain $NewUser.Id
        }
    }
    Context "Scen8:Create a new group and add existing user to that group"{
        It "Creating a new Group"{
            $testGrpName = 'SimpleTestGroup' + $thisTestInstanceId
            $global:NewGroup = New-EntraBetaGroup -DisplayName $testGrpName -MailEnabled $false -SecurityEnabled $true -MailNickName "NickName" 
        }
        It "Adding existing user to new group"{
            $ExistUser = Get-EntraBetaUser -ObjectId $existingUser.Id
            Add-EntraBetaGroupMember -ObjectId $NewGroup.ObjectId -RefObjectId $ExistUser.ObjectId
        }
        It "Verification of exixting user's addition to the new group"{
            $User = Get-EntraBetaUser -ObjectId $existingUser.Id
            $GetMember = Get-EntraBetaGroupMember -ObjectId $NewGroup.ObjectId 
            $GetMember.Id | Should -Contain $User.Id
        }
    }
    Context "Scen9: Create a new user and create a new group and add that new user to the new group"{
        It "Creating a new user and group"{
            $domain = (Get-EntraBetaTenantDetail).VerifiedDomains.Name
            $thisTestInstanceId = (New-Guid).Guid.ToString()
            $thisTestInstanceId = $thisTestInstanceId.Substring($thisTestInstanceId.Length - 5)
            $testUserName = 'SimpleTestUsers' + $thisTestInstanceId
            # Create new User
            $PasswordProfile = New-Object -TypeName Microsoft.Open.AzureAD.Model.PasswordProfile
            $PasswordProfile.Password = $password
            $global:NewUser1 = New-EntraBetaUser -AccountEnabled $true -DisplayName $testUserName -PasswordProfile $PasswordProfile -MailNickName $testUserName -UserPrincipalName "$testUserName@$domain" 

            $testGrpName = 'SimpleTestGroup' + $thisTestInstanceId
            $global:NewGroup1 = New-EntraBetaGroup -DisplayName $testGrpName -MailEnabled $false -SecurityEnabled $true -MailNickName "NickName"
        }
        It "Adding New User to New group"{
            Add-EntraBetaGroupMember -ObjectId $NewGroup1.ObjectId -RefObjectId $NewUser1.ObjectId
        }
    }
    Context "Scen10: Create a new user and add the user to the newly created group and check that user is Member of the group"{
        It "Creating a new user and group"{
            $domain = (Get-EntraBetaTenantDetail).VerifiedDomains.Name
            $thisTestInstanceId = (New-Guid).Guid.ToString()
            $thisTestInstanceId = $thisTestInstanceId.Substring($thisTestInstanceId.Length - 5)
            $testUserName = 'SimpleTestUsers' + $thisTestInstanceId
            # Create new User
            $PasswordProfile = New-Object -TypeName Microsoft.Open.AzureAD.Model.PasswordProfile
            $PasswordProfile.Password = $password
            $global:NewUser2 = New-EntraBetaUser -AccountEnabled $true -DisplayName $testUserName -PasswordProfile $PasswordProfile -MailNickName $testUserName -UserPrincipalName "$testUserName@$domain"

            $testGrpName = 'SimpleTestGroup' + $thisTestInstanceId
            $global:NewGroup2 = New-EntraBetaGroup -DisplayName $testGrpName -MailEnabled $false -SecurityEnabled $true -MailNickName "NickName"
        }
        It "Adding New User to New group"{
            Add-EntraBetaGroupMember -ObjectId $NewGroup2.ObjectId -RefObjectId $NewUser2.ObjectId
        }
        It "Verification of User is Member of the group"{
            $GetMember = Get-EntraBetaUserMembership -ObjectId $NewUser2.Id
            $GetMember.Id | Should -Contain $NewGroup2.Id
        }
    }
    Context "Scen11: Create a new user and assign that user to the existing Service Principal"{
        It "Creating a new user and assign that user to the existing Service Principal"{
            $domain = (Get-EntraBetaTenantDetail).VerifiedDomains.Name
            $thisTestInstanceId = (New-Guid).Guid.ToString()
            $thisTestInstanceId = $thisTestInstanceId.Substring($thisTestInstanceId.Length - 5)
            $thisTestInstanceId = New-Guid | Select-Object -expandproperty guid
            $Tuser = 'SimpleTestUsers' + $thisTestInstanceId
            $PasswordProfile = New-Object -TypeName Microsoft.Open.AzureAD.Model.PasswordProfile
            $PasswordProfile.Password = $password
            $global:NewUser3 = New-EntraBetaUser -AccountEnabled $true -DisplayName $Tuser -PasswordProfile $PasswordProfile -MailNickName $Tuser -UserPrincipalName "$Tuser@$domain"
            Add-EntraBetaServicePrincipalOwner -ObjectId $servicePrincipal.Id -RefObjectId $NewUser3.Id
        }
        It "Verfication of assigned User"{
            $GetOwner = Get-EntraBetaServicePrincipalOwner -ObjectId $servicePrincipal.Id
            $GetOwner.Id | Should -Contain $NewUser3.Id
        }
    }
    # Context "Scen12: Create a new conditional access policy and attach that policy to the Service Principal"{
    #     It "Creating a new conditional access policy and attach that policy to the Service Principal"{
    #         $thisTestInstanceId = New-Guid | Select-Object -expandproperty guid
    #         $testpolicyName = 'Simplepolicy' + $thisTestInstanceId

    #         $Condition = New-Object -TypeName Microsoft.Open.MSGraph.Model.ConditionalAccessConditionSet
    #         $Condition.clientAppTypes = @("mobileAppsAndDesktopClients","browser")
    #         $Condition.Applications = New-Object -TypeName Microsoft.Open.MSGraph.Model.ConditionalAccessApplicationCondition
    #         $Condition.Applications.IncludeApplications = $NewServicePrincipal.AppId
    #         $Condition.Users = New-Object -TypeName Microsoft.Open.MSGraph.Model.ConditionalAccessUserCondition
    #         $Condition.Users.IncludeUsers = "all"

    #         $Controls = New-Object -TypeName Microsoft.Open.MSGraph.Model.ConditionalAccessGrantControls
    #         $Controls._Operator = "AND"
    #         $Controls.BuiltInControls = @("mfa")

    #         $SessionControls = New-Object -TypeName Microsoft.Open.MSGraph.Model.ConditionalAccessSessionControls
    #         $ApplicationEnforcedRestrictions = New-Object Microsoft.Open.MSGraph.Model.ConditionalAccessApplicationEnforcedRestrictions
    #         $ApplicationEnforcedRestrictions.IsEnabled = $true
    #         $SessionControls.applicationEnforcedRestrictions = $ApplicationEnforcedRestrictions

    #         $global:NewConditionalAccessPolicy = New-EntraBetaConditionalAccessPolicy -DisplayName $testpolicyName -State enabled -Conditions $Condition -GrantControls $Controls -SessionControls $SessionControls
    #     }
    #     It "Verification of attached policy"{
    #         $result = Get-EntraBetaConditionalAccessPolicy -policyid $NewConditionalAccessPolicy.Id 
    #         $result.Conditions.Applications.IncludeApplications | should -Be $NewServicePrincipal.AppId
    #     }
    # }
    Context "Scen13: Create new claims issuance policy and attach that to the Service Principal"{
        It "Creating policy"{
            $thisTestInstanceId = New-Guid | Select-Object -expandproperty guid
            $testpolicyName = 'Simplepolicy' + $thisTestInstanceId
            $global:NewPolicy = New-EntraBetaPolicy -Definition @('{ "definition": [ "{\"ClaimsMappingPolicy\":{\"Version\":1,\"IncludeBasicClaimSet\":\"true\",\"ClaimsSchema\":[{\"Source\":\"user\",\"ID\":\"userPrincipalName\",\"SAMLClaimType\":\"http://schemas.xmlsoap.org/ws/2005/05/identity/claims/name\",\"JwtClaimType\":\"upn\"},{\"Source\":\"user\",\"ID\":\"displayName\",\"SAMLClaimType\":\"http://schemas.microsoft.com/identity/claims/displayname\",\"JwtClaimType\":\"name\"}]}}" ], "displayName": "Custom Claims Issuance Policy", "isOrganizationDefault": false }') -DisplayName $testpolicyName -Type "claimsMappingPolicies" -IsOrganizationDefault $false
        }
        It "Attaching Policy to service principal"{
            Add-EntraBetaServicePrincipalPolicy -Id $servicePrincipal.Id -RefObjectId $NewPolicy.Id
        }
        It "Verification of added policy to service principal"{
            $result = Get-EntraBetaServicePrincipalPolicy -Id $servicePrincipal.Id
            $result.Id | should -Contain $NewPolicy.Id
        }
    }
    Context "Scene14: Remove the policy attached to the existing Service Principal"{
        It "Removing the policy attached"{
            Remove-EntraBetaServicePrincipalPolicy -Id $servicePrincipal.Id -PolicyId $NewPolicy.Id
            $retrivePolicy = Get-EntraBetaServicePrincipalPolicy -Id $servicePrincipal.Id
            $retrivePolicy.Id | should -Not -Contain $NewPolicy.Id
        }
    }

    AfterAll {
        Remove-EntraBetaGroupMember -ObjectId $ExistGroup.ObjectId -MemberId $NewUser.ObjectId
        Remove-EntraBetaGroupMember -ObjectId $NewGroup.ObjectId -MemberId $ExistUser.ObjectId
        Remove-EntraBetaGroupMember -ObjectId $NewGroup1.ObjectId -MemberId $NewUser1.ObjectId
        Remove-EntraBetaGroupMember -ObjectId $NewGroup2.ObjectId -MemberId $NewUser2.ObjectId
        
        foreach ($app in (Get-EntraBetaApplication -SearchString "SimpleTestApp")) {
            Remove-EntraBetaApplication -ObjectId $app.Id | Out-Null
        }
        foreach ($user in (Get-EntraBetaUser -SearchString "SimpleTestUsers")) {
            Remove-EntraBetaUser -ObjectId $user.Id | Out-Null
        }
        foreach ($group in (Get-EntraBetaGroup -SearchString "SimpleTestGroup")) {
            Remove-EntraBetaGroup -ObjectId $group.Id | Out-Null
        }
        # Remove-EntraBetaConditionalAccessPolicy -PolicyId $NewConditionalAccessPolicy.Id
        Remove-EntraBetaPolicy -Id $NewPolicy.Id
    }
}
