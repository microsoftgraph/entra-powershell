# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

BeforeAll {  
    if((Get-Module -Name Microsoft.Entra.Groups) -eq $null){
        Import-Module Microsoft.Entra.Groups        
    }
    Import-Module (Join-Path $PSScriptRoot "..\..\Common-Functions.ps1") -Force

    Mock -CommandName Invoke-MgGraphRequest -MockWith {} -ModuleName Microsoft.Entra.Groups
    Mock -CommandName Get-EntraContext -MockWith { @{Scopes = @("Group.ReadWrite.All")} } -ModuleName Microsoft.Entra.Groups
}
  
Describe "Update-EntraGroup" {
    Context "Test for Update-EntraGroup" {
        It "Should return empty object" {
            $result = Update-EntraGroup -GroupId bbbbbbbb-1111-2222-3333-cccccccccccc -DisplayName "demo" -MailEnabled $false -SecurityEnabled $true -MailNickName "demoNickname" -Description "test"
            $result | Should -BeNullOrEmpty

            Should -Invoke -CommandName Invoke-MgGraphRequest -ModuleName Microsoft.Entra.Groups -Times 1
        }
        It "Should execute successfully with Alias" {
            $result = Update-EntraGroup -Id bbbbbbbb-1111-2222-3333-cccccccccccc -DisplayName "demo" -MailEnabled $false -SecurityEnabled $true -MailNickName "demoNickname" -Description "test"
            $result | Should -BeNullOrEmpty

            Should -Invoke -CommandName Invoke-MgGraphRequest -ModuleName Microsoft.Entra.Groups -Times 1
        }
        It "Should fail when GroupId is invalid" {
            { Update-EntraGroup -GroupId "" } | Should -Throw "Cannot validate argument on parameter 'GroupId'. The argument is null or empty. Provide an argument that is not null or empty, and then try the command again."
        }
        It "Should fail when GroupId is empty" {
            { Update-EntraGroup -GroupId } | Should -Throw "Missing an argument for parameter 'GroupId'*"
        }
        It "Should not execute Invoke-MgGraphRequest with WhatIf parameter" {
            Update-EntraGroup -GroupId bbbbbbbb-1111-2222-3333-cccccccccccc -DisplayName "demo" -WhatIf
            Should -Invoke -CommandName Invoke-MgGraphRequest -ModuleName Microsoft.Entra.Groups -Times 0
        }
        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Update-EntraGroup"

            Update-EntraGroup -Id bbbbbbbb-1111-2222-3333-cccccccccccc -DisplayName "demo"

            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Update-EntraGroup"
            Should -Invoke -CommandName Invoke-MgGraphRequest -ModuleName Microsoft.Entra.Groups -Times 1 -ParameterFilter {
                $Headers.'User-Agent' | Should -Be $userAgentHeaderValue
                $true
            }
        }
        It "Should execute successfully without throwing an error " {
            # Disable confirmation prompts       
            $originalDebugPreference = $DebugPreference
            $DebugPreference = 'Continue'
    
            try {
                # Act & Assert: Ensure the function doesn't throw an exception
                { Update-EntraGroup -Id bbbbbbbb-1111-2222-3333-cccccccccccc } | Should -Not -Throw
            } finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        }   
    }
}

