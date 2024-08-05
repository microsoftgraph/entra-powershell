BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra) -eq $null){
        Import-Module Microsoft.Graph.Entra       
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force
     $scriptblockForAuthenticationMethod = {
            return @(
                [PSCustomObject]@{
                    "Id" = "00160a01-0755-47fa-a241-090fe6d5f71a"

                }        
        )   
     }      
     $scriptblockForMgUser= {
        return @(
            [PSCustomObject]@{
                "Id" = "daa2b3a5-23e0-409a-90c0-e28585d5e387"
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
        
            $result =Convert-EntraFederatedUser -UserPrincipalName "xyz.onmicrosoft.com" -NewPassword "Pass1234"
            $params = Get-Parameters -data $result
            $params.Headers["User-Agent"] | Should -Be $userAgentHeaderValue
        }
    }
} 