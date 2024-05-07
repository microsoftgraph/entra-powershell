BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra) -eq $null){
        Import-Module Microsoft.Graph.Entra
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force

    Mock -CommandName Remove-MgServicePrincipal -MockWith {} -ModuleName Microsoft.Graph.Entra
}
Describe "Remove-EntraServicePrincipal" {
    Context "Test for Remove-EntraServicePrincipal" {
        It "Should return empty object" {
            $result = Remove-EntraServicePrincipal -ObjectId "a39eeff5-5529-4a7c-8c19-e97c010a012b"
            $result | Should -BeNullOrEmpty
            Should -Invoke -CommandName Remove-MgServicePrincipal -ModuleName Microsoft.Graph.Entra -Times 1
        }

        It "Should fail when ObjectId is empty" {
            { Remove-EntraServicePrincipal -ObjectId }| Should -Throw "Missing an argument for parameter 'ObjectId'.*"                
        } 
        It "Should fail when ObjectId is invalid" {
            { Remove-EntraServicePrincipal -ObjectId "" } | Should -Throw "Cannot bind argument to parameter 'ObjectId' because it is an empty string.*"
        }
        It "Should contain ServicePrincipalId in parameters when passed ObjectId to it" {
            Mock -CommandName Remove-MgServicePrincipal -MockWith {$args} -ModuleName Microsoft.Graph.Entra

            $result = Remove-EntraServicePrincipal -ObjectId "a39eeff5-5529-4a7c-8c19-e97c010a012b" 
            $params = Get-Parameters -data $result
            $params.ServicePrincipalId | Should -Be "a39eeff5-5529-4a7c-8c19-e97c010a012b"
        
        }
        It "Should contain 'User-Agent' header" {
            Mock -CommandName Remove-MgServicePrincipal -MockWith {$args} -ModuleName Microsoft.Graph.Entra
            
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Remove-EntraServicePrincipal"
            $result = Remove-EntraServicePrincipal -ObjectId "a39eeff5-5529-4a7c-8c19-e97c010a012b"
            $params = Get-Parameters -data $result
            $params.Headers["User-Agent"] | Should -Be $userAgentHeaderValue
        } 
    }
}