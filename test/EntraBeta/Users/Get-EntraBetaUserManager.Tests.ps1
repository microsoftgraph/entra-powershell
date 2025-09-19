BeforeAll {  
    if ((Get-Module -Name Microsoft.Entra.Beta.Users) -eq $null) {
        Import-Module Microsoft.Entra.Beta.Users    
    }
    Import-Module (Join-Path $PSScriptRoot "..\..\Common-Functions.ps1") -Force
    
    $scriptblock = {
        return @(
            [PSCustomObject]@{
                DeletedDateTime                 = ''
                Id                              = 'aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb'
                '@odata.context'                = 'https://graph.microsoft.com/beta/`$metadata#directoryObjects/`$entity'
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
                onPremisesLastSyncDateTime      = $null
                preferredLanguage               = $null
                ageGroup                        = $null
                creationType                    = $null
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
                        skuId         = '6a0f6da5-0b87-4190-a6ae-9bb5a2b9546a'
                    }
                )
                assignedPlans                   = @(
                    @{
                        assignedDateTime = '2023-07-07T14:18:07Z'
                        capabilityStatus = 'Enabled'
                        service          = 'ProcessSimple'
                        servicePlanId    = 'aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb'
                    }
                )
                authorizationInfo               = @{certificateUserIds = @() }
                cloudRealtimeCommunicationInfo  = @{isSipEnabled = $true }
                deviceKeys                      = @{}
                identities                      = @(
                    @{
                        signInType       = 'userPrincipalName'
                        issuer           = 'contoso.com'
                        issuerAssignedId = 'MiriamG@contoso.com'
                    }
                )
                onPremisesExtensionAttributes   = @{}
                onPremisesProvisioningErrors    = @{}
                onPremisesSipInfo               = @{isSipEnabled = $false }
                provisionedPlans                = @(
                    @{
                        capabilityStatus   = 'Enabled'
                        provisioningStatus = 'Success'
                        service            = 'SharePoint'
                    }
                )
                serviceProvisioningErrors       = @{}
                AdditionalProperties            = @{
                    test = 'data'
                }
                Parameters                      = $args
            }
        )
    }

    Mock -CommandName Get-MgBetaUserManager -MockWith $scriptblock -ModuleName Microsoft.Entra.Beta.Users
    Mock -CommandName Get-EntraContext -MockWith { @{Scopes = @("User.Read.All") } } -ModuleName Microsoft.Entra.Beta.Users
}
  
Describe "Get-EntraBetaUserManager" {
    Context "Test for Get-EntraBetaUserManager" {
        It "Should throw when not connected and not invoke SDK" {
            Mock -CommandName Get-EntraContext -MockWith { $null } -ModuleName Microsoft.Entra.Beta.Users
            { Get-EntraBetaUserManager -UserId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" } | Should -Throw "Not connected to Microsoft Graph*"
            Should -Invoke -CommandName Get-MgBetaUserManager -ModuleName Microsoft.Entra.Beta.Users -Times 0
        }
        
        It "Should return specific user manager" {
            $result = Get-EntraBetaUserManager -UserId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"

            $result | Should -Not -BeNullOrEmpty
            $result.ageGroup | Should -BeNullOrEmpty
            $result.onPremisesLastSyncDateTime | Should -BeNullOrEmpty
            $result.creationType | Should -BeNullOrEmpty
            $result.imAddresses | Should -Be @("miriamg@contoso.com")
            $result.preferredLanguage | Should -BeNullOrEmpty
            $result.mail | Should -Be "MiriamG@contoso.com"
            $result.securityIdentifier | Should -Be "S-1-12-1-649798363-1255893902-1277583799-1163042182"
            $result.identities | Should -HaveCount 1
            $result.identities[0].signInType | Should -Be "userPrincipalName"
            $result.identities[0].issuer | Should -Be "contoso.com"
            $result.identities[0].issuerAssignedId | Should -Be "MiriamG@contoso.com"

            Should -Invoke -CommandName Get-MgBetaUserManager -ModuleName Microsoft.Entra.Beta.Users -Times 1
        } 

        It "Should fail when invalid parameter is passed" {
            { Get-EntraBetaUserManager -Power "abc" } | Should -Throw "A parameter cannot be found that matches parameter name 'Power'*"
        }  

        It "Result should Contain ObjectId" {
            $result = Get-EntraBetaUserManager -UserId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
            $result.Id | should -Be "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
        }     

        It "Should contain UserId in parameters when passed ObjectId to it" {              
            $result = Get-EntraBetaUserManager -UserId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
            $params = Get-Parameters -data $result.Parameters
            $params.UserId | Should -Be "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
        }
        It "Should return append specified properties to the default properties" {
            $scriptblock = {
                return @(
                    [PSCustomObject]@{
                        "DisplayName"            = "Sawyer Miller"
                        "Id"                     = "dddddddd-3333-4444-5555-eeeeeeeeeeee"
                        "UserPrincipalName"      = "SawyerM@contoso.com"
                        "OnPremisesImmutableId"  = "eeeeeeee-4444-5555-6666-ffffffffffff"
                        "CreatedDateTime"        = "2023-01-01T00:00:00Z"
                        "DeletedDateTime"        = $null
                        "AdditionalProperties"   = @{
                            "@odata.type"  = "#microsoft.graph.user"
                            accountEnabled = $true
                        }
                    }
                )
            }

            Mock -CommandName Get-MgBetaUserManager -MockWith $scriptblock -ModuleName Microsoft.Entra.Beta.Users
            $result = Get-EntraBetaUserManager -UserId "aaaaaaaa-1111-2222-3333-cccccccccccc" -Property onPremisesImmutableId,Id -AppendSelected
            $result.Id | should -Be "dddddddd-3333-4444-5555-eeeeeeeeeeee"
            $result.OnPremisesImmutableId | should -Be "eeeeeeee-4444-5555-6666-ffffffffffff"
        }
        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraBetaUserManager"
            $result = Get-EntraBetaUserManager -UserId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
            $result | Should -Not -BeNullOrEmpty
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraBetaUserManager"
            Should -Invoke -CommandName Get-MgBetaUserManager -ModuleName Microsoft.Entra.Beta.Users -Times 1 -ParameterFilter {
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
                { Get-EntraBetaUserManager -UserId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -Debug } | Should -Not -Throw
            }
            finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        }
    
    }
}

