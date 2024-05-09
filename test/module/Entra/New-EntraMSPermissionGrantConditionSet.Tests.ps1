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
                "PermissionClassification"                    = "all"
                "PermissionType"                              = "delegated"
                "Parameters"                                  = $args
            }
        )
    }    

    Mock -CommandName New-MgPolicyPermissionGrantPolicyInclude -MockWith $scriptblock -ModuleName Microsoft.Graph.Entra

    Mock -CommandName New-MgPolicyPermissionGrantPolicyExclude -MockWith $scriptblock -ModuleName Microsoft.Graph.Entra
}
Describe "New-EntraMSPermissionGrantConditionSet"{
    It "Should not return empty object for condition set 'includes'"{
        $result = New-EntraMSPermissionGrantConditionSet -PolicyId "test1" -ConditionSetType "includes" -PermissionType "delegated"
        $result | Should -Not -BeNullOrEmpty
        Should -Invoke -CommandName New-MgPolicyPermissionGrantPolicyInclude -ModuleName Microsoft.Graph.Entra -Times 1
    }
    It "Should not return empty object for condition set 'excludes'"{
        $result = New-EntraMSPermissionGrantConditionSet -PolicyId "test1" -ConditionSetType "excludes" -PermissionType "delegated"
        $result | Should -Not -BeNullOrEmpty
        Should -Invoke -CommandName New-MgPolicyPermissionGrantPolicyExclude -ModuleName Microsoft.Graph.Entra -Times 1
    }
    It "Should fail when parameters are empty" {
        { New-EntraMSPermissionGrantConditionSet -PolicyId "" -ConditionSetType ""} | Should -Throw "Cannot bind argument to parameter*"
    }
    It "Should fail when parameters are null" {
        { New-EntraMSPermissionGrantConditionSet -PolicyId  -ConditionSetType } | Should -Throw "Missing an argument for parameter*"
    }
    It "Should contain PermissionGrantPolicyId in parameters when passed PolicyId to it" {              
        $result = New-EntraMSPermissionGrantConditionSet -PolicyId "test1" -ConditionSetType "includes" -PermissionType "delegated"
        $params = Get-Parameters -data $result.Parameters
        $params.PermissionGrantPolicyId | Should -Be "test1"
    }
    It "Should contain 'User-Agent' header" {
        $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion New-EntraMSPermissionGrantConditionSet"
        $result = New-EntraMSPermissionGrantConditionSet -PolicyId "test1" -ConditionSetType "includes" -PermissionType "delegated"
        $params = Get-Parameters -data $result.Parameters
        $params.Headers["User-Agent"] | Should -Be $userAgentHeaderValue
    }
}