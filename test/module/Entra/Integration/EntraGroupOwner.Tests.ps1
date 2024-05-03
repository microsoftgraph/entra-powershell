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
            
            #create test group 
            $global:newGroup = New-EntraGroup -DisplayName $displayName -MailEnabled $false -SecurityEnabled $true -MailNickName  $displayName
            Write-Host $newGroup.Id
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
            #create test user 
            $PasswordProfile = New-Object -TypeName Microsoft.Open.AzureAD.Model.PasswordProfile
            $PasswordProfile.Password = "Pass@12345"
            $thisTestInstanceId = New-Guid | Select-Object -expandproperty guid
            $Username = 'DemoName' + $thisTestInstanceId
            $UserPrincipalName = "$Username@M365x99297270.OnMicrosoft.com"
            $global:newUser = New-EntraUser -DisplayName $updatedDisplayName -PasswordProfile $PasswordProfile -UserPrincipalName $UserPrincipalName -AccountEnabled $true -MailNickName $updatedDisplayName
            Write-Host $newUser
        }

        It "should successfully get user" {
            $user = Get-EntraUser -ObjectId $newUser.Id
            $user.Id | Should -Be $newUser.Id
            $user.DisplayName | Should -Be $updatedDisplayName
        }
        
        It "should successfully get user" {
            $user = Get-EntraUser -ObjectId $newUser.Id
            $user.Id | Should -Be $newUser.Id
            $user.DisplayName | Should -Be $updatedDisplayName
            $updatedDisplayNameInCreatedUser = 'YetAnotherTestUser' 
            Set-EntraUser -ObjectId $newUser.Id -Displayname $updatedDisplayNameInCreatedUser
            $global:updatedUser = Get-EntraUser -ObjectId $newUser.Id
            $updatedUser.Id | Should -Be $newUser.Id
            $updatedUser.DisplayName | Should -Be $updatedDisplayNameInCreatedUser
            Write-Host $updatedUser.Id
        }

        It "should successfully create and get group owner" {
            #create group owner
            $createdGroupOwner= Add-EntraGroupOwner -ObjectId $newGroup.Id -RefObjectId $updatedUser.Id
            Write-Host $createdGroupOwner | FL

            $global:getCreatedGroupOwner = Get-EntraGroupOwner -ObjectId $newGroup.Id
            $getCreatedGroupOwner.Id | Should -Be $updatedUser.Id
            Write-Host $getCreatedGroupOwner
            Write-Host $getCreatedGroupOwner.Id
        }

        AfterAll {
            if ($getCreatedGroupOwner) {
                Remove-EntraGroupOwner -ObjectId $updatedUser.Id -OwnerId $getCreatedGroupOwner.Id | Out-Null
            }
            if ($updatedUser) {
                Remove-EntraUser -ObjectId $updatedUser.Id | Out-Null
            }
            if ($newGroup) {
                Remove-EntraGroup -ObjectId $newGroup.Id | Out-Null
            }
        }
    }
}