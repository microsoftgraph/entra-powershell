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
                "Id"                        = "bbbbbbbb-1111-2222-3333-cccccccccccc"
                "AdditionalProperties"                              = @{
                    "@odata.type"  = "#microsoft.graph.passwordAuthenticationMethod";
                    createdDateTime= "2023-11-21T12:43:51Z";
                }
                "Parameters"                = $args
            }
         )
    }
    Mock -CommandName Get-MgUserAuthenticationMethod  -MockWith {} -ModuleName Microsoft.Graph.Entra
}
 
Describe "Test for Reset-EntraStrongAuthenticationMethodByUpn" {
    It "Should Resets the strong authentication method" {
        $result = Reset-EntraStrongAuthenticationMethodByUpn  -UserPrincipalName 'Test_contoso.com#EXT#@M365x99297270.onmicrosoft.com'
        $result | Should -BeNullOrEmpty
       
        Should -Invoke -CommandName Get-MgUserAuthenticationMethod -ModuleName Microsoft.Graph.Entra -Times 1
    }
    It "Should fail when UserPrincipalName is empty" {
        { Reset-EntraStrongAuthenticationMethodByUpn  -UserPrincipalName } | Should -Throw "Missing an argument for parameter 'UserPrincipalName'*"
    }  
 
    It "Should fail when Id is invalid" {
        { Reset-EntraStrongAuthenticationMethodByUpn  -UserPrincipalName "" } | Should -Throw "Cannot bind argument to parameter 'UserPrincipalName' because it is an empty string."
    }  
 
}