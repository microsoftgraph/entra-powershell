# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
BeforeAll {  
    if ((Get-Module -Name Microsoft.Entra.Applications) -eq $null) {
        Import-Module Microsoft.Entra.Applications      
    }
    Import-Module (Join-Path $PSScriptRoot "..\..\Common-Functions.ps1") -Force
    
    $scriptblock = {
        return @(
            [PSCustomObject]@{
                "Id"                     = "aaaaaaaa-bbbb-cccc-1111-222222222222"
                "AppDisplayName"         = "Mock-App"
                "DataType"               = "MockType"
                "DeletedDateTime"        = $null
                "IsMultiValued"          = $False
                "IsSyncedFromOnPremises" = $False
                "Name"                   = "Mock-App"
                "TargetObjects"          = "Application"
                "AdditionalProperties"   = @{"@odata.context" = "https://graph.microsoft.com/v1.0/`$metadata#applications('aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb')/extensionProperties/`$entity" }
                "Parameters"             = $args
            }
        )
    }

    Mock -CommandName New-MgApplicationExtensionProperty -MockWith $scriptblock -ModuleName Microsoft.Entra.Applications
    Mock -CommandName Get-EntraContext -MockWith { @{Scopes = @("Application.ReadWrite.All") } } -ModuleName Microsoft.Entra.Applications
}

Describe "New-EntraApplicationExtensionProperty" {
    Context "Test for New-EntraApplicationExtensionProperty" {
        It "Should return created MS application extension property" {
            $result = New-EntraApplicationExtensionProperty -ApplicationId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -DataType "MockType" -Name "Mock-App" -TargetObjects "Application"
            $result | Should -Not -BeNullOrEmpty
            $result.Id | Should -Be "aaaaaaaa-bbbb-cccc-1111-222222222222"
            $result.Name | Should -Be "Mock-App"
            $result.TargetObjects | Should -Be "Application"
            $result.DataType | Should -Be "MockType"

            Should -Invoke -CommandName New-MgApplicationExtensionProperty -ModuleName Microsoft.Entra.Applications -Times 1
        }
        It "Should return created MS application extension property with alias" {
            $result = New-EntraApplicationExtensionProperty -ObjectId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -DataType "MockType" -Name "Mock-App" -TargetObjects "Application"
            $result | Should -Not -BeNullOrEmpty
            $result.Id | Should -Be "aaaaaaaa-bbbb-cccc-1111-222222222222"
            $result.Name | Should -Be "Mock-App"
            $result.TargetObjects | Should -Be "Application"
            $result.DataType | Should -Be "MockType"

            Should -Invoke -CommandName New-MgApplicationExtensionProperty -ModuleName Microsoft.Entra.Applications -Times 1
        }
        It "Should fail when ApplicationId is empty" {
            { New-EntraApplicationExtensionProperty -ApplicationId -DataType "MockType" -Name "Mock-App" -TargetObjects "Application" } | Should -Throw "Missing an argument for parameter 'ApplicationId'*"
        }
        It "Should fail when ApplicationId is invalid" {
            { New-EntraApplicationExtensionProperty -ApplicationId "" -DataType "MockType" -Name "Mock-App" -TargetObjects "Application" } | Should -Throw "Cannot validate argument on parameter 'ApplicationId'. The argument is null or empty. Provide an argument that is not null or empty, and then try the command again."
        }
        It "Should fail when DataType is empty" {
            { New-EntraApplicationExtensionProperty -ApplicationId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -DataType -Name "Mock-App" -TargetObjects "Application" } | Should -Throw "Missing an argument for parameter 'DataType'*"
        }
        It "Should fail when Name is empty" {
            { New-EntraApplicationExtensionProperty -ApplicationId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -DataType "MockType" -Name -TargetObjects "Application" } | Should -Throw "Missing an argument for parameter 'Name'*"
        }
        It "Should fail when TargetObjects is empty" {
            { New-EntraApplicationExtensionProperty -ApplicationId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -DataType "MockType" -Name "Mock-App" -TargetObjects } | Should -Throw "Missing an argument for parameter 'TargetObjects'*"
        }
        It "Result should Contain ObjectId" {
            $result = New-EntraApplicationExtensionProperty -ApplicationId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -DataType "MockType" -Name "Mock-App" -TargetObjects "Application"
            $result.ObjectId | should -Be "aaaaaaaa-bbbb-cccc-1111-222222222222"
        }
        It "Should contain ApplicationId in parameters when passed ApplicationId to it" {              
            $result = New-EntraApplicationExtensionProperty -ApplicationId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -DataType "MockType" -Name "Mock-App" -TargetObjects "Application"
            $params = Get-Parameters -data $result.Parameters
            $params.ApplicationId | Should -Be "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
        }
        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion New-EntraApplicationExtensionProperty"
            $result = New-EntraApplicationExtensionProperty -ApplicationId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -DataType "MockType" -Name "Mock-App" -TargetObjects "Application"
            $result | Should -Not -BeNullOrEmpty
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion New-EntraApplicationExtensionProperty"
            Should -Invoke -CommandName New-MgApplicationExtensionProperty -ModuleName Microsoft.Entra.Applications -Times 1 -ParameterFilter {
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
                { New-EntraApplicationExtensionProperty -ApplicationId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -DataType "MockType" -Name "Mock-App" -TargetObjects "Application" -Debug } | Should -Not -Throw
            }
            finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        }

    }
}    

