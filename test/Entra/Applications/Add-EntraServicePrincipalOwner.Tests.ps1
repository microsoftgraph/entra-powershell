# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
BeforeAll {  
    if ((Get-Module -Name Microsoft.Entra.Applications) -eq $null) {
        Import-Module Microsoft.Entra.Applications        
    }
    Import-Module (Join-Path $PSScriptRoot "..\..\Common-Functions.ps1") -Force

    Mock -CommandName Get-EntraContext -MockWith { @{
            Environment = "Global"
        } } -ModuleName Microsoft.Entra.Applications
    Mock -CommandName Get-EntraEnvironment -MockWith { return @{
            GraphEndpoint = "https://graph.microsoft.com"
        } } -ModuleName Microsoft.Entra.Applications

    Mock -CommandName New-MgServicePrincipalOwnerByRef -MockWith {} -ModuleName Microsoft.Entra.Applications
}

Describe "Add-EntraServicePrincipalOwner" {
    Context "Test for Add-EntraServicePrincipalOwner" {
        It "Should return empty object" {
            $result = Add-EntraServicePrincipalOwner -ServicePrincipalId "aaaaaaaa-0b0b-1c1c-2d2d-333333333333" -OwnerId "bbbbbbbb-1111-2222-3333-cccccccccccc"
            $result | Should -BeNullOrEmpty

            Should -Invoke -CommandName New-MgServicePrincipalOwnerByRef -ModuleName Microsoft.Entra.Applications -Times 1
        }
        It "Should update the parameter with Alias" {
            $result = Add-EntraServicePrincipalOwner -ObjectId "aaaaaaaa-0b0b-1c1c-2d2d-333333333333" -OwnerId "bbbbbbbb-1111-2222-3333-cccccccccccc"
            $result | Should -BeNullOrEmpty

            Should -Invoke -CommandName New-MgServicePrincipalOwnerByRef -ModuleName Microsoft.Entra.Applications -Times 1
        }
        It "Should fail when ServicePrincipalId is empty" {
            { Add-EntraServicePrincipalOwner -ServicePrincipalId -OwnerId "bbbbbbbb-1111-2222-3333-cccccccccccc" } | Should -Throw "Missing an argument for parameter 'ServicePrincipalId'.*"
        }
        It "Should fail when ServicePrincipalId is invalid" {
            { Add-EntraServicePrincipalOwner -ServicePrincipalId "" -OwnerId "bbbbbbbb-1111-2222-3333-cccccccccccc" } | Should -Throw "Cannot validate argument on parameter 'ServicePrincipalId'. The argument is null or empty. Provide an argument that is not null or empty*"
        }
        It "Should fail when OwnerId is empty" {
            { Add-EntraServicePrincipalOwner -ServicePrincipalId "aaaaaaaa-0b0b-1c1c-2d2d-333333333333" -OwnerId } | Should -Throw "Missing an argument for parameter 'OwnerId'.*"
        }
        It "Should fail when OwnerId is invalid" {
            { Add-EntraServicePrincipalOwner -ServicePrincipalId "aaaaaaaa-0b0b-1c1c-2d2d-333333333333" -OwnerId "" } | Should -Throw "Cannot validate argument on parameter 'OwnerId'. The argument is null or empty. Provide an argument that is not null or empty*"
        }
        It "Should contain ServicePrincipalId in parameters when passed ServicePrincipalId to it" {
            Mock -CommandName New-MgServicePrincipalOwnerByRef -MockWith { $args } -ModuleName Microsoft.Entra.Applications

            $result = Add-EntraServicePrincipalOwner -ServicePrincipalId "aaaaaaaa-0b0b-1c1c-2d2d-333333333333" -OwnerId "bbbbbbbb-1111-2222-3333-cccccccccccc"
            $params = Get-Parameters -data $result
            $params.ServicePrincipalId | Should -Be "aaaaaaaa-0b0b-1c1c-2d2d-333333333333"
        }
        It "Should contain BodyParameter in parameters when passed OwnerId to it" {
            Add-EntraServicePrincipalOwner -ServicePrincipalId "aaaaaaaa-0b0b-1c1c-2d2d-333333333333" -OwnerId "bbbbbbbb-1111-2222-3333-cccccccccccc"
            $value = @{"@odata.id" = "https://graph.microsoft.com/v1.0/directoryObjects/bbbbbbbb-1111-2222-3333-cccccccccccc" }
            Should -Invoke -CommandName New-MgServicePrincipalOwnerByRef -ModuleName Microsoft.Entra.Applications -Times 1 -ParameterFilter {
                $BodyParameter.AdditionalProperties.'@odata.id' | Should -Be $value.'@odata.id'
                Write-Host $BodyParameter.AdditionalProperties.'@odata.id'
                $true
            }
        }
        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Add-EntraServicePrincipalOwner"
    
            Add-EntraServicePrincipalOwner -ServicePrincipalId "aaaaaaaa-0b0b-1c1c-2d2d-333333333333" -OwnerId "bbbbbbbb-1111-2222-3333-cccccccccccc"
                
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Add-EntraServicePrincipalOwner"
    
            Should -Invoke -CommandName New-MgServicePrincipalOwnerByRef -ModuleName Microsoft.Entra.Applications -Times 1 -ParameterFilter {
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
                { Add-EntraServicePrincipalOwner -ServicePrincipalId "0008861a-d455-4671-bd24-ce9b3bfce288" -OwnerId "bbbbbbbb-1111-2222-3333-cccccccccccc" -Debug } | Should -Not -Throw
            }
            finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        }    

    }

}  

