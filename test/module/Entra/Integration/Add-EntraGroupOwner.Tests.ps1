Describe "The Add-EntraGroupOwner command executing unmocked" {

    Context "When getting user and group" {
        BeforeAll {
            $testReportPath = join-path $psscriptroot "\setenv.ps1"
            Import-Module -Name $testReportPath
            $appId = $env:TEST_APPID
            $tenantId = $env:TEST_TENANTID
            $cert = $env:CERTIFICATETHUMBPRINT
            Connect-MgGraph -TenantId $tenantId -AppId $appId -CertificateThumbprint $cert

            $thisTestInstanceId = New-Guid | select -expandproperty guid
            $testName = 'SimpleTests' + $thisTestInstanceId
            $testName1 = 'SimpleTests1' + $thisTestInstanceId

            #create test user 
            $PasswordProfile = New-Object -TypeName Microsoft.Open.AzureAD.Model.PasswordProfile
            $PasswordProfile.Password = "Pass@1234"
            $global:newUser = New-EntraUser -AccountEnabled $true -DisplayName $testName -PasswordProfile $PasswordProfile -MailNickName $testName -UserPrincipalName $testName"@M365x99297270.OnMicrosoft.com" 
    
            #create test user 
            $PasswordProfile1 = New-Object -TypeName Microsoft.Open.AzureAD.Model.PasswordProfile
            $PasswordProfile1.Password = "Pass@1234"
            $global:newUser1 = New-EntraUser -AccountEnabled $true -DisplayName $testName1 -PasswordProfile $PasswordProfile1 -MailNickName $testName1 -UserPrincipalName $testName1"@M365x99297270.OnMicrosoft.com" 
    
            #create test group 
            $global:newGroup = New-EntraGroup -DisplayName $testName -MailEnabled $false -SecurityEnabled $true -MailNickName $testName 
        }

        It "should update the proprties of user and group" {            
            $updatedDisplayName = "SimpleTestsUpdated"
            Set-EntraGroup -ObjectId $newGroup.Id -DisplayName $updatedDisplayName
            
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