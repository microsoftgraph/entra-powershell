BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra) -eq $null){
        Import-Module Microsoft.Graph.Entra
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force
    
    $scriptblock = {
        Write-Host "Mocking Get-MgContactMemberOf with parameters: $($args | ConvertTo-Json -Depth 3)"
        return @(
            [PSCustomObject]@{
              "Parameters"      = $args
            }
        )
    }  

    Mock -CommandName Remove-MgApplicationExtensionProperty -MockWith $scriptblock -ModuleName Microsoft.Graph.Entra
}

Describe "Remove-EntraMSApplicationExtensionProperty" {
    Context "Test for Remove-EntraMSApplicationExtensionProperty" {
        It "Should return empty object" {
            $result = Remove-EntraMSApplicationExtensionProperty -ObjectId "0f9742d9-a7ec-4ae3-8e15-223aed7e4e56" -ExtensionPropertyId "d0479464-8cae-4859-9a88-fa20cd6c5d3a"
            $result | Should -BeNullOrEmpty

            Should -Invoke -CommandName Remove-MgApplicationExtensionProperty -ModuleName Microsoft.Graph.Entra -Times 1
        }

        It "Should fail when ObjectId is empty" {
            { Remove-EntraMSApplicationExtensionProperty -ObjectId "" -ExtensionPropertyId ""}
        }   

        It "Should contain ApplicationId in parameters when passed ObjectId to it" {
            $result = Remove-EntraMSApplicationExtensionProperty -ObjectId "0f9742d9-a7ec-4ae3-8e15-223aed7e4e56" -ExtensionPropertyId "d0479464-8cae-4859-9a88-fa20cd6c5d3a"
            $params = Get-Parameters -data $result.Parameters
            $params.ApplicationId | Should -Be "0f9742d9-a7ec-4ae3-8e15-223aed7e4e56"
        }

        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Remove-EntraMSApplicationExtensionProperty"
            
            $result = Remove-EntraMSApplicationExtensionProperty -ObjectId "0f9742d9-a7ec-4ae3-8e15-223aed7e4e56" -ExtensionPropertyId "d0479464-8cae-4859-9a88-fa20cd6c5d3a"
            $params = Get-Parameters -data $result.Parameters
            $params.Headers["User-Agent"] | Should -Be $userAgentHeaderValue
        } 
    }
}