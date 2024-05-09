BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra) -eq $null){
        Import-Module Microsoft.Graph.Entra    
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force
    
    $scriptblock = {
        # Write-Host "Mocking New-MgServicePrincipal with parameters: $($args | ConvertTo-Json -Depth 3)"
        return @(
            [PSCustomObject]@{
              "AppId"                        = "3ee2fcac-fa2b-4080-a8fe-442c6536ca94"
              "AccountEnabled"               = $True
              "Id"                           = "8eb49881-a102-49c0-87ef-4fa85359dc0f"
              "AppDisplayName"               = "ToGraph_443DEM"
              "ServicePrincipalType"         = "Application"
              "SignInAudience"               = "AzureADMyOrg"
              "AppRoleAssignmentRequired"    = $true
              "AlternativeNames"             = "unitalternative"
              "Homepage"                     = "http://localhost/home"
              "DisplayName"                  = "ToGraph_443DEM"
              "LogoutUrl"                    = "htpp://localhost/logout"
              "ReplyUrls"                    = "http://localhost/redirect"
              "Tags"                         = "{WindowsAzureActiveDirectoryIntegratedApp}"
              "ServicePrincipalNames"        = "3ee2fcac-fa2b-4080-a8fe-442c6536ca94"
              "AppOwnerOrganizationId"       = "d5aec55f-2d12-4442-8d2f-ccca95d4390e"
              "KeyCredentials"               = @{CustomKeyIdentifier = @(84, 101, 115, 116);DisplayName =""; Key="";KeyId="bf620d66-bd18-4348-94e4-7431d7ad20a6";Type="Symmetric";Usage="Sign"}
              "PasswordCredentials"          = @{}
            }
        )
    }

    Mock -CommandName New-MgServicePrincipal -MockWith $scriptblock -ModuleName Microsoft.Graph.Entra
}

Describe "New-EntraServicePrincipal"{
    Context "Test for New-EntraServicePrincipal" {
        It "Should return created service principal"{
            $result = New-EntraServicePrincipal  -AppId "3ee2fcac-fa2b-4080-a8fe-442c6536ca94" -Homepage 'http://localhost/home' -LogoutUrl 'htpp://localhost/logout' -ReplyUrls 'http://localhost/redirect' -AccountEnabled $true -DisplayName "ToGraph_443DEM"  -AlternativeNames "unitalternative" -Tags {WindowsAzureActiveDirectoryIntegratedApp} -AppRoleAssignmentRequired $true  -ServicePrincipalType "Application" -ServicePrincipalNames "3ee2fcac-fa2b-4080-a8fe-442c6536ca94"
            $result | Should -Not -Be NullOrEmpty
            $result.DisplayName | should -Be "ToGraph_443DEM"
            $result.AccountEnabled | should -Be "True"
            $result.AppId | should -Be "3ee2fcac-fa2b-4080-a8fe-442c6536ca94"
            $result.Homepage | should -Be "http://localhost/home" 
            $result.LogoutUrl | should -Be "htpp://localhost/logout"
            $result.AlternativeNames | should -Be "unitalternative"
            $result.Tags | should -Be "{WindowsAzureActiveDirectoryIntegratedApp}"
            $result.AppRoleAssignmentRequired | should -Be "True"
            $result.ReplyUrls | should -Be "http://localhost/redirect"
            $result.ServicePrincipalType | should -Be "Application"
            $result.ServicePrincipalNames | should -Be "3ee2fcac-fa2b-4080-a8fe-442c6536ca94"

            Should -Invoke -CommandName New-MgServicePrincipal -ModuleName Microsoft.Graph.Entra -Times 1
        }
        It "Should fail when AppID is empty" {
            { New-EntraServicePrincipal  -AppId  } | Should -Throw "Missing an argument for parameter 'AppId'.*"
        }
        It "Should fail when AppID is Invalid" {
            { New-EntraServicePrincipal  -AppId ""  } | Should -Throw "Cannot bind argument to parameter 'AppId' because it is an empty string.*"
        }
        It "Should fail when non-mandatory is empty" {
            { New-EntraServicePrincipal  -AppId "3ee2fcac-fa2b-4080-a8fe-442c6536ca94" -Tags  -ReplyUrls -AccountEnabled -AlternativeNames  } | Should -Throw "Missing an argument for parameter*"
        }
        It "Should create service principal with KeyCredentials parameter"{
            $creds = New-Object Microsoft.Open.AzureAD.Model.KeyCredential
            $creds.CustomKeyIdentifier = [System.Text.Encoding]::UTF8.GetBytes("Test")
            $startdate = Get-Date -Year 2023 -Month 10 -Day 23
            $creds.StartDate = $startdate
            $creds.Type = "Symmetric"
            $creds.Usage = 'Sign'
            $creds.Value = [System.Text.Encoding]::UTF8.GetBytes("123")
            $creds.EndDate = Get-Date -Year 2024 -Month 10 -Day 23
            $result= New-EntraServicePrincipal -AppId "3ee2fcac-fa2b-4080-a8fe-442c6536ca94" -KeyCredentials $creds
            $result | Should -Not -Be NullOrEmpty
            $result.AppId | should -Be "3ee2fcac-fa2b-4080-a8fe-442c6536ca94"
            $keycredentials = @{CustomKeyIdentifier = @(84, 101, 115, 116);DisplayName =""; Key="";KeyId="bf620d66-bd18-4348-94e4-7431d7ad20a6";Type="Symmetric";Usage="Sign"} | ConvertTo-json 
           ($result.KeyCredentials | ConvertTo-json ) | should -Be $keycredentials 
        }
        It "Should fail when KeyCredentials is empty" {
            { New-EntraServicePrincipal -AppId "3ee2fcac-fa2b-4080-a8fe-442c6536ca94" -KeyCredentials  } | Should -Throw "Missing an argument for parameter 'KeyCredentials'.*"
        }
        It "Should fail when KeyCredentials is Invalid" {
            { New-EntraServicePrincipal -AppId "3ee2fcac-fa2b-4080-a8fe-442c6536ca94" -KeyCredentials "xyz" } | Should -Throw "Cannot process argument transformation on parameter 'KeyCredentials'.*"
        }
        It "Result should Contain ObjectId and AppOwnerTenantId" {
            $result =  New-EntraServicePrincipal -AppId "3ee2fcac-fa2b-4080-a8fe-442c6536ca94"
            $result.ObjectId | should -Be "8eb49881-a102-49c0-87ef-4fa85359dc0f"
            $result.AppOwnerTenantId | should -Be "d5aec55f-2d12-4442-8d2f-ccca95d4390e"
        } 
        It "Should contain 'User-Agent' header" {
            Mock -CommandName New-MgServicePrincipal -MockWith {$args} -ModuleName Microsoft.Graph.Entra

            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion New-EntraServicePrincipal"

            $result = New-EntraServicePrincipal  -AppId "3ee2fcac-fa2b-4080-a8fe-442c6536ca94" -Homepage 'http://localhost/home' -LogoutUrl 'htpp://localhost/logout'  -AccountEnabled $true -DisplayName "ToGraph_443DEM"  -AlternativeNames "unitalternative" -Tags {WindowsAzureActiveDirectoryIntegratedApp} -AppRoleAssignmentRequired $true -ReplyUrls 'http://localhost/redirect' -ServicePrincipalType "Application" -ServicePrincipalNames "3ee2fcac-fa2b-4080-a8fe-442c6536ca94"
            $params = Get-Parameters -data $result
            $params.Headers["User-Agent"] | Should -Be $userAgentHeaderValue
        }
    }
}