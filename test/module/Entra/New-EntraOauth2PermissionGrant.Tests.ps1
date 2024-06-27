BeforeAll {  
    if ((Get-Module -Name Microsoft.Graph.Entra) -eq $null) {
        Import-Module Microsoft.Graph.Entra      
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force
    
    $scriptblock = {
        return @(
            [Microsoft.Graph.PowerShell.Models.MicrosoftGraphOAuth2PermissionGrant]@{
                "ClientId"    = "bbbbbbbb-1111-2222-3333-cccccccccccc"
                "ConsentType" = "AllPrincipals"
                "PrincipalId" = $null
                "ResourceId"  = "bbbbbbbb-1111-2222-3333-rrrrrrrrrrrr"
                "Scope"       = "DelegatedPermissionGrant.ReadWrite.All"
            }
        )
    }
    
    Mock -CommandName Invoke-GraphRequest -MockWith $scriptblock -ModuleName Microsoft.Graph.Entra
}
  
Describe "New-EntraOauth2PermissionGrant" {
    Context "Test for New-EntraOauth2PermissionGrant" {
        It "Should return created Oauth2PermissionGrant" {
            $result = New-EntraOauth2PermissionGrant -ClientId "bbbbbbbb-1111-2222-3333-cccccccccccc" -ConsentType "AllPrincipals" -ResourceId "bbbbbbbb-1111-2222-3333-rrrrrrrrrrrr" -Scope "DelegatedPermissionGrant.ReadWrite.All"
            $result | Should -Not -BeNullOrEmpty
            $result.ClientId | should -Be "bbbbbbbb-1111-2222-3333-cccccccccccc"
            $result.ConsentType | should -Be "AllPrincipals"
            $result.ResourceId | should -Be "bbbbbbbb-1111-2222-3333-rrrrrrrrrrrr" 
            $result.Scope | should -Be "DelegatedPermissionGrant.ReadWrite.All" 

            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Graph.Entra -Times 1
        }
        It "Should fail when parameters are invalid" {
            { New-EntraOauth2PermissionGrant -DisplayName "" -MailEnabled "" -SecurityEnabled "" -MailNickName  "" -Description "" } | Should -Throw "Cannot bind argument to parameter*"
        }
        It "Should fail when parameters are empty" {
            { New-EntraOauth2PermissionGrant -DisplayName -MailEnabled -SecurityEnabled -MailNickName -Description } | Should -Throw "Missing an argument for parameter*"
        }
        It "Result should Contain ObjectId" {            
            $result = New-EntraOauth2PermissionGrant -DisplayName "demo" -MailEnabled $false -SecurityEnabled $true -MailNickName "demoNickname" -Description "test"
            $result.ObjectId | should -Be "bbbbbbbb-1111-2222-3333-cccccccccccc"
        } 
        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion New-EntraOauth2PermissionGrant"

            New-EntraOauth2PermissionGrant -ClientId "bbbbbbbb-1111-2222-3333-cccccccccccc" -ConsentType "AllPrincipals" -ResourceId "bbbbbbbb-1111-2222-3333-rrrrrrrrrrrr" | Out-Null
            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Graph.Entra -Times 1 -ParameterFilter {
                $Headers.'User-Agent' | Should -Be $userAgentHeaderValue
                $true
            }
        }   
    }
}