# ------------------------------------------------------------------------------ 
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  
#  Licensed under the MIT License.  See License in the project root for license information. 
# ------------------------------------------------------------------------------ 
function Set-EntraUser {
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("PSAvoidUsingUserNameAndPassWordParams", "", Scope = "Function", Target = "*")]
    [CmdletBinding(DefaultParameterSetName = 'Default')]
    param (
        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = "The unique identifier for the user, such as their object ID or user principal name.")]
        [Alias('ObjectId', 'UPN', 'Identity', 'Id')]
        [ValidateNotNullOrEmpty()]
        [ValidateScript({
                if ($_ -match '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$' -or 
                    $_ -match '^[0-9a-fA-F]{8}-([0-9a-fA-F]{4}-){3}[0-9a-fA-F]{12}$') {
                    return $true
                }
                throw "UserId must be a valid email address or GUID."
            })]
        [string]$UserId,

        [Parameter(HelpMessage = "A short biography or description about the user.")]
        [string]$aboutMe,

        [Parameter(HelpMessage = "Indicates whether the account is enabled. true if enabled; otherwise, false.")]
        [bool]$accountEnabled,

        [Parameter(HelpMessage = "The user's age group. Allowed values: minor, notAdult, adult.")]
        [ValidateSet("minor", "notAdult", "adult")]
        [string]$ageGroup,

        [Parameter(HelpMessage = "The user's birthday.")]
        [datetime]$birthday,

        [Parameter(HelpMessage = "The user's business phone numbers.")]
        [string[]]$businessPhones,

        [Parameter(HelpMessage = "The city where the user is located.")]
        [string]$city,

        [Parameter(HelpMessage = "The company name associated with the user.")]
        [string]$companyName,

        [Parameter(HelpMessage = "Indicates if consent has been obtained for minors. Allowed values: Granted, Denied, NotRequired.")]
        [ValidateSet("Granted", "Denied", "NotRequired")]
        [string]$consentProvidedForMinor,

        [Parameter(HelpMessage = "The country/region where the user is located.")]
        [string]$country,

        [Parameter(HelpMessage = "The department where the user works.")]
        [string]$department,

        [Parameter(HelpMessage = "The name displayed in the address book for the user.")]
        [string]$displayName,

        [Parameter(HelpMessage = "The date and time when the user was hired.")]
        [datetime]$employeeHireDate,

        [Parameter(HelpMessage = "The date and time when the user will leave the company.")]
        [datetime]$employeeLeaveDateTime,

        [Parameter(HelpMessage = "The employee identifier assigned to the user.")]
        [string]$employeeId,

        [Parameter(HelpMessage = "The organization data related to the user.")]
        [hashtable]$employeeOrgData,

        [Parameter(HelpMessage = "Captures enterprise worker type: Employee, Contractor, Consultant, Vendor, etc.")]
        [string]$employeeType,

        [Parameter(HelpMessage = "The user's fax number.")]
        [string]$faxNumber,

        [Parameter(HelpMessage = "The given name (first name) of the user.")]
        [string]$givenName,

        [Parameter(HelpMessage = "The hire date of the user.")]
        [datetime]$hireDate,

        [Parameter(HelpMessage = "The instant message addresses for the user.")]
        [string[]]$imAddresses,

        [Parameter(HelpMessage = "A list of interests for the user.")]
        [string[]]$interests,

        [Parameter(HelpMessage = "The user's job title.")]
        [string]$jobTitle,

        [Parameter(HelpMessage = "Specifies the legal age group classification.")]
        [string]$legalAgeGroupClassification,

        [Parameter(HelpMessage = "The SMTP address for the user.")]
        [string]$mail,

        [Parameter(HelpMessage = "The mail alias for the user.")]
        [string]$mailNickname,

        [Parameter(HelpMessage = "The primary cellular telephone number for the user.")]
        [string]$mobilePhone,

        [Parameter(HelpMessage = "The URL for the user's personal site.")]
        [string]$mySite,

        [Parameter(HelpMessage = "The office location in the user's place of business.")]
        [string]$officeLocation,

        [Parameter(HelpMessage = "A collection of other email addresses for the user.")]
        [string[]]$otherMails,

        [Parameter(HelpMessage = "Specifies password policies for the user.")]
        [string]$passwordPolicies,

        [Parameter(HelpMessage = "Specifies the password profile for the user.")]
        [hashtable]$passwordProfile,

        [Parameter(HelpMessage = "The postal code for the user's postal address.")]
        [string]$postalCode,

        [Parameter(HelpMessage = "The preferred data location for the user.")]
        [string]$preferredDataLocation,

        [Parameter(HelpMessage = "The preferred language for the user.")]
        [string]$preferredLanguage,

        [Parameter(HelpMessage = "The user's surname (last name).")]
        [string]$surname,

        [Parameter(HelpMessage = "A two-letter country code (ISO 3166). Required for users who will be assigned licenses.")]
        [string]$usageLocation,

        [Parameter(HelpMessage = "The user principal name (UPN) of the user.")]
        [string]$userPrincipalName,

        [Parameter(HelpMessage = "The type of user.")]
        [string]$UserType,

        [Parameter(HelpMessage = "The street address for the user.")]
        [string]$StreetAddress,

        [Parameter(HelpMessage = "The state associated with the user.")]
        [string]$State,

        # New: Accepts a hashtable for bulk updates
        [Parameter(Mandatory = $false, HelpMessage = "A hashtable of additional user properties to update.")]
        [Alias("BodyParameter", "Body", "BodyParameters")]
        [hashtable]$AdditionalProperties = @{}  # Default to an empty hashtable if not provided
    )

    begin {

        # Ensure connection to Microsoft Entra
        if (-not (Get-EntraContext)) {
            $errorMessage = "Not connected to Microsoft Graph. Use 'Connect-Entra -Scopes User.ReadWrite.All' to authenticate."
            Write-Error -Message $errorMessage -ErrorAction Stop
            return
        }
    }

    process {
        $customHeaders = New-EntraCustomHeaders -Command $MyInvocation.MyCommand

        # Microsoft Graph API URL for updating users
        $graphUri = "/v1.0/users/$UserId"

        # Initialize hashtable for user properties
        $UserProperties = @{}

        $CommonParameters = @("Verbose", "Debug", "WarningAction", "WarningVariable", "ErrorAction", "ErrorVariable", "OutVariable", "OutBuffer", "WhatIf", "Confirm")

        # Merge individual parameters into UserProperties
        foreach ($param in $PSBoundParameters.Keys) {
            if ($param -ne "UserId" -and $param -ne "AdditionalProperties" -and $CommonParameters -notcontains $param) {
                $UserProperties[$param] = $PSBoundParameters[$param]
            }
        }

        # Merge AdditionalProperties if provided
        foreach ($key in $AdditionalProperties.Keys) {
            $UserProperties[$key] = $AdditionalProperties[$key]
        }

        # Convert final update properties to JSON
        $bodyJson = $UserProperties | ConvertTo-Json -Depth 2
        if ($UserProperties.Count -eq 0) {
            Write-Warning "No properties provided for update. Exiting."
            return
        }

        
        try {
            # Invoke Microsoft Graph API Request
            Invoke-MgGraphRequest -Uri $graphUri -Method PATCH -Body $bodyJson -Headers $customHeaders
            Write-Verbose "Properties for user $UserId updated successfully. Updated properties: $($UserProperties | Out-String)"
        }
        catch {
            Write-Debug "Error Details: $_"
            Write-Error "Failed to update user properties: $_"
        }
    }
}
Set-Alias -Name Update-EntraUser -Value Set-EntraUser -Scope Global -Force
