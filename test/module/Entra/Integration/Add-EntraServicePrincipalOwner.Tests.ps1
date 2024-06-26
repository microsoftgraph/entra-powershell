Describe "The Add-EntraServicePrincipalOwner command executing unmocked" {

    Context "When getting ServicePrincipal and User" {
        BeforeAll {
            $testReportPath = join-path $psscriptroot "\setenv.ps1"
            Import-Module -Name $testReportPath
            $appId = $env:TEST_APPID
            $tenantId = $env:TEST_TENANTID
            $cert = $env:CERTIFICATETHUMBPRINT
            Connect-MgGraph -TenantId $tenantId -AppId $appId -CertificateThumbprint $cert

            $thisTestInstanceId = New-Guid | select -expandproperty guid
            $testName1 = 'DemoTests' + $thisTestInstanceId
            $testname2 = 'appTests' + $thisTestInstanceId
           
            #Create Teste Application
            $global:newApplication = New-EntraApplication -DisplayName $testname2 

            #create ServicePrincipal test user 
            $global:newServicePrincipal = New-EntraServicePrincipal -AccountEnabled $true -AlternativeNames "Demo" -DisplayName $testname2 -AppId $newApplication.AppId
    
            #create test user 
            $PasswordProfile1 = New-Object -TypeName Microsoft.Open.AzureAD.Model.PasswordProfile
            $PasswordProfile1.Password = "Pass@1234"
            $global:newUser1 = New-EntraUser -AccountEnabled $true -DisplayName $testName1 -PasswordProfile $PasswordProfile1 -MailNickName $testName1 -UserPrincipalName $testName1"@M365x99297270.OnMicrosoft.com" 
    
        }

        It "should update the properties of Application , ServicePrincipal and User" { 
            $updatedDisplayNameforappUser = 'appTetsUpdatedUser' 
            Set-EntraApplication -ObjectId $newApplication.Id -Displayname $updatedDisplayNameforappUser

            $Application = Get-EntraApplication -ObjectId $newApplication.Id 
            $Application.Id | Should -Be $newApplication.Id 
            $Application.DisplayName | Should -Be $updatedDisplayNameforappUser
            
            Set-EntraServicePrincipal -ObjectId $newServicePrincipal.Id -Displayname $updatedDisplayNameforappUser

            $ServicePrincipal = Get-EntraServicePrincipal -ObjectId $newServicePrincipal.Id
            $ServicePrincipal.Id | Should -Be $newServicePrincipal.Id
            $ServicePrincipal.DisplayName | Should -Be $updatedDisplayNameforappUser

            $updatedDisplayNameInCreatedUser = 'DemoTestsUpdatedUser' 
            Set-EntraUser -ObjectId $newUser1.Id -Displayname $updatedDisplayNameInCreatedUser

            $updatedUser = Get-EntraUser -ObjectId $newUser1.Id
            $updatedUser.Id | Should -Be $newUser1.Id
            $updatedUser.DisplayName | Should -Be $updatedDisplayNameInCreatedUser
        }

        It "should successfully Adds an owner to a service principal." { 
            Add-EntraServicePrincipalOwner -ObjectId $newServicePrincipal.Id -RefObjectId $newUser1.Id
            $result = Get-EntraServicePrincipalOwner -ObjectId $newServicePrincipal.Id
            $result.Id | Should -Contain $newUser1.Id
        }

        AfterAll {
           Remove-EntraServicePrincipalOwner -ObjectId $newServicePrincipal.Id -OwnerId $newUser1.Id
           Remove-EntraUser -ObjectId $newUser1.Id
           Remove-EntraApplication -ObjectId $newApplication.Id    
        }
    }
}