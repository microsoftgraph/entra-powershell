BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra) -eq $null){
        Import-Module Microsoft.Graph.Entra      
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force
    
    $scriptblock = {
        return @(
            [PSCustomObject]@{
                "Id"                   = "7dc3a38a-4c92-40bd-b290-ea00f85b478c"
                "AdditionalProperties" = @{DeletedDateTime = $null}
                "Parameters"           = $args
            }
        )
    }

    Mock -CommandName Get-MgServicePrincipalTransitiveMemberOf -MockWith $scriptblock -ModuleName Microsoft.Graph.Entra
}
Describe "Get-EntraServicePrincipalMembership"{
    It "Result should not be empty" {
        $result = Get-EntraServicePrincipalMembership -ObjectId "02ed943d-6eca-4f99-83d6-e6fbf9dc63ae"
        $result | Should -Not -BeNullOrEmpty
        Should -Invoke -CommandName Get-MgServicePrincipalTransitiveMemberOf -ModuleName Microsoft.Graph.Entra -Times 1
    }
    It "Should fail when ObjectId is empty" {
        { Get-EntraServicePrincipalMembership -ObjectId "" } | Should -Throw "Cannot bind argument to parameter 'ObjectId' because it is an empty string."
    }
    It "Should return all applications" {
        $result = Get-EntraServicePrincipalMembership -ObjectId "02ed943d-6eca-4f99-83d6-e6fbf9dc63ae" -All $true
        $result | Should -Not -BeNullOrEmpty
        Should -Invoke -CommandName Get-MgServicePrincipalTransitiveMemberOf -ModuleName Microsoft.Graph.Entra -Times 1
    }
    It "Should fail when All is empty" {
        { Get-EntraServicePrincipalMembership -ObjectId "02ed943d-6eca-4f99-83d6-e6fbf9dc63ae" -All } | Should -Throw "Missing an argument for parameter 'All'*"
    }
    It "Should return top application" {
        $result = Get-EntraServicePrincipalMembership -ObjectId "02ed943d-6eca-4f99-83d6-e6fbf9dc63ae" -Top 1
        $result | Should -Not -BeNullOrEmpty
        Should -Invoke -CommandName Get-MgServicePrincipalTransitiveMemberOf -ModuleName Microsoft.Graph.Entra -Times 1
    }
    It "Result should Contain ObjectId" {            
        $result = Get-EntraServicePrincipalMembership -ObjectId "02ed943d-6eca-4f99-83d6-e6fbf9dc63ae"
        $result.ObjectId | should -Be "7dc3a38a-4c92-40bd-b290-ea00f85b478c"
    }
    It "Should contain ServicePrincipalId in parameters when passed ObjectId to it" {    
        $result = Get-EntraServicePrincipalMembership -ObjectId "02ed943d-6eca-4f99-83d6-e6fbf9dc63ae"
        $params = Get-Parameters -data $result.Parameters
        $params.ServicePrincipalId | Should -Be "02ed943d-6eca-4f99-83d6-e6fbf9dc63ae"
    }
    It "Should contain 'User-Agent' header" {
        $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraServicePrincipalMembership"
        $result = Get-EntraServicePrincipalMembership -ObjectId "02ed943d-6eca-4f99-83d6-e6fbf9dc63ae"
        $params = Get-Parameters -data $result.Parameters
        $params.Headers["User-Agent"] | Should -Be $userAgentHeaderValue
    }
}