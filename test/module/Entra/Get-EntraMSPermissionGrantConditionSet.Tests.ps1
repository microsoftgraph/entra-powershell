BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra) -eq $null){
        Import-Module Microsoft.Graph.Entra      
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force
    
    $scriptblock = {
        return @(
            [PSCustomObject]@{
                "Id"                                          = "4ccf1a57-4c5e-4ba6-9175-00407743b0e2"
                "ClientApplicationIds"                        = {"All"}
                "ClientApplicationPublisherIds"               = {"All"}
                "ClientApplicationTenantIds"                  = {"All"}
                "ClientApplicationsFromVerifiedPublisherOnly" = $true
                "Parameters"                                  = $args
            }
        )
    }    

    Mock -CommandName Get-MgPolicyPermissionGrantPolicyInclude -MockWith $scriptblock -ModuleName Microsoft.Graph.Entra

    Mock -CommandName Get-MgPolicyPermissionGrantPolicyExclude -MockWith $scriptblock -ModuleName Microsoft.Graph.Entra
}
Describe "Get-EntraMSPermissionGrantConditionSet"{
    It "Should not return empty object for condition set 'includes'"{
        $result = Get-EntraMSPermissionGrantConditionSet -PolicyId "policy1" -ConditionSetType "includes" -Id "4ccf1a57-4c5e-4ba6-9175-00407743b0e2"
        $result | Should -Not -BeNullOrEmpty
        Should -Invoke -CommandName Get-MgPolicyPermissionGrantPolicyInclude -ModuleName Microsoft.Graph.Entra -Times 1
    }
    It "Should not return empty object for condition set 'excludes'"{
        $result = Get-EntraMSPermissionGrantConditionSet -PolicyId "policy1" -ConditionSetType "excludes" -Id "4ccf1a57-4c5e-4ba6-9175-00407743b0e2"
        $result | Should -Not -BeNullOrEmpty
        Should -Invoke -CommandName Get-MgPolicyPermissionGrantPolicyExclude -ModuleName Microsoft.Graph.Entra -Times 1
    }
    It "Should fail when parameters are empty" {
        { Get-EntraMSPermissionGrantConditionSet -PolicyId "" -ConditionSetType "" -Id ""} | Should -Throw "Cannot bind argument to parameter*"
    }
    It "Should fail when parameters are null" {
        { Get-EntraMSPermissionGrantConditionSet -PolicyId  -ConditionSetType  -Id} | Should -Throw "Missing an argument for parameter*"
    }
    It "Should contain PermissionGrantConditionSetId in parameters when passed Id to it" {              
        $result = Get-EntraMSPermissionGrantConditionSet -PolicyId "policy1" -ConditionSetType "includes" -Id "4ccf1a57-4c5e-4ba6-9175-00407743b0e2"
        $params = Get-Parameters -data $result.Parameters
        $params.PermissionGrantConditionSetId | Should -Be "4ccf1a57-4c5e-4ba6-9175-00407743b0e2"
    }
    It "Should contain PermissionGrantPolicyId in parameters when passed PolicyId to it" {              
        $result = Get-EntraMSPermissionGrantConditionSet -PolicyId "policy1" -ConditionSetType "includes" -Id "4ccf1a57-4c5e-4ba6-9175-00407743b0e2"
        $params = Get-Parameters -data $result.Parameters
        $params.PermissionGrantPolicyId | Should -Be "policy1"
    }
    It "Should contain 'User-Agent' header" {
        $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraMSPermissionGrantConditionSet"
        $result = Get-EntraMSPermissionGrantConditionSet -PolicyId "policy1" -ConditionSetType "includes"
        $params = Get-Parameters -data $result.Parameters
        $params.Headers["User-Agent"] | Should -Be $userAgentHeaderValue
    }
}