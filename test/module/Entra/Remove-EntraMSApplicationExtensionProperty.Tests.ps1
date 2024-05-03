BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra) -eq $null){
        #Import-Module .\bin\Microsoft.Graph.Entra.psm1 -Force
        Import-Module Microsoft.Graph.Entra
    }
    Import-Module .\test\module\Common-Functions.ps1 -Force

    Mock -CommandName Remove-MgApplicationExtensionProperty -MockWith {} -ModuleName Microsoft.Graph.Entra
}

Describe "Remove-EntraMSApplicationExtensionProperty" {
    Context "Test for Remove-EntraMSApplicationExtensionProperty" {
        It "Should return empty object" {
            $result = Remove-EntraMSApplicationExtensionProperty -ObjectId "9301311c-22b0-4835-9522-89ffacf6e502" -ExtensionPropertyId "4eb50c8b-0572-46a9-a48d-a1d77e7f36b9"
            $result | Should -BeNullOrEmpty

            Should -Invoke -CommandName Remove-MgApplicationExtensionProperty -ModuleName Microsoft.Graph.Entra -Times 1
        }
        It "Should fail when ObjectId is empty" {
            { Remove-EntraMSApplicationExtensionProperty -ObjectId  -ExtensionPropertyId "4eb50c8b-0572-46a9-a48d-a1d77e7f36b9"} | Should -Throw "Missing an argument for parameter 'ObjectId'*"
        }  
        It "Should fail when ObjectId is invalid" {
            { Remove-EntraMSApplicationExtensionProperty -ObjectId "" -ExtensionPropertyId "4eb50c8b-0572-46a9-a48d-a1d77e7f36b9" } | Should -Throw "Cannot bind argument to parameter 'ObjectId' because it is an empty string."
        } 
        It "Should fail when ExtensionPropertyId is empty" {
            { Remove-EntraMSApplicationExtensionProperty -ObjectId "9301311c-22b0-4835-9522-89ffacf6e502" -ExtensionPropertyId  } | Should -Throw "Missing an argument for parameter 'ExtensionPropertyId'*"
        }  
        It "Should fail when ExtensionPropertyId is invalid" {
            { Remove-EntraMSApplicationExtensionProperty -ObjectId "9301311c-22b0-4835-9522-89ffacf6e502" -ExtensionPropertyId "" } | Should -Throw "Cannot bind argument to parameter 'ExtensionPropertyId' because it is an empty string."
        }
        It "Should contain ApplicationId in parameters when passed ObjectId to it" { 
            Mock -CommandName Remove-MgApplicationExtensionProperty -MockWith {$args} -ModuleName Microsoft.Graph.Entra

            $result = Remove-EntraMSApplicationExtensionProperty -ObjectId "9301311c-22b0-4835-9522-89ffacf6e502" -ExtensionPropertyId "4eb50c8b-0572-46a9-a48d-a1d77e7f36b9"
            $params = Get-Parameters -data $result
            $params.ApplicationId | Should -Be "9301311c-22b0-4835-9522-89ffacf6e502"
        }
        It "Should contain 'User-Agent' header" {
            Mock -CommandName Remove-MgApplicationExtensionProperty -MockWith {$args} -ModuleName Microsoft.Graph.Entra
            
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Remove-EntraMSApplicationExtensionProperty"

            $result = Remove-EntraMSApplicationExtensionProperty -ObjectId "9301311c-22b0-4835-9522-89ffacf6e502" -ExtensionPropertyId "4eb50c8b-0572-46a9-a48d-a1d77e7f36b9"
            $params = Get-Parameters -data $result
            $params.Headers["User-Agent"] | Should -Be $userAgentHeaderValue
        } 
    }
}