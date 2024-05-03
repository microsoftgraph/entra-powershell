BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra) -eq $null){
        Import-Module Microsoft.Graph.Entra      
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force
    
    $scriptblock = {
        return @(
            [PSCustomObject]@{
              "Id"                           = "4eb50c8b-0572-46a9-a48d-a1d77e7f36b9"
              "AppDisplayName"               = $null
              "DataType"                     = "MockType"
              "DeletedDateTime"              = $null
              "IsMultiValued"                = $False
              "IsSyncedFromOnPremises"       = $False
              "Name"                         = "Mock-App"
              "TargetObjects"                = "Application"
              "AdditionalProperties"         = @{}
              "Parameters"                   = $args
            }
        )
    }

    Mock -CommandName Get-MgApplicationExtensionProperty -MockWith $scriptblock -ModuleName Microsoft.Graph.Entra
}

Describe "New-EntraMSApplicationExtensionProperty" {
Context "Test for New-EntraMSApplicationExtensionProperty" {
        It "Should return MS application extension property" {
            $result = Get-EntraMSApplicationExtensionProperty -ObjectId "9301311c-22b0-4835-9522-89ffacf6e502" 
            $result | Should -Not -BeNullOrEmpty
            $result.Id | Should -Be "4eb50c8b-0572-46a9-a48d-a1d77e7f36b9"
            $result.Name | Should -Be "Mock-App"
            $result.TargetObjects | Should -Be "Application"
            $result.DataType | Should -Be "MockType"


            Should -Invoke -CommandName Get-MgApplicationExtensionProperty  -ModuleName Microsoft.Graph.Entra -Times 1
        }
        It "Should fail when ObjectlId is empty" {
            { Get-EntraMSApplicationExtensionProperty -ObjectId   } | Should -Throw "Missing an argument for parameter 'ObjectId'*"
        }
        It "Should fail when ObjectlId is invalid" {
            {Get-EntraMSApplicationExtensionProperty -ObjectId ""} | Should -Throw "Cannot bind argument to parameter 'ObjectId' because it is an empty string."
        }
        It "Should contain ApplicationId in parameters when passed ObjectId to it" {              
            $result = Get-EntraMSApplicationExtensionProperty -ObjectId "9301311c-22b0-4835-9522-89ffacf6e502"
            $params = Get-Parameters -data $result.Parameters
            $params.ApplicationId | Should -Be "9301311c-22b0-4835-9522-89ffacf6e502"
        }
        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraMSApplicationExtensionProperty"

            $result = Get-EntraMSApplicationExtensionProperty -ObjectId "9301311c-22b0-4835-9522-89ffacf6e502"
            $params = Get-Parameters -data $result.Parameters
            $params.Headers["User-Agent"] | Should -Be $userAgentHeaderValue
        }


    }
}    