BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra) -eq $null){
        Import-Module Microsoft.Graph.Entra
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force
    $scriptblock = {
        #Write-Host "Mocking set-EntraPolicy with parameters: $($args | ConvertTo-Json -Depth 3)"
        
        $response = @{
            '@odata.context' = 'https://graph.microsoft.com/v1.0/$metadata#policies/homeRealmDiscoveryPolicies/$entity'            
        }

        return $response
    }
    Mock -CommandName Invoke-GraphRequest -MockWith $scriptblock -ModuleName Microsoft.Graph.Entra
}

Describe "Test for Set-EntraPolicy" {

    It "Should return empty object" {
        $result = Set-EntraPolicy -Id "bbbbbbbb-1111-2222-3333-cccccccccccc" 
        
        Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Graph.Entra -Times 1
    }

    It "Should fail when id is empty" {
        { Set-EntraPolicy -Id "" } | Should -Throw "Cannot bind argument to parameter 'Id'*"
    }
    It "Should fail when Id is null" {
        { Set-EntraPolicy -Id } | Should -Throw "Missing an argument for parameter 'Id'*"
    }
    It "Should fail when displaymane is null" {
        { Set-EntraPolicy -DisplayName } | Should -Throw "Missing an argument for parameter 'DisplayName'*"
    }
    It "Should fail when AlternativeIdentifier is null" {
        { Set-EntraPolicy -AlternativeIdentifier } | Should -Throw "Missing an argument for parameter 'AlternativeIdentifier'*"
    }
    It "Should fail when IsOrganizationDefault is null" {
        { Set-EntraPolicy -IsOrganizationDefault } | Should -Throw "Missing an argument for parameter 'IsOrganizationDefault'*"
    }
    It "Should fail when invalid parameter is passed" {
        { Set-EntraPolicy -xyz } | Should -Throw "A parameter cannot be found that matches parameter name 'xyz'*"
    }


    It "Should contain 'User-Agent' header" {
        Mock -CommandName Invoke-GraphRequest -MockWith {$args} -ModuleName Microsoft.Graph.Entra
        $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Set-EntraPolicy"
        $result = Set-EntraPolicy -Id "Engineering_Project"  -type "homeRealmDiscoveryPolicies"
        $params = Get-Parameters -data $result
        $a= $params | ConvertTo-json | ConvertFrom-Json
        $a.headers.'User-Agent' | Should -Be $userAgentHeaderValue        
    } 
}

