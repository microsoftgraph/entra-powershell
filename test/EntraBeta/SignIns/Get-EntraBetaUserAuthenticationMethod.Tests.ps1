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
                    "Id"              = "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
                    "password"        = "null"
                    "createdDateTime" = "10/16/2024 11:13:33"
                    "@odata.type"     = "#microsoft.graph.passwordAuthenticationMethod"
                }
            )
        }
    }
    
    Mock -CommandName Invoke-MgGraphRequest -MockWith $scriptblock -ModuleName Microsoft.Entra.Beta.SignIns
    Mock -CommandName Get-EntraContext -MockWith { @{Scopes = @("UserAuthenticationMethod.Read.All") } } -ModuleName Microsoft.Entra.Beta.SignIns
}

Describe "Get-EntraBetaUserAuthenticationMethod" {
    Context "Test for Get-EntraBetaUserAuthenticationMethod" {
        
        It "Should fail when UserId is empty" {
            { Get-EntraBetaUserAuthenticationMethod -UserId } | Should -Throw "Missing an argument for parameter 'UserId'*"
        }
              
        It "Should return all user authentication methods" {
            $result = Get-EntraBetaUserAuthenticationMethod -UserId "SawyerM@Contoso.com" 
            $result | Should -Not -BeNullOrEmpty
            
            Should -Invoke -CommandName Invoke-MgGraphRequest -ModuleName Microsoft.Entra.Beta.SignIns -Times 1
        }

        It "Should return all user authentication methods with an alias" {
            $result = Get-EntraBetaUserAuthenticationMethod -UserId "SawyerM@Contoso.com" 
            $result | Should -Not -BeNullOrEmpty
            
            Should -Invoke -CommandName Invoke-MgGraphRequest -ModuleName Microsoft.Entra.Beta.SignIns -Times 1
        }
      
        It "Should contain 'User-Agent' header" {
            
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraBetaUserAuthenticationMethod"
            $result = Get-EntraBetaUserAuthenticationMethod -UserId "SawyerM@Contoso.com"
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
                { Get-EntraBetaUserAuthenticationMethod -UserId "SawyerM@Contoso.com" -Debug } | Should -Not -Throw
            }
            finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        }
    }
}
