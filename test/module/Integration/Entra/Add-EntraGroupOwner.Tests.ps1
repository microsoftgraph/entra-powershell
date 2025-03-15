# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
Describe "The Add-EntraGroupOwner command executing unmocked" {

    Context "When getting user and group" {
        BeforeAll {
            $testReportPath = join-path $psscriptroot "..\setenv.ps1"
            . $testReportPath
            $password = $env:USER_PASSWORD

            $domain = (Get-EntraTenantDetail).VerifiedDomains.Name
            $thisTestInstanceId = (New-Guid).Guid.ToString()
            $thisTestInstanceId = $thisTestInstanceId.Substring($thisTestInstanceId.Length - 5)
            $testName = 'SimpleTests' + $thisTestInstanceId
            $testName1 = 'SimpleTests1' + $thisTestInstanceId

            #create test user 
            $PasswordProfile = New-Object -TypeName Microsoft.Open.AzureAD.Model.PasswordProfile
            $PasswordProfile.Password = $password
            $global:newUser = New-EntraUser -AccountEnabled $true -DisplayName $testName -PasswordProfile $PasswordProfile -MailNickName $testName -UserPrincipalName "$testName@$domain"
    
            #create test user 
            $PasswordProfile1 = New-Object -TypeName Microsoft.Open.AzureAD.Model.PasswordProfile
            $PasswordProfile1.Password = $password
            $global:newUser1 = New-EntraUser -AccountEnabled $true -DisplayName $testName1 -PasswordProfile $PasswordProfile1 -MailNickName $testName1 -UserPrincipalName "$testName1@$domain"
            #create test group 
            $global:newGroup = New-EntraGroup -DisplayName $testName -MailEnabled $false -SecurityEnabled $true -MailNickName $testName 
        }

        It "should update the properties of user and group" {            
            $updatedDisplayName = "SimpleTestsUpdated"
            Set-EntraGroup -Id $newGroup.Id -DisplayName $updatedDisplayName
            
            $result = Get-EntraGroup -ObjectId $newGroup.Id
            $result.Id | Should -Contain $newGroup.Id
            $result.DisplayName | Should -Contain $updatedDisplayName

            $updatedDisplayNameInCreatedUser = 'SimpleTests1AnotherTestUser' 
            Set-EntraUser -ObjectId $newUser.Id -Displayname $updatedDisplayNameInCreatedUser

            $updatedUser = Get-EntraUser -ObjectId $newUser.Id
            $updatedUser.Id | Should -Be $newUser.Id
            $updatedUser.DisplayName | Should -Be $updatedDisplayNameInCreatedUser

            $user1 = Get-EntraUser -ObjectId $newUser1.Id
            $user1.Id | Should -Be $newUser1.Id
            $user1.DisplayName | Should -Be $testName1
        }
        It "Should successfully Adds an owner to a group" {   
            Add-EntraGroupOwner -ObjectId $newGroup.Id -RefObjectId $newUser.Id
            $result = Get-EntraGroupOwner -ObjectId $newGroup.Id
            $result.Id | Should -Contain $newUser.Id

            Add-EntraGroupOwner -ObjectId $newGroup.Id -RefObjectId $newUser1.Id
            $result1 = Get-EntraGroupOwner -ObjectId $newGroup.Id
            $result1.Id | Should -Contain $newUser1.Id
        }

        AfterAll {
            Remove-EntraGroupOwner -ObjectId $newGroup.Id -OwnerId $newUser.Id
            Remove-EntraUser -ObjectId $newUser.Id
            Remove-EntraGroup -ObjectId $newGroup.Id
            Remove-EntraUser -ObjectId $newUser1.Id 
        }
    }
}