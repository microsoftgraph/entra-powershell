BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra) -eq $null){
        Import-Module Microsoft.Graph.Entra
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force

    Mock -CommandName Invoke-GraphRequest -MockWith {} -ModuleName Microsoft.Graph.Entra
}

Describe "Test for Set-EntraMSCustomSecurityAttributeDefinitionAllowedValue" {

    It "Should return empty object" {
        $result = Set-EntraMSCustomSecurityAttributeDefinitionAllowedValue -Id "Engineering_Project" -AllowedValueId "Alpine" -IsActive $true
        $result | Should -BeNullOrEmpty
        Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Graph.Entra -Times 1
    }

    It "Should fail when ID is empty" {
        { Set-EntraMSCustomSecurityAttributeDefinitionAllowedValue -Id "" } | Should -Throw "Cannot bind argument to parameter 'Id'*"
    }
    It "Should fail when Id is null" {
        { Set-EntraMSCustomSecurityAttributeDefinitionAllowedValue -Id } | Should -Throw "Missing an argument for parameter 'Id'*"
    }
    It "Should fail when invalid parameter is passed" {
        { Set-EntraMSCustomSecurityAttributeDefinitionAllowedValue -xyz } | Should -Throw "A parameter cannot be found that matches parameter name 'xyz'*"
    }

    It "Should fail when AllowedValueId is empty" {
        { Set-EntraMSCustomSecurityAttributeDefinitionAllowedValue -Id "Engineering_Project" -AllowedValueId "" } | Should -Throw "Cannot bind argument to parameter 'AllowedValueId'*"
    }
    It "Should fail when AllowedValueId is null" {
        { Set-EntraMSCustomSecurityAttributeDefinitionAllowedValue -Id "Engineering_Project" -AllowedValueId } | Should -Throw "Missing an argument for parameter 'AllowedValueId'*"
    }
    
    It "Should contain 'User-Agent' header" {
        Mock -CommandName Invoke-GraphRequest -MockWith {$args} -ModuleName Microsoft.Graph.Entra
        $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Set-EntraMSCustomSecurityAttributeDefinitionAllowedValue"
        $result = Set-EntraMSCustomSecurityAttributeDefinitionAllowedValue -Id "Engineering_Project" -AllowedValueId "Alpine" -IsActive $true
        $params = Get-Parameters -data $result
        $a= $params | ConvertTo-json | ConvertFrom-Json
        $a.headers.'User-Agent' | Should -Be $userAgentHeaderValue        
    } 
}