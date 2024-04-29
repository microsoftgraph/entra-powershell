BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra) -eq $null){
        
        Import-Module Microsoft.Graph.Entra      
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force

$scriptblock = {
    return @(
        [PSCustomObject]@{
           "PrepaidUnits"                     = @{Enabled="20"; LockedOut=""; Suspended=0; Warning=""; AdditionalProperties=""} 
           "AccountId"                        = "d5aec55f-2d12-4442-8d2f-ccca95d4390e"
           "AccountName"                      = "M365x99297270"
           "AppliesTo"                        = "User"
           "CapabilityStatus"                 = "Enabled"
           "ConsumedUnits"                    = "20"
           "Id"                               = "d5aec55f-2d12-4442-8d2f-ccca95d4390e_b05e124f-c7cc-45a0-a6aa-8cf78c946968"
           "ServicePlans"                     = {"M365_AUDIT_PLATFORM", "EXCHANGE_S_FOUNDATION", "ATA", "ADALLOM_S_STANDALONE"}
           "SkuId"                            = "b05e124f-c7cc-45a0-a6aa-8cf78c946968"
           "SkuPartNumber"                    = "EMSPREMIUM"
           "SubscriptionIds"                  = {"f56a4f3e-0812-4a08-8f08-0499121e842f"}
           "Parameters"                       = $args
          
        } 
    )

}

    Mock -CommandName Get-MgSubscribedSku -MockWith $scriptblock -ModuleName Microsoft.Graph.Entra
}


Describe "Get-EntraSubscribedSku" {
    Context "Test for Get-EntraSubscribedSku" {
        It "Should return specific SubscribedSku" {
            $result = Get-EntraSubscribedSku -ObjectId "d5aec55f-2d12-4442-8d2f-ccca95d4390e_b05e124f-c7cc-45a0-a6aa-8cf78c946968"
            $result | Should -Not -BeNullOrEmpty
	        $result.Id | should -Be "d5aec55f-2d12-4442-8d2f-ccca95d4390e_b05e124f-c7cc-45a0-a6aa-8cf78c946968"		
            
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
         It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraSubscribedSku"
            $result = Get-EntraSubscribedSku -ObjectId "d5aec55f-2d12-4442-8d2f-ccca95d4390e_b05e124f-c7cc-45a0-a6aa-8cf78c946968"
            $params = Get-Parameters -data $result.Parameters
            $params.Headers["User-Agent"] | Should -Be $userAgentHeaderValue
        }

    }   
}
