BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra) -eq $null){
        Import-Module Microsoft.Graph.Entra      
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force
    
    $scriptblock = {
        # Write-Host "Mocking Get-EntraApplicationKeyCredential with parameters: $($args | ConvertTo-Json -Depth 3)"
        return @(
            [PSCustomObject]@{              
                "CustomKeyIdentifier" = {116, 101, 115, 116}
                "EndDate"             = "10/23/2024 11:36:56 AM"
                "KeyId"               = "52ab6cca-bc59-4f06-8450-75a3d2b8e53b"
                "StartDate"           = "11/22/2023 11:35:16 AM"
                "Type"                = "Symmetric"
                "Usage"               = "Sign"
                "Value"               = ""
            }
        )
    }
    
    Mock -CommandName Get-MgApplication -MockWith $scriptblock -ModuleName Microsoft.Graph.Entra
  }
  
  Describe "Get-EntraApplicationKeyCredential" {
    Context "Test for Get-EntraApplicationKeyCredential" {
        It "Should not return empty" {
            $result = Get-EntraApplicationKeyCredential -ObjectId "dc587a80-d49c-4700-a73b-57227856fc32"
            $result | Should -Not -BeNullOrEmpty

            Should -Invoke -CommandName Get-MgApplication -ModuleName Microsoft.Graph.Entra -Times 1
        }
        It "Should fail when ObjectId is empty" {
            { Get-EntraApplicationKeyCredential -ObjectId "" } | Should -Throw "Cannot bind argument to parameter 'ObjectId' because it is an empty string."
        }
        It "Should contain 'User-Agent' header" {
            Mock -CommandName Get-MgApplication -MockWith {$args} -ModuleName Microsoft.Graph.Entra

            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraApplicationKeyCredential"

            $result = Get-EntraApplicationKeyCredential -ObjectId "dc587a80-d49c-4700-a73b-57227856fc32"
            $params = Get-Parameters -data $result
            $params.Headers["User-Agent"] | Should -Be $userAgentHeaderValue
        }     
    }
  }