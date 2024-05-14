BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra) -eq $null){
        Import-Module Microsoft.Graph.Entra      
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force

    Mock -CommandName Update-MgPolicyPermissionGrantPolicyInclude -MockWith {} -ModuleName Microsoft.Graph.Entra

    Mock -CommandName Update-MgPolicyPermissionGrantPolicyExclude -MockWith {} -ModuleName Microsoft.Graph.Entra
}
Describe "Set-EntraMSPermissionGrantConditionSet"{
    It "Should return empty object for condition set 'includes'"{
        $result = Set-EntraMSPermissionGrantConditionSet -PolicyId "policy1" -ConditionSetType "includes" -Id "665a9903-0398-48ab-b4e9-7a570d468b66" -PermissionClassification "Low"
        $result | Should -BeNullOrEmpty
        Should -Invoke -CommandName Update-MgPolicyPermissionGrantPolicyInclude -ModuleName Microsoft.Graph.Entra -Times 1
    }
    It "Should return empty object for condition set 'excludes'"{
        $result = Set-EntraMSPermissionGrantConditionSet -PolicyId "policy1" -ConditionSetType "excludes" -Id "665a9903-0398-48ab-b4e9-7a570d468b66" -PermissionClassification "Low"
        $result | Should -BeNullOrEmpty
        Should -Invoke -CommandName Update-MgPolicyPermissionGrantPolicyExclude -ModuleName Microsoft.Graph.Entra -Times 1
    }
    It "Should fail when parameters are empty" {
        { Set-EntraMSPermissionGrantConditionSet -PolicyId "" -ConditionSetType "" -Id ""} | Should -Throw "Cannot bind argument to parameter*"
    }
    It "Should fail when parameters are null" {
        { Set-EntraMSPermissionGrantConditionSet -PolicyId  -ConditionSetType  -Id } | Should -Throw "Missing an argument for parameter*"
    }
    It "Should contain parameters for condition set 'includes'" {   
        Mock -CommandName Update-MgPolicyPermissionGrantPolicyInclude -MockWith {$args} -ModuleName Microsoft.Graph.Entra           
        $result = Set-EntraMSPermissionGrantConditionSet -PolicyId "policy1" -ConditionSetType "includes" -Id "665a9903-0398-48ab-b4e9-7a570d468b66" -PermissionClassification "Low"
        $params = Get-Parameters -data $result
        $params.PermissionGrantPolicyId | Should -Be "policy1"
        $params.PermissionGrantConditionSetId | Should -Be "665a9903-0398-48ab-b4e9-7a570d468b66"
        Should -Invoke -CommandName Update-MgPolicyPermissionGrantPolicyInclude -ModuleName Microsoft.Graph.Entra -Times 1
    }   
    It "Should contain parameters for condition set 'excludes'" {     
        Mock -CommandName Update-MgPolicyPermissionGrantPolicyExclude -MockWith {$args} -ModuleName Microsoft.Graph.Entra         
        $result = Set-EntraMSPermissionGrantConditionSet -PolicyId "policy1" -ConditionSetType "excludes" -Id "665a9903-0398-48ab-b4e9-7a570d468b66" -PermissionClassification "Low"
        $params = Get-Parameters -data $result
        $params.PermissionGrantPolicyId | Should -Be "policy1"
        $params.PermissionGrantConditionSetId | Should -Be "665a9903-0398-48ab-b4e9-7a570d468b66"
        Should -Invoke -CommandName Update-MgPolicyPermissionGrantPolicyExclude -ModuleName Microsoft.Graph.Entra -Times 1
    }    
    It "Should contain 'User-Agent' header" {
        Mock -CommandName Update-MgPolicyPermissionGrantPolicyInclude -MockWith {$args} -ModuleName Microsoft.Graph.Entra
        $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Set-EntraMSPermissionGrantConditionSet"
        $result = Set-EntraMSPermissionGrantConditionSet -PolicyId "policy1" -ConditionSetType "includes" -Id "665a9903-0398-48ab-b4e9-7a570d468b66"
        $params = Get-Parameters -data $result
        $params.Headers["User-Agent"] | Should -Be $userAgentHeaderValue
    }
}