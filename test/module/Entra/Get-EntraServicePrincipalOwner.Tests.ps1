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
                "Id"                     = "00aa00aa-bb11-cc22-dd33-44ee44ee44ee"
                "DisplayName"            = "Adams Smith"
                "UserPrincipalName"      = "Adams@contoso.com"
                "UserType"               = "Member"
                "appRoles"               = @{
                                                allowedMemberTypes=$null; 
                                                description="msiam_access";
                                                displayName="msiam_access"; 
                                                id="d0d7e4e4-96be-41c9-805a-08e0526868ad";
                                                isEnabled=$True; 
                                                origin="Application"
                                            }
                "oauth2PermissionScopes" = @{
                                                adminConsentDescription="Allow the application to access from tmplate test 3 on behalf of the signed-in user."; 
                                                adminConsentDisplayName="Access from tmplate test 3"; 
                                                id="64c2cef3-e118-4795-a580-a32bdbd7ba88"; 
                                                isEnabled=$True; 
                                                type="User";
                                                userConsentDescription="Allow the application to access from tmplate test 3 on your behalf."; 
                                                userConsentDisplayName="Access from tmplate test 3";
                                                value="user_impersonation"
                                            }
                "AdditionalProperties"   = @{
                                                "@odata.type" = "#microsoft.graph.servicePrincipal";
                                                accountEnabled = $true
                                            }
                "Parameters"             = $args
            }
        )
    }

    Mock -CommandName Get-MgServicePrincipalOwner -MockWith $scriptblock -ModuleName Microsoft.Graph.Entra
}
Describe "Get-EntraServicePrincipalOwner"{
    It "Result should not be empty" {
        $result = Get-EntraServicePrincipalOwner -ObjectId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
        $result | Should -Not -BeNullOrEmpty
        Should -Invoke -CommandName Get-MgServicePrincipalOwner -ModuleName Microsoft.Graph.Entra -Times 1
    }
    It "Should fail when ObjectId is empty" {
        { Get-EntraServicePrincipalOwner -ObjectId "" } | Should -Throw "Cannot bind argument to parameter 'ObjectId' because it is an empty string."
    }
    It "Should return all applications" {
        $result = Get-EntraServicePrincipalOwner -ObjectId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -All
        $result | Should -Not -BeNullOrEmpty
        Should -Invoke -CommandName Get-MgServicePrincipalOwner -ModuleName Microsoft.Graph.Entra -Times 1
    }
    It "Should fail when All has an argument" {
        { Get-EntraServicePrincipalOwner -ObjectId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -All $true} | Should -Throw "A positional parameter cannot be found that accepts argument 'True'."
    }
    It "Should return top application" {
        $result = Get-EntraServicePrincipalOwner -ObjectId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -Top 1
        $result | Should -Not -BeNullOrEmpty
        Should -Invoke -CommandName Get-MgServicePrincipalOwner -ModuleName Microsoft.Graph.Entra -Times 1
    }
    It "Result should Contain ObjectId" {            
        $result = Get-EntraServicePrincipalOwner -ObjectId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
        $result.ObjectId | should -Be "00aa00aa-bb11-cc22-dd33-44ee44ee44ee"
    }
    It "Should contain ServicePrincipalId in parameters when passed ObjectId to it" {    
        $result = Get-EntraServicePrincipalOwner -ObjectId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
        $params = Get-Parameters -data $result.Parameters
        $params.ServicePrincipalId | Should -Be "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
    }
    It "Property parameter should work" {
        $result = Get-EntraServicePrincipalOwner -ObjectId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -Property DisplayName
        $result | Should -Not -BeNullOrEmpty
        $result.DisplayName | Should -Be 'Adams Smith'

        Should -Invoke -CommandName Get-MgServicePrincipalOwner -ModuleName Microsoft.Graph.Entra -Times 1
    }
    It "Should fail when Property is empty" {
        { Get-EntraServicePrincipalOwner -ObjectId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -Property } | Should -Throw "Missing an argument for parameter 'Property'*"
    }
    It "Should contain 'User-Agent' header" {
        $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraServicePrincipalOwner"
        $result = Get-EntraServicePrincipalOwner -ObjectId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
        $result | Should -Not -BeNullOrEmpty
        $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraServicePrincipalOwner"    
        Should -Invoke -CommandName Get-MgServicePrincipalOwner -ModuleName Microsoft.Graph.Entra -Times 1 -ParameterFilter {
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
            {Get-EntraServicePrincipalOwner -ObjectId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -Debug } | Should -Not -Throw
        } finally {
            # Restore original confirmation preference            
            $DebugPreference = $originalDebugPreference        
        }
    } 
}