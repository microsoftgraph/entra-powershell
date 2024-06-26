BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra) -eq $null){
        Import-Module Microsoft.Graph.Entra
    }
    Import-Module .\test\module\Common-Functions.ps1 -Force

    Mock -CommandName Remove-MgOAuth2PermissionGrant -MockWith {} -ModuleName Microsoft.Graph.Entra
}

Describe "Remove-EntraGroupAppRoleAssignment" {
    Context "Test for Remove-EntraGroupAppRoleAssignment" {
        It "Should return empty object" {
            $result = Remove-EntraOAuth2PermissionGrant -ObjectId "txAVAlPnqkC2aCl1MpXKNPfW8XpadQNIoHik9aQxrVE"
            $result | Should -BeNullOrEmpty

            Should -Invoke -CommandName Remove-MgOAuth2PermissionGrant -ModuleName Microsoft.Graph.Entra -Times 1
        }
        It "Should fail when ObjectId is empty" {
            { Remove-EntraOAuth2PermissionGrant -ObjectId  } | Should -Throw "Missing an argument for parameter 'ObjectId'*"
        }  
        It "Should fail when ObjectId is invalid" {
            { Remove-EntraOAuth2PermissionGrant -ObjectId "" } | Should -Throw "Cannot bind argument to parameter 'ObjectId' because it is an empty string."
        }
        It "Should contain OAuth2PermissionGrantId in parameters when passed ObjectId to it" { 
            Mock -CommandName Remove-MgOAuth2PermissionGrant -MockWith {$args} -ModuleName Microsoft.Graph.Entra

            $result = Remove-EntraOAuth2PermissionGrant -ObjectId "txAVAlPnqkC2aCl1MpXKNPfW8XpadQNIoHik9aQxrVE"
            $params = Get-Parameters -data $result
            $params.OAuth2PermissionGrantId | Should -Be "txAVAlPnqkC2aCl1MpXKNPfW8XpadQNIoHik9aQxrVE"
        }
        It "Should contain 'User-Agent' header" {
            Mock -CommandName Remove-MgOAuth2PermissionGrant -MockWith {$args} -ModuleName Microsoft.Graph.Entra
            
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Remove-EntraOAuth2PermissionGrant"

            $result = Remove-EntraOAuth2PermissionGrant -ObjectId "txAVAlPnqkC2aCl1MpXKNPfW8XpadQNIoHik9aQxrVE"
            $params = Get-Parameters -data $result
            $params.Headers["User-Agent"] | Should -Be $userAgentHeaderValue
        } 
    }
}