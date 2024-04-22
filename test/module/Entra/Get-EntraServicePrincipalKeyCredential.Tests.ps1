BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra) -eq $null){
        Import-Module Microsoft.Graph.Entra        
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force
    
    $scriptblock = {
        return @(
            [PSCustomObject]@{
                "KeyCredentials"                    = @{
                    "CustomKeyIdentifier"           = ""
                    "DisplayName"                   = ""
                    "EndDateTime"                   = "08-Feb-25 9:57:08 AM"
                    "Key"                           = ""
                    "KeyId"                         = "68b45e27-fef8-4f0d-bc7a-76bd949c16d1"
                    "StartDateTime"                 = "08-Feb-24 9:57:08 AM"
                    "Type"                          = "Symmetric"
                    "Usage"                         = "Sign"
                    "AdditionalProperties"          = @{}
                    "Parameters"                    = $args
                }    
            }
        )
    }

    Mock -CommandName Get-MgServicePrincipal -MockWith $scriptblock -ModuleName Microsoft.Graph.Entra
}
  
Describe "Get-EntraServicePrincipalKeyCredential" {
    Context "Test for Get-EntraServicePrincipalKeyCredential" {
        It "Should return specific principal key credential" {
            $objectId = "0008861a-d455-4671-bd24-ce9b3bfce288"
            $result = Get-EntraServicePrincipalKeyCredential -ObjectId $objectId
            $result | Should -Not -BeNullOrEmpty
            $resultJson = $result | ConvertTo-Json -Depth 10 | ConvertFrom-Json
            $resultJson.Parameters | ForEach-Object {
                if ($_.ServicePrincipalId -eq $objectId) {
                    $objectIdFound = $true
                    break
                }
            }

            Should -Invoke -CommandName Get-MgServicePrincipal -ModuleName Microsoft.Graph.Entra -Times 1
        }

        It "Should fail when ObjectId is empty" {
            $errorActionPreference = "Stop"
            { Get-EntraServicePrincipalKeyCredential -ObjectId "" } | Should -Throw "Cannot bind argument to parameter 'ObjectId' because it is an empty string."
        }
        
        It "Result should Contain ObjectId" {
            $objectId = "0008861a-d455-4671-bd24-ce9b3bfce288"
            $result = Get-EntraServicePrincipalKeyCredential -ObjectId $objectId
            $result | Should -Not -BeNullOrEmpty
            $resultJson = $result | ConvertTo-Json -Depth 10 | ConvertFrom-Json
            $resultJson.Parameters | ForEach-Object {
                if ($_.ObjectId -eq $objectId) {
                    $objectIdFound = $true
                    break
                }
            }
            Write-Host $resultJson

            Should -Invoke -CommandName Get-MgServicePrincipal -ModuleName Microsoft.Graph.Entra -Times 1
        } 

        It "Should contain ServicePrincipalId in parameters when passed ObjectId to it" {
            $result = Get-EntraServicePrincipalKeyCredential -ObjectId "0008861a-d455-4671-bd24-ce9b3bfce288"
            $a = $result | ConvertTo-Json -Depth 10 | ConvertFrom-Json
            $params = Get-Parameters -data $a.Parameters
            $params.ServicePrincipalId | Should -Be "0008861a-d455-4671-bd24-ce9b3bfce288"
        }

        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraServicePrincipalKeyCredential"

            $result = Get-EntraServicePrincipalKeyCredential -ObjectId "0008861a-d455-4671-bd24-ce9b3bfce288"
            $a = $result | ConvertTo-Json -Depth 10 | ConvertFrom-Json
            $params = Get-Parameters -data $a.Parameters
            $params.Headers."User-Agent" | Should -Be $userAgentHeaderValue
            Write-Host $a.Parameters
        }    
    }
}