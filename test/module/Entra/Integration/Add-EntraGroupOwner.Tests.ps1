Describe "The Add-EntraGroupOwner command executing unmocked" {

    Context "When getting user and group" {
        BeforeAll {
            $testReportPath = join-path $psscriptroot "\setenv.ps1"
            Import-Module -Name $testReportPath
            $appId = $env:TEST_APPID
            $tenantId = $env:TEST_TENANTID
            $cert = $env:CERTIFICATETHUMBPRINT
            Connect-Entra -TenantId $tenantId -AppId $appId -CertificateThumbprint $cert

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

        It "should successfully Adds an owner to a group" {
            
            $group = Get-EntraGroup -ObjectId $newGroup.Id
            $group.Id | Should -Be $newGroup.Id
            $group.DisplayName | Should -Be $testName

            $user = Get-EntraUser -ObjectId $newUser.Id
            $user.Id | Should -Be $newUser.Id
            $user.DisplayName | Should -Be $testName

            $user1 = Get-EntraUser -ObjectId $newUser1.Id
            $user1.Id | Should -Be $newUser1.Id
            $user1.DisplayName | Should -Be $testName1

            Add-EntraGroupOwner -ObjectId $group.Id -RefObjectId $user.Id
            $result = Get-EntraGroupOwner -ObjectId $group.Id
            $result.Id | Should -Contain $user.Id

            Add-EntraGroupOwner -ObjectId $group.Id -RefObjectId $user1.Id
            $result1 = Get-EntraGroupOwner -ObjectId $group.Id
            $result1.Id | Should -Contain $user1.Id
        }

        AfterAll {
            Remove-EntraGroupOwner -ObjectId $newGroup.Id -OwnerId $newUser.Id
            Remove-EntraUser -ObjectId $newUser.Id
            Remove-EntraGroup -ObjectId $newGroup.Id
            Remove-EntraUser -ObjectId $newUser1.Id

            
        }
    }
}