# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra) -eq $null){
        Import-Module Microsoft.Graph.Entra      
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force
    
    $scriptblock = {
        return @(
            [PSCustomObject]@{
              "Id"                           = "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
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
Describe "Restore-EntraDeletedDirectoryObject" {
Context "Restore-EntraDeletedDirectoryObject" {
        It "Should return specific MS deleted directory object" {
            $result = Restore-EntraDeletedDirectoryObject -Id "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
            $result | Should -Not -BeNullOrEmpty
            $result.Id | Should -Be "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"

            Should -Invoke -CommandName Restore-MgDirectoryDeletedItem -ModuleName Microsoft.Graph.Entra -Times 1
        }
        It "Should fail when Id is empty" {
            { Restore-EntraDeletedDirectoryObject -Id  } | Should -Throw "Missing an argument for parameter 'Id'*"
        }
        It "Should fail when Id is invalid" {
            { Restore-EntraDeletedDirectoryObject -Id "" } | Should -Throw "Cannot bind argument to parameter 'Id' because it is an empty string."
        }
        It "Result should contain Alias properties" {
            $result = Restore-EntraDeletedDirectoryObject -Id "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" 
            $result.ObjectId | should -Be "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
            $result.OdataType |  should -Be "#microsoft.graph.user"
        }
        It "Should contain DirectoryObjectId in parameters when passed Id to it" {              
            $result = Restore-EntraDeletedDirectoryObject -Id "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" 
            $params = Get-Parameters -data $result.Parameters
            $params.DirectoryObjectId | Should -Be "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
        }
        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Restore-EntraDeletedDirectoryObject"
            $result = Restore-EntraDeletedDirectoryObject -Id "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" 
            $result | Should -Not -BeNullOrEmpty
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Restore-EntraDeletedDirectoryObject"
    
            Should -Invoke -CommandName Restore-MgDirectoryDeletedItem -ModuleName Microsoft.Graph.Entra -Times 1 -ParameterFilter {
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
                { Restore-EntraDeletedDirectoryObject -Id "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -Debug } | Should -Not -Throw
            } finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        }
    }
}    