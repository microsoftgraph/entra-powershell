# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
BeforeAll {  
    if((Get-Module -Name Microsoft.Entra.DirectoryManagement) -eq $null){
        Import-Module Microsoft.Entra.DirectoryManagement        
    }
    Import-Module (Join-Path $PSScriptRoot "..\..\Common-Functions.ps1") -Force

    $scriptblock = {
        return @(
            [PSCustomObject]@{
                "Id" = "contoso.com"
                "IsAdminManaged" ="True"
                "PasswordNotificationWindowInDays" = @{PasswordNotificationWindowInDays="14";  "Parameters" = $args}
                "PasswordValidityPeriodInDays" = "2147483647"      
            }
        )
    }    
    Mock -CommandName Get-MgDomain -MockWith $scriptblock -ModuleName Microsoft.Entra.DirectoryManagement

    Mock -CommandName Get-EntraContext -MockWith { @{
        Environment = @{ Name = "Global" }
        Scopes      = @('Domain.Read.All')
    }} -ModuleName Microsoft.Entra.DirectoryManagement
}

Describe "Get-EntraPasswordPolicy" {
    Context "Test for Get-EntraPasswordPolicy" {
        It "Should gets the current password policy for a tenant or a domain." {
            $result = Get-EntraPasswordPolicy -DomainName "contoso.com"
            $result | Should -Not -BeNullOrEmpty
            $result.NotificationDays.PasswordNotificationWindowInDays | Should -Be "14"
            $result.ValidityPeriod | Should -Be "2147483647"

            Should -Invoke -CommandName Get-MgDomain -ModuleName Microsoft.Entra.DirectoryManagement -Times 1
        }
        
        It "Should fail when DomainName is empty" {
            {Get-EntraPasswordPolicy -DomainName} | Should -Throw "Missing an argument for parameter 'DomainName'. Specify a parameter*"
        }

        It "Should fail when DomainName is invalid" {
            {Get-EntraPasswordPolicy -DomainName ""} | Should -Throw "Cannot bind argument to parameter 'DomainName' because it is an empty string.*"
        } 
       
        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraPasswordPolicy"
    
            $result = Get-EntraPasswordPolicy -DomainName "contoso.com" 
            $result | Should -Not -BeNullOrEmpty
            
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraPasswordPolicy"

            Should -Invoke -CommandName Get-MgDomain -ModuleName Microsoft.Entra.DirectoryManagement -Times 1 -ParameterFilter {
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
                { Get-EntraPasswordPolicy -DomainName "contoso.com" -Debug } | Should -Not -Throw
            } finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        }
    }    
}    

