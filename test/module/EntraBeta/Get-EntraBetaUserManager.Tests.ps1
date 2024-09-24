BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra.Beta) -eq $null){
        Import-Module Microsoft.Graph.Entra.Beta    
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force
    
    $scriptblock = {
        return @(
            [PSCustomObject]@{
                DeletedDateTime                 = ''
                Id                              = '26bb22db-6b8e-4adb-b761-264c869d5245'
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
                imAddresses                     = @('miriamg@m365x99297270.onmicrosoft.com')
                infoCatalogs                    = @{}
                isLicenseReconciliationNeeded   = $false
                isManagementRestricted          = $false
                jobTitle                        = 'Director'
                mail                            = 'MiriamG@M365x99297270.OnMicrosoft.com'
                mailNickname                    = 'MiriamG'
                officeLocation                  = '131/2103'
                otherMails                      = @()
                postalCode                      = '92121'
                proxyAddresses                  = @('SMTP:MiriamG@M365x99297270.OnMicrosoft.com')
                refreshTokensValidFromDateTime  = '2023-07-12T02:36:51Z'
                securityIdentifier              = 'S-1-12-1-649798363-1255893902-1277583799-1163042182'
                signInSessionsValidFromDateTime = '2023-07-12T02:36:51Z'
                state                           = 'CA'
                streetAddress                   = '9255 Towne Center Dr., Suite 400'
                surname                         = 'Graham'
                usageLocation                   = 'NL'
                userPrincipalName               = 'MiriamG@M365x99297270.OnMicrosoft.com'
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
                        servicePlanId      = '2d589a15-b171-4e61-9b5f-31d15eeb2872'
                    }
                )
                authorizationInfo               = @{certificateUserIds = @()}
                cloudRealtimeCommunicationInfo  = @{isSipEnabled = $true}
                deviceKeys                      = @{}
                identities                      = @(
                    @{
                        signInType      = 'userPrincipalName'
                        issuer          = 'M365x99297270.onmicrosoft.com'
                        issuerAssignedId = 'MiriamG@M365x99297270.OnMicrosoft.com'
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
            $result = Get-EntraBetaUserManager -ObjectId "26bb22db-6b8e-4adb-b761-264c869d5245"

            $result | Should -Not -BeNullOrEmpty
            $result.ageGroup | Should -BeNullOrEmpty
            $result.onPremisesLastSyncDateTime | Should -BeNullOrEmpty
            $result.creationType | Should -BeNullOrEmpty
            $result.imAddresses | Should -Be @("miriamg@m365x99297270.onmicrosoft.com")
            $result.preferredLanguage | Should -BeNullOrEmpty
            $result.mail | Should -Be "MiriamG@M365x99297270.OnMicrosoft.com"
            $result.securityIdentifier | Should -Be "S-1-12-1-649798363-1255893902-1277583799-1163042182"
            $result.identities | Should -HaveCount 1
            $result.identities[0].signInType | Should -Be "userPrincipalName"
            $result.identities[0].issuer | Should -Be "M365x99297270.onmicrosoft.com"
            $result.identities[0].issuerAssignedId | Should -Be "MiriamG@M365x99297270.OnMicrosoft.com"

            Should -Invoke -CommandName Get-MgBetaUserManager -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }

        It "Should fail when ObjectId is empty" {
            { Get-EntraBetaUserManager -ObjectId "" } | Should -Throw "Cannot bind argument to parameter 'ObjectId' because it is an empty string."
        }   

        It "Should fail when invalid parameter is passed" {
            { Get-EntraBetaUserManager -Power "abc" } | Should -Throw "A parameter cannot be found that matches parameter name 'Power'*"
        }  

        It "Result should Contain ObjectId" {
            $result = Get-EntraBetaUserManager -ObjectId "26bb22db-6b8e-4adb-b761-264c869d5245"
            $result.ObjectId | should -Be "26bb22db-6b8e-4adb-b761-264c869d5245"
        }     

        It "Should contain UserId in parameters when passed ObjectId to it" {              
            $result = Get-EntraBetaUserManager -ObjectId "26bb22db-6b8e-4adb-b761-264c869d5245"
            $params = Get-Parameters -data $result.Parameters
            $params.UserId | Should -Be "26bb22db-6b8e-4adb-b761-264c869d5245"
        }

        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraBetaUserManager"

            $result = Get-EntraBetaUserManager -ObjectId "26bb22db-6b8e-4adb-b761-264c869d5245"
            $params = Get-Parameters -data $result.Parameters

            $params.Headers."User-Agent" | Should -Be $userAgentHeaderValue
        }
    
    }
}