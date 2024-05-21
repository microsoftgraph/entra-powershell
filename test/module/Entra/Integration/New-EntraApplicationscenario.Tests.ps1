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
        It "Scen1: Creating Applications and attaching secrets to that newly created application " {
             # Create New application
            $thisTestInstanceId = New-Guid | select -expandproperty guid
            $global:testAppName = 'SimpleTestApp' + $thisTestInstanceId
            $global:newApp = New-EntraApplication -DisplayName $testAppName -AvailableToOtherTenants $true -ReplyUrls @("https://yourapp.com") 
            $newApp.DisplayName | Should -Be $testAppName

            $Result = New-EntraApplicationPasswordCredential -ObjectId $newApp.Id -CustomKeyIdentifier "MySecret" 

            # Retrive application password credentials and verify keyId is present or not
            # $Result1 = Get-EntraApplicationPasswordCredential -ObjectId $newApp.Id
            # $Result1.KeyId | Should -be $Result.KeyId

            # Retrive new created application 
            $global:application = Get-EntraApplication -ObjectId $newApp.Id 
            
            # verify keyId 
            $application.PasswordCredentials.KeyId | Should -be $Result.KeyId
        }
        It "Scen3: Create Service Principal to the newly created application" {

            # Create service Principal for new application
            $global:NewServicePrincipal = New-EntraServicePrincipal -AppId $application.AppId

            # store service principal objectId
            $global:servicePrincipalObjectId = $NewServicePrincipal.ObjectId

             # Get created service principal
            $ServicePrincipal = Get-EntraServicePrincipal -ObjectId $servicePrincipalObjectId
            $ServicePrincipal.AppId | Should -Be $application.AppId

        }
        It "Scen4: Configure App ID URI and Redirect URIs on the newly created application" {

             # configure application fot ID URI
            $configureApp = Set-EntraApplication -ObjectId $newApp.Id -IdentifierUris @("IdM365x992972700.onmicrosoft.com")

            # Retrive new application and verifying ID URI 
            $updatedApp = Get-EntraApplication -ObjectId $newApp.Id
            $updatedApp.IdentifierUris | Should -Be "IdM365x992972700.onmicrosoft.com"
        }
        It "Scen5: Create AppRoles to the Application" {
            
            # create approles
            $types += 'User'
            $approle = New-Object Microsoft.Open.AzureAD.Model.AppRole
            $approle.AllowedMemberTypes =  $types
            $approle.Description = 'msiam_access'
            $approle.DisplayName = 'msiam_access'
            $approle.Id = '643985ce-3eaf-4a67-9550-ecca25cb6814'
            $approle.Value = 'Application'
            $approle.IsEnabled = $true

             # Assign approles to newly created applictaion
            $thisTestInstanceId = New-Guid | select -expandproperty guid
            $testAppName1 = 'SimpleTestApp' + $thisTestInstanceId
            $global:newApp1 = New-EntraApplication -DisplayName $testAppName1 -AvailableToOtherTenants $true -AppRoles $approle
            $newApp1.DisplayName | Should -Be $testAppName1

            # Retrive new application and verifying AppRoles 
            $updatedApp = Get-EntraApplication -ObjectId $newApp1.Id
            $updatedApp.AppRoles.DisplayName | Should -Be 'msiam_access'
            $updatedApp.AppRoles.Id | Should -Be '643985ce-3eaf-4a67-9550-ecca25cb6814'
            $updatedApp.AppRoles.Value | Should -Be 'Application'
        }
        # It "Scen6: Assign user and groups to the newly created Service Principal and set right AppRole to it" {
            
        #     $thisTestInstanceId = New-Guid | select -expandproperty guid
            # $testGrpName = 'SimpleTestGrp' + $thisTestInstanceId
            # $testUserName = 'SimpleTestUser' + $thisTestInstanceId

        #     # store service principal object
        #     $global:servicePrincipalObjectId = $NewServicePrincipal.ObjectId
        #     write-host "serviceP  $servicePrincipalObjectId"

        #     # Create new Group
        #     $NewGroup = New-EntraGroup -DisplayName $testGrpName -MailEnabled $false -SecurityEnabled $true -MailNickName "NickName" | ConvertTo-json | ConvertFrom-json
        #     write-host "New Group $NewGroup.Id"
        #     # Create new User
        #     $PasswordProfile = New-Object -TypeName Microsoft.Open.AzureAD.Model.PasswordProfile
        #     $PasswordProfile.Password = "Pass@1234"
        #     $NewUser = New-EntraUser -AccountEnabled $true -DisplayName $testUserName -PasswordProfile $PasswordProfile -MailNickName $testUserName -UserPrincipalName "$testUserName@M365x99297270.OnMicrosoft.com" 
        #     write-host "NewUser $NewUser.Id"

        #     # $GrpToServicePrincipal = Add-EntraGroupOwner -ObjectId $NewGroup.ObjectId -RefObjectId $servicePrincipalObjectId
        #     # write-host $GrpToServicePrincipal
        #     $userToServicePrincipal = Add-EntraGroupMember -ObjectId $NewGroup.Id -RefObjectId $servicePrincipalObjectId 
        #      write-host $userToServicePrincipal
           
        # }
        It "Scen7: Create a new user and add that user to an existing group"{
            # Create new User
            $thisTestInstanceId = New-Guid | select -expandproperty guid
            $user = 'userName' + $thisTestInstanceId
            $PasswordProfile = New-Object -TypeName Microsoft.Open.AzureAD.Model.PasswordProfile
            $PasswordProfile.Password = "Pass@1234"
            $global:NewUser = New-EntraUser -AccountEnabled $true -DisplayName $user -PasswordProfile $PasswordProfile -MailNickName $user -UserPrincipalName "$user@M365x99297270.OnMicrosoft.com" 
            # Retrive existing group
            $Group = Get-EntraGroup -top 1

            # Add Group member
            $NewMem = Add-EntraGroupMember -ObjectId $Group.ObjectId -RefObjectId $NewUser.ObjectId

            # Get group member
            $GetMemb = Get-EntraGroupMember -ObjectId $Group.ObjectId 
            $GetMemb.Id | Should -Contain $NewUser.Id

        }
        It "Scen8:Create a new group and add existing user to that group"{
            # Create new Group
            $testGrpName = 'SimpleTestGrp' + $thisTestInstanceId
            $global:NewGroup = New-EntraGroup -DisplayName $testGrpName -MailEnabled $false -SecurityEnabled $true -MailNickName "NickName" | ConvertTo-json | ConvertFrom-json
            # Retrive existing User
            $User = Get-EntraUser -top 1

            # Add group member
            $NewMem = Add-EntraGroupMember -ObjectId $NewGroup.ObjectId -RefObjectId $User.ObjectId

            # Get group member
            $GetMember = Get-EntraGroupMember -ObjectId $Group.ObjectId 
            $GetMember.Id | Should -Contain $NewUser.Id

        }
         It "Scen9: Create a new user and create a new group and add that new user to the new group"{
            
            $thisTestInstanceId = New-Guid | select -expandproperty guid
            $testGrpName = 'SimpleGroup' + $thisTestInstanceId
            $testUserName = 'SimpleUser' + $thisTestInstanceId
            # Create new User
            $PasswordProfile = New-Object -TypeName Microsoft.Open.AzureAD.Model.PasswordProfile
            $PasswordProfile.Password = "Pass@1234"
            $global:NewUser1 = New-EntraUser -AccountEnabled $true -DisplayName $testUserName -PasswordProfile $PasswordProfile -MailNickName $testUserName -UserPrincipalName "$testUserName@M365x99297270.OnMicrosoft.com" 
            
            # Create new Group
            $global:NewGroup1 = New-EntraGroup -DisplayName $testGrpName -MailEnabled $false -SecurityEnabled $true -MailNickName "NickName" | ConvertTo-json | ConvertFrom-json

            # Add group member
            $NewMem = Add-EntraGroupMember -ObjectId $NewGroup1.ObjectId -RefObjectId $NewUser1.ObjectId

            # Get group member
            # $GetMember = Get-EntraGroupMember -ObjectId $NewGroup1.ObjectId 
            # $GetMember.Id | Should -Be $NewUser1.Id

        }
        It "Scen10: Create a new user and add the user to the newly created group and check that user is Member of the group"{
            
            $thisTestInstanceId = New-Guid | select -expandproperty guid
            $testGrpName = 'SimpleGroup' + $thisTestInstanceId
            $testUserName = 'SimpleUser' + $thisTestInstanceId
            # Create new User
            $PasswordProfile = New-Object -TypeName Microsoft.Open.AzureAD.Model.PasswordProfile
            $PasswordProfile.Password = "Pass@1234"
            $global:NewUser2 = New-EntraUser -AccountEnabled $true -DisplayName $testUserName -PasswordProfile $PasswordProfile -MailNickName $testUserName -UserPrincipalName "$testUserName@M365x99297270.OnMicrosoft.com" 
            
            # Create new Group
            $global:NewGroup2 = New-EntraGroup -DisplayName $testGrpName -MailEnabled $false -SecurityEnabled $true -MailNickName "NickName" | ConvertTo-json | ConvertFrom-json

            # Add group member
            $NewMem = Add-EntraGroupMember -ObjectId $NewGroup2.ObjectId -RefObjectId $NewUser2.ObjectId

            # User is member of the new group
            $GetMember = Get-EntraGroupMember -ObjectId $NewGroup2.ObjectId 
            $GetMember.Id | Should -Be $NewUser2.Id
        }
        It "Scen11: Create a new user and assign that user to the existing Service Principal"{
            # Create new User
            $thisTestInstanceId = New-Guid | select -expandproperty guid
            $Tuser = 'user' + $thisTestInstanceId
            $PasswordProfile = New-Object -TypeName Microsoft.Open.AzureAD.Model.PasswordProfile
            $PasswordProfile.Password = "Pass@1234"
            $global:NewUser3 = New-EntraUser -AccountEnabled $true -DisplayName $Tuser -PasswordProfile $PasswordProfile -MailNickName $Tuser -UserPrincipalName "$Tuser@M365x99297270.OnMicrosoft.com" 
            
            # Assign user to service principal
            $NewOwner= Add-EntraServicePrincipalOwner -ObjectId $servicePrincipalObjectId  -RefObjectId $NewUser3.ObjectId

            # Get group member
            $GetOwner = Get-EntraServicePrincipalOwner -ObjectId $servicePrincipalObjectId 
            $GetOwner.ObjectId | Should -Contain $NewUser3.Id

        }
        It "Scen12: Create a new conditional access policy and attach that policy to the Service Principal" {
            # Create conditional access policy
            $thisTestInstanceId = New-Guid | select -expandproperty guid
            $testpolicyName = 'Simplepolicy' + $thisTestInstanceId

            $Condition = New-Object -TypeName Microsoft.Open.MSGraph.Model.ConditionalAccessConditionSet
            $Condition.clientAppTypes = @("mobileAppsAndDesktopClients","browser")
            $Condition.Applications = New-Object -TypeName Microsoft.Open.MSGraph.Model.ConditionalAccessApplicationCondition
            $Condition.Applications.IncludeApplications = "00000002-0000-0ff1-ce00-000000000000"
            $Condition.Users = New-Object -TypeName Microsoft.Open.MSGraph.Model.ConditionalAccessUserCondition
            $Condition.Users.IncludeUsers = "all"

            $Controls = New-Object -TypeName Microsoft.Open.MSGraph.Model.ConditionalAccessGrantControls
            $Controls._Operator = "AND"
            $Controls.BuiltInControls = @("mfa")

            $SessionControls = New-Object -TypeName Microsoft.Open.MSGraph.Model.ConditionalAccessSessionControls
            $ApplicationEnforcedRestrictions = New-Object Microsoft.Open.MSGraph.Model.ConditionalAccessApplicationEnforcedRestrictions
            $ApplicationEnforcedRestrictions.IsEnabled = $true
            $SessionControls.applicationEnforcedRestrictions = $ApplicationEnforcedRestrictions

            $global:NewConditionalAccessPolicy = New-EntraMSConditionalAccessPolicy -DisplayName $testpolicyName -State enabled -Conditions $Condition -GrantControls $Controls -SessionControls $SessionControls

            
            # $ConditionalPolicyToServicePrincipal = Add-EntraServicePrincipalPolicy -Id $servicePrincipalObjectId -RefObjectId $NewConditionalAccessPolicy.Id
            # write-Host $ConditionalPolicyToServicePrincipal
        }

        AfterAll {
                Remove-EntraMSConditionalAccessPolicy -PolicyId $NewConditionalAccessPolicy.Id
                Remove-EntraServicePrincipalOwner -ObjectId $servicePrincipalObjectId -OwnerId $NewUser3.ObjectId
                Remove-EntraGroupMember -ObjectId $NewGroup2.ObjectId -MemberId $NewUser2.ObjectId
                Remove-EntraGroupMember -ObjectId $NewGroup1.ObjectId -MemberId $NewUser1.ObjectId
                # Remove-EntraGroupMember -ObjectId $Group.ObjectId -MemberId $NewUser.ObjectId
                # Remove-EntraGroupMember -ObjectId $NewGroup.ObjectId -MemberId $User.ObjectId
                Remove-EntraServicePrincipal -ObjectId $NewServicePrincipal.ObjectId 
                Remove-EntraApplication -ObjectId $newApp.Id | Out-Null
                Remove-EntraApplication -ObjectId $newApp1.Id | Out-Null
                Remove-EntraGroup -ObjectId $NewGroup.ObjectId
                Remove-EntraGroup -ObjectId $NewGroup1.ObjectId
                Remove-EntraGroup -ObjectId $NewGroup2.ObjectId
                Remove-EntraUser -ObjectId $NewUser.Id
                Remove-EntraUser -ObjectId $NewUser1.Id
                Remove-EntraUser -ObjectId $NewUser2.Id
                Remove-EntraUser -ObjectId $NewUser3.Id

        }

    }
}
