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

Describe "Get-EntraApplicationExtensionProperty" {
Context "Test for Get-EntraApplicationExtensionProperty" {
        It "Should return application extension property" {
            $result = Get-EntraApplicationExtensionProperty -ObjectId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" 
            $result | Should -Not -BeNullOrEmpty
            $result.Id | Should -Be "aaaaaaaa-bbbb-cccc-1111-222222222222"
            $result.Name | Should -Be "Mock-App"
            $result.TargetObjects | Should -Be "Application"
            $result.DataType | Should -Be "MockType"


            Should -Invoke -CommandName Get-MgApplicationExtensionProperty  -ModuleName Microsoft.Graph.Entra -Times 1
        }
        It "Should fail when ObjectlId is empty" {
            { Get-EntraApplicationExtensionProperty -ObjectId   } | Should -Throw "Missing an argument for parameter 'ObjectId'*"
        }
        It "Should fail when ObjectlId is invalid" {
            {Get-EntraApplicationExtensionProperty -ObjectId ""} | Should -Throw "Cannot bind argument to parameter 'ObjectId' because it is an empty string."
        }
        It "Property parameter should work" {
            $result = Get-EntraApplicationExtensionProperty -ObjectId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -Property Name
            $result | Should -Not -BeNullOrEmpty
            $result.Name | Should -Be 'Mock-App'

            Should -Invoke -CommandName Get-MgApplicationExtensionProperty -ModuleName Microsoft.Graph.Entra -Times 1
        }
        It "Should fail when Property is empty" {
             { Get-EntraApplicationExtensionProperty -ObjectId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -Property } | Should -Throw "Missing an argument for parameter 'Property'*"
        }
        It "Should contain ApplicationId in parameters when passed ObjectId to it" {              
            $result = Get-EntraApplicationExtensionProperty -ObjectId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
            $params = Get-Parameters -data $result.Parameters
            $params.ApplicationId | Should -Be "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
        }
        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraApplicationExtensionProperty"

            $result = Get-EntraApplicationExtensionProperty -ObjectId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
            $params = Get-Parameters -data $result.Parameters
            $params.Headers["User-Agent"] | Should -Be $userAgentHeaderValue
        }
        It "Should execute successfully without throwing an error " {
            # Disable confirmation prompts       
            $originalDebugPreference = $DebugPreference
            $DebugPreference = 'Continue'

            try {
                # Act & Assert: Ensure the function doesn't throw an exception
                { Get-EntraApplicationExtensionProperty -ObjectId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -Debug } | Should -Not -Throw
            } finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        }

    }
}    