BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra) -eq $null){
        
        Import-Module Microsoft.Graph.Entra      
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force

$scriptblock = {
    return @(
        [PSCustomObject]@{
           "Id"                               = "d5aec55f-2d12-4442-8d2f-ccca95d4390e" 
           "OnPremisesLastSyncDateTime"       = $null
           "OnPremisesSyncEnabled"            = $null
           "BusinessPhones"                   = {"425-555-0100"}
           "City"                             = "Luchthaven Schiphol"
           "DisplayName"                      = "Mock App"
           "MarketingNotificationEmails"      = {"mary@contoso.com", "john@contoso.com"}
           "State"                            = "Noord-Holland"
           "Street"                           = "Evert van de Beekstraat 354"
           "TechnicalNotificationMails"       = {"peter@contoso.com"}
           "TenantType"                       = "AAD"
           "AssignedPlans"                    = @{AssignedDateTime="04-12-2023 16:50:27"; CapabilityStatus="Enabled"; Service="MixedRealityCollaborationServices"; ServicePlanId="dcf9d2f4-772e-4434-b757-77a453cfbc02";
                                                    AdditionalProperties=""}
           "ProvisionedPlans"                 = @{CapabilityStatus="Enabled"; ProvisioningStatus="Success"; Service="exchange"; AdditionalProperties=""}
           "VerifiedDomains"                  = @{Capabilities="Email"; IsDefault="False"; IsInitial="True"; Name="M365x99297270.onmicrosoft.com"; Type="Managed"; AdditionalProperties=""}                                   
           "PrivacyProfile"                   = @{ContactEmail="alice@contoso.com"; StatementUrl="https://contoso.com/privacyStatement"; AdditionalProperties=""}
           "Parameters"                       = $args
          
        } 
    )

}

    Mock -CommandName Get-MgOrganization -MockWith $scriptblock -ModuleName Microsoft.Graph.Entra
}


Describe "Get-EntraTenantDetail" {
    Context "Test for Get-EntraTenantDetail" {
        It "Should return all Tenant Detail" {
            $result = Get-EntraTenantDetail -All $true
            $result | Should -Not -BeNullOrEmpty
            
            Should -Invoke -CommandName Get-MgOrganization -ModuleName Microsoft.Graph.Entra -Times 1
        }   
        It "Should fail when All is empty" {
            { Get-EntraTenantDetail -All  } | Should -Throw "Missing an argument for parameter 'All'*"
        }
        It "Should fail when All is invalid" {
            { Get-EntraTenantDetail -All "xyz" } | Should -Throw "Cannot process argument transformation on parameter 'All'*"
        }
        It "Should return top Tenant Detail" {
            $result = Get-EntraTenantDetail -Top 1
            $result | Should -Not -BeNullOrEmpty
            
            Should -Invoke -CommandName Get-MgOrganization -ModuleName Microsoft.Graph.Entra -Times 1
        }   
        It "Should fail when Top is empty" {
            { Get-EntraTenantDetail -Top  } | Should -Throw "Missing an argument for parameter 'Top'*"
        }
        It "Should fail when Top is invalid" {
            { Get-EntraTenantDetail -Top "xyz" } | Should -Throw "Cannot process argument transformation on parameter 'Top'*"
        }
        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraTenantDetail"
            $result = Get-EntraTenantDetail -Top 1
            $params = Get-Parameters -data $result.Parameters
            $params.Headers["User-Agent"] | Should -Be $userAgentHeaderValue
        }

    }   
}
