BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra) -eq $null){
        Import-Module Microsoft.Graph.Entra        
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force
    
    $scriptblock = {
        return @(
            [PSCustomObject]@{
                "ClientId"              = "c057711d-e0a2-40a1-b8af-06d96c20c875"
                "ConsentType"           = "Principal"
                "Id"                    = "HXFXwKLgoUC4rwbZbCDIdffW8XpadQNIoHik9aQxrVHR6StBYBRhQI7tzKID_LIV"
                "PrincipalId"           = "412be9d1-1460-4061-8eed-cca203fcb215"
                "ResourceId"            = "7af1d6f7-755a-4803-a078-a4f5a431ad51"
                "Scope"                 = "User.Read openid profile offline_access"
                "AdditionalProperties"  = @{}
                "Parameters"            = $args
        }
    )
}

    Mock -CommandName Get-MgUserOAuth2PermissionGrant -MockWith $scriptblock -ModuleName Microsoft.Graph.Entra
}
  
Describe "Get-EntraUserOAuth2PermissionGrant" {
    Context "Test for Get-EntraUserOAuth2PermissionGrant" {
        It "Should return specific UserOAuth2PermissionGrant" {
            $result = Get-EntraUserOAuth2PermissionGrant -ObjectId "412be9d1-1460-4061-8eed-cca203fcb215"
            $result | Should -Not -BeNullOrEmpty
            $result.PrincipalId | should -Contain '412be9d1-1460-4061-8eed-cca203fcb215'
            $result.Id | Should -Contain 'HXFXwKLgoUC4rwbZbCDIdffW8XpadQNIoHik9aQxrVHR6StBYBRhQI7tzKID_LIV'

            Should -Invoke -CommandName Get-MgUserOAuth2PermissionGrant -ModuleName Microsoft.Graph.Entra -Times 1
        }

        It "Should fail when ObjectId is empty" {
            { Get-EntraUserOAuth2PermissionGrant -ObjectId "" } | Should -Throw "Cannot bind argument to parameter 'ObjectId' because it is an empty string."
        }

        It "Should return all User OAuth2Permission Grant" {
            $result = Get-EntraUserOAuth2PermissionGrant -ObjectId "412be9d1-1460-4061-8eed-cca203fcb215" -All $true
            $result | Should -Not -BeNullOrEmpty            
            
            Should -Invoke -CommandName Get-MgUserOAuth2PermissionGrant -ModuleName Microsoft.Graph.Entra -Times 1
        }

        It "Should fail when All is empty" {
            { Get-EntraUserOAuth2PermissionGrant -ObjectId "412be9d1-1460-4061-8eed-cca203fcb215" -All } | Should -Throw "Missing an argument for parameter 'All'*"
        }       
        
        It "Should return top User OAuth2Permission Grant" {
            $result = Get-EntraUserOAuth2PermissionGrant -ObjectId "412be9d1-1460-4061-8eed-cca203fcb215" -Top 1
            $result | Should -Not -BeNullOrEmpty

            Should -Invoke -CommandName Get-MgUserOAuth2PermissionGrant -ModuleName Microsoft.Graph.Entra -Times 1
        }  

        It "Should fail when top is empty" {
            { Get-EntraUserOAuth2PermissionGrant -ObjectId "412be9d1-1460-4061-8eed-cca203fcb215" -Top } | Should -Throw "Missing an argument for parameter 'Top'*"
        }  

        It "Result should Contain ObjectId" {
            $result = Get-EntraUserOAuth2PermissionGrant -ObjectId "412be9d1-1460-4061-8eed-cca203fcb215"
            $result.PrincipalId | should -Contain "412be9d1-1460-4061-8eed-cca203fcb215"
        } 

        It "Should contain PrincipalId in parameters when passed ObjectId to it" {
            $result = Get-EntraUserOAuth2PermissionGrant -ObjectId "412be9d1-1460-4061-8eed-cca203fcb215 "
            $params = Get-Parameters -data $result.Parameters
            $params.UserId | Should -Be "412be9d1-1460-4061-8eed-cca203fcb215 "
        }

        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraUserOAuth2PermissionGrant"

            $result = Get-EntraUserOAuth2PermissionGrant -ObjectId "412be9d1-1460-4061-8eed-cca203fcb215"
            $params = Get-Parameters -data $result.Parameters
            $params.Headers["User-Agent"] | Should -Contain $userAgentHeaderValue
            Write-Host $params
        }    
    }
}