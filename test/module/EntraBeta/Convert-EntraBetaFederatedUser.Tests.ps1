BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra.Beta) -eq $null){
        Import-Module Microsoft.Graph.Entra.Beta      
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

    Mock -CommandName Get-MgBetaUserAuthenticationMethod -MockWith $scriptblockForAuthenticationMethod -ModuleName Microsoft.Graph.Entra.Beta
    Mock -CommandName Get-MgBetaUser -MockWith $scriptblockForMgUser -ModuleName Microsoft.Graph.Entra.Beta
    Mock -CommandName Reset-MgBetaUserAuthenticationMethodPassword -MockWith {} -ModuleName Microsoft.Graph.Entra.Beta
}
 
    Describe "Convert-EntraBetaFederatedUser" {
    Context "Test for Convert-EntraBetaFederatedUser" {
        It "Should sets identity synchronization features for a tenant." {
            $result = Convert-EntraBetaFederatedUser -UserPrincipalName "xyz.onmicrosoft.com" -NewPassword "Pass1234"
            $result | Should -BeNullOrEmpty
            Should -Invoke -CommandName Reset-MgBetaUserAuthenticationMethodPassword -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }
        It "Should fail when UserPrincipalName is empty" {
            {Convert-EntraBetaFederatedUser -UserPrincipalName } | Should -Throw "Missing an argument for parameter 'UserPrincipalName'. Specify a parameter*"
        }
        It "Should fail when UserPrincipalName is invalid" {
            {Convert-EntraBetaFederatedUser -UserPrincipalName ""} | Should -Throw "Cannot bind argument to parameter 'UserPrincipalName' because it is an empty string*"
        }
        It "Should fail when NewPassword is empty" {
            { Convert-EntraBetaFederatedUser -UserPrincipalName "xyz.onmicrosoft.com" -NewPassword  } | Should -Throw "Missing an argument for parameter 'NewPassword'. Specify a parameter*"
        }
        It "Should contain 'User-Agent' header" {

            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Convert-EntraBetaFederatedUser"
            Mock -CommandName Reset-MgBetaUserAuthenticationMethodPassword -MockWith {$args} -ModuleName Microsoft.Graph.Entra.Beta
        
            $result =Convert-EntraBetaFederatedUser -UserPrincipalName "xyz.onmicrosoft.com" -NewPassword "Pass1234"
            $params = Get-Parameters -data $result
            $params.Headers["User-Agent"] | Should -Be $userAgentHeaderValue
        }
    }
} 