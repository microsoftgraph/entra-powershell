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
                "PrepaidUnits"     = @{Enabled=20;LockedOut= 0; Suspended= 0;Warning =0}
                "Id"               = "00001111-aaaa-2222-bbbb-3333cccc4444_11112222-bbbb-3333-cccc-4444dddd5555"
                "ConsumedUnits"    = "20"
                "AccountName"      = "M365x99297270"
                "CapabilityStatus" = "Enabled"
                "AccountId"        = "00001111-aaaa-2222-bbbb-3333cccc4444"
                "AppliesTo"        = "User"
                "Parameters"       = $args
            }
        )
    }    
    Mock -CommandName Get-MgBetaSubscribedSku -MockWith $scriptblock -ModuleName Microsoft.Graph.Entra.Beta
}

Describe "Get-EntraBetaAccountSku" {
    Context "Test for Get-EntraBetaAccountSku" {
        It "Returns all the SKUs for a company." {
            $result = Get-EntraBetaAccountSku -TenantId "aaaabbbb-0000-cccc-1111-dddd2222eeee"
            $result | Should -Not -BeNullOrEmpty
            $result.Id | should -Be "00001111-aaaa-2222-bbbb-3333cccc4444_11112222-bbbb-3333-cccc-4444dddd5555"
            $result.ConsumedUnits | should -Be "20"
            $result.AccountName | should -Be "M365x99297270"
            $result.CapabilityStatus | should -Be "Enabled"
            $result.AccountId | should -Be "00001111-aaaa-2222-bbbb-3333cccc4444"
            $result.AppliesTo | should -Be "User"

            Should -Invoke -CommandName Get-MgBetaSubscribedSku -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }
        It "Should fail when TenantId is empty" {
            { Get-EntraBetaAccountSku -TenantId } | Should -Throw "Missing an argument for parameter 'TenantId'*"
        }
        It "Should fail when TenantId is invalid" {
            { Get-EntraBetaAccountSku -TenantId "" } | Should -Throw "Cannot process argument transformation on parameter 'TenantId'.*"
        }
       
        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraBetaAccountSku"

            $result = Get-EntraBetaAccountSku -TenantId "aaaabbbb-0000-cccc-1111-dddd2222eeee"
            $result | Should -Not -BeNullOrEmpty

            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraBetaAccountSku"

            Should -Invoke -CommandName Get-MgBetaSubscribedSku -ModuleName Microsoft.Graph.Entra.Beta -Times 1 -ParameterFilter {
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
                { Get-EntraBetaAccountSku -TenantId "aaaabbbb-0000-cccc-1111-dddd2222eeee" -Debug } | Should -Not -Throw
            } finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        }
    }
}