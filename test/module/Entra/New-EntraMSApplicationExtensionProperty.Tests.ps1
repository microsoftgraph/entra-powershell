BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra) -eq $null){
        Import-Module Microsoft.Graph.Entra      
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force
    
    $scriptblock = {
        return @(
            [PSCustomObject]@{
              "Id"                           = "4eb50c8b-0572-46a9-a48d-a1d77e7f36b9"
              "AppDisplayName"               = "Mock-App"
              "DataType"                     = "MockType"
              "DeletedDateTime"              = $null
              "IsMultiValued"                = $False
              "IsSyncedFromOnPremises"       = $False
              "Name"                         = "Mock-App"
              "TargetObjects"                = "Application"
              "AdditionalProperties"         = @{"@odata.context" = "https://graph.microsoft.com/v1.0/$metadata#applications('9301311c-22b0-4835-9522-89ffacf6e502')/extensionProperties/$entity"}
              "Parameters"                   = $args
            }
        )
    }

    Mock -CommandName New-MgApplicationExtensionProperty -MockWith $scriptblock -ModuleName Microsoft.Graph.Entra
}

Describe "New-EntraMSApplicationExtensionProperty" {
Context "Test for New-EntraMSApplicationExtensionProperty" {
        It "Should return created MS application extension property" {
            $result = New-EntraMSApplicationExtensionProperty -ObjectId "9301311c-22b0-4835-9522-89ffacf6e502" -DataType "MockType" -Name "Mock-App" -TargetObjects "Application"
            $result | Should -Not -BeNullOrEmpty
            $result.Id | Should -Be "4eb50c8b-0572-46a9-a48d-a1d77e7f36b9"
            $result.Name | Should -Be "Mock-App"
            $result.TargetObjects | Should -Be "Application"
            $result.DataType | Should -Be "MockType"


            Should -Invoke -CommandName New-MgApplicationExtensionProperty  -ModuleName Microsoft.Graph.Entra -Times 1
        }
        It "Should fail when ObjectlId is empty" {
            { New-EntraMSApplicationExtensionProperty -ObjectId  -DataType "MockType" -Name "Mock-App" -TargetObjects "Application"  } | Should -Throw "Missing an argument for parameter 'ObjectId'*"
        }
        It "Should fail when ObjectlId is invalid" {
            { New-EntraMSApplicationExtensionProperty -ObjectId "" -DataType "MockType" -Name "Mock-App" -TargetObjects "Application" } | Should -Throw "Cannot bind argument to parameter 'ObjectId' because it is an empty string."
        }
        It "Should fail when DataType is empty" {
            { New-EntraMSApplicationExtensionProperty -ObjectId "9301311c-22b0-4835-9522-89ffacf6e502" -DataType  -Name "Mock-App" -TargetObjects "Application"  } | Should -Throw "Missing an argument for parameter 'DataType'*"
        }
        It "Should fail when Name is empty" {
            { New-EntraMSApplicationExtensionProperty -ObjectId "9301311c-22b0-4835-9522-89ffacf6e502" -DataType "MockType" -Name  -TargetObjects "Application"  } | Should -Throw "Missing an argument for parameter 'Name'*"
        }
        It "Should fail when TargetObjects is empty" {
            { New-EntraMSApplicationExtensionProperty -ObjectId "9301311c-22b0-4835-9522-89ffacf6e502" -DataType "MockType" -Name "Mock-App" -TargetObjects   } | Should -Throw "Missing an argument for parameter 'TargetObjects'*"
        }
        It "Result should Contain ObjectId" {
            $result = New-EntraMSApplicationExtensionProperty -ObjectId "9301311c-22b0-4835-9522-89ffacf6e502" -DataType "MockType" -Name "Mock-App" -TargetObjects "Application"
            $result.ObjectId | should -Be "4eb50c8b-0572-46a9-a48d-a1d77e7f36b9"
        }
        It "Should contain ApplicationId in parameters when passed ObjectId to it" {              
            $result = New-EntraMSApplicationExtensionProperty -ObjectId "9301311c-22b0-4835-9522-89ffacf6e502" -DataType "MockType" -Name "Mock-App" -TargetObjects "Application"
            $params = Get-Parameters -data $result.Parameters
            $params.ApplicationId | Should -Be "9301311c-22b0-4835-9522-89ffacf6e502"
        }
        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion New-EntraMSApplicationExtensionProperty"

            $result = New-EntraMSApplicationExtensionProperty -ObjectId "9301311c-22b0-4835-9522-89ffacf6e502" -DataType "MockType" -Name "Mock-App" -TargetObjects "Application"
            $params = Get-Parameters -data $result.Parameters
            $params.Headers["User-Agent"] | Should -Be $userAgentHeaderValue
        }


    }
}    