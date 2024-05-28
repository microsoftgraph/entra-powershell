BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra.Beta) -eq $null){
        Import-Module Microsoft.Graph.Entra.Beta    
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force

    $scriptblock = {
        return @(
            [PSCustomObject]@{
                "ReferenceId"       = "ProfileEdit"
                "Id"                    = "PolicyProfile"
                "displayName"           = "PolicyProfile123"
                "PolicyId" = "B2C_1A_TrustFrameworkExtensions"
                "TenantId"                  = "intelucre.onmicrosoft.com"
                "Parameters"            = $args
            }
        )
    }
    
    # $mockResponse = {
    #     return @(
    #        "XMl" = "<TrustFrameworkPolicy xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns="http://schemas.microsoft.com/online/cpim/schemas/2013/06" PolicySchemaVersion="0.3.0.0" TenantId="intelucre.onmicrosoft.com" PolicyId="B2C_1A_ProfileAdd" PublicPolicyUri="http://intelucre.onmicrosoft.com/B2C_1A_ProfileAdd" TenantObjectId="5737bf45-194f-4bc5-b209-bbbbadb4641a">
    #         <BasePolicy>
    #           <TenantId></TenantId>
    #           <PolicyId>B2C_1A_TrustFrameworkExtensions</PolicyId>
    #         </BasePolicy>
    #         <RelyingParty>
    #           <DefaultUserJourney ReferenceId="ProfileEdit" />
    #           <TechnicalProfile Id="PolicyProfile">
    #             <DisplayName>PolicyProfile123</DisplayName>
    #             <Protocol Name="OpenIdConnect" />
    #             <OutputClaims>
    #               <OutputClaim ClaimTypeReferenceId="objectId" PartnerClaimType="sub" />
    #               <OutputClaim ClaimTypeReferenceId="tenantId" AlwaysUseDefaultValue="true" DefaultValue="{Policy:TenantObjectId}" />
    #             </OutputClaims>
    #             <SubjectNamingInfo ClaimType="sub" />
    #           </TechnicalProfile>
    #         </RelyingParty>
    #       </TrustFrameworkPolicy>"
    #     )
    # }
    Mock -CommandName  Invoke-GraphRequest -MockWith $scriptblock -ModuleName Microsoft.Graph.Entra.Beta
}

Describe "Get-EntraBetaMSTrustFrameworkPolicy" {
    Context "Test for Get-EntraBetaMSTrustFrameworkPolicy" {
        It "Should retrieve the created trust framework policies (custom policies) in the directory." {
            $result = Get-EntraBetaMSTrustFrameworkPolicy -Id "B2C_1A_PROFILEADD"
            Write-Host ($result | ConvertTo-Json)
            $result | Should -Not -BeNullOrEmpty
            
            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }

        It "Should fail when Id is empty" {
            { Get-EntraBetaMSTrustFrameworkPolicy -Id } | Should -Throw "Missing an argument for parameter 'Id'*"
        }

        It "Should fail when Id is invalid" {
            { Get-EntraBetaMSTrustFrameworkPolicy -Id "" } | Should -Throw "Cannot bind argument to parameter 'Id' because it is an empty string."
        }

        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraBetaMSTrustFrameworkPolicy"

            $result = Get-EntraBetaMSTrustFrameworkPolicy -Id "B2C_1A_PROFILEADD"
            $params = Get-Parameters -data $result.Parameters
            $params.Headers["User-Agent"] | Should -Contain $userAgentHeaderValue
        }    
    }
}