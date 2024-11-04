# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra.Beta.Authentication) -eq $null){
        Import-Module Microsoft.Graph.Entra.Beta.Authentication
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force
    $scriptblock = {
        return @(
            [PSCustomObject]@{
                "Id" = "bbbbbbbb-1111-2222-3333-cccccccccccc"
                "AdditionalProperties"  = @{
                    "@odata.type"  = "#microsoft.graph.passwordAuthenticationMethod";
                    createdDateTime= "2023-11-21T12:43:51Z";
                }
            }
         )
    }
    Mock -CommandName Get-MgBetaUserAuthenticationMethod  -MockWith {} -ModuleName Microsoft.Graph.Entra.Beta.Authentication
}

Describe "Reset-EntraBetaStrongAuthenticationMethodByUpn" {
    Context "Test for Reset-EntraBetaStrongAuthenticationMethodByUpn" {
    It "Should Resets the strong authentication method" {
        $result = Reset-EntraBetaStrongAuthenticationMethodByUpn  -UserPrincipalName 'Test_contoso.com#EXT#@M365x99297270.onmicrosoft.com'
        $result | Should -BeNullOrEmpty
       
        Should -Invoke -CommandName Get-MgBetaUserAuthenticationMethod -ModuleName Microsoft.Graph.Entra.Beta.Authentication -Times 1
    }
    It "Should fail when UserPrincipalName is empty" {
        { Reset-EntraBetaStrongAuthenticationMethodByUpn  -UserPrincipalName } | Should -Throw "Missing an argument for parameter 'UserPrincipalName'*"
    }  
 
    It "Should fail when Id is invalid" {
        { Reset-EntraBetaStrongAuthenticationMethodByUpn  -UserPrincipalName "" } | Should -Throw "Cannot bind argument to parameter 'UserPrincipalName' because it is an empty string."
    }  
    It "Should contain 'User-Agent' header" {
        $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Reset-EntraBetaStrongAuthenticationMethodByUpn"

        Reset-EntraBetaStrongAuthenticationMethodByUpn  -UserPrincipalName 'Test_contoso@M365x99297270.onmicrosoft.com' | Out-Null
        Should -Invoke -CommandName Get-MgBetaUserAuthenticationMethod -ModuleName Microsoft.Graph.Entra.Beta.Authentication -Times 1 -ParameterFilter {
            $Headers.'User-Agent' | Should -Be $userAgentHeaderValue
            $true
        }
    }
    It "Should contain 'User-Agent' header" {
        Reset-EntraBetaStrongAuthenticationMethodByUpn  -UserPrincipalName 'Test_contoso@M365x99297270.onmicrosoft.com' | Out-Null
        Should -Invoke -CommandName Get-MgBetaUserAuthenticationMethod -ModuleName Microsoft.Graph.Entra.Beta.Authentication -Times 1 -ParameterFilter {
            $userId | Should -Be 'Test_contoso@M365x99297270.onmicrosoft.com'
            $true
        }
    }  
    It "Should execute successfully without throwing an error" {
        # Disable confirmation prompts       
        $originalDebugPreference = $DebugPreference
        $DebugPreference = 'Continue'

        try {
            # Act & Assert: Ensure the function doesn't throw an exception
            { Reset-EntraBetaStrongAuthenticationMethodByUpn  -UserPrincipalName 'Test_contoso@M365x99297270.onmicrosoft.com' -Debug } | Should -Not -Throw
        } finally {
            # Restore original confirmation preference            
            $DebugPreference = $originalDebugPreference        
        }
    }    
}
}
