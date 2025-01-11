# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra.Beta) -eq $null){
        Import-Module Microsoft.Graph.Entra.Beta       
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force

    Mock -CommandName Update-MgUser -MockWith {} -ModuleName Microsoft.Graph.Entra.Beta
}
  
Describe "Set-EntraBetaUserPassword" {
    Context "Test for Set-EntraBetaUserPassword" {
        It "Should return empty object" {
           $userUPN="mock106@M365x99297270.OnMicrosoft.com"
           $newPassword="New@12345"
           $secPassword = ConvertTo-SecureString $newPassword -AsPlainText -Force
           $result = Set-EntraBetaUserPassword -UserId $userUPN -Password $secPassword -ForceChangePasswordNextLogin $true -EnforceChangePasswordPolicy $true
           $result | Should -BeNullOrEmpty

            Should -Invoke -CommandName Update-MgUser -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }
        It "Should fail when UserId is empty" {
           $newPassword="New@12345"
           $secPassword = ConvertTo-SecureString $newPassword -AsPlainText -Force
           { Set-EntraBetaUserPassword -UserId  -Password $secPassword } | Should -Throw "Missing an argument for parameter 'UserId'*"
        }
        It "Should fail when UserId is invalid" {
           $newPassword="New@12345"
           $secPassword = ConvertTo-SecureString $newPassword -AsPlainText -Force
           { Set-EntraBetaUserPassword -UserId "" -Password $secPassword } | Should -Throw "Cannot bind argument to parameter 'UserId' because it is an empty string*"
        }
        It "Should fail when Password is empty" {
           $userUPN="mock106@M365x99297270.OnMicrosoft.com"
           $newPassword="New@12345"
           $secPassword = ConvertTo-SecureString $newPassword -AsPlainText -Force 
           { Set-EntraBetaUserPassword -UserId $userUPN -Password  } | Should -Throw "Missing an argument for parameter 'Password'*"
        }
        It "Should fail when Password is invalid" {
           $userUPN="mock106@M365x99297270.OnMicrosoft.com"
           $newPassword="New@12345"
           $secPassword = ConvertTo-SecureString $newPassword -AsPlainText -Force
           { Set-EntraBetaUserPassword -UserId $userUPN -Password "" } | Should -Throw "Cannot process argument transformation on parameter 'Password'*"
        }
        It "Should fail when ForceChangePasswordNextLogin  is empty" {
           $userUPN="mock106@M365x99297270.OnMicrosoft.com"
           $newPassword="New@12345"
           $secPassword = ConvertTo-SecureString $newPassword -AsPlainText -Force
           { Set-EntraBetaUserPassword -UserId $userUPN -Password $secPassword -ForceChangePasswordNextLogin  } | Should -Throw "Missing an argument for parameter 'ForceChangePasswordNextLogin'*"
        }
        It "Should fail when ForceChangePasswordNextLogin is invalid" {
           $userUPN="mock106@M365x99297270.OnMicrosoft.com"
           $newPassword="New@12345"
           $secPassword = ConvertTo-SecureString $newPassword -AsPlainText -Force
           { Set-EntraBetaUserPassword -UserId $userUPN -Password $secPassword -ForceChangePasswordNextLogin xyz } | Should -Throw "Cannot process argument transformation on parameter 'ForceChangePasswordNextLogin'*"
        }
        It "Should fail when EnforceChangePasswordPolicy is empty" {
           $userUPN="mock106@M365x99297270.OnMicrosoft.com"
           $newPassword="New@12345"
           $secPassword = ConvertTo-SecureString $newPassword -AsPlainText -Force
           { Set-EntraBetaUserPassword -UserId $userUPN -Password $secPassword -EnforceChangePasswordPolicy  } | Should -Throw "Missing an argument for parameter 'EnforceChangePasswordPolicy'*"
        }
        It "Should fail when EnforceChangePasswordPolicy is invalid" {
           $userUPN="mock106@M365x99297270.OnMicrosoft.com"
           $newPassword="New@12345"
           $secPassword = ConvertTo-SecureString $newPassword -AsPlainText -Force
           { Set-EntraBetaUserPassword -UserId $userUPN -Password $secPassword -EnforceChangePasswordPolicy xyz } | Should -Throw "Cannot process argument transformation on parameter 'EnforceChangePasswordPolicy'*"
        }
        It "Should contain ForceChangePasswordNextSignIn in parameters when passed ForceChangePasswordNextLogin to it" {
            Mock -CommandName Update-MgUser -MockWith {$args} -ModuleName Microsoft.Graph.Entra.Beta

            $userUPN="mock106@M365x99297270.OnMicrosoft.com"
            $newPassword="New@12345"
            $secPassword = ConvertTo-SecureString $newPassword -AsPlainText -Force
            $result = Set-EntraBetaUserPassword -UserId $userUPN -Password $secPassword -ForceChangePasswordNextLogin $true -EnforceChangePasswordPolicy $true
            $params = Get-Parameters -data $result
            $params.PasswordProfile.ForceChangePasswordNextSignIn | Should -Be $true
        }
        It "Should contain ForceChangePasswordNextSignInWithMfa in parameters when passed EnforceChangePasswordPolicy to it" {
            Mock -CommandName Update-MgUser -MockWith {$args} -ModuleName Microsoft.Graph.Entra.Beta

            $userUPN="mock106@M365x99297270.OnMicrosoft.com"
            $newPassword="New@12345"
            $secPassword = ConvertTo-SecureString $newPassword -AsPlainText -Force
            $result = Set-EntraBetaUserPassword -UserId $userUPN -Password $secPassword -ForceChangePasswordNextLogin $true -EnforceChangePasswordPolicy $true
            $params = Get-Parameters -data $result
            $params.PasswordProfile.ForceChangePasswordNextSignInWithMfa | Should -Be $true
        }
        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Set-EntraBetaUserPassword"
            $userUPN="mock106@M365x99297270.OnMicrosoft.com"
            $newPassword="New@12345"
            $secPassword = ConvertTo-SecureString $newPassword -AsPlainText -Force
            $result = Set-EntraBetaUserPassword -UserId $userUPN -Password $secPassword -ForceChangePasswordNextLogin $true -EnforceChangePasswordPolicy $true
            $result | Should  -BeNullOrEmpty
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Set-EntraBetaUserPassword"
            Should -Invoke -CommandName Update-MgUser -ModuleName Microsoft.Graph.Entra.Beta -Times 1 -ParameterFilter {
                $Headers.'User-Agent' | Should -Be $userAgentHeaderValue
                $true
            }
        }
         It "Should execute successfully without throwing an error " {
            # Disable confirmation prompts       
            $originalDebugPreference = $DebugPreference
            $DebugPreference = 'Continue'
            $userUPN="mock106@M365x99297270.OnMicrosoft.com"
            $newPassword="New@12345"
            $secPassword = ConvertTo-SecureString $newPassword -AsPlainText -Force

            try {
                # Act & Assert: Ensure the function doesn't throw an exception
                { Set-EntraBetaUserPassword -UserId $userUPN -Password $secPassword -ForceChangePasswordNextLogin $true -EnforceChangePasswordPolicy $true -Debug } | Should -Not -Throw
            } finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        }
    }
}            