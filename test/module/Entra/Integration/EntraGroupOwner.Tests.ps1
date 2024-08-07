Describe "The EntraGroupOwner command executing unmocked" {

    Context "When getting user and group" {
        BeforeAll {
            $testReportPath = join-path $psscriptroot "\setenv.ps1"
            Import-Module -Name $testReportPath
            $appId = $env:TEST_APPID
            $tenantId = $env:TEST_TENANTID
            $cert = $env:CERTIFICATETHUMBPRINT
            Connect-Entra -TenantId $tenantId  -AppId $appId -CertificateThumbprint $cert

            $thisTestInstanceId = New-Guid | Select-Object -expandproperty guid
            $global:displayName = 'DemoName' + $thisTestInstanceId
            
            $global:newGroup = New-EntraGroup -DisplayName $displayName -MailEnabled $false -SecurityEnabled $true -MailNickName  $displayName
        }

        It "should successfully get a specific group by using an Id" {
            $group = Get-EntraGroup -ObjectId $newGroup.Id
            $group.Id | Should -Be $newGroup.Id
            $group.DisplayName | Should -Be $displayName
        }

        It "should successfully update a group display name" {
            $global:updatedDisplayName = "DemoNameUpdated"
            Set-EntraGroup -ObjectId $newGroup.Id -DisplayName $updatedDisplayName
            $result = Get-EntraGroup -ObjectId $newGroup.Id
            $result.Id | Should -Contain $newGroup.Id
            $result.DisplayName | Should -Contain $updatedDisplayName
        }

        It "should successfully create user" {
            $PasswordProfile = New-Object -TypeName Microsoft.Open.AzureAD.Model.PasswordProfile
            $PasswordProfile.Password = "Pass@12345"
            $thisTestInstanceId = New-Guid | Select-Object -expandproperty guid
            $Username = 'DemoName' + $thisTestInstanceId
            $UserPrincipalName = "$Username@M365x99297270.OnMicrosoft.com"
            $global:newUser = New-EntraUser -DisplayName $updatedDisplayName -PasswordProfile $PasswordProfile -UserPrincipalName $UserPrincipalName -AccountEnabled $true -MailNickName $updatedDisplayName
        }

        It "should successfully get created user" {
            $user = Get-EntraUser -ObjectId $newUser.Id
            $user.Id | Should -Be $newUser.Id
            $user.DisplayName | Should -Be $updatedDisplayName
        }
        
        It "should successfully update created user" {
            $user = Get-EntraUser -ObjectId $newUser.Id
            $user.Id | Should -Be $newUser.Id
            $user.DisplayName | Should -Be $updatedDisplayName
            $updatedDisplayNameInCreatedUser = 'YetAnotherTestUser' 
            Set-EntraUser -ObjectId $newUser.Id -Displayname $updatedDisplayNameInCreatedUser
            $global:updatedUser = Get-EntraUser -ObjectId $newUser.Id
            $updatedUser.Id | Should -Be $newUser.Id
            $updatedUser.DisplayName | Should -Be $updatedDisplayNameInCreatedUser
        }

        It "should successfully create and get group owner" {
            Add-EntraGroupOwner -ObjectId $newGroup.Id -RefObjectId $updatedUser.Id
            $global:getCreatedGroupOwner = Get-EntraGroupOwner -ObjectId $newGroup.Id
            $getCreatedGroupOwner.Id | Should -Be $updatedUser.Id
        }

        It "should successfully create second user" {
            $PasswordProfile1 = New-Object -TypeName Microsoft.Open.AzureAD.Model.PasswordProfile
            $PasswordProfile1.Password = "Pass@12345"
            $thisTestInstanceId = New-Guid | Select-Object -expandproperty guid
            $Username1 = 'DemoName2' + $thisTestInstanceId
            $UserPrincipalName1 = "$Username1@M365x99297270.OnMicrosoft.com"
            $global:newUser1 = New-EntraUser -DisplayName $updatedDisplayName -PasswordProfile $PasswordProfile1 -UserPrincipalName $UserPrincipalName1 -AccountEnabled $true -MailNickName $updatedDisplayName
        }

        It "should successfully create and get group owner for second user" {
            Add-EntraGroupOwner -ObjectId $newGroup.Id -RefObjectId $newUser1.Id
            $getCreatedGroupOwner1 = Get-EntraGroupOwner -ObjectId $newGroup.Id
            $retrievedIds = $getCreatedGroupOwner1.Id | Sort-Object -Unique
            $retrievedIds.Count | Should -BeExactly 2
            $retrievedIds | should -Contain $newUser1.Id
        }

        AfterAll {
            if ($getCreatedGroupOwner) {
                Remove-EntraGroupOwner -ObjectId $newGroup.Id -OwnerId $getCreatedGroupOwner.Id | Out-Null
            }
            if ($updatedUser) {
                Remove-EntraUser -ObjectId $updatedUser.Id | Out-Null
            }
            if ($newGroup) {
                Remove-EntraGroup -ObjectId $newGroup.Id | Out-Null
            }
            if ($newUser1) {
                Remove-EntraUser -ObjectId $newUser1.Id | Out-Null
            }
        }
    }
}