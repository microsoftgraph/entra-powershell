Describe "The Add-EntraGroupMember command executing unmocked" {

    Context "When getting user and group" {
        BeforeAll {
            $testReportPath = join-path $psscriptroot "\setenv.ps1"
            Import-Module -Name $testReportPath
            $appId = $env:TEST_APPID
            $tenantId = $env:TEST_TENANTID
            $cert = $env:CERTIFICATETHUMBPRINT
            Connect-Entra -TenantId $tenantId  -AppId $appId -CertificateThumbprint $cert

            $thisTestInstanceId = New-Guid | select -expandproperty guid
            $testName = 'SimpleTest' + $thisTestInstanceId

            #create test user 
            $PasswordProfile = New-Object -TypeName Microsoft.Open.AzureAD.Model.PasswordProfile
            $PasswordProfile.Password = "Pass@1234"
            $global:newUser = New-EntraUser -AccountEnabled $true -DisplayName $testName -PasswordProfile $PasswordProfile -MailNickName $testName -UserPrincipalName "SimpleTestUser@M365x99297270.OnMicrosoft.com" 
    
            #create test group 
            $global:newGroup = New-EntraGroup -DisplayName $testName -MailEnabled $false -SecurityEnabled $true -MailNickName $testName 
        }

        It "should successfully add user to new created group" {
            $user = Get-EntraUser -ObjectId $newUser.Id
            $user.Id | Should -Be $newUser.Id
            $user.DisplayName | Should -Be $testName

            $group = Get-EntraGroup -ObjectId $newGroup.Id
            $group.Id | Should -Be $newGroup.Id
            $group.DisplayName | Should -Be $testName

            Add-EntraGroupMember -ObjectId $group.Id -RefObjectId $user.Id
            $result = Get-EntraGroupMember -ObjectId $group.Id
            $result.Id | Should -Contain $user.Id
        }

        AfterAll {
            Remove-EntraGroupMember -ObjectId $newGroup.Id -MemberId $newUser.Id
            Remove-EntraUser -ObjectId $newUser.Id
            Remove-EntraGroup -ObjectId $newGroup.Id
        }
    }
}
