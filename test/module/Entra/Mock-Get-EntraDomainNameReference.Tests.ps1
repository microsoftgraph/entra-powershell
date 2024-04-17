BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra) -eq $null){
        
        Import-Module Microsoft.Graph.Entra      
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force
$scriptblock = @{
        value = @(
            @{
           "Id"                               = "996d39aa-fdac-4d97-aa3d-c81fb47362ac" 
           "State"                            = ""
           "displayName"                      = "Mock-app"
           "mailNickname"                     = "Mock-app"
           "accountEnabled"                   = $True
           "userPrincipalName"                = "mock.mail.onmicrosoft.com"
           "api"                              = @{knownClientApplications=""; requestedAccessTokenVersion=2; preAuthorizedApplications=""; oauth2PermissionScopes="";acceptMappedClaims=""}
           "onPremisesImmutableId"            = $null
           "deletedDateTime"                  = $null
           "onPremisesSyncEnabled"            = $null
           "mobilePhone"                      = "425-555-0101"
           "onPremisesProvisioningErrors"     = @{}
           "businessPhones"                   = {"425-555-0100"}
           "externalUserState"                = $null
           "externalUserStateChangeDate"      = $null
           "createdDateTime"                  = "29-02-2024 13:49:47"
           "signInSessionsValidFromDateTime"  = "29-02-2024 13:51:05"
           "identities"                       = {@{signInType=userPrincipalName; issuer=""; issuerAssignedId=""}}
           "info"                             = @{marketingUrl=""; privacyStatementUrl=""; termsOfServiceUrl=""; logoUrl=""; supportUrl=""}
           "assignedPlans"                    = @{servicePlanId="8ba1ff15-7bf6-4620-b65c-ecedb6942766"; service="D365SalesProductivityProvisioning"; capabilityStatus="Deleted"; assignedDateTime="26-10-2023 14:40:16"}
           "Parameters"                       = $args
            }
        )
    }
    
    Mock -CommandName Invoke-GraphRequest -MockWith { $scriptblock } -ModuleName Microsoft.Graph.Entra

}


# Describe "Get-EntraDomainNameReference" {
#     Context "Test for Get-EntraDomainNameReference" {
#         It "Should return specific domain Name Reference" {
#             $result = Get-EntraDomainNameReference -Name "M365x99297270.mail.onmicrosoft.com"
#             Write-Host $result
#             $result | Should -Not -BeNullOrEmpty
#             $result.Id | should -Be '996d39aa-fdac-4d97-aa3d-c81fb47362ac'

#             Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Graph.Entra -Times 1
#         }



#     }

# }    