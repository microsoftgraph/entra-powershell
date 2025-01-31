# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra) -eq $null){
        
        Import-Module Microsoft.Graph.Entra      
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force
    $scriptblock = {
        return @{
            value = @(
                @{
                    "Id"                               = "00aa00aa-bb11-cc22-dd33-44ee44ee44ee" 
                    "OnPremisesSyncEnabled"            = $null
                    "userPrincipalName"                = "Adams@M365x99297270.OnMicrosoft.com"
                    "accountEnabled"                   = $true
                    "usageLocation"                    = "DE"
                    "displayName"                      = "Mock-App"
                    "userType"                         = "User"
                    "OnPremisesLastSyncDateTime"       = $null
                    "onPremisesProvisioningErrors"     = @{}
                    "Parameters"                       = $args
                }
            )
        }
    }
    
    Mock -CommandName Invoke-GraphRequest -MockWith $scriptblock -ModuleName Microsoft.Graph.Entra

}


Describe "Get-EntraObjectByObjectId" {
    Context "Test for Get-EntraObjectByObjectId" {
        It "Should return specific object by objectId" {
            $result = Get-EntraObjectByObjectId -ObjectId '00aa00aa-bb11-cc22-dd33-44ee44ee44ee'
            $result | Should -Not -BeNullOrEmpty
            $result.Id | should -Be '00aa00aa-bb11-cc22-dd33-44ee44ee44ee'
            $result.displayName | should -Be 'Mock-App'
             $result.userType | should -Be 'User'

            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Graph.Entra -Times 1
        }
        It "Should fail when ObjectId is empty" {
            { Get-EntraObjectByObjectId -ObjectId } | Should -Throw "Missing an argument for parameter 'ObjectIds'*"
        }
        It "Should fail when ObjectId is invalid" {
            { Get-EntraObjectByObjectId -ObjectId "" } | Should -Throw "Cannot bind argument to parameter 'ObjectIds' because it is an empty string*"
        }
        It "Should return specific object by objectId and Types" {
            $result = Get-EntraObjectByObjectId -ObjectId "00aa00aa-bb11-cc22-dd33-44ee44ee44ee" -Types "User"
            $result | Should -Not -BeNullOrEmpty
            $result.userType | should -Be 'User'

            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Graph.Entra -Times 1
        }
        It "Should fail when ObjectId is empty" {
            { Get-EntraObjectByObjectId -ObjectId "00aa00aa-bb11-cc22-dd33-44ee44ee44ee" -Types } | Should -Throw "Missing an argument for parameter 'Types'*"
        }
        It "Should contain Ids in parameters when passed Id to it" {              
            $result = Get-EntraObjectByObjectId -ObjectId "00aa00aa-bb11-cc22-dd33-44ee44ee44ee"
            $params = Get-Parameters -data $result.Parameters
            $para= $params | ConvertTo-json | ConvertFrom-Json
            $para.Body.Ids | Should -Be "00aa00aa-bb11-cc22-dd33-44ee44ee44ee"
        }
        It "Property parameter should work" {
            $result =  Get-EntraObjectByObjectId -ObjectId "00aa00aa-bb11-cc22-dd33-44ee44ee44ee" -Property displayName 
            $result | Should -Not -BeNullOrEmpty
            $result.displayName | Should -Be "Mock-App"

            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Graph.Entra -Times 1
        }

        It "Should fail when Property is empty" {
             { Get-EntraObjectByObjectId -ObjectId "00aa00aa-bb11-cc22-dd33-44ee44ee44ee" -Property } | Should -Throw "Missing an argument for parameter 'Property'*"
        }
        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraObjectByObjectId"

            $result = Get-EntraObjectByObjectId -ObjectId "00aa00aa-bb11-cc22-dd33-44ee44ee44ee"
            $result | Should -Not -BeNullOrEmpty

            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraObjectByObjectId"

            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Graph.Entra -Times 1 -ParameterFilter {
                $Headers.'User-Agent' | Should -Be $userAgentHeaderValue
                $true
            }
        }
        It "Should execute successfully without throwing an error" {
            # Disable confirmation prompts       
            $originalDebugPreference = $DebugPreference
            $DebugPreference = 'Continue'

            try {
                # Act & Assert: Ensure the function doesn't throw an exception
                { Get-EntraObjectByObjectId -ObjectId "00aa00aa-bb11-cc22-dd33-44ee44ee44ee" -Debug } | Should -Not -Throw
            } finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        }

    }

}    