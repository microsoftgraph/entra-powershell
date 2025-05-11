# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
BeforeAll {  
    if((Get-Module -Name Microsoft.Entra.Applications) -eq $null){
        Import-Module Microsoft.Entra.Applications    
    }
    Import-Module (Join-Path $PSScriptRoot "..\..\Common-Functions.ps1") -Force
    
    $scriptblock = {
        # Write-Host "Mocking New-MgServicePrincipal with parameters: $($args | ConvertTo-Json -Depth 3)"
        return @(
            [PSCustomObject]@{
              "AppId"                        = "00001111-aaaa-2222-bbbb-3333cccc4444"
              "AccountEnabled"               = $True
              "Id"                           = "00aa00aa-bb11-cc22-dd33-44ee44ee44ee"
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
              "ServicePrincipalNames"        = "11bb11bb-cc22-dd33-ee44-55ff55ff55ff"
              "AppOwnerOrganizationId"       = "44445555-eeee-6666-ffff-7777aaaa8888"
              "KeyCredentials"               = @{CustomKeyIdentifier = @(84, 101, 115, 116);DisplayName =""; Key="";KeyId="bf620d66-bd18-4348-94e4-7431d7ad20a6";Type="Symmetric";Usage="Sign"}
              "PasswordCredentials"          = @{}
            }
        )
    }

    Mock -CommandName New-MgServicePrincipal -MockWith $scriptblock -ModuleName Microsoft.Entra.Applications
    Mock -CommandName Get-EntraContext -MockWith { @{Scopes = @("Application.ReadWrite.All") } } -ModuleName Microsoft.Entra.Applications
}

Describe "New-EntraServicePrincipal"{
    Context "Test for New-EntraServicePrincipal" {
        It "Should return created service principal"{
            $result = New-EntraServicePrincipal  -AppId "00001111-aaaa-2222-bbbb-3333cccc4444" -Homepage 'http://localhost/home' -LogoutUrl 'htpp://localhost/logout' -ReplyUrls 'http://localhost/redirect' -AccountEnabled $true -DisplayName "ToGraph_443DEM"  -AlternativeNames "unitalternative" -Tags {WindowsAzureActiveDirectoryIntegratedApp} -AppRoleAssignmentRequired $true  -ServicePrincipalType "Application" -ServicePrincipalNames "11bb11bb-cc22-dd33-ee44-55ff55ff55ff"
            $result | Should -Not -Be NullOrEmpty
            $result.DisplayName | should -Be "ToGraph_443DEM"
            $result.AccountEnabled | should -Be "True"
            $result.AppId | should -Be "00001111-aaaa-2222-bbbb-3333cccc4444"
            $result.Homepage | should -Be "http://localhost/home" 
            $result.LogoutUrl | should -Be "htpp://localhost/logout"
            $result.AlternativeNames | should -Be "unitalternative"
            $result.Tags | should -Be "{WindowsAzureActiveDirectoryIntegratedApp}"
            $result.AppRoleAssignmentRequired | should -Be "True"
            $result.ReplyUrls | should -Be "http://localhost/redirect"
            $result.ServicePrincipalType | should -Be "Application"
            $result.ServicePrincipalNames | should -Be "11bb11bb-cc22-dd33-ee44-55ff55ff55ff"

            Should -Invoke -CommandName New-MgServicePrincipal -ModuleName Microsoft.Entra.Applications -Times 1
        }
        It "Should fail when AppID is empty" {
            { New-EntraServicePrincipal  -AppId  } | Should -Throw "Missing an argument for parameter 'AppId'.*"
        }
        It "Should fail when AppID is Invalid" {
            { New-EntraServicePrincipal  -AppId ""  } | Should -Throw "Cannot bind argument to parameter 'AppId' because it is an empty string.*"
        }
        It "Should fail when non-mandatory is empty" {
            { New-EntraServicePrincipal  -AppId "00001111-aaaa-2222-bbbb-3333cccc4444" -Tags  -ReplyUrls -AccountEnabled -AlternativeNames  } | Should -Throw "Missing an argument for parameter*"
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
            $result= New-EntraServicePrincipal -AppId "00001111-aaaa-2222-bbbb-3333cccc4444" -KeyCredentials $creds
            $result | Should -Not -Be NullOrEmpty
            $result.AppId | should -Be "00001111-aaaa-2222-bbbb-3333cccc4444"
            $keycredentials = @{CustomKeyIdentifier = @(84, 101, 115, 116);DisplayName =""; Key="";KeyId="bf620d66-bd18-4348-94e4-7431d7ad20a6";Type="Symmetric";Usage="Sign"} | ConvertTo-json 
           ($result.KeyCredentials | ConvertTo-json ) | should -Be $keycredentials 
        }
        It "Should fail when KeyCredentials is empty" {
            { New-EntraServicePrincipal -AppId "00001111-aaaa-2222-bbbb-3333cccc4444" -KeyCredentials  } | Should -Throw "Missing an argument for parameter 'KeyCredentials'.*"
        }
        It "Should fail when KeyCredentials is Invalid" {
            { New-EntraServicePrincipal -AppId "00001111-aaaa-2222-bbbb-3333cccc4444" -KeyCredentials "xyz" } | Should -Throw "Cannot process argument transformation on parameter 'KeyCredentials'.*"
        }
        It "Result should Contain ObjectId and AppOwnerTenantId" {
            $result =  New-EntraServicePrincipal -AppId "00001111-aaaa-2222-bbbb-3333cccc4444"
            $result.ObjectId | should -Be "00aa00aa-bb11-cc22-dd33-44ee44ee44ee"
            $result.AppOwnerTenantId | should -Be "44445555-eeee-6666-ffff-7777aaaa8888"
        } 
        
        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion New-EntraServicePrincipal"

            $result = New-EntraServicePrincipal -AppId "00001111-aaaa-2222-bbbb-3333cccc4444"
            $result | Should -Not -BeNullOrEmpty

            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion New-EntraServicePrincipal"

            Should -Invoke -CommandName New-MgServicePrincipal -ModuleName Microsoft.Entra.Applications -Times 1 -ParameterFilter {
                $Headers.'User-Agent' | Should -Be $userAgentHeaderValue
                $true
            }
        }

        It "Should execute successfully without throwing an error" {
            # Disable confirmation prompts       
            $originalDebugPreference = $DebugPreference
            $DebugPreference = 'Continue'

            try {
                # Act & Assert: Ensure the function doesn't throw an exception
                { New-EntraServicePrincipal  -AppId "00001111-aaaa-2222-bbbb-3333cccc4444" -Homepage 'http://localhost/home' -LogoutUrl 'htpp://localhost/logout'  -AccountEnabled $true -DisplayName "ToGraph_443DEM"  -AlternativeNames "unitalternative" -Tags {WindowsAzureActiveDirectoryIntegratedApp} -AppRoleAssignmentRequired $true -ReplyUrls 'http://localhost/redirect' -ServicePrincipalType "Application" -ServicePrincipalNames "11bb11bb-cc22-dd33-ee44-55ff55ff55ff" -Debug } | Should -Not -Throw
            } finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        }    
    }
}

