# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra.Beta) -eq $null){
        Import-Module Microsoft.Graph.Entra.Beta    
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force

    $scriptblock = {
        return @(
            [PSCustomObject]@{
              "DisplayName"                     = "My Test san"
              "Id"                              = "bbbbbbbb-1111-2222-3333-cccccccccc55"
              "MailEnabled"                     = $false
              "Description"                     = ""
              "CreatedByAppId"                  = "bbbbbbbb-1111-2222-3333-cccccccccc56"
              "Mail"                            = ""
              "MailNickname"                    = "NotSet"
              "SecurityEnabled"                 = $true
              "Visibility"                      = ""
              "IsAssignableToRole"              = ""
              "GroupTypes"                      = @{}
              "ProxyAddresses"                  = @{} 
              "MembershipRule"                  = ""
              "MembershipRuleProcessingState"   = ""
              "Parameters"                      = $args
            } 
        )
    }
    Mock -CommandName New-MgBetaGroup -MockWith $scriptblock -ModuleName Microsoft.Graph.Entra.Beta
}

Describe "New-EntraBetaGroup" {
    Context "Test for New-EntraBetaGroup" {
        It "Should return created Group" {
            $result = New-EntraBetaGroup -DisplayName "My Test san" -MailEnabled $false -SecurityEnabled $true -MailNickName "NotSet"
            $result | Should -Not -BeNullOrEmpty
            $result.DisplayName | should -Be "My Test san"
            $result.Description | should -BeNullOrEmpty 
            $result.MailEnabled | should -Be $false
            $result.MailNickname | should -Be "NotSet"
            $result.SecurityEnabled | should -Be $true
            $result.IsAssignableToRole | should -BeNullOrEmpty
            $result.Visibility | should -BeNullOrEmpty
            $result.GroupTypes | should -BeNullOrEmpty
            $result.Mail | should -BeNullOrEmpty
            $result.MembershipRule | should -BeNullOrEmpty
            $result.MembershipRuleProcessingState | should -BeNullOrEmpty
            $result.CreatedByAppId | should -Be "bbbbbbbb-1111-2222-3333-cccccccccc56"
            $result.Id | should -Be "bbbbbbbb-1111-2222-3333-cccccccccc55"

            Should -Invoke -CommandName New-MgBetaGroup -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }

        It "Should fail when parameters are empty" {
            { New-EntraBetaGroup -DisplayName -Description -MailEnabled -SecurityEnabled -MailNickName -GroupTypes } | Should -Throw "Missing an argument for parameter*"
        }

        It "Should fail when MailEnabled parameters are Invalid" {
            { New-EntraBetaGroup -DisplayName "My Test san" -MailEnabled "test"  } | Should -Throw "Cannot process argument transformation on parameter*"
        }

        It "Should fail when SecurityEnabled parameters are Invalid" {
            { New-EntraBetaGroup -DisplayName "My Test san" -MailEnabled $false -SecurityEnabled 'test'  } | Should -Throw "Cannot process argument transformation*"
        }

        It "Should contain ObjectId in result" {
            $result = New-EntraBetaGroup -DisplayName "My Test san" -MailEnabled $false -SecurityEnabled $true -MailNickName "NotSet"
            $result.ObjectId | should -Be "bbbbbbbb-1111-2222-3333-cccccccccc55"
        } 

        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion New-EntraBetaGroup"

            $result = New-EntraBetaGroup -DisplayName "My Test san" -MailEnabled $false -SecurityEnabled $true -MailNickName "NotSet"
            $result | Should -Not -BeNullOrEmpty

            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion New-EntraBetaGroup"

            Should -Invoke -CommandName New-MgBetaGroup -ModuleName Microsoft.Graph.Entra.Beta -Times 1 -ParameterFilter {
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
                { New-EntraBetaGroup -DisplayName "My Test san" -MailEnabled $false -SecurityEnabled $true -MailNickName "NotSet" -Debug } | Should -Not -Throw
            } finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        }
    }
}