BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra) -eq $null){
        Import-Module Microsoft.Graph.Entra        
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force

    $mockResponse = {
        return @{
            "value" = @{
                "Value" = $true
                "Parameters"          = $args
            }
        }
    }
    Mock -CommandName Invoke-GraphRequest -MockWith $mockResponse -ModuleName Microsoft.Graph.Entra
}

Describe "Revoke-EntraSignedInUserAllRefreshToken" {
    Context "Test for Revoke-EntraSignedInUserAllRefreshToken" {
        It "Should revoke refresh tokens for the current user" {
            $result = Revoke-EntraSignedInUserAllRefreshToken 
            $result | Should -Not -BeNullOrEmpty
            $result | Should -Be $true

            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Graph.Entra -Times 1
        }

        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Revoke-EntraSignedInUserAllRefreshToken"
            
            $result = Revoke-EntraSignedInUserAllRefreshToken 
            $params = Get-Parameters -data $result.Parameters
            $params.Headers."User-Agent" | Should -Be $userAgentHeaderValue
        }  
    }
}