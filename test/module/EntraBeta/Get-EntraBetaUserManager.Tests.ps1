BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra.Beta) -eq $null){
        Import-Module Microsoft.Graph.Entra.Beta    
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force
    
    $scriptblock = {
        return @(
            [PSCustomObject]@{
                DeletedDateTime                 = ''
                Id                              = 'aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb'
                '@odata.context'                = 'https://graph.microsoft.com/beta/$metadata#directoryObjects/$entity'
                '@odata.type'                   = '#microsoft.graph.user'
                accountEnabled                  = $true
                businessPhones                  = @('+1 858 555 0109')
                city                            = 'San Diego'
                createdDateTime                 = '2023-07-07T14:18:05Z'
                country                         = 'United States'
                department                      = 'Sales & Marketing'
                displayName                     = 'Miriam Graham'
                givenName                       = 'Miriam'
                imAddresses                     = @('miriamg@contoso.com')
                infoCatalogs                    = @{}
                isLicenseReconciliationNeeded   = $false
                isManagementRestricted          = $false
                jobTitle                        = 'Director'
                mail                            = 'MiriamG@contoso.com'
                mailNickname                    = 'MiriamG'
                officeLocation                  = '131/2103'
                otherMails                      = @()
                postalCode                      = '92121'
                proxyAddresses                  = @('SMTP:MiriamG@contoso.com')
                refreshTokensValidFromDateTime  = '2023-07-12T02:36:51Z'
                securityIdentifier              = 'S-1-12-1-649798363-1255893902-1277583799-1163042182'
                signInSessionsValidFromDateTime = '2023-07-12T02:36:51Z'
                state                           = 'CA'
                streetAddress                   = '9255 Towne Center Dr., Suite 400'
                surname                         = 'Graham'
                usageLocation                   = 'NL'
                userPrincipalName               = 'MiriamG@contoso.com'
                userType                        = 'Member'
                assignedLicenses                = @(
                    @{
                        disabledPlans = @()
                        skuId = '6a0f6da5-0b87-4190-a6ae-9bb5a2b9546a'
                    }
                )
                assignedPlans                   = @(
                    @{
                        assignedDateTime   = '2023-07-07T14:18:07Z'
                        capabilityStatus   = 'Enabled'
                        service            = 'ProcessSimple'
                        servicePlanId      = 'aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb'
                    }
                )
                authorizationInfo               = @{certificateUserIds = @()}
                cloudRealtimeCommunicationInfo  = @{isSipEnabled = $true}
                deviceKeys                      = @{}
                identities                      = @(
                    @{
                        signInType      = 'userPrincipalName'
                        issuer          = 'contoso.com'
                        issuerAssignedId = 'MiriamG@contoso.com'
                    }
                )
                onPremisesExtensionAttributes   = @{}
                onPremisesProvisioningErrors    = @{}
                onPremisesSipInfo               = @{isSipEnabled = $false}
                provisionedPlans                = @(
                    @{
                        capabilityStatus    = 'Enabled'
                        provisioningStatus  = 'Success'
                        service             = 'SharePoint'
                    }
                )
                serviceProvisioningErrors       = @{}
                AdditionalProperties            = @{
                    test = 'data'
                }
                Parameters                 = $args
            }
        )
    }

    Mock -CommandName Get-MgBetaUserManager -MockWith $scriptblock -ModuleName Microsoft.Graph.Entra.Beta
}
  
Describe "Get-EntraBetaUserManager" {
    Context "Test for Get-EntraBetaUserManager" {
        It "Should return specific user manager" {
            $result = Get-EntraBetaUserManager -ObjectId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
            $result | Should -Not -BeNullOrEmpty            
            $result.mail | Should -Be "MiriamG@contoso.com"
            $result.securityIdentifier | Should -Be "S-1-12-1-649798363-1255893902-1277583799-1163042182"
            $result.identities | Should -HaveCount 1
            $result.identities[0].signInType | Should -Be "userPrincipalName"
            $result.identities[0].issuer | Should -Be "contoso.com"
            $result.identities[0].issuerAssignedId | Should -Be "MiriamG@contoso.com"

            Should -Invoke -CommandName Get-MgBetaUserManager -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }

        It "Should fail when ObjectId is empty" {
            { Get-EntraBetaUserManager -ObjectId "" } | Should -Throw "Cannot bind argument to parameter 'ObjectId' because it is an empty string."
        }   

        It "Should fail when invalid parameter is passed" {
            { Get-EntraBetaUserManager -Power "abc" } | Should -Throw "A parameter cannot be found that matches parameter name 'Power'*"
        }  

        It "Result should Contain ObjectId" {
            $result = Get-EntraBetaUserManager -ObjectId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
            $result.Id | should -Be "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
        }     

        It "Should contain UserId in parameters when passed ObjectId to it" {              
            $result = Get-EntraBetaUserManager -ObjectId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
            $params = Get-Parameters -data $result.Parameters
            $params.UserId | Should -Be "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
        }

        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraBetaUserManager"

            $result = Get-EntraBetaUserManager -ObjectId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
            $params = Get-Parameters -data $result.Parameters

            $params.Headers."User-Agent" | Should -Be $userAgentHeaderValue
        }
        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraBetaUserManager"
            $result = Get-EntraBetaUserManager -ObjectId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
            $result | Should -Not -BeNullOrEmpty
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraBetaUserManager"
            Should -Invoke -CommandName Get-MgBetaUserManager -ModuleName Microsoft.Graph.Entra.Beta -Times 1 -ParameterFilter {
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
                { Get-EntraBetaUserManager -ObjectId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -Debug } | Should -Not -Throw
            } finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        }
    
    }
}