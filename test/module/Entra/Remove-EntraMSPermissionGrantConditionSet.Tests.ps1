BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra) -eq $null){
        Import-Module Microsoft.Graph.Entra        
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force

    Mock -CommandName Remove-MgPolicyPermissionGrantPolicyInclude -MockWith {} -ModuleName Microsoft.Graph.Entra

    Mock -CommandName Remove-MgPolicyPermissionGrantPolicyExclude -MockWith {} -ModuleName Microsoft.Graph.Entra
}

Describe "Remove-EntraMSPermissionGrantConditionSet"{
    Context "Test for Remove-EntraMSPermissionGrantConditionSet" {
        It "Should delete a permission grant condition set 'includes' from a policy"{
            $result = Remove-EntraMSPermissionGrantConditionSet -PolicyId "test1" -ConditionSetType "includes" -Id "665a9903-0398-48ab-b4e9-7a570d468b66"
            $result | Should -BeNullOrEmpty
            
            Should -Invoke -CommandName Remove-MgPolicyPermissionGrantPolicyInclude -ModuleName Microsoft.Graph.Entra -Times 1
        }

        It "Should delete a permission grant condition set 'excludes' from a policy"{
            $result = Remove-EntraMSPermissionGrantConditionSet -PolicyId "test1" -ConditionSetType "excludes" -Id "665a9903-0398-48ab-b4e9-7a570d468b66"
            $result | Should -BeNullOrEmpty

            Should -Invoke -CommandName Remove-MgPolicyPermissionGrantPolicyExclude -ModuleName Microsoft.Graph.Entra -Times 1
        }

        It "Should fail when PolicyId parameter are invalid when ConditionSetType is includes" {
            { Remove-EntraMSPermissionGrantConditionSet -PolicyId "" -ConditionSetType "includes" -Id "665a9903-0398-48ab-b4e9-7a570d468b66"} | Should -Throw "Cannot bind argument to parameter 'PolicyId' because it is an empty string.*"
        }

        It "Should fail when PolicyId parameter are empty when ConditionSetType is includes" {
            { Remove-EntraMSPermissionGrantConditionSet -PolicyId  -ConditionSetType "includes" -Id "665a9903-0398-48ab-b4e9-7a570d468b66" } | Should -Throw "Missing an argument for parameter*"
        }

        It "Should fail when PolicyId parameter are invalid when ConditionSetType is excludes" {
            { Remove-EntraMSPermissionGrantConditionSet -PolicyId "" -ConditionSetType "excludes" -Id "665a9903-0398-48ab-b4e9-7a570d468b66"} | Should -Throw "Cannot bind argument to parameter*"
        }

        It "Should fail when PolicyId parameter are empty when ConditionSetType is excludes" {
            { Remove-EntraMSPermissionGrantConditionSet -PolicyId  -ConditionSetType "excludes" -Id "665a9903-0398-48ab-b4e9-7a570d468b66" } | Should -Throw "Missing an argument for parameter*"
        }

        It "Should fail when Id parameter are empty when ConditionSetType is includes" {
            { Remove-EntraMSPermissionGrantConditionSet -PolicyId "test1" -ConditionSetType "includes" -Id } | Should -Throw "Missing an argument for parameter*"
        }

        It "Should fail when Id parameter are invalid when ConditionSetType is includes" {
            { Remove-EntraMSPermissionGrantConditionSet -PolicyId "test1" -ConditionSetType "includes" -Id "" } | Should -Throw "Cannot bind argument to parameter 'Id' because it is an empty string."
        }

        It "Should fail when Id parameter are invalid when ConditionSetType is excludes" {
            { Remove-EntraMSPermissionGrantConditionSet -PolicyId "test1" -ConditionSetType "excludes" -Id ""} | Should -Throw "Cannot bind argument to parameter 'Id' because it is an empty string.*"
        }

        It "Should fail when Id parameter are empty when ConditionSetType is excludes" {
            { Remove-EntraMSPermissionGrantConditionSet -PolicyId "test1" -ConditionSetType "excludes" -Id  } | Should -Throw "Missing an argument for parameter*"
        }

        It "Should fail when ConditionSetType parameter are empty" {
            { Remove-EntraMSPermissionGrantConditionSet -PolicyId "test1" -Id "665a9903-0398-48ab-b4e9-7a570d468b66" -ConditionSetType } | Should -Throw "Missing an argument for parameter*"
        }

        It "Should fail when ConditionSetType parameter are invalid" {
            { Remove-EntraMSPermissionGrantConditionSet -PolicyId "test1" -Id "665a9903-0398-48ab-b4e9-7a570d468b66" -ConditionSetType "" } | Should -Throw "Cannot bind argument to parameter 'ConditionSetType' because it is an empty string."
        }

        It "Should contain PermissionGrantPolicyId in parameters when passed PolicyId to it" {   
            Mock -CommandName Remove-MgPolicyPermissionGrantPolicyInclude -MockWith {$args} -ModuleName Microsoft.Graph.Entra

            $result = Remove-EntraMSPermissionGrantConditionSet -PolicyId "test1" -ConditionSetType "includes" -Id "665a9903-0398-48ab-b4e9-7a570d468b66"
            $params = Get-Parameters -data $result
            $params.PermissionGrantPolicyId | Should -Be "test1"
        }

        It "Should contain PermissionGrantConditionSetId in parameters when passed Id to it" {   
            Mock -CommandName Remove-MgPolicyPermissionGrantPolicyInclude -MockWith {$args} -ModuleName Microsoft.Graph.Entra

            $result = Remove-EntraMSPermissionGrantConditionSet -PolicyId "test1" -ConditionSetType "includes" -Id "665a9903-0398-48ab-b4e9-7a570d468b66"
            $params = Get-Parameters -data $result
            $params.PermissionGrantConditionSetId | Should -Be "665a9903-0398-48ab-b4e9-7a570d468b66"
        }

        It "Should contain 'User-Agent' header" {
            Mock -CommandName Remove-MgPolicyPermissionGrantPolicyInclude -MockWith {$args} -ModuleName Microsoft.Graph.Entra

            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Remove-EntraMSPermissionGrantConditionSet"
            $result = Remove-EntraMSPermissionGrantConditionSet -PolicyId "test1" -ConditionSetType "includes" -Id "665a9903-0398-48ab-b4e9-7a570d468b66"
            $params = Get-Parameters -data $result
            $params.Headers["User-Agent"] | Should -Be $userAgentHeaderValue
        }
    }
}