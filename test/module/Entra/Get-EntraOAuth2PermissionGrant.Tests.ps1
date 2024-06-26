BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra) -eq $null){
        Import-Module Microsoft.Graph.Entra      
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force
    
    $scriptblock = {
        return @(
            [PSCustomObject]@{
              "Id"                           = "p9u1ll7Iq0-Gh9M3EERXhffW8XpadQNIoHik9aQxrVE"
              "ClientId"                     = "96b5dba7-c85e-4fab-8687-d33710445785"
              "PrincipalId"                  = $null
              "ResourceId"                   = "7af1d6f7-755a-4803-a078-a4f5a431ad51"
              "ConsentType"                  = "AllPrincipals"
              "Scope"                        = "Policy.Read.All Policy.ReadWrite.ConditionalAccess User.Read"
              "AdditionalProperties"         = @{}
              "Parameters"                   = $args
            }
        )
    }

    Mock -CommandName Get-MgOAuth2PermissionGrant -MockWith $scriptblock -ModuleName Microsoft.Graph.Entra
}

Describe "Get-EntraOAuth2PermissionGrant" {
Context "Test for Get-EntraOAuth2PermissionGrant" {
        It "Should return OAuth2 Permission Grant" {
            $result = Get-EntraOAuth2PermissionGrant
            $result | Should -Not -BeNullOrEmpty
            $result.Id | Should -Be "p9u1ll7Iq0-Gh9M3EERXhffW8XpadQNIoHik9aQxrVE"
            $result.ResourceId | Should -Be "7af1d6f7-755a-4803-a078-a4f5a431ad51"
            $result.PrincipalId | Should -BeNullOrEmpty
            $result.ClientId | Should -Be "96b5dba7-c85e-4fab-8687-d33710445785"


            Should -Invoke -CommandName Get-MgOAuth2PermissionGrant  -ModuleName Microsoft.Graph.Entra -Times 1
        }
        It "Should return All Group AppRole Assignment" {
            $result = Get-EntraOAuth2PermissionGrant -All $true
            $result | Should -Not -BeNullOrEmpty
            $result.Id | Should -Be "p9u1ll7Iq0-Gh9M3EERXhffW8XpadQNIoHik9aQxrVE"
            $result.ResourceId | Should -Be "7af1d6f7-755a-4803-a078-a4f5a431ad51"
            $result.PrincipalId | Should -BeNullOrEmpty
            $result.ClientId | Should -Be "96b5dba7-c85e-4fab-8687-d33710445785"


            Should -Invoke -CommandName Get-MgOAuth2PermissionGrant  -ModuleName Microsoft.Graph.Entra -Times 1
        }
        It "Should fail when All is empty" {
            { Get-EntraOAuth2PermissionGrant -All  } | Should -Throw "Missing an argument for parameter 'All'*"
        }
        It "Should fail when All is invalid" {
            { Get-EntraOAuth2PermissionGrant -All xyz } | Should -Throw "Cannot process argument transformation on parameter 'All'*"
        }
        It "Should return top 1 Group AppRole Assignment" {
            $result = Get-EntraOAuth2PermissionGrant -Top 1
            $result | Should -Not -BeNullOrEmpty
            $result.Id | Should -Be "p9u1ll7Iq0-Gh9M3EERXhffW8XpadQNIoHik9aQxrVE"
            $result.ResourceId | Should -Be "7af1d6f7-755a-4803-a078-a4f5a431ad51"
            $result.PrincipalId | Should -BeNullOrEmpty
            $result.ClientId | Should -Be "96b5dba7-c85e-4fab-8687-d33710445785"


            Should -Invoke -CommandName Get-MgOAuth2PermissionGrant  -ModuleName Microsoft.Graph.Entra -Times 1
        }
        It "Should fail when Top is empty" {
            { Get-EntraOAuth2PermissionGrant -Top  } | Should -Throw "Missing an argument for parameter 'Top'*"
        }
        It "Should fail when Top is invalid" {
            { Get-EntraOAuth2PermissionGrant -Top xyz } | Should -Throw "Cannot process argument transformation on parameter 'Top'*"
        }
        It "Result should Contain ObjectId" {
            $result = Get-EntraOAuth2PermissionGrant -Top 1
            $result.ObjectId | should -Be "p9u1ll7Iq0-Gh9M3EERXhffW8XpadQNIoHik9aQxrVE"
        }
        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraOAuth2PermissionGrant"

            $result = Get-EntraOAuth2PermissionGrant -Top 1
            $params = Get-Parameters -data $result.Parameters
            $params.Headers["User-Agent"] | Should -Be $userAgentHeaderValue
        }


    }
}