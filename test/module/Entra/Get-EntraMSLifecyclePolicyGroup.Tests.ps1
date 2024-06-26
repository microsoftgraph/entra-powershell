BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra) -eq $null){
        Import-Module Microsoft.Graph.Entra        
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force
    
    $scriptblock = {
        return @(
            [PSCustomObject]@{
                "AlternateNotificationEmails"   = "admingroup@contoso.com"
                "GroupLifetimeInDays"           = 200
                "Id"                            = "098e32e0-06e0-4ca2-b398-f521b6a7ddef"
                "ManagedGroupTypes"             = "All"
                "AdditionalProperties"          = @{}
                "Parameters"                    = $args
            }
        )
    }
    Mock -CommandName Get-MgGroupLifecyclePolicyByGroup -MockWith $scriptblock -ModuleName Microsoft.Graph.Entra
}
  
Describe "Get-EntraMSLifecyclePolicyGroup" {
    Context "Test for Get-EntraMSLifecyclePolicyGroup" {
        It "Retrieve lifecycle policy object" {
            $result = Get-EntraMSLifecyclePolicyGroup -Id "056b2531-005e-4f3e-be78-01a71ea30a04"
            $result | Should -Not -BeNullOrEmpty
            $result.ObjectId | should -Be '098e32e0-06e0-4ca2-b398-f521b6a7ddef'
            $result.GroupLifetimeInDays | Should -Be 200
            $result.AlternateNotificationEmails | Should -Be "admingroup@contoso.com"
            $result.Id | Should -Be "098e32e0-06e0-4ca2-b398-f521b6a7ddef"
            $result.ManagedGroupTypes | Should -Be "All"

            Should -Invoke -CommandName Get-MgGroupLifecyclePolicyByGroup -ModuleName Microsoft.Graph.Entra -Times 1
        }

        It "Should fail when Id is empty" {
            { Get-EntraMSLifecyclePolicyGroup -Id } | Should -Throw "Missing an argument for parameter 'Id'*"
        }

        It "Should fail when Id is invalid" {
            { Get-EntraMSLifecyclePolicyGroup -Id "" } | Should -Throw "Cannot bind argument to parameter 'Id' because it is an empty string."
        }

        It "Should contain GroupId in parameters when passed Id to it" {
            $result = Get-EntraMSLifecyclePolicyGroup -Id "098e32e0-06e0-4ca2-b398-f521b6a7ddef"
            $params = Get-Parameters -data $result.Parameters
            $params.GroupId | Should -Be "098e32e0-06e0-4ca2-b398-f521b6a7ddef"
        }

        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraMSLifecyclePolicyGroup"

            $result = Get-EntraMSLifecyclePolicyGroup -Id "056b2531-005e-4f3e-be78-01a71ea30a04"
            $params = Get-Parameters -data $result.Parameters
            $params.Headers["User-Agent"] | Should -Be $userAgentHeaderValue
        }    
    }
}