BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra) -eq $null){
        Import-Module Microsoft.Graph.Entra      
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force

    Mock -CommandName Update-MgPolicyPermissionGrantPolicyInclude -MockWith {} -ModuleName Microsoft.Graph.Entra

    Mock -CommandName Update-MgPolicyPermissionGrantPolicyExclude -MockWith {} -ModuleName Microsoft.Graph.Entra
}
Describe "Set-EntraPermissionGrantConditionSet"{
    It "Should return empty object for condition set 'includes'"{
        $result = Set-EntraPermissionGrantConditionSet -PolicyId "policy1" -ConditionSetType "includes" -Id "00aa00aa-bb11-cc22-dd33-44ee44ee44ee" -PermissionClassification "Low"
        $result | Should -BeNullOrEmpty
        Should -Invoke -CommandName Update-MgPolicyPermissionGrantPolicyInclude -ModuleName Microsoft.Graph.Entra -Times 1
    }
    It "Should return empty object for condition set 'excludes'"{
        $result = Set-EntraPermissionGrantConditionSet -PolicyId "policy1" -ConditionSetType "excludes" -Id "00aa00aa-bb11-cc22-dd33-44ee44ee44ee" -PermissionClassification "Low"
        $result | Should -BeNullOrEmpty
        Should -Invoke -CommandName Update-MgPolicyPermissionGrantPolicyExclude -ModuleName Microsoft.Graph.Entra -Times 1
    }
    It "Should fail when parameters are empty" {
        { Set-EntraPermissionGrantConditionSet -PolicyId "" -ConditionSetType "" -Id ""} | Should -Throw "Cannot bind argument to parameter*"
    }
    It "Should fail when parameters are null" {
        { Set-EntraPermissionGrantConditionSet -PolicyId  -ConditionSetType  -Id } | Should -Throw "Missing an argument for parameter*"
    }
    It "Should contain parameters for condition set 'includes'" {   
        Mock -CommandName Update-MgPolicyPermissionGrantPolicyInclude -MockWith {$args} -ModuleName Microsoft.Graph.Entra           
        $result = Set-EntraPermissionGrantConditionSet -PolicyId "policy1" -ConditionSetType "includes" -Id "00aa00aa-bb11-cc22-dd33-44ee44ee44ee" -PermissionClassification "Low"
        $params = Get-Parameters -data $result
        $params.PermissionGrantPolicyId | Should -Be "policy1"
        $params.PermissionGrantConditionSetId | Should -Be "00aa00aa-bb11-cc22-dd33-44ee44ee44ee"
        Should -Invoke -CommandName Update-MgPolicyPermissionGrantPolicyInclude -ModuleName Microsoft.Graph.Entra -Times 1
    }   
    It "Should contain parameters for condition set 'excludes'" {     
        Mock -CommandName Update-MgPolicyPermissionGrantPolicyExclude -MockWith {$args} -ModuleName Microsoft.Graph.Entra         
        $result = Set-EntraPermissionGrantConditionSet -PolicyId "policy1" -ConditionSetType "excludes" -Id "00aa00aa-bb11-cc22-dd33-44ee44ee44ee" -PermissionClassification "Low"
        $params = Get-Parameters -data $result
        $params.PermissionGrantPolicyId | Should -Be "policy1"
        $params.PermissionGrantConditionSetId | Should -Be "00aa00aa-bb11-cc22-dd33-44ee44ee44ee"
        Should -Invoke -CommandName Update-MgPolicyPermissionGrantPolicyExclude -ModuleName Microsoft.Graph.Entra -Times 1
    }    
    It "Should contain 'User-Agent' header" {
        $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Set-EntraPermissionGrantConditionSet"
        $result =  Set-EntraPermissionGrantConditionSet -PolicyId "policy1" -ConditionSetType "excludes" -Id "00aa00aa-bb11-cc22-dd33-44ee44ee44ee" -PermissionClassification "Low"
        $result | Should  -BeNullOrEmpty
        $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Set-EntraPermissionGrantConditionSet"
        Should -Invoke -CommandName Update-MgPolicyPermissionGrantPolicyExclude -ModuleName Microsoft.Graph.Entra -Times 1 -ParameterFilter {
            $Headers.'User-Agent' | Should -Be $userAgentHeaderValue
            $true
        }
    } 
    It "Should execute successfully without throwing an error " {
        # Disable confirmation prompts       
        $originalDebugPreference = $DebugPreference
        $DebugPreference = 'Continue'

        try {
            # Act & Assert: Ensure the function doesn't throw an exception
            { Set-EntraPermissionGrantConditionSet -PolicyId "policy1" -ConditionSetType "excludes" -Id "00aa00aa-bb11-cc22-dd33-44ee44ee44ee" -PermissionClassification "Low" -Debug } | Should -Not -Throw
        } finally {
            # Restore original confirmation preference            
            $DebugPreference = $originalDebugPreference        
        }
    }
}