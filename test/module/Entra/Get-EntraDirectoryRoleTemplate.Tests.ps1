BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra) -eq $null){
        Import-Module Microsoft.Graph.Entra      
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force
    
    $scriptblock = {
        return @(
            [PSCustomObject]@{
              "Id"                           = "dbee41d1-5a69-4c8f-a8f1-5d8cc0e2e935"
              "DisplayName"                  = "Mock-App"
              "DeletedDateTime"              = $null
              "Description"                  = "Can read mock-app service health information"
              "AdditionalProperties"         = @{}
              "Parameters"                   = $args
            }
        )
    }

    Mock -CommandName Get-MgDirectoryRoleTemplate -MockWith $scriptblock -ModuleName Microsoft.Graph.Entra
}

Describe "Get-EntraDirectoryRoleTemplate" {
    Context "Test for Get-EntraDirectoryRoleTemplate" {
        It "Should return all directory role template" {
            $result = Get-EntraDirectoryRoleTemplate 
            $result | Should -Not -BeNullOrEmpty
            $result.Id | should -Be "dbee41d1-5a69-4c8f-a8f1-5d8cc0e2e935"
            $result.DisplayName | should -Be "Mock-App"

            Should -Invoke -CommandName Get-MgDirectoryRoleTemplate  -ModuleName Microsoft.Graph.Entra -Times 1
        }
        It "Should be fail when provide non supported parameter" {
            { Get-EntraDirectoryRoleTemplate -Top 1} | should -Throw "A parameter cannot be found that matches parameter name 'Top'."
        }
        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraDirectoryRoleTemplate"

            $result = Get-EntraDirectoryRoleTemplate
            $params = Get-Parameters -data $result.Parameters
            $params.Headers["User-Agent"] | Should -Be $userAgentHeaderValue
        }
        


    }
}        