BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra) -eq $null){
        Import-Module Microsoft.Graph.Entra      
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force
    
    $scriptblock = {
        @{
            "PasswordCredentials" = @(
                @{
                    "CustomKeyIdentifier" = {116, 101, 115, 116}
                    "DisplayName"         = ""
                    "EndDateTime"         = "10/23/2024 11:36:56 AM"
                    "KeyId"               = "52ab6cca-bc59-4f06-8450-75a3d2b8e53b"
                    "StartDateTime"       = "11/22/2023 11:35:16 AM"
                    "Hint"                = "123"
                    "SecretText"          = ""
                    "Parameters"          = $args
                }
            )            
        }
    }
    
    Mock -CommandName Get-MgApplication -MockWith $scriptblock -ModuleName Microsoft.Graph.Entra
  }
  
  Describe "Get-EntraApplicationPasswordCredential" {
    Context "Test for Get-EntraApplicationPasswordCredential" {
        It "Should not return empty" {
            $result = Get-EntraApplicationPasswordCredential -ObjectId "dc587a80-d49c-4700-a73b-57227856fc32"
            $result | Should -Not -BeNullOrEmpty
            Should -Invoke -CommandName Get-MgApplication -ModuleName Microsoft.Graph.Entra -Times 1
        }
        It "Should fail when ObjectId is empty" {
            { Get-EntraApplicationPasswordCredential -ObjectId "" } | Should -Throw "Cannot bind argument to parameter 'ObjectId'*"
        }
        It "Should fail when ObjectId is null" {
            { Get-EntraApplicationPasswordCredential -ObjectId  } | Should -Throw "Missing an argument for parameter 'ObjectId'*"
        }
        It "Should fail when invalid parameter is passed" {
            { Get-EntraApplicationPasswordCredential -DisplayName "abc" } | Should -Throw "A parameter cannot be found that matches parameter name 'DisplayName'*"
        }
        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraApplicationPasswordCredential"
            $result = Get-EntraApplicationPasswordCredential -ObjectId "dc587a80-d49c-4700-a73b-57227856fc32"
            $params = Get-Parameters -data $result.Parameters
            $params.Headers["User-Agent"] | Should -Be $userAgentHeaderValue
        }     
    }
  }