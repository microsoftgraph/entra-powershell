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
              "Id"                           = "aaaaaaaa-bbbb-cccc-1111-222222222222"
              "AppDisplayName"               = "Mock-App"
              "DataType"                     = "MockType"
              "DeletedDateTime"              = $null
              "IsMultiValued"                = $False
              "IsSyncedFromOnPremises"       = $False
              "Name"                         = "Mock-App"
              "TargetObjects"                = "Application"
              "AdditionalProperties"         = @{"@odata.context" = "https://graph.microsoft.com/v1.0/$metadata#applications('aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb')/extensionProperties/$entity"}
              "Parameters"                   = $args
            }
        )
    }

    Mock -CommandName New-MgApplicationExtensionProperty -MockWith $scriptblock -ModuleName Microsoft.Graph.Entra
}

Describe "New-EntraApplicationExtensionProperty" {
Context "Test for New-EntraApplicationExtensionProperty" {
        It "Should return created MS application extension property" {
            $result = New-EntraApplicationExtensionProperty -ObjectId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -DataType "MockType" -Name "Mock-App" -TargetObjects "Application"
            $result | Should -Not -BeNullOrEmpty
            $result.Id | Should -Be "aaaaaaaa-bbbb-cccc-1111-222222222222"
            $result.Name | Should -Be "Mock-App"
            $result.TargetObjects | Should -Be "Application"
            $result.DataType | Should -Be "MockType"


            Should -Invoke -CommandName New-MgApplicationExtensionProperty  -ModuleName Microsoft.Graph.Entra -Times 1
        }
        It "Should fail when ObjectlId is empty" {
            { New-EntraApplicationExtensionProperty -ObjectId  -DataType "MockType" -Name "Mock-App" -TargetObjects "Application"  } | Should -Throw "Missing an argument for parameter 'ObjectId'*"
        }
        It "Should fail when ObjectlId is invalid" {
            { New-EntraApplicationExtensionProperty -ObjectId "" -DataType "MockType" -Name "Mock-App" -TargetObjects "Application" } | Should -Throw "Cannot bind argument to parameter 'ObjectId' because it is an empty string."
        }
        It "Should fail when DataType is empty" {
            { New-EntraApplicationExtensionProperty -ObjectId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -DataType  -Name "Mock-App" -TargetObjects "Application"  } | Should -Throw "Missing an argument for parameter 'DataType'*"
        }
        It "Should fail when Name is empty" {
            { New-EntraApplicationExtensionProperty -ObjectId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -DataType "MockType" -Name  -TargetObjects "Application"  } | Should -Throw "Missing an argument for parameter 'Name'*"
        }
        It "Should fail when TargetObjects is empty" {
            { New-EntraApplicationExtensionProperty -ObjectId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -DataType "MockType" -Name "Mock-App" -TargetObjects   } | Should -Throw "Missing an argument for parameter 'TargetObjects'*"
        }
        It "Result should Contain ObjectId" {
            $result = New-EntraApplicationExtensionProperty -ObjectId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -DataType "MockType" -Name "Mock-App" -TargetObjects "Application"
            $result.ObjectId | should -Be "aaaaaaaa-bbbb-cccc-1111-222222222222"
        }
        It "Should contain ApplicationId in parameters when passed ObjectId to it" {              
            $result = New-EntraApplicationExtensionProperty -ObjectId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -DataType "MockType" -Name "Mock-App" -TargetObjects "Application"
            $params = Get-Parameters -data $result.Parameters
            $params.ApplicationId | Should -Be "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
        }
        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion New-EntraApplicationExtensionProperty"
            $result = New-EntraApplicationExtensionProperty -ObjectId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -DataType "MockType" -Name "Mock-App" -TargetObjects "Application"
            $result | Should -Not -BeNullOrEmpty
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion New-EntraApplicationExtensionProperty"
            Should -Invoke -CommandName New-MgApplicationExtensionProperty -ModuleName Microsoft.Graph.Entra -Times 1 -ParameterFilter {
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
                { New-EntraApplicationExtensionProperty -ObjectId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -DataType "MockType" -Name "Mock-App" -TargetObjects "Application" -Debug } | Should -Not -Throw
            } finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        }

    }
}    