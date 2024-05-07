BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra) -eq $null){
        Import-Module Microsoft.Graph.Entra      
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force
    
    $scriptblock = {
        return @(
            [PSCustomObject]@{
                "Id"                   = "9uBzRwC0s0CFCDQN6O4Ik_fW8XpadQNIoHik9aQxrVE"
                "ClientId"             = "4773e0f6-b400-40b3-8508-340de8ee0893"
                "ConsentType"          = "AllPrincipals"
                "PrincipalId"          = "7af1d6f7-755a-4803-a078-a4f5a431ad5"
                "ResourceId"           = "412be9d1-1460-4061-8eed-cca203fcb215"
                "Scope"                = "openid"
                "Parameters"           = $args
            }
        )
    }

    Mock -CommandName Get-MgServicePrincipalOauth2PermissionGrant -MockWith $scriptblock -ModuleName Microsoft.Graph.Entra
}
Describe "Get-EntraServicePrincipalOAuth2PermissionGrant"{
    It "Result should not be empty" {
        $result = Get-EntraServicePrincipalOAuth2PermissionGrant -ObjectId "02ed943d-6eca-4f99-83d6-e6fbf9dc63ae"
        $result | Should -Not -BeNullOrEmpty
        Should -Invoke -CommandName Get-MgServicePrincipalOauth2PermissionGrant -ModuleName Microsoft.Graph.Entra -Times 1
    }
    It "Should fail when ObjectId is empty" {
        { Get-EntraServicePrincipalOAuth2PermissionGrant -ObjectId "" } | Should -Throw "Cannot bind argument to parameter 'ObjectId' because it is an empty string."
    }
    It "Should return all applications" {
        $result = Get-EntraServicePrincipalOAuth2PermissionGrant -ObjectId "02ed943d-6eca-4f99-83d6-e6fbf9dc63ae" -All $true
        $result | Should -Not -BeNullOrEmpty
        Should -Invoke -CommandName Get-MgServicePrincipalOauth2PermissionGrant -ModuleName Microsoft.Graph.Entra -Times 1
    }
    It "Should fail when All is empty" {
        { Get-EntraServicePrincipalOAuth2PermissionGrant -ObjectId "02ed943d-6eca-4f99-83d6-e6fbf9dc63ae" -All } | Should -Throw "Missing an argument for parameter 'All'*"
    }
    It "Should return top application" {
        $result = Get-EntraServicePrincipalOAuth2PermissionGrant -ObjectId "02ed943d-6eca-4f99-83d6-e6fbf9dc63ae" -Top 1
        $result | Should -Not -BeNullOrEmpty
        Should -Invoke -CommandName Get-MgServicePrincipalOauth2PermissionGrant -ModuleName Microsoft.Graph.Entra -Times 1
    }
    It "Result should Contain ObjectId" {            
        $result = Get-EntraServicePrincipalOAuth2PermissionGrant -ObjectId "02ed943d-6eca-4f99-83d6-e6fbf9dc63ae"
        $result.ObjectId | should -Be "9uBzRwC0s0CFCDQN6O4Ik_fW8XpadQNIoHik9aQxrVE"
    }
    It "Should contain ServicePrincipalId in parameters when passed ObjectId to it" {    
        $result = Get-EntraServicePrincipalOAuth2PermissionGrant -ObjectId "02ed943d-6eca-4f99-83d6-e6fbf9dc63ae"
        $params = Get-Parameters -data $result.Parameters
        $params.ServicePrincipalId | Should -Be "02ed943d-6eca-4f99-83d6-e6fbf9dc63ae"
    }
    It "Should contain 'User-Agent' header" {
        $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraServicePrincipalOAuth2PermissionGrant"
        $result = Get-EntraServicePrincipalOAuth2PermissionGrant -ObjectId "02ed943d-6eca-4f99-83d6-e6fbf9dc63ae"
        $params = Get-Parameters -data $result.Parameters
        $params.Headers["User-Agent"] | Should -Be $userAgentHeaderValue
    }
}