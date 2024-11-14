# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

BeforeAll {  
    if ((Get-Module -Name Microsoft.Graph.Entra) -eq $null) {
        Import-Module Microsoft.Graph.Entra      
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force
    
    $scriptblock = {
        #Write-Host "Mocking New-EntraGroup with parameters: $($args | ConvertTo-Json -Depth 3)"
        return @(
            [PSCustomObject]@{
                "DisplayName"     = "demo"
                "Id"              = "bbbbbbbb-1111-2222-3333-cccccccccccc"
                "MailEnabled"     = "False"
                "Description"     = "test"
                "MailNickname"    = "demoNickname"
                "SecurityEnabled" = "True"
                "Parameters"      = $args
            }
        )
    }
    
    Mock -CommandName New-MgGroup -MockWith $scriptblock -ModuleName Microsoft.Graph.Entra
}
  
Describe "New-EntraGroup" {
    Context "Test for New-EntraGroup" {
        It "Should return created Group" {
            $result = New-EntraGroup -DisplayName "demo" -MailEnabled $false -SecurityEnabled $true -MailNickName "demoNickname" -Description "test"
            $result | Should -Not -BeNullOrEmpty
            $result.DisplayName | should -Be "demo"
            $result.MailEnabled | should -Be "False"
            $result.SecurityEnabled | should -Be "True"
            $result.Description | should -Be "test" 

            Should -Invoke -CommandName New-MgGroup -ModuleName Microsoft.Graph.Entra -Times 1
        }
        It "Should fail when parameters are invalid" {
            { New-EntraGroup -DisplayName "" -MailEnabled "" -SecurityEnabled "" -MailNickName  "" -Description "" } | Should -Throw "Cannot bind argument to parameter*"
        }
        It "Should fail when parameters are empty" {
            { New-EntraGroup -DisplayName -MailEnabled -SecurityEnabled -MailNickName -Description } | Should -Throw "Missing an argument for parameter*"
        }
        It "Result should Contain ObjectId" {            
            $result = New-EntraGroup -DisplayName "demo" -MailEnabled $false -SecurityEnabled $true -MailNickName "demoNickname" -Description "test"
            $result.ObjectId | should -Be "bbbbbbbb-1111-2222-3333-cccccccccccc"
        } 
        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion New-EntraGroup"
            $result = New-EntraGroup -DisplayName "demo" -MailEnabled $false -SecurityEnabled $true -MailNickName "demoNickname" -Description "test"
            $result | Should -Not -BeNullOrEmpty
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion New-EntraGroup"
            Should -Invoke -CommandName New-MgGroup -ModuleName Microsoft.Graph.Entra -Times 1 -ParameterFilter {
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
                { New-EntraGroup -DisplayName "demo" -MailEnabled $false -SecurityEnabled $true -MailNickName "demoNickname" -Debug } | Should -Not -Throw
            } finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        }  
    }
}