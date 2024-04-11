BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra) -eq $null){
        Import-Module Microsoft.Graph.Entra      
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force
    
    $scriptblock = {
        # Write-Host "Mocking Get-EntraApplicationExtensionProperty with parameters: $($args | ConvertTo-Json -Depth 3)"
        return @(
            [PSCustomObject]@{              
              "Id"             = "dc587a80-d49c-4700-a73b-57227856fc32"
              "Name"           = "extension_36ee4c6c081240a2b820b22ebd02bce3_NewAttribute"
              "TargetObjects"  = {}
            }
        )
    }
    
    Mock -CommandName Get-MgApplicationExtensionProperty -MockWith $scriptblock -ModuleName Microsoft.Graph.Entra
  }
  
  Describe "Get-EntraApplicationExtensionProperty" {
    Context "Test for Get-EntraApplicationExtensionProperty" {
        It "Should not return empty" {
            $result = Get-EntraApplicationExtensionProperty -ObjectId "dc587a80-d49c-4700-a73b-57227856fc32"
            $result | Should -Not -BeNullOrEmpty

            Should -Invoke -CommandName Get-MgApplicationExtensionProperty  -ModuleName Microsoft.Graph.Entra -Times 1
        }
        It "Should fail when ObjectId is empty" {
            { Get-EntraApplicationExtensionProperty -ObjectId "" } | Should -Throw "Cannot bind argument to parameter 'ObjectId' because it is an empty string."
        }
        It "Result should Contain ObjectId" {
            $result = Get-EntraApplicationExtensionProperty -ObjectId "dc587a80-d49c-4700-a73b-57227856fc32"
            $result.ObjectId | should -Be "dc587a80-d49c-4700-a73b-57227856fc32"
        } 
        It "Should contain ApplicationId in parameters when passed ObjectId to it" {     
            Mock -CommandName Get-MgApplicationExtensionProperty -MockWith {$args} -ModuleName Microsoft.Graph.Entra

            $result = Get-EntraApplicationExtensionProperty -ObjectId "dc587a80-d49c-4700-a73b-57227856fc32"
            $params = Get-Parameters -data $result
            $params.ApplicationId | Should -Be "dc587a80-d49c-4700-a73b-57227856fc32"
        }
        It "Should contain 'User-Agent' header" {
            Mock -CommandName Get-MgApplicationExtensionProperty -MockWith {$args} -ModuleName Microsoft.Graph.Entra

            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraApplicationExtensionProperty"

            $result = Get-EntraApplicationExtensionProperty -ObjectId "dc587a80-d49c-4700-a73b-57227856fc32"
            $params = Get-Parameters -data $result
            $params.Headers["User-Agent"] | Should -Be $userAgentHeaderValue
        }     
    }
  }