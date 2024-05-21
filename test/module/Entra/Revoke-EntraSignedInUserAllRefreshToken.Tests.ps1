BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra) -eq $null){
        Import-Module Microsoft.Graph.Entra        
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force

    $mockResponse = {
        return @{
            value = @()
            "Parameters"          = $args
        }
    }
    Mock -CommandName Invoke-GraphRequest -MockWith $mockResponse -ModuleName Microsoft.Graph.Entra
}

Describe "Revoke-EntraSignedInUserAllRefreshToken" {
    Context "Test for Revoke-EntraSignedInUserAllRefreshToken" {
        It "Should revoke refresh tokens for the current user" {
            $result = Revoke-EntraSignedInUserAllRefreshToken 
            $result | Should -BeNullOrEmpty
            Write-Host $result
            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Graph.Entra -Times 1
        }

        It "Should contain 'User-Agent' header" {
            # Mock -CommandName Invoke-GraphRequest -MockWith {$args} -ModuleName Microsoft.Graph.Entra

            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Revoke-EntraSignedInUserAllRefreshToken"
            $result = Revoke-EntraSignedInUserAllRefreshToken 
            $params = Get-Parameters -data $result.Parameters
            Write-Host $params
            $userAgent= $params | ConvertTo-json | ConvertFrom-Json
            $userAgent.Headers."User-Agent" | Should -Be $userAgentHeaderValue
            Write-Host $userAgent
        }  
    }
}