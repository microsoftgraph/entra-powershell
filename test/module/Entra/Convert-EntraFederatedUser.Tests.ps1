# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra) -eq $null){
        Import-Module Microsoft.Graph.Entra       
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force
     $scriptblockForAuthenticationMethod = {
            return @(
                [PSCustomObject]@{
                    "Id" = "00aa00aa-bb11-cc22-dd33-44ee44ee44ee"
                }        
        )   
     }      
     $scriptblockForMgUser= {
        return @(
            [PSCustomObject]@{
                "Id" = "22cc22cc-dd33-ee44-ff55-66aa66aa66aa"
            }        
    )   
 }  

    Mock -CommandName Get-MgUserAuthenticationMethod -MockWith $scriptblockForAuthenticationMethod -ModuleName Microsoft.Graph.Entra
    Mock -CommandName Get-MgUser -MockWith $scriptblockForMgUser -ModuleName Microsoft.Graph.Entra
    Mock -CommandName Reset-MgUserAuthenticationMethodPassword -MockWith {} -ModuleName Microsoft.Graph.Entra
}
 
    Describe "Convert-EntraFederatedUser" {
    Context "Test for Convert-EntraFederatedUser" {
        It "Should sets identity synchronization features for a tenant." {
            $result = Convert-EntraFederatedUser -UserPrincipalName "xyz.onmicrosoft.com" -NewPassword "Pass1234"
            $result | Should -BeNullOrEmpty
            Should -Invoke -CommandName Reset-MgUserAuthenticationMethodPassword -ModuleName Microsoft.Graph.Entra -Times 1
        }
        It "Should fail when UserPrincipalName is empty" {
            {Convert-EntraFederatedUser -UserPrincipalName } | Should -Throw "Missing an argument for parameter 'UserPrincipalName'. Specify a parameter*"
        }
        It "Should fail when UserPrincipalName is invalid" {
            {Convert-EntraFederatedUser -UserPrincipalName ""} | Should -Throw "Cannot bind argument to parameter 'UserPrincipalName' because it is an empty string*"
        }
        It "Should fail when NewPassword is empty" {
            { Convert-EntraFederatedUser -UserPrincipalName "xyz.onmicrosoft.com" -NewPassword  } | Should -Throw "Missing an argument for parameter 'NewPassword'. Specify a parameter*"
        }
        It "Should contain 'User-Agent' header" {

            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Convert-EntraFederatedUser"
            Mock -CommandName Reset-MgUserAuthenticationMethodPassword -MockWith {$args} -ModuleName Microsoft.Graph.Entra
        
            $result = Convert-EntraFederatedUser -UserPrincipalName "xyz.onmicrosoft.com" -NewPassword "Pass1234"
            $params = Get-Parameters -data $result
            $params.Headers["User-Agent"] | Should -Be $userAgentHeaderValue
        }
        It "Should execute successfully without throwing an error " {
            # Disable confirmation prompts       
            $originalDebugPreference = $DebugPreference
            $DebugPreference = 'Continue'
    
            try {
                # Act & Assert: Ensure the function doesn't throw an exception
                { Convert-EntraFederatedUser -UserPrincipalName "xyz.onmicrosoft.com" -NewPassword "Pass1234" -Debug } | Should -Not -Throw
            } finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        }
    }
} 