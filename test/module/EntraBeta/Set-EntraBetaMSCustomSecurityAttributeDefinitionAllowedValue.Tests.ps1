BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra.Beta) -eq $null){
        Import-Module Microsoft.Graph.Entra.Beta    
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force

    Mock -CommandName Update-MgBetaDirectoryCustomSecurityAttributeDefinitionAllowedValue -MockWith {} -ModuleName Microsoft.Graph.Entra.Beta
}

Describe "Set-EntraBetaMSCustomSecurityAttributeDefinitionAllowedValue" {
    Context "Test for Set-EntraBetaMSCustomSecurityAttributeDefinitionAllowedValue" {
        It "Should update a specific value for the Id" {
            $result = Set-EntraBetaMSCustomSecurityAttributeDefinitionAllowedValue -CustomSecurityAttributeDefinitionId Engineering_Projectt -Id "wasssup snehal" -IsActive $false
            $result | Should -BeNullOrEmpty

            Should -Invoke -CommandName Update-MgBetaDirectoryCustomSecurityAttributeDefinitionAllowedValue -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }

        It "Should fail when CustomSecurityAttributeDefinitionId are empty" {
            { Set-EntraBetaMSCustomSecurityAttributeDefinitionAllowedValue -CustomSecurityAttributeDefinitionId  -Id "wasssup snehal"  -IsActive $false } | Should -Throw "Missing an argument for parameter 'CustomSecurityAttributeDefinitionId'*"
        }

        It "Should fail when CustomSecurityAttributeDefinitionId is Invalid" {
            { Set-EntraBetaMSCustomSecurityAttributeDefinitionAllowedValue -CustomSecurityAttributeDefinitionId "" -Id "wasssup snehal"  -IsActive $false } | Should -Throw "Cannot bind argument to parameter 'CustomSecurityAttributeDefinitionId' because it is an empty string."
        }

        It "Should fail when Id are empty" {
            { Set-EntraBetaMSCustomSecurityAttributeDefinitionAllowedValue -CustomSecurityAttributeDefinitionId Engineering_Projectt -Id  -IsActive $false } | Should -Throw "Missing an argument for parameter 'Id'*"
        }

        It "Should fail when Id is Invalid" {
            { Set-EntraBetaMSCustomSecurityAttributeDefinitionAllowedValue -CustomSecurityAttributeDefinitionId Engineering_Projectt -Id ""  -IsActive $false } | Should -Throw "Cannot bind argument to parameter 'Id' because it is an empty string."
        }

        It "Should fail when IsActive are empty" {
            { Set-EntraBetaMSCustomSecurityAttributeDefinitionAllowedValue -CustomSecurityAttributeDefinitionId Engineering_Projectt -Id "wasssup snehal" -IsActive } | Should -Throw "Missing an argument for parameter 'IsActive'*"
        }

        It "Should fail when IsActive are invalid" {
            { Set-EntraBetaMSCustomSecurityAttributeDefinitionAllowedValue -CustomSecurityAttributeDefinitionId Engineering_Projectt -Id "wasssup snehal" -IsActive dffg } | Should -Throw "Cannot process argument transformation on parameter 'IsActive'*"
        }

        It "Should contain AllowedValueId in parameters when passed Id to it" {
            Mock -CommandName Update-MgBetaDirectoryCustomSecurityAttributeDefinitionAllowedValue -MockWith {$args} -ModuleName Microsoft.Graph.Entra.Beta

            $result = Set-EntraBetaMSCustomSecurityAttributeDefinitionAllowedValue -CustomSecurityAttributeDefinitionId Engineering_Projectt -Id "wasssup snehal" -IsActive $false
            $params = Get-Parameters -data $result
            $params.AllowedValueId | Should -Be "wasssup snehal"
        }

        It "Should contain 'User-Agent' header" {
            Mock -CommandName Update-MgBetaDirectoryCustomSecurityAttributeDefinitionAllowedValue -MockWith {$args} -ModuleName Microsoft.Graph.Entra.Beta

            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Set-EntraBetaMSCustomSecurityAttributeDefinitionAllowedValue"
            $result = Set-EntraBetaMSCustomSecurityAttributeDefinitionAllowedValue -CustomSecurityAttributeDefinitionId Engineering_Projectt -Id "wasssup snehal" -IsActive $false
            $params = Get-Parameters -data $result
            $params.Headers["User-Agent"] | Should -Be $userAgentHeaderValue
        }   
    }
}