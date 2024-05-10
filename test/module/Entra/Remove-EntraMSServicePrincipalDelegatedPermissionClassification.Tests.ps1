BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra) -eq $null){
        Import-Module Microsoft.Graph.Entra
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force

    Mock -CommandName Remove-MgServicePrincipalDelegatedPermissionClassification -MockWith {} -ModuleName Microsoft.Graph.Entra
}

Describe "Remove-EntraMSServicePrincipalDelegatedPermissionClassification" {
    Context "Test for Remove-EntraMSServicePrincipalDelegatedPermissionClassification" {
        It "Should return empty object" {
            $result = Remove-EntraMSServicePrincipalDelegatedPermissionClassification -ServicePrincipalId "31a7a6c7-6625-446b-8254-30438fb13c9a" -Id "jyXUloeRbE6wMXJOeJuTIwE"
            $result | Should -BeNullOrEmpty

            Should -Invoke -CommandName Remove-MgServicePrincipalDelegatedPermissionClassification -ModuleName Microsoft.Graph.Entra -Times 1
        }
        It "Should fail when ServicePrincipalId is empty" {
            { Remove-EntraMSServicePrincipalDelegatedPermissionClassification -ServicePrincipalId  -Id "jyXUloeRbE6wMXJOeJuTIwE" } | should -Throw "Missing an argument for parameter 'ServicePrincipalId'.*"
        }   
        It "Should fail when ServicePrincipalId is invalid" {
            { Remove-EntraMSServicePrincipalDelegatedPermissionClassification -ServicePrincipalId "" -Id "jyXUloeRbE6wMXJOeJuTIwE" } | should -Throw "Cannot bind argument to parameter 'ServicePrincipalId'*"
        }  
        It "Should fail when Id is empty" {
            {  Remove-EntraMSServicePrincipalDelegatedPermissionClassification -ServicePrincipalId "31a7a6c7-6625-446b-8254-30438fb13c9a" -Id  } | should -Throw "Missing an argument for parameter 'Id'.*"
        }   
        It "Should fail when Id is invalid" {
            {  Remove-EntraMSServicePrincipalDelegatedPermissionClassification -ServicePrincipalId "31a7a6c7-6625-446b-8254-30438fb13c9a" -Id "" } | should -Throw "Cannot bind argument to parameter 'Id'*"
        }  
        It "Should contain DelegatedPermissionClassificationId in parameters when passed Id to it" {
            Mock -CommandName Remove-MgServicePrincipalDelegatedPermissionClassification -MockWith {$args} -ModuleName Microsoft.Graph.Entra

            $result =  Remove-EntraMSServicePrincipalDelegatedPermissionClassification -ServicePrincipalId "31a7a6c7-6625-446b-8254-30438fb13c9a" -Id "jyXUloeRbE6wMXJOeJuTIwE"
            $params = Get-Parameters -data $result
            $params.DelegatedPermissionClassificationId | Should -Be "jyXUloeRbE6wMXJOeJuTIwE"
        }
        It "Should contain 'User-Agent' header" {
            Mock -CommandName Remove-MgServicePrincipalDelegatedPermissionClassification -MockWith {$args} -ModuleName Microsoft.Graph.Entra

            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Remove-EntraMSServicePrincipalDelegatedPermissionClassification"
            $result =  Remove-EntraMSServicePrincipalDelegatedPermissionClassification -ServicePrincipalId "31a7a6c7-6625-446b-8254-30438fb13c9a" -Id "jyXUloeRbE6wMXJOeJuTIwE"
            $params = Get-Parameters -data $result
            $params.Headers["User-Agent"] | Should -Be $userAgentHeaderValue
        } 
    }
}