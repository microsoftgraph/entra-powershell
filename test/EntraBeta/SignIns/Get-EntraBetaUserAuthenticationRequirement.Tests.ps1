# ------------------------------------------------------------------------------ 
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.
#  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
BeforeAll {
    if ((Get-Module -Name Microsoft.Entra.Beta.SignIns) -eq $null) {
        Import-Module Microsoft.Entra.Beta.SignIns      
    }
    Import-Module (Join-Path $PSScriptRoot "..\..\Common-Functions.ps1") -Force

    $scriptblock = {
        return @{
            value = @(
                @{
                    "perUserMfaState" = "enforced"
                    "@odata.type"     = "https://graph.microsoft.com/beta/$metadata#users('b3f1c54f-1b1f-40fc-8d6d-cd4dc041e959')/authentication/requirements"
                }
            )
        }
    }
    
    Mock -CommandName Invoke-MgGraphRequest -MockWith $scriptblock -ModuleName Microsoft.Entra.Beta.SignIns
    Mock -CommandName Get-EntraContext -MockWith { @{Scopes = @("Policy.Read.All") } } -ModuleName Microsoft.Entra.Beta.SignIns
}

Describe "Get-EntraBetaUserAuthenticationRequirement" {
    Context "Test for Get-EntraBetaUserAuthenticationRequirement" {
        It "Should throw when not connected and not invoke SDK" {
            Mock -CommandName Get-EntraContext -MockWith { $null } -ModuleName Microsoft.Entra.Beta.SignIns
            { Get-EntraBetaUserAuthenticationRequirement -UserId "SawyerM@Contoso.com" } | Should -Throw "Not connected to Microsoft Graph*"
            Should -Invoke -CommandName Invoke-MgGraphRequest -ModuleName Microsoft.Entra.Beta.SignIns -Times 0
        }
        
        It "Should fail when UserId is empty" {
            { Get-EntraBetaUserAuthenticationRequirement -UserId } | Should -Throw "Missing an argument for parameter 'UserId'*"
        }
              
        It "Should return all user authentication methods" {
            $result = Get-EntraBetaUserAuthenticationRequirement -UserId "SawyerM@Contoso.com" 
            $result | Should -Not -BeNullOrEmpty
            
            Should -Invoke -CommandName Invoke-MgGraphRequest -ModuleName Microsoft.Entra.Beta.SignIns -Times 1
        }

        It "Should return all user authentication methods with an alias" {
            $result = Get-EntraBetaUserAuthenticationRequirement -UserId "SawyerM@Contoso.com" 
            $result | Should -Not -BeNullOrEmpty
            
            Should -Invoke -CommandName Invoke-MgGraphRequest -ModuleName Microsoft.Entra.Beta.SignIns -Times 1
        }
      
        It "Should contain 'User-Agent' header" {
            
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraBetaUserAuthenticationRequirement"
            $result = Get-EntraBetaUserAuthenticationRequirement -UserId "SawyerM@Contoso.com"
            $result | Should -Not -BeNullOrEmpty

            Should -Invoke -CommandName Invoke-MgGraphRequest -ModuleName Microsoft.Entra.Beta.SignIns -Times 1 -ParameterFilter {
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
                { Get-EntraBetaUserAuthenticationRequirement -UserId "SawyerM@Contoso.com" -Debug } | Should -Not -Throw
            }
            finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        }
    }
}
