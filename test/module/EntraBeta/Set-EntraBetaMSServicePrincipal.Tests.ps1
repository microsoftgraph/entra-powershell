BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra.Beta) -eq $null){
        Import-Module Microsoft.Graph.Entra.Beta    
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force

    Mock -CommandName Update-MgBetaServicePrincipal -MockWith {} -ModuleName Microsoft.Graph.Entra.Beta
}

Describe "Set-EntraBetaMSServicePrincipal" {
    Context "Test for Set-EntraBetaMSServicePrincipal" {
        It "Should update account enabled in service principal for the given Id" {
            $result = Set-EntraBetaMSServicePrincipal -Id "2a07a4ca-7eaf-4f3e-bf67-4460899baf60" -AccountEnabled $true
            $result | Should -BeNullOrEmpty

            Should -Invoke -CommandName Update-MgBetaServicePrincipal -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }

        It "Should fail when Id are empty" {
            { Set-EntraBetaMSServicePrincipal -Id  -AccountEnabled $true } | Should -Throw "Missing an argument for parameter 'Id'*"
        }

        It "Should fail when Id is Invalid" {
            { Set-EntraBetaMSServicePrincipal -Id "" -AccountEnabled $true } | Should -Throw "Cannot bind argument to parameter 'Id' because it is an empty string."
        }

        It "Should fail when AccountEnabled are empty" {
            { Set-EntraBetaMSServicePrincipal -Id "2a07a4ca-7eaf-4f3e-bf67-4460899baf60" -AccountEnabled } | Should -Throw "Missing an argument for parameter 'AccountEnabled'*"
        }

        It "Should set appId in service principal for the given Id" {
            $result = Set-EntraBetaMSServicePrincipal -Id "2a07a4ca-7eaf-4f3e-bf67-4460899baf60" -AppId "609d427d-b574-4063-8d19-6ed1c03a80c7"
            $result | Should -BeNullOrEmpty

            Should -Invoke -CommandName Update-MgBetaServicePrincipal -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }

        It "Should fail when AppId are empty" {
            { Set-EntraBetaMSServicePrincipal -Id "2a07a4ca-7eaf-4f3e-bf67-4460899baf60" -AppId  } | Should -Throw "Missing an argument for parameter 'AppId'*"
        }

        It "Should update AppRoleAssignmentRequired in service principal for the given Id" {
            $result = Set-EntraBetaMSServicePrincipal -Id "2a07a4ca-7eaf-4f3e-bf67-4460899baf60" -AppRoleAssignmentRequired $false
            $result | Should -BeNullOrEmpty

            Should -Invoke -CommandName Update-MgBetaServicePrincipal -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }

        It "Should fail when AppRoleAssignmentRequired are empty" {
            { Set-EntraBetaMSServicePrincipal -Id "2a07a4ca-7eaf-4f3e-bf67-4460899baf60" -AppRoleAssignmentRequired  } | Should -Throw "Missing an argument for parameter 'AppRoleAssignmentRequired'*"
        }

        It "Should fail when AppRoleAssignmentRequired is Invalid" {
            { Set-EntraBetaMSServicePrincipal -Id "2a07a4ca-7eaf-4f3e-bf67-4460899baf60" -AppRoleAssignmentRequired "" } | Should -Throw "Cannot process argument transformation on parameter 'AppRoleAssignmentRequired'*"
        }

        It "Should update CustomSecurityAttributes in service principal for the given Id" {
            $customSecurityAttributes =@{
                engineering= @{
                    "@odata.type" = "#Microsoft.DirectoryServices.CustomSecurityAttributeValue"
                     }
                    }
            $result = Set-EntraBetaMSServicePrincipal -Id "2a07a4ca-7eaf-4f3e-bf67-4460899baf60" -CustomSecurityAttributes $customSecurityAttributes
            $result | Should -BeNullOrEmpty

            Should -Invoke -CommandName Update-MgBetaServicePrincipal -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }

        It "Should fail when CustomSecurityAttributes are empty" {
            { Set-EntraBetaMSServicePrincipal -Id "2a07a4ca-7eaf-4f3e-bf67-4460899baf60" -CustomSecurityAttributes  } | Should -Throw "Missing an argument for parameter 'CustomSecurityAttributes'*"
        }

        It "Should fail when CustomSecurityAttributes is Invalid" {
            { Set-EntraBetaMSServicePrincipal -Id "2a07a4ca-7eaf-4f3e-bf67-4460899baf60" -CustomSecurityAttributes "" } | Should -Throw "Cannot process argument transformation on parameter 'CustomSecurityAttributes'*"
        }

        It "Should update DisplayName in service principal for the given Id" {
            $result = Set-EntraBetaMSServicePrincipal -Id "2a07a4ca-7eaf-4f3e-bf67-4460899baf60" -DisplayName "demo1"
            $result | Should -BeNullOrEmpty

            Should -Invoke -CommandName Update-MgBetaServicePrincipal -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }

        It "Should fail when DisplayName are empty" {
            { Set-EntraBetaMSServicePrincipal -Id "2a07a4ca-7eaf-4f3e-bf67-4460899baf60" -DisplayName  } | Should -Throw "Missing an argument for parameter 'DisplayName'*"
        }

        It "Should update LogoutUrl in service principal for the given Id" {
            $result = Set-EntraBetaMSServicePrincipal -Id "2a07a4ca-7eaf-4f3e-bf67-4460899baf60" -LogoutUrl 'https://securescorece.com/SignOut'
            $result | Should -BeNullOrEmpty

            Should -Invoke -CommandName Update-MgBetaServicePrincipal -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }

        It "Should fail when LogoutUrl are empty" {
            { Set-EntraBetaMSServicePrincipal -Id "2a07a4ca-7eaf-4f3e-bf67-4460899baf60" -LogoutUrl  } | Should -Throw "Missing an argument for parameter 'LogoutUrl'*"
        }

        It "Should update Homepage in service principal for the given Id" {
            $result = Set-EntraBetaMSServicePrincipal -Id "2a07a4ca-7eaf-4f3e-bf67-4460899baf60" -Homepage 'https://HomePageurlsss.com'
            $result | Should -BeNullOrEmpty

            Should -Invoke -CommandName Update-MgBetaServicePrincipal -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }

        It "Should fail when Homepage are empty" {
            { Set-EntraBetaMSServicePrincipal -Id "2a07a4ca-7eaf-4f3e-bf67-4460899baf60" -Homepage  } | Should -Throw "Missing an argument for parameter 'Homepage'*"
        }

        It "Should update PreferredTokenSigningKeyThumbprint in service principal for the given Id" {
            $result = Set-EntraBetaMSServicePrincipal -Id "2a07a4ca-7eaf-4f3e-bf67-4460899baf60" -PreferredTokenSigningKeyThumbprint '0123456789ABCDEF0123456789ABCDEF01234568'
            $result | Should -BeNullOrEmpty

            Should -Invoke -CommandName Update-MgBetaServicePrincipal -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }

        It "Should fail when PreferredTokenSigningKeyThumbprint are empty" {
            { Set-EntraBetaMSServicePrincipal -Id "2a07a4ca-7eaf-4f3e-bf67-4460899baf60" -PreferredTokenSigningKeyThumbprint  } | Should -Throw "Missing an argument for parameter 'PreferredTokenSigningKeyThumbprint'*"
        }
      
        It "Should update ReplyUrls in service principal for the given Id" {
            $result = Set-EntraBetaMSServicePrincipal -Id "2a07a4ca-7eaf-4f3e-bf67-4460899baf60" -ReplyUrls 'https://admin.microsoft.com'
            $result | Should -BeNullOrEmpty

            Should -Invoke -CommandName Update-MgBetaServicePrincipal -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }

        It "Should fail when ReplyUrls are empty" {
            { Set-EntraBetaMSServicePrincipal -Id "2a07a4ca-7eaf-4f3e-bf67-4460899baf60" -ReplyUrls  } | Should -Throw "Missing an argument for parameter 'ReplyUrls'*"
        }

        It "Should update service principal names for the given Id" {
            $result = Set-EntraBetaMSServicePrincipal -Id "2a07a4ca-7eaf-4f3e-bf67-4460899baf60" -ServicePrincipalNames '0e2f044c-def9-4f98-8c82-41606d311450' -AccountEnabled $true
            $result | Should -BeNullOrEmpty

            Should -Invoke -CommandName Update-MgBetaServicePrincipal -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }

        It "Should fail when ServicePrincipalNames are empty" {
            { Set-EntraBetaMSServicePrincipal -Id "2a07a4ca-7eaf-4f3e-bf67-4460899baf60" -ServicePrincipalNames -AccountEnabled $true } | Should -Throw "Missing an argument for parameter 'ServicePrincipalNames'*"
        }

        It "Should update Tags in service principal for the given Id" {
            $tags = @("Environment=Production", "Department=Finance", "Project=XY8Z")
            $result = Set-EntraBetaMSServicePrincipal -Id "2a07a4ca-7eaf-4f3e-bf67-4460899baf60" -Tags $tags
            $result | Should -BeNullOrEmpty

            Should -Invoke -CommandName Update-MgBetaServicePrincipal -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }

        It "Should fail when Tags are empty" {
            { Set-EntraBetaMSServicePrincipal -Id "2a07a4ca-7eaf-4f3e-bf67-4460899baf60" -Tags  } | Should -Throw "Missing an argument for parameter 'Tags'*"
        }

        It "Should update KeyCredentials in service principal for the given Id" {
            $creds =New-Object Microsoft.Open.MSGraph.Model.MsKeyCredential
            $creds.CustomKeyIdentifier = [System.Text.Encoding]::UTF8.GetBytes("test")
            $creds.EndDate = Get-Date -Year 2025 -Month 10 -Day 23
            $creds.StartDate = Get-Date -Year 2023 -Month 10 -Day 23
            $creds.Type = "Symmetric"
            $creds.Usage = 'Sign'
            $creds.Value = [System.Text.Encoding]::UTF8.GetBytes("789")
            $result = Set-EntraBetaMSServicePrincipal -Id "2a07a4ca-7eaf-4f3e-bf67-4460899baf60" -KeyCredentials $creds
            $result | Should -BeNullOrEmpty

            Should -Invoke -CommandName Update-MgBetaServicePrincipal -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }

        It "Should fail when KeyCredentials are empty" {
            { Set-EntraBetaMSServicePrincipal -Id "2a07a4ca-7eaf-4f3e-bf67-4460899baf60" -KeyCredentials  } | Should -Throw "Missing an argument for parameter 'KeyCredentials'*"
        }

        It "Should fail when KeyCredentials is Invalid" {
            { Set-EntraBetaMSServicePrincipal -Id "2a07a4ca-7eaf-4f3e-bf67-4460899baf60" -KeyCredentials "" } | Should -Throw "Cannot process argument transformation on parameter 'KeyCredentials'*"
        }

        It "Should contain ServicePrincipalId in parameters when passed Id to it" {
            Mock -CommandName Update-MgBetaServicePrincipal -MockWith {$args} -ModuleName Microsoft.Graph.Entra.Beta

            $result = Set-EntraBetaMSServicePrincipal -Id "2a07a4ca-7eaf-4f3e-bf67-4460899baf60"
            $params = Get-Parameters -data $result
            $params.ServicePrincipalId | Should -Be "2a07a4ca-7eaf-4f3e-bf67-4460899baf60"
        }

        It "Should contain 'User-Agent' header" {
            Mock -CommandName Update-MgBetaServicePrincipal -MockWith {$args} -ModuleName Microsoft.Graph.Entra.Beta

            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Set-EntraBetaMSServicePrincipal"
            $result = Set-EntraBetaMSServicePrincipal -Id "2a07a4ca-7eaf-4f3e-bf67-4460899baf60" -AccountEnabled $true
            $params = Get-Parameters -data $result
            $params.Headers["User-Agent"] | Should -Be $userAgentHeaderValue
        }   
    }
}