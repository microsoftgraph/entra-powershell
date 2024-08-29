# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra) -eq $null){
        
        Import-Module Microsoft.Graph.Entra      
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force

$scriptblock = {
    return @(
        [PSCustomObject]@{
           "PrepaidUnits"                     = @{Enabled="20"; LockedOut=""; Suspended=0; Warning=""; AdditionalProperties=""} 
           "AccountId"                        = "00001111-aaaa-2222-bbbb-3333cccc4444"
           "AccountName"                      = "M365x99297270"
           "AppliesTo"                        = "User"
           "CapabilityStatus"                 = "Enabled"
           "ConsumedUnits"                    = "20"
           "Id"                               = "00001111-aaaa-2222-bbbb-3333cccc4444_11112222-bbbb-3333-cccc-4444dddd5555"
           "ServicePlans"                     = {"M365_AUDIT_PLATFORM", "EXCHANGE_S_FOUNDATION", "ATA", "ADALLOM_S_STANDALONE"}
           "SkuId"                            = "11112222-bbbb-3333-cccc-4444dddd5555"
           "SkuPartNumber"                    = "EMSPREMIUM"
           "SubscriptionIds"                  = {"aaaa0a0a-bb1b-cc2c-dd3d-eeeeee4e4e4e"}
           "Parameters"                       = $args
          
        } 
    )

}

    Mock -CommandName Get-MgSubscribedSku -MockWith $scriptblock -ModuleName Microsoft.Graph.Entra
}


Describe "Get-EntraSubscribedSku" {
    Context "Test for Get-EntraSubscribedSku" {
        It "Should return specific SubscribedSku" {
            $result = Get-EntraSubscribedSku -ObjectId "00001111-aaaa-2222-bbbb-3333cccc4444_11112222-bbbb-3333-cccc-4444dddd5555"
            $result | Should -Not -BeNullOrEmpty
	        $result.Id | should -Be "00001111-aaaa-2222-bbbb-3333cccc4444_11112222-bbbb-3333-cccc-4444dddd5555"		
            
            Should -Invoke -CommandName Get-MgSubscribedSku -ModuleName Microsoft.Graph.Entra -Times 1
        }   
        It "Should fail when ObjectId empty" {
            { Get-EntraSubscribedSku -ObjectId  } | Should -Throw "Missing an argument for parameter 'ObjectId'*"
        }
        It "Should fail when ObjectId invalid" {
            { Get-EntraSubscribedSku -ObjectId "" } | Should -Throw "Cannot bind argument to parameter 'ObjectId' because it is an empty string."
        }
        It "Should return all SubscribedSku" {
            $result = Get-EntraSubscribedSku 
            $result | Should -Not -BeNullOrEmpty

	    Should -Invoke -CommandName Get-MgSubscribedSku -ModuleName Microsoft.Graph.Entra -Times 1
        }
        It "Property parameter should work" {
            $result = Get-EntraSubscribedSku -Property AppliesTo
            $result | Should -Not -BeNullOrEmpty
            $result.AppliesTo | Should -Be 'User'

            Should -Invoke -CommandName Get-MgSubscribedSku -ModuleName Microsoft.Graph.Entra -Times 1
        }
        It "Should fail when Property is empty" {
             { Get-EntraSubscribedSku -Property } | Should -Throw "Missing an argument for parameter 'Property'*"
        }
         It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraSubscribedSku"
            $result = Get-EntraSubscribedSku -ObjectId "00001111-aaaa-2222-bbbb-3333cccc4444_11112222-bbbb-3333-cccc-4444dddd5555"
            $params = Get-Parameters -data $result.Parameters
            $params.Headers["User-Agent"] | Should -Be $userAgentHeaderValue
        }
        It "Should execute successfully without throwing an error" {
            # Disable confirmation prompts       
            $originalDebugPreference = $DebugPreference
            $DebugPreference = 'Continue'

            try {
                # Act & Assert: Ensure the function doesn't throw an exception
                { Get-EntraSubscribedSku -ObjectId "00001111-aaaa-2222-bbbb-3333cccc4444_11112222-bbbb-3333-cccc-4444dddd5555" -Debug } | Should -Not -Throw
            } finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        }
    }   
}
