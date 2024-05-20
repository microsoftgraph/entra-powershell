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

            # Get created service principal
            $ServicePrincipal = Get-EntraServicePrincipal -ObjectId $NewServicePrincipal.ObjectId
            $ServicePrincipal.AppId | Should -Be $application.AppId

        }
        It "Scen4: Configure App ID URI and Redirect URIs on the newly created application" {

             # configure application fot ID URI
            $configureApp = Set-EntraApplication -ObjectId $newApp.Id -IdentifierUris @("M365x992972700.onmicrosoft.com")

            # Retrive new application and verifying ID URI 
            $updatedApp = Get-EntraApplication -ObjectId $newApp.Id
            $updatedApp.IdentifierUris | Should -Be "M365x992972700.onmicrosoft.com"
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
        # It "Scen6:Assign user and groups to the newly created Service Principal and set right AppRole to it" {
            
        #     $thisTestInstanceId = New-Guid | select -expandproperty guid
        #     $global:testGrpName = 'SimpleTestGrp' + $thisTestInstanceId
        #     $global:testUserName = 'SimpleTestUser' + $thisTestInstanceId

        #     # store service principal object
        #     $global:servicePrincipalObjectId = $NewServicePrincipal.ObjectId
        #     write-host "serviceP  $servicePrincipalObjectId"

        #     # Create new Group
        #     $global:NewGroup = New-EntraGroup -DisplayName $testGrpName -MailEnabled $false -SecurityEnabled $true -MailNickName "NickName" | ConvertTo-json | ConvertFrom-json
        #     write-host "New Group $NewGroup.Id"
        #     # Create new User
        #     $PasswordProfile = New-Object -TypeName Microsoft.Open.AzureAD.Model.PasswordProfile
        #     $PasswordProfile.Password = "Pass@1234"
        #     $global:NewUser = New-EntraUser -AccountEnabled $true -DisplayName $testUserName -PasswordProfile $PasswordProfile -MailNickName $testUserName -UserPrincipalName "$testUserName@M365x99297270.OnMicrosoft.com" 
        #     write-host "NewUser $NewUser.Id"

        #     # $GrpToServicePrincipal = Add-EntraGroupOwner -ObjectId $NewGroup.ObjectId -RefObjectId $servicePrincipalObjectId
        #     # write-host $GrpToServicePrincipal
        #     $userToServicePrincipal = Add-EntraGroupMember -ObjectId $NewGroup.Id -RefObjectId $servicePrincipalObjectId 
        #      write-host $userToServicePrincipal
           
        # }
        It "Scen7:Create a new user and add that user to an existing group"{
            # Create new User
            $PasswordProfile = New-Object -TypeName Microsoft.Open.AzureAD.Model.PasswordProfile
            $PasswordProfile.Password = "Pass@1234"
            $global:NewUser = New-EntraUser -AccountEnabled $true -DisplayName $testUserName -PasswordProfile $PasswordProfile -MailNickName $testUserName -UserPrincipalName "$testUserName@M365x99297270.OnMicrosoft.com" 
            # Retrive existing group
            $global:Group = Get-EntraGroup -top 1

            # Add Group member
            $NewMem = Add-EntraGroupMember -ObjectId $Group.ObjectId -RefObjectId $NewUser.ObjectId

            # Get group member
            $GetMemb = Get-EntraGroupMember -ObjectId $Group.ObjectId 
            $GetMemb.Id[-1] | Should -Be $NewUser.Id

        }
        It "Scen8:Create a new group and add existing user to that group"{
            # Create new Group
            $global:NewGroup = New-EntraGroup -DisplayName $testGrpName -MailEnabled $false -SecurityEnabled $true -MailNickName "NickName" | ConvertTo-json | ConvertFrom-json
            # Retrive existing User
            $User = Get-EntraUser -top 1

            # Add hroup member
            $NewMem = Add-EntraGroupMember -ObjectId $NewGroup.ObjectId -RefObjectId $User.ObjectId

            # Get group member
            $GetMember = Get-EntraGroupMember -ObjectId $Group.ObjectId 
            $GetMember.Id[-1] | Should -Be $NewUser.Id

        }


        AfterAll {
                Remove-EntraGroupMember -ObjectId $Group.ObjectId -MemberId $NewUser.ObjectId
                Remove-EntraServicePrincipal -ObjectId $NewServicePrincipal.ObjectId 
                Remove-EntraApplication -ObjectId $newApp.Id | Out-Null
                Remove-EntraApplication -ObjectId $newApp1.Id | Out-Null
                Remove-EntraGroup -ObjectId $NewGroup.ObjectId
                Remove-EntraUser -ObjectId $NewUser.Id
                

        }

    }
}
