# ------------------------------------------------------------------------------ 
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  
#  Licensed under the MIT License.  See License in the project root for license information. 
# ------------------------------------------------------------------------------ 
function New-EntraBetaUser {
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("PSAvoidUsingUserNameAndPassWordParams", "", Scope = "Function", Target = "*")]
    [CmdletBinding(DefaultParameterSetName = 'CreateUser')]
    param (                
        [Parameter(ParameterSetName = "CreateUser", HelpMessage = "The state or province in the user's address. Maximum length is 128 characters.")]
        [System.String] $State,
                
        [Parameter(ParameterSetName = "CreateUser", HelpMessage = "The user's fax number.")]
        [Alias('FacsimileTelephoneNumber', 'Fax')]
        [System.String] $FaxNumber,
                
        [Parameter(ParameterSetName = "CreateUser", HelpMessage = "The type of user (e.g., Member, Guest).")]
        [System.String] $UserType,
                
        [Parameter(ParameterSetName = "CreateUser", HelpMessage = "The user's preferred language (e.g., en-US).")]
        [System.String] $PreferredLanguage,
                
        [Parameter(ParameterSetName = "CreateUser", HelpMessage = "The street address of the user's place of business. Maximum length is 1,024 characters.")]
        [System.String] $StreetAddress,
                
        [Parameter(ParameterSetName = "CreateUser", HelpMessage = "Indicates how the user was created (e.g., LocalAccount, Invitation).")]
        [System.String] $CreationType,
                
        [Parameter(ParameterSetName = "CreateUser", HelpMessage = "Immutable identifier for the user from on-premises directory.")]
        [System.String] $ImmutableId,
                
        [Parameter(ParameterSetName = "CreateUser", HelpMessage = "The user's company name, useful for identifying a guest's organization. Maximum length: 64 characters.")]
        [System.String] $CompanyName,
                
        [Parameter(ParameterSetName = "CreateUser", HelpMessage = "The user's postal code, specific to their country or region (ZIP code in the U.S.). Maximum length: 40 characters.")]
        [System.String] $PostalCode,
                
        [Parameter(ParameterSetName = "CreateUser", Mandatory = $true, HelpMessage = "The display name of the user.")]
        [ValidateNotNullOrEmpty()]
        [System.String] $DisplayName,
                
        [Parameter(ParameterSetName = "CreateUser", HelpMessage = "Indicates if consent was obtained for minors. Values: null, Granted, Denied, or NotRequired.")]
        [System.String] $ConsentProvidedForMinor,
                
        [Parameter(ParameterSetName = "CreateUser", HelpMessage = "The user's department.")]
        [System.String] $Department,
                
        [Parameter(ParameterSetName = "CreateUser", HelpMessage = "The user's mobile phone number.")]
        [System.String] $Mobile,
                
        [Parameter(ParameterSetName = "CreateUser", HelpMessage = "Timestamp of the most recent change to the *externalUserState* property.")]
        [Alias('UserStateChangedOn')]
        [System.String] $ExternalUserStateChangeDateTime,
                
        [Parameter(ParameterSetName = "CreateUser", HelpMessage = "The given name (first name) of the user. Maximum length is 64 characters.")]
        [System.String] $GivenName,
                
        [Parameter(ParameterSetName = "CreateUser", HelpMessage = "The user's country or region; for example, US or UK. Maximum length is 128 characters.")]
        [System.String] $Country,
                
        [Parameter(ParameterSetName = "CreateUser", HelpMessage = "Set password policies like DisableStrongPassword or DisablePasswordExpiration. You can use both, separated by a comma.")]
        [System.String] $PasswordPolicies,
                
        [Parameter(ParameterSetName = "CreateUser", Mandatory = $true, HelpMessage = "Defines the user's password profile. Required when creating a user. The password must meet the policy requirements-strong by default.")]
        [ValidateNotNullOrEmpty()]
        [Microsoft.Open.AzureAD.Model.PasswordProfile] $PasswordProfile,
                
        [Parameter(ParameterSetName = "CreateUser", HelpMessage = "The user's mail alias. Required when creating a user. Maximum length: 64 characters.")]
        [System.String] $MailNickName,
                
        [Parameter(ParameterSetName = "CreateUser", HelpMessage = "The user's job title. Maximum length: 128 characters.")]
        [System.String] $JobTitle,
                
        [Parameter(ParameterSetName = "CreateUser", HelpMessage = "The user's external state for invited guest users (e.g., PendingAcceptance, Accepted).")]
        [Alias('UserState')]
        [System.String] $ExternalUserState,
                
        [Parameter(ParameterSetName = "CreateUser", HelpMessage = "The user's city location. Maximum length: 128 characters.")]
        [System.String] $City,
                
        [Parameter(ParameterSetName = "CreateUser", HelpMessage = "A two-letter country code (ISO 3166). Required for licensed users to verify service availability. Examples: US, JP, GB.")]
        [System.String] $UsageLocation,
                
        [Parameter(ParameterSetName = "CreateUser", HelpMessage = "The user's surname (last name). Maximum length: 64 characters.")]
        [System.String] $Surname,
                
        [Parameter(ParameterSetName = "CreateUser", HelpMessage = "A list of the user’s additional email addresses (e.g., ['bob@contoso.com', 'Robert@fabrikam.com']). Supports up to 250 entries, each up to 250 characters.")]
        [System.Collections.Generic.List`1[System.String]] $OtherMails,
                
        [Parameter(ParameterSetName = "CreateUser", HelpMessage = "The user's sign-in name (UPN) in the format alias@domain. It should match the user's email and use a verified domain in the tenant.")]
        [Alias('UPN')]
        [ValidateNotNullOrEmpty()]
        [ValidateScript({
                try {
                    $null = [System.Net.Mail.MailAddress]$_
                    return $true
                }
                catch {
                    throw "UserPrincipalName must be a valid email address."
                }
            })]
        [System.String] $UserPrincipalName,
                
        [Parameter(ParameterSetName = "CreateUser", HelpMessage = "The user's phone number. Only one number is allowed. Read-only for users synced from on-premises.")]
        [Alias('TelephoneNumber')]
        [System.String] $BusinessPhones,
                
        [Parameter(ParameterSetName = "CreateUser", HelpMessage = "Sets the user's age group. Options: null, Minor, NotAdult, or Adult.")]
        [System.String] $AgeGroup,
                
        [Parameter(ParameterSetName = "CreateUser", Mandatory = $true, HelpMessage = "Indicates if the account is active. Required when creating a user.")]
        [System.Nullable`1[System.Boolean]] $AccountEnabled,
                
        [Parameter(ParameterSetName = "CreateUser", HelpMessage = "Represents the identities that can be used to sign in to this user account. Microsoft (also known as a local account), organizations, or social identity providers such as Facebook, Google, and Microsoft can provide identity and tie it to a user account. It might contain multiple items with the same signInType value.")]
        [Alias('SignInNames')]
        [System.Collections.Generic.List`1[Microsoft.Open.AzureAD.Model.SignInName]] $Identities
    )

    begin {
        # Ensure connection to Microsoft Entra
        if (-not (Get-EntraContext)) {
            $errorMessage = "Not connected to Microsoft Graph. Use 'Connect-Entra -Scopes User.ReadWrite.All' to authenticate."
            Write-Error -Message $errorMessage -ErrorAction Stop
            return
        }
    }

    PROCESS {
        $params = @{}
        $customHeaders = New-EntraBetaCustomHeaders -Command $MyInvocation.MyCommand
        if ($null -ne $PSBoundParameters["PostalCode"]) {
            $params["PostalCode"] = $PSBoundParameters["PostalCode"]
        }
        if ($null -ne $PSBoundParameters["MailNickName"]) {
            $params["MailNickName"] = $PSBoundParameters["MailNickName"]
        }
        if ($null -ne $PSBoundParameters["DisplayName"]) {
            $params["DisplayName"] = $PSBoundParameters["DisplayName"]
        }
        if ($null -ne $PSBoundParameters["Mobile"]) {
            $params["MobilePhone"] = $PSBoundParameters["Mobile"]
        }
        if ($null -ne $PSBoundParameters["JobTitle"]) {
            $params["JobTitle"] = $PSBoundParameters["JobTitle"]
        }
        if ($null -ne $PSBoundParameters["ConsentProvidedForMinor"]) {
            $params["ConsentProvidedForMinor"] = $PSBoundParameters["ConsentProvidedForMinor"]
        }
        if ($null -ne $PSBoundParameters["OtherMails"]) {
            $params["OtherMails"] = $PSBoundParameters["OtherMails"]
        }
        if ($null -ne $PSBoundParameters["PasswordPolicies"]) {
            $params["PasswordPolicies"] = $PSBoundParameters["PasswordPolicies"]
        }
        if ($null -ne $PSBoundParameters["Identities"]) {
            $params["Identities"] = $PSBoundParameters["Identities"]
        }
        if ($null -ne $PSBoundParameters["PreferredLanguage"]) {
            $params["PreferredLanguage"] = $PSBoundParameters["PreferredLanguage"]
        }
        if ($null -ne $PSBoundParameters["ExternalUserState"]) {
            $params["ExternalUserState"] = $PSBoundParameters["ExternalUserState"]
        }
        if ($null -ne $PSBoundParameters["ImmutableId"]) {
            $params["OnPremisesImmutableId"] = $PSBoundParameters["ImmutableId"]
        }
        if ($null -ne $PSBoundParameters["City"]) {
            $params["City"] = $PSBoundParameters["City"]
        }
        if ($null -ne $PSBoundParameters["AgeGroup"]) {
            $params["AgeGroup"] = $PSBoundParameters["AgeGroup"]
        }
        if ($null -ne $PSBoundParameters["UsageLocation"]) {
            $params["UsageLocation"] = $PSBoundParameters["UsageLocation"]
        }
        if ($null -ne $PSBoundParameters["ExternalUserStateChangeDateTime"]) {
            $params["ExternalUserStateChangeDateTime"] = $PSBoundParameters["ExternalUserStateChangeDateTime"]
        }
        if ($null -ne $PSBoundParameters["AccountEnabled"]) {
            $params["AccountEnabled"] = $PSBoundParameters["AccountEnabled"]
        }
        if ($null -ne $PSBoundParameters["Country"]) {
            $params["Country"] = $PSBoundParameters["Country"]
        }
        if ($null -ne $PSBoundParameters["UserPrincipalName"]) {
            $params["UserPrincipalName"] = $PSBoundParameters["UserPrincipalName"]
        }
        if ($null -ne $PSBoundParameters["GivenName"]) {
            $params["GivenName"] = $PSBoundParameters["GivenName"]
        }
        if ($null -ne $PSBoundParameters["PasswordProfile"]) {
            $TmpValue = $PSBoundParameters["PasswordProfile"]
            $Value = @{
                forceChangePasswordNextSignIn        = $TmpValue.ForceChangePasswordNextLogin
                forceChangePasswordNextSignInWithMfa = $TmpValue.EnforceChangePasswordPolicy
                password                             = $TmpValue.Password 
            }
            $params["passwordProfile"] = $Value
        }
        if ($null -ne $PSBoundParameters["UserType"]) {
            $params["UserType"] = $PSBoundParameters["UserType"]
        }
        if ($null -ne $PSBoundParameters["StreetAddress"]) {
            $params["StreetAddress"] = $PSBoundParameters["StreetAddress"]
        }
        if ($null -ne $PSBoundParameters["State"]) {
            $params["State"] = $PSBoundParameters["State"]
        }
        if ($null -ne $PSBoundParameters["Department"]) {
            $params["Department"] = $PSBoundParameters["Department"]
        }
        if ($null -ne $PSBoundParameters["CompanyName"]) {
            $params["CompanyName"] = $PSBoundParameters["CompanyName"]
        }
        if ($null -ne $PSBoundParameters["FaxNumber"]) {
            $params["faxNumber"] = $PSBoundParameters["FaxNumber"]
        }
        if ($null -ne $PSBoundParameters["Surname"]) {
            $params["Surname"] = $PSBoundParameters["Surname"]
        }
        if ($null -ne $PSBoundParameters["BusinessPhones"]) {
            $params["BusinessPhones"] = @($PSBoundParameters["BusinessPhones"])
        }
        if ($null -ne $PSBoundParameters["CreationType"]) {
            $params["CreationType"] = $PSBoundParameters["CreationType"]
        }
    
        Write-Debug("============================ TRANSFORMATIONS ============================")
        $params.Keys | ForEach-Object { "$_ : $($params[$_])" } | Write-Debug
        Write-Debug("=========================================================================`n")
        $params = $params | ConvertTo-Json
        $response = Invoke-GraphRequest -Headers $customHeaders -Uri '/beta/users?$select=*' -Method POST -Body $params
        $response = $response | ConvertTo-Json | ConvertFrom-Json
        $response | ForEach-Object {
            if ($null -ne $_) {
                Add-Member -InputObject $_ -MemberType AliasProperty -Name ObjectId -Value Id
                Add-Member -InputObject $_ -MemberType AliasProperty -Name UserState -Value ExternalUserState
                Add-Member -InputObject $_ -MemberType AliasProperty -Name UserStateChangedOn -Value ExternalUserStateChangeDateTime
                Add-Member -InputObject $_ -MemberType AliasProperty -Name Mobile -Value mobilePhone
                Add-Member -InputObject $_ -MemberType AliasProperty -Name DeletionTimestamp -Value DeletedDateTime
                Add-Member -InputObject $_ -MemberType AliasProperty -Name DirSyncEnabled -Value OnPremisesSyncEnabled
                Add-Member -InputObject $_ -MemberType AliasProperty -Name ImmutableId -Value onPremisesImmutableId
                Add-Member -InputObject $_ -MemberType AliasProperty -Name LastDirSyncTime -Value OnPremisesLastSyncDateTime
                Add-Member -InputObject $_ -MemberType AliasProperty -Name ProvisioningErrors -Value onPremisesProvisioningErrors
                Add-Member -InputObject $_ -MemberType AliasProperty -Name TelephoneNumber -Value BusinessPhones
                
                $userData = [Microsoft.Graph.Beta.PowerShell.Models.MicrosoftGraphUser]::new()
                $_.PSObject.Properties | ForEach-Object {
                    $userData | Add-Member -MemberType NoteProperty -Name $_.Name -Value $_.Value -Force
                }
            }
        }        
        $userData
    }      
}

