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
                "Id"                   = "00aa00aa-bb11-cc22-dd33-44ee44ee44ee"
                "AdditionalProperties" = @{DeletedDateTime = $null}
                "Parameters"           = $args
            }
        )
    }

    Mock -CommandName Get-MgServicePrincipalTransitiveMemberOf -MockWith $scriptblock -ModuleName Microsoft.Graph.Entra
}
Describe "Get-EntraServicePrincipalMembership"{
    It "Result should not be empty" {
        $result = Get-EntraServicePrincipalMembership -ObjectId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
        $result | Should -Not -BeNullOrEmpty
        Should -Invoke -CommandName Get-MgServicePrincipalTransitiveMemberOf -ModuleName Microsoft.Graph.Entra -Times 1
    }
    It "Should fail when ObjectId is empty" {
        { Get-EntraServicePrincipalMembership -ObjectId "" } | Should -Throw "Cannot bind argument to parameter 'ObjectId' because it is an empty string."
    }
    It "Should return all applications" {
        $result = Get-EntraServicePrincipalMembership -ObjectId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -All
        $result | Should -Not -BeNullOrEmpty
        Should -Invoke -CommandName Get-MgServicePrincipalTransitiveMemberOf -ModuleName Microsoft.Graph.Entra -Times 1
    }
    It "Should fail when All has an argument" {
        { Get-EntraServicePrincipalMembership -ObjectId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -All $true} | Should -Throw "A positional parameter cannot be found that accepts argument 'True'."
    } 
    It "Should return top application" {
        $result = Get-EntraServicePrincipalMembership -ObjectId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -Top 1
        $result | Should -Not -BeNullOrEmpty
        Should -Invoke -CommandName Get-MgServicePrincipalTransitiveMemberOf -ModuleName Microsoft.Graph.Entra -Times 1
    }
    It "Result should Contain ObjectId" {            
        $result = Get-EntraServicePrincipalMembership -ObjectId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
        $result.ObjectId | should -Be "00aa00aa-bb11-cc22-dd33-44ee44ee44ee"
    }
    It "Should contain ServicePrincipalId in parameters when passed ObjectId to it" {    
        $result = Get-EntraServicePrincipalMembership -ObjectId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
        $params = Get-Parameters -data $result.Parameters
        $params.ServicePrincipalId | Should -Be "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
    }
    It "Property parameter should work" {
        $result = Get-EntraServicePrincipalMembership -ObjectId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -Property Id
        $result | Should -Not -BeNullOrEmpty
        $result.Id | Should -Be '00aa00aa-bb11-cc22-dd33-44ee44ee44ee'

        Should -Invoke -CommandName Get-MgServicePrincipalTransitiveMemberOf -ModuleName Microsoft.Graph.Entra -Times 1
    }
    It "Should fail when Property is empty" {
        { Get-EntraServicePrincipalMembership -ObjectId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -Property } | Should -Throw "Missing an argument for parameter 'Property'*"
    }
    It "Should contain 'User-Agent' header" {
        $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraServicePrincipalMembership"
        $result = Get-EntraServicePrincipalMembership -ObjectId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
        $result | Should -Not -BeNullOrEmpty
        $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraServicePrincipalMembership"    
        Should -Invoke -CommandName Get-MgServicePrincipalTransitiveMemberOf -ModuleName Microsoft.Graph.Entra -Times 1 -ParameterFilter {
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
            { Get-EntraServicePrincipalMembership -ObjectId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -Debug } | Should -Not -Throw
        } finally {
            # Restore original confirmation preference            
            $DebugPreference = $originalDebugPreference        
        }
    } 
}