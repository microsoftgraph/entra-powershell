BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra) -eq $null){
        Import-Module Microsoft.Graph.Entra        
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force
    
    $scriptblock = {
        return @(
            [PSCustomObject]@{
                "PasswordCredentials"                    = @{
                    "StartDate"                     = "17-Apr-24 7:32:41 AM"
                    "EndDate"                       = "17-Apr-25 7:32:41 AM"
                    "CustomKeyIdentifier"           = ""
                    "DisplayName"                   = ""
                    "EndDateTime"                   = "17-Apr-25 7:32:41 AM"
                    "Key"                           = ""
                    "KeyId"                         = "bdf6a3df-cc9b-4612-b948-e32804ee88f7"
                    "StartDateTime"                 = "17-Apr-24 7:32:41 AM"
                    "Hint"                          = "gjW"
                    "SecretText"                    = ""
                    "AdditionalProperties"          = @{}
                    "Parameters"                    = $args
                }
            }
        )
    }
    Mock -CommandName Get-MgServicePrincipal -MockWith $scriptblock -ModuleName Microsoft.Graph.Entra
}
  
Describe "Get-EntraServicePrincipalPasswordCredential" {
    Context "Test for Get-EntraServicePrincipalPasswordCredential" {
        It "Should return specific principal password credential" {
            $ServicePrincipalId = "0008861a-d455-4671-bd24-ce9b3bfce288"
            $result = Get-EntraServicePrincipalPasswordCredential -ObjectId $ServicePrincipalId
            $result | Should -Not -BeNullOrEmpty
            $result.KeyId | Should -Be "bdf6a3df-cc9b-4612-b948-e32804ee88f7"
            
            Should -Invoke -CommandName Get-MgServicePrincipal -ModuleName Microsoft.Graph.Entra -Times 1
        }

        It "Should fail when ObjectId is empty" {
            $errorActionPreference = "Stop"
            { Get-EntraServicePrincipalPasswordCredential -ObjectId } | Should -Throw "Missing an argument for parameter 'ObjectId'*"
        }

        It "Should fail when ObjectId is invalid" {
            $errorActionPreference = "Stop"
            { Get-EntraServicePrincipalPasswordCredential -ObjectId "" } | Should -Throw "Cannot bind argument to parameter 'ObjectId' because it is an empty string."
        }

        It "Should contain ServicePrincipalId in parameters when passed ObjectId to it" {
            $result = Get-EntraServicePrincipalPasswordCredential -ObjectId "0008861a-d455-4671-bd24-ce9b3bfce288"
            $servicePrincipalPasswordCredential = $result | ConvertTo-Json -Depth 10 | ConvertFrom-Json
            $params = Get-Parameters -data $servicePrincipalPasswordCredential.Parameters
            $params.ServicePrincipalId | Should -Be "0008861a-d455-4671-bd24-ce9b3bfce288"
        }

        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraServicePrincipalPasswordCredential"

            $result = Get-EntraServicePrincipalPasswordCredential -ObjectId "0008861a-d455-4671-bd24-ce9b3bfce288"
            $servicePrincipalPasswordCredentialHeader = $result | ConvertTo-Json -Depth 10 | ConvertFrom-Json
            $params = Get-Parameters -data $servicePrincipalPasswordCredentialHeader.Parameters
            $params.Headers."User-Agent" | Should -Be $userAgentHeaderValue
        }    
    }
}