BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra) -eq $null){
        Import-Module Microsoft.Graph.Entra    
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force
    
    $scriptblock = {
        # Write-Host "Mocking New-MgDirectoryAdministrativeUnit with parameters: $($args | ConvertTo-Json -Depth 3)"
        return @(
            [PSCustomObject]@{
                "DeletedDateTime"              = $null
                "Id"                           = "eb7dee2b-4938-4835-b3e1-bb8207ae0814"
                "DisplayName"                  = "Mock-AU"
                "AdditionalProperties"         = {}
            }
        )
    }

    Mock -CommandName New-MgDirectoryAdministrativeUnit -MockWith $scriptblock -ModuleName Microsoft.Graph.Entra
}

Describe "New-EntraMSAdministrativeUnit"{
    Context "Test for New-EntraMSAdministrativeUnit" {
        It "Should return created administrative unit"{
            $result = New-EntraMSAdministrativeUnit -DisplayName "Mock-AU"
            $result | Should -Not -BeNullOrEmpty
            $result.DisplayName | should -Be "Mock-AU" 

            Should -Invoke -CommandName New-MgDirectoryAdministrativeUnit -ModuleName Microsoft.Graph.Entra -Times 1
        }
        It "Should fail when DisplayName is empty" {
            { New-EntraMSAdministrativeUnit -DisplayName "" } | Should -Throw "Cannot bind argument to parameter 'DisplayName' because it is an empty string."
        }
        It "Result should Contain ObjectId"{
            $result = New-EntraMSAdministrativeUnit -DisplayName "Mock-App"
            $result.ObjectId | should -Be "eb7dee2b-4938-4835-b3e1-bb8207ae0814"
        }
        It "Should contain 'User-Agent' header" {
            Mock -CommandName New-MgDirectoryAdministrativeUnit -MockWith {$args} -ModuleName Microsoft.Graph.Entra

            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion New-EntraMSAdministrativeUnit"

            $result = New-EntraMSAdministrativeUnit -DisplayName "Mock-App"
            $params = Get-Parameters -data $result
            $params.Headers["User-Agent"] | Should -Be $userAgentHeaderValue
        }
    }
}