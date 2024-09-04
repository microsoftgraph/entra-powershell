# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra) -eq $null){
        Import-Module Microsoft.Graph.Entra        
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force

    Mock -CommandName New-MgServicePrincipalOwnerByRef -MockWith {} -ModuleName Microsoft.Graph.Entra
}

Describe "Add-EntraServicePrincipalOwner" {
    Context "Test for Add-EntraServicePrincipalOwner" {
        It "Should return empty object" {
            $result = Add-EntraServicePrincipalOwner -ObjectId "aaaaaaaa-0b0b-1c1c-2d2d-333333333333" -RefObjectId "bbbbbbbb-1111-2222-3333-cccccccccccc"
            $result | Should -BeNullOrEmpty

            Should -Invoke -CommandName New-MgServicePrincipalOwnerByRef -ModuleName Microsoft.Graph.Entra -Times 1
        }
        It "Should fail when ObjectId is empty" {
            { Add-EntraServicePrincipalOwner -ObjectId  -RefObjectId "bbbbbbbb-1111-2222-3333-cccccccccccc"  } | Should -Throw "Missing an argument for parameter 'ObjectId'.*"
        }
        It "Should fail when ObjectId is invalid" {
            { Add-EntraServicePrincipalOwner -ObjectId "" -RefObjectId "bbbbbbbb-1111-2222-3333-cccccccccccc"   } | Should -Throw "Cannot bind argument to parameter 'ObjectId' because it is an empty string."
        }
        It "Should fail when RefObjectId is empty" {
            { Add-EntraServicePrincipalOwner -ObjectId "aaaaaaaa-0b0b-1c1c-2d2d-333333333333" -RefObjectId   } | Should -Throw "Missing an argument for parameter 'RefObjectId'.*"
        }
        It "Should fail when RefObjectId is invalid" {
            { Add-EntraServicePrincipalOwner -ObjectId "aaaaaaaa-0b0b-1c1c-2d2d-333333333333" -RefObjectId ""  } | Should -Throw "Cannot bind argument to parameter 'RefObjectId' because it is an empty string."
        }
        It "Should contain ServicePrincipalId in parameters when passed ObjectId to it" {
            Mock -CommandName New-MgServicePrincipalOwnerByRef -MockWith {$args} -ModuleName Microsoft.Graph.Entra

            $result = Add-EntraServicePrincipalOwner -ObjectId "aaaaaaaa-0b0b-1c1c-2d2d-333333333333" -RefObjectId "bbbbbbbb-1111-2222-3333-cccccccccccc"
            $params = Get-Parameters -data $result
            $params.ServicePrincipalId | Should -Be "aaaaaaaa-0b0b-1c1c-2d2d-333333333333"
        }
        It "Should contain BodyParameter in parameters when passed RefObjectId to it" {
            Add-EntraServicePrincipalOwner -ObjectId "aaaaaaaa-0b0b-1c1c-2d2d-333333333333" -RefObjectId "bbbbbbbb-1111-2222-3333-cccccccccccc"
            $value = @{"@odata.id" = "https://graph.microsoft.com/v1.0/directoryObjects/bbbbbbbb-1111-2222-3333-cccccccccccc"}
            Should -Invoke -CommandName New-MgServicePrincipalOwnerByRef -ModuleName Microsoft.Graph.Entra -Times 1 -ParameterFilter {
                $BodyParameter.AdditionalProperties.'@odata.id' | Should -Be $value.'@odata.id'
                Write-Host $BodyParameter.AdditionalProperties.'@odata.id'
                $true
            }
        }
        It "Should contain 'User-Agent' header" {
                $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Add-EntraServicePrincipalOwner"
    
                Add-EntraServicePrincipalOwner -ObjectId "aaaaaaaa-0b0b-1c1c-2d2d-333333333333" -RefObjectId "bbbbbbbb-1111-2222-3333-cccccccccccc"
                
                $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Add-EntraServicePrincipalOwner"
    
                Should -Invoke -CommandName New-MgServicePrincipalOwnerByRef -ModuleName Microsoft.Graph.Entra -Times 1 -ParameterFilter {
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
                { Add-EntraServicePrincipalOwner -ObjectId "0008861a-d455-4671-bd24-ce9b3bfce288" -RefObjectId "bbbbbbbb-1111-2222-3333-cccccccccccc" -Debug } | Should -Not -Throw
            } finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        }    

    }

}  