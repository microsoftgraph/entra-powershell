BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra.Beta) -eq $null){
        Import-Module Microsoft.Graph.Entra.Beta       
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force

    $scriptblock = {
        return @(
            [PSCustomObject]@{
                "Id" = "M365x99297270.onmicrosoft.com"
                "IsAdminManaged" ="True"
                "PasswordNotificationWindowInDays" = @{PasswordNotificationWindowInDays="14";  "Parameters" = $args}
                "PasswordValidityPeriodInDays" = "2147483647"      
            }
        )
    }    
    Mock -CommandName Get-MgBetaDomain -MockWith $scriptblock -ModuleName Microsoft.Graph.Entra.Beta
}

Describe "Get-EntraBetaPasswordPolicy" {
    Context "Test for Get-EntraBetaPasswordPolicy" {
        It "Should gets the current password policy for a tenant or a domain." {
            $result = Get-EntraBetaPasswordPolicy -DomainName "M365x99297270.onmicrosoft.com"
            $result | Should -Not -BeNullOrEmpty
            $result.NotificationDays.PasswordNotificationWindowInDays | Should -Be "14"
            $result.ValidityPeriod | Should -Be "2147483647"

            Should -Invoke -CommandName Get-MgBetaDomain -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }
        
        It "Should fail when DomainName is empty" {
            {Get-EntraBetaPasswordPolicy -DomainName} | Should -Throw "Missing an argument for parameter 'DomainName'. Specify a parameter*"
        }

        It "Should fail when DomainName is invalid" {
            {Get-EntraBetaPasswordPolicy -DomainName ""} | Should -Throw "Cannot bind argument to parameter 'DomainName' because it is an empty string.*"
        } 
       
        It "Should contain 'User-Agent' header" {
        $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraBetaPasswordPolicy"

        $result = Get-EntraBetaPasswordPolicy -DomainName "M365x99297270.onmicrosoft.com"
        $params = Get-Parameters -data $result.NotificationDays.Parameters
        $params.Headers["User-Agent"] | Should -Contain $userAgentHeaderValue
        }    
    }    
}    