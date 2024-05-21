BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra) -eq $null){
        Import-Module Microsoft.Graph.Entra        
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force

    $scriptblock = {
        return @(
            [PSCustomObject]@{
                   "PrepaidUnits"     = @{Enabled=20;LockedOut= 0; Suspended= 0;Warning =0}
                   "Id"               = "d5aec55f-2d12-4442-8d2f-ccca95d4390e_b05e124f-c7cc-45a0-a6aa-8cf78c946968"
                   "ConsumedUnits"    = "20"
                   "AccountName"      = "M365x99297270"
                   "CapabilityStatus" = "Enabled"
                   "AccountId"        = "d5aec55f-2d12-4442-8d2f-ccca95d4390e"
                   "AppliesTo"        = "User"
                   "Parameters"       = $args
            }
        )
    }    
    Mock -CommandName Get-MgSubscribedSku -MockWith $scriptblock -ModuleName Microsoft.Graph.Entra
}

Describe "Get-EntraAccountSku" {
    Context "Test for Get-EntraAccountSku" {
        It "Returns all the SKUs for a company." {
            $result = Get-EntraAccountSku -TenantId "d5aec55f-2d12-4442-8d2f-ccca95d4390e"
            $result | Should -Not -BeNullOrEmpty
            $result.Id | should -Be "d5aec55f-2d12-4442-8d2f-ccca95d4390e_b05e124f-c7cc-45a0-a6aa-8cf78c946968"
            $result.ConsumedUnits | should -Be "20"
            $result.AccountName | should -Be "M365x99297270"
            $result.CapabilityStatus | should -Be "Enabled"
            $result.AccountId | should -Be "d5aec55f-2d12-4442-8d2f-ccca95d4390e"
            $result.AppliesTo | should -Be "User"

            Should -Invoke -CommandName Get-MgSubscribedSku -ModuleName Microsoft.Graph.Entra -Times 1
        }
        It "Should fail when TenantId is empty" {
            { Get-EntraAccountSku -TenantId } | Should -Throw "Missing an argument for parameter 'TenantId'*"
        }
        It "Should fail when TenantId is invalid" {
            { Get-EntraAccountSku -TenantId "" } | Should -Throw "Cannot process argument transformation on parameter 'TenantId'.*"
        }
       
        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraAccountSku"
            $result = Get-EntraAccountSku -TenantId "d5aec55f-2d12-4442-8d2f-ccca95d4390e"
            $params = Get-Parameters -data $result.Parameters
            $params.Headers["User-Agent"] | Should -Be $userAgentHeaderValue
        }
    }
}