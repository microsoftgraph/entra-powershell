BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra) -eq $null){
        Import-Module Microsoft.Graph.Entra      
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force
    
    $scriptblock = {
        return @(
            [PSCustomObject]@{
              "Id"                           = "1139c016-f606-45f0-83f7-40eb2a552a6f"
              "AdditionalProperties"         = @{
                                                    "@odata.type"            = "#microsoft.graph.user"
                                                    "@odata.Context"         = "https://graph.microsoft.com/v1.0/$metadata#directoryObjects/$entity"
                                                    "displayName"            = "Mock-App"
                                                    "jobTitle"               = "TestMock"
                                                    "mail"                   = "M365x99297270.onmicrosoft.com"
                                                    "mobilePhone"            = "9984534564"
                                                    "businessPhones"         = {"8976546787"}
                                                    "userPrincipalName"      = "M365x99297270.onmicrosoft.com"
                                                    "preferredLanguage"      = "EN"
                                                 }
              "Parameters"                   = $args
            }
        )
    }

    Mock -CommandName Restore-MgDirectoryDeletedItem -MockWith $scriptblock -ModuleName Microsoft.Graph.Entra
}
Describe "Restore-EntraMSDeletedDirectoryObject" {
Context "Restore-EntraMSDeletedDirectoryObject" {
        It "Should return specific MS deleted directory object" {
            $result = Restore-EntraMSDeletedDirectoryObject -Id "1139c016-f606-45f0-83f7-40eb2a552a6f"
            $result | Should -Not -BeNullOrEmpty
            $result.Id | Should -Be "1139c016-f606-45f0-83f7-40eb2a552a6f"

            Should -Invoke -CommandName Restore-MgDirectoryDeletedItem -ModuleName Microsoft.Graph.Entra -Times 1
        }
        It "Should fail when Id is empty" {
            { Restore-EntraMSDeletedDirectoryObject -Id  } | Should -Throw "Missing an argument for parameter 'Id'*"
        }
        It "Should fail when Id is invalid" {
            { Restore-EntraMSDeletedDirectoryObject -Id "" } | Should -Throw "Cannot bind argument to parameter 'Id' because it is an empty string."
        }
        It "Result should contain Alias properties" {
            $result = Restore-EntraMSDeletedDirectoryObject -Id "1139c016-f606-45f0-83f7-40eb2a552a6f" 
            $result.ObjectId | should -Be "1139c016-f606-45f0-83f7-40eb2a552a6f"
            $result.OdataType |  should -Be "#microsoft.graph.user"
        }
        It "Should contain DirectoryObjectId in parameters when passed Id to it" {              
            $result = Restore-EntraMSDeletedDirectoryObject -Id "1139c016-f606-45f0-83f7-40eb2a552a6f" 
            $params = Get-Parameters -data $result.Parameters
            $params.DirectoryObjectId | Should -Be "1139c016-f606-45f0-83f7-40eb2a552a6f"
        }
        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Restore-EntraMSDeletedDirectoryObject"

            $result = Restore-EntraMSDeletedDirectoryObject -Id "1139c016-f606-45f0-83f7-40eb2a552a6f"
            $params = Get-Parameters -data $result.Parameters
            $params.Headers["User-Agent"] | Should -Be $userAgentHeaderValue
        }

    }
}    