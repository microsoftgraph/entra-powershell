# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.
#  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

function New-EntraApplication {
    [CmdletBinding(DefaultParameterSetName = 'CreateApplication', SupportsShouldProcess)]
    [OutputType([PSCustomObject])]
    param (
        [Parameter(ParameterSetName = "CreateApplication", Mandatory = $true, Position = 0, 
            HelpMessage = "The display name of the application in Microsoft Entra ID.")]
        [Parameter(ParameterSetName = "CreateWithAdditionalProperties", Mandatory = $false, Position = 0)]
        [ValidateNotNullOrEmpty()]
        [System.String] $DisplayName,

        [Parameter(ParameterSetName = "CreateApplication", 
            HelpMessage = "Defines which accounts are supported for this application. Valid values: AzureADMyOrg`, AzureADMultipleOrgs`, AzureADandPersonalMicrosoftAccount`, PersonalMicrosoftAccount.")]
        [System.String] $SignInAudience,

        [Parameter(ParameterSetName = "CreateApplication", 
            HelpMessage = "URIs that uniquely identify the application within Azure AD.")]
        [System.Collections.Generic.List`1[System.String]] $IdentifierUris,

        [Parameter(ParameterSetName = "CreateApplication", 
            HelpMessage = "Custom tags that can be used to categorize and identify the application.")]
        [System.Collections.Generic.List`1[System.String]] $Tags,

        [Parameter(ParameterSetName = "CreateApplication", 
            HelpMessage = "Configures the groups claim issued in a user or OAuth 2.0 access token. Valid values: None`, SecurityGroup`, All.")]
        [System.String] $GroupMembershipClaims,

        [Parameter(ParameterSetName = "CreateApplication", 
            HelpMessage = "Specifies the keyId of a public key from the keyCredentials collection for token encryption.")]
        [System.String] $TokenEncryptionKeyId,

        [Parameter(ParameterSetName = "CreateApplication", 
            HelpMessage = "Specifies whether this application supports device authentication without a user.")]
        [System.Nullable`1[System.Boolean]] $IsDeviceOnlyAuthSupported,

        [Parameter(ParameterSetName = "CreateApplication", 
            HelpMessage = "Specifies whether the application is a public client. If not set`, the default behavior is false.")]
        [System.Nullable`1[System.Boolean]] $IsFallbackPublicClient,

        [Parameter(ParameterSetName = "CreateApplication", 
            HelpMessage = "The collection of application roles defined for the application.")]
        [System.Collections.Generic.List`1[Microsoft.Graph.PowerShell.Models.MicrosoftGraphAppRole]] $AppRoles,

        [Parameter(ParameterSetName = "CreateApplication", 
            HelpMessage = "The API permissions required by the application to other resources such as Microsoft Graph.")]
        [Microsoft.Graph.PowerShell.Models.MicrosoftGraphRequiredResourceAccess[]] $RequiredResourceAccess,

        [Parameter(ParameterSetName = "CreateApplication", 
            HelpMessage = "The API settings for the application`, including OAuth2 permission scopes and app roles.")]
        [Microsoft.Graph.PowerShell.Models.MicrosoftGraphApiApplication] $Api,

        [Parameter(ParameterSetName = "CreateApplication", 
            HelpMessage = "Settings for a public client application (mobile or desktop).")]
        [Microsoft.Graph.PowerShell.Models.MicrosoftGraphPublicClientApplication] $PublicClient,

        [Parameter(ParameterSetName = "CreateApplication", 
            HelpMessage = "Settings for a web application`, including redirect URIs and logout URL.")]
        [Microsoft.Graph.PowerShell.Models.MicrosoftGraphWebApplication] $Web,

        [Parameter(ParameterSetName = "CreateApplication", 
            HelpMessage = "URLs with more information about the application (marketing`, terms of service`, privacy`, etc).")]
        [Microsoft.Graph.PowerShell.Models.MicrosoftGraphInformationalUrl] $InformationalUrl,

        [Parameter(ParameterSetName = "CreateApplication", 
            HelpMessage = "Specifies parental control settings for an application.")]
        [Microsoft.Graph.PowerShell.Models.MicrosoftGraphParentalControlSettings] $ParentalControlSettings,

        [Parameter(ParameterSetName = "CreateApplication", 
            HelpMessage = "The optional claims configuration that will be included in access and ID tokens.")]
        [Microsoft.Graph.PowerShell.Models.MicrosoftGraphOptionalClaims] $OptionalClaims,

        [Parameter(ParameterSetName = "CreateApplication", 
            HelpMessage = "Defines custom behavior extensions for the application.")]
        [System.Object[]] $AddIns,
        
        [Parameter(ParameterSetName = "CreateApplication", 
            HelpMessage = "The collection of certificate credentials associated with the application.")]
        [System.Object[]] $KeyCredentials,

        [Parameter(ParameterSetName = "CreateApplication", 
            HelpMessage = "The collection of password credentials associated with the application.")]
        [Microsoft.Graph.PowerShell.Models.MicrosoftGraphPasswordCredential[]] $PasswordCredentials,
        
        [Parameter(ParameterSetName = "CreateWithAdditionalProperties", 
            HelpMessage = "Custom properties to send directly to the Microsoft Graph API.")]
        [Alias('Body', 'Properties', 'BodyParameter')]
        [Hashtable] $AdditionalProperties
    )

    PROCESS {    
        # Ensure connection to Microsoft Entra
        if (-not (Get-EntraContext)) {
            $errorMessage = "Not connected to Microsoft Graph. Use 'Connect-Entra -Scopes Application.ReadWrite.All' to authenticate."
            Write-Error -Message $errorMessage -ErrorAction Stop
            return
        }

        # Create headers for the request
        $customHeaders = New-EntraCustomHeaders -Command $MyInvocation.MyCommand
        
        # Build the application body based on parameter set
        if ($PSCmdlet.ParameterSetName -eq 'CreateApplication') {
            $appBody = @{}
            
            # Add required parameters
            $appBody['displayName'] = $DisplayName
            
            # Add optional parameters if provided
            if ($PSBoundParameters.ContainsKey('SignInAudience')) {
                $appBody['signInAudience'] = $SignInAudience
            }
            
            if ($PSBoundParameters.ContainsKey('IdentifierUris')) {
                $appBody['identifierUris'] = $IdentifierUris
            }
            
            if ($PSBoundParameters.ContainsKey('Tags')) {
                $appBody['tags'] = $Tags
            }
            
            if ($PSBoundParameters.ContainsKey('GroupMembershipClaims')) {
                $appBody['groupMembershipClaims'] = $GroupMembershipClaims
            }
            
            if ($PSBoundParameters.ContainsKey('TokenEncryptionKeyId')) {
                $appBody['tokenEncryptionKeyId'] = $TokenEncryptionKeyId
            }
            
            if ($PSBoundParameters.ContainsKey('IsDeviceOnlyAuthSupported')) {
                $appBody['isDeviceOnlyAuthSupported'] = $IsDeviceOnlyAuthSupported
            }
            
            if ($PSBoundParameters.ContainsKey('IsFallbackPublicClient')) {
                $appBody['isFallbackPublicClient'] = $IsFallbackPublicClient
            }
            
            # Handle complex types by converting them to hashtables
            if ($PSBoundParameters.ContainsKey('AppRoles')) {
                $appRolesArray = @()
                foreach ($role in $AppRoles) {
                    # Initialize roleHash with required properties
                    $roleHash = @{
                        id        = [Guid]::NewGuid().ToString('D')
                        isEnabled = $true
                    }
                    
                    # Convert role to hashtable if it's not already
                    if ($role -is [hashtable]) {
                        foreach ($key in $role.Keys) {
                            # Handle GUID id specifically
                            if ($key -eq 'id' -and $role[$key] -is [System.Guid]) {
                                $roleHash['id'] = $role[$key].ToString('D')
                            }
                            else {
                                $roleHash[$key] = $role[$key]
                            }
                        }
                    }
                    else {
                        $role.PSObject.Properties | Where-Object { 
                            $_.Name -ne 'AdditionalProperties' -and $null -ne $_.Value 
                        } | ForEach-Object {
                            if ($_.Name -eq 'id' -and $_.Value -is [System.Guid]) {
                                $roleHash[$_.Name] = $_.Value.ToString('D')
                            }
                            else {
                                $roleHash[$_.Name] = $_.Value
                            }
                        }
                    }

                    # Validate required properties
                    if (-not $roleHash.ContainsKey('allowedMemberTypes')) {
                        Write-Error "AppRole must specify allowedMemberTypes"
                        continue
                    }
                    if (-not $roleHash.ContainsKey('displayName')) {
                        Write-Error "AppRole must specify displayName"
                        continue
                    }
                    if (-not $roleHash.ContainsKey('value')) {
                        Write-Error "AppRole must specify value"
                        continue
                    }

                    # Ensure allowedMemberTypes is an array
                    if ($roleHash['allowedMemberTypes'] -isnot [array]) {
                        $roleHash['allowedMemberTypes'] = @($roleHash['allowedMemberTypes'])
                    }

                    $appRolesArray += $roleHash
                }
                $appBody['appRoles'] = $appRolesArray
            }
            
            if ($PSBoundParameters.ContainsKey('RequiredResourceAccess')) {
                $resourceAccessArray = @()
                foreach ($resource in $RequiredResourceAccess) {
                    # Handle hashtable input
                    if ($resource -is [Hashtable] -or $resource -is [PSCustomObject]) {
                        $resourceHash = @{
                            resourceAppId  = $resource.ResourceAppId
                            resourceAccess = @()
                        }
                        
                        # Convert each resource access item
                        if ($resource.ResourceAccess) {
                            foreach ($access in $resource.ResourceAccess) {
                                $accessHash = @{
                                    id   = $access.Id
                                    type = $access.Type
                                }
                                $resourceHash.resourceAccess += $accessHash
                            }
                        }
                        
                        $resourceAccessArray += $resourceHash
                    }
                    # Handle Microsoft Graph model objects
                    else {
                        $resourceHash = @{
                            resourceAppId  = $resource.ResourceAppId
                            resourceAccess = @()
                        }
                        
                        if ($resource.ResourceAccess) {
                            foreach ($access in $resource.ResourceAccess) {
                                $accessHash = @{
                                    id   = $access.Id
                                    type = $access.Type
                                }
                                $resourceHash.resourceAccess += $accessHash
                            }
                        }
                        
                        $resourceAccessArray += $resourceHash
                    }
                }
                $appBody['requiredResourceAccess'] = $resourceAccessArray
            }
            
            if ($PSBoundParameters.ContainsKey('Api')) {
                $apiHash = @{}
                $Api.PSObject.Properties | ForEach-Object {
                    if ($null -ne $_.Value -and $_.Name -ne 'AdditionalProperties') {
                        # Handle special case for Oauth2PermissionScopes
                        if ($_.Name -eq 'Oauth2PermissionScopes') {
                            $scopesArray = @()
                            foreach ($scope in $_.Value) {
                                $scopeHash = @{
                                    id                      = $scope.Id
                                    adminConsentDescription = $scope.AdminConsentDescription
                                    adminConsentDisplayName = $scope.AdminConsentDisplayName
                                    isEnabled               = $scope.IsEnabled
                                    type                    = $scope.Type
                                    value                   = $scope.Value
                                }
                                $scopesArray += $scopeHash
                            }
                            $apiHash['oauth2PermissionScopes'] = $scopesArray
                        }
                        else {
                            $apiHash[$_.Name] = $_.Value
                        }
                    }
                }
                $appBody['api'] = $apiHash
            }
            
            if ($PSBoundParameters.ContainsKey('PublicClient')) {
                $publicClientHash = @{}
                $PublicClient.PSObject.Properties | ForEach-Object {
                    if ($null -ne $_.Value -and $_.Name -ne 'AdditionalProperties') {
                        $publicClientHash[$_.Name] = $_.Value
                    }
                }
                $appBody['publicClient'] = $publicClientHash
            }
            
            if ($PSBoundParameters.ContainsKey('Web')) {
                $webHash = @{}
    
                # Handle hashtable input
                if ($Web -is [Hashtable] -or $Web -is [PSCustomObject]) {
                    foreach ($key in $Web.Keys) {
                        # Handle special case for ImplicitGrantSettings
                        if ($key -eq 'ImplicitGrantSettings' -or $key -eq 'implicitGrantSettings') {
                            $implicitSettings = @{}
                
                            if ($Web[$key] -is [Hashtable] -or $Web[$key] -is [PSCustomObject]) {
                                foreach ($settingKey in $Web[$key].Keys) {
                                    if ($settingKey -ne 'AdditionalProperties') {
                                        # Convert to camelCase for API
                                        $camelCaseKey = $settingKey.Substring(0, 1).ToLower() + $settingKey.Substring(1)
                                        $implicitSettings[$camelCaseKey] = $Web[$key][$settingKey]
                                    }
                                }
                            }
                            else {
                                $Web[$key].PSObject.Properties | ForEach-Object {
                                    if ($null -ne $_.Value -and $_.Name -ne 'AdditionalProperties') {
                                        # Convert to camelCase for API
                                        $camelCaseKey = $_.Name.Substring(0, 1).ToLower() + $_.Name.Substring(1)
                                        $implicitSettings[$camelCaseKey] = $_.Value
                                    }
                                }
                            }
                
                            $webHash['implicitGrantSettings'] = $implicitSettings
                        }
                        else {
                            # Handle all other web properties
                            # Convert to camelCase for consistency
                            $camelCaseKey = $key.Substring(0, 1).ToLower() + $key.Substring(1)
                            $webHash[$camelCaseKey] = $Web[$key]
                        }
                    }
                }
                # Handle Microsoft Graph model objects
                else {
                    $Web.PSObject.Properties | ForEach-Object {
                        if ($null -ne $_.Value -and $_.Name -ne 'AdditionalProperties') {
                            if ($_.Name -eq 'ImplicitGrantSettings') {
                                $implicitSettings = @{}
                                $_.Value.PSObject.Properties | ForEach-Object {
                                    if ($null -ne $_.Value -and $_.Name -ne 'AdditionalProperties') {
                                        # Convert to camelCase for API
                                        $camelCaseKey = $_.Name.Substring(0, 1).ToLower() + $_.Name.Substring(1)
                                        $implicitSettings[$camelCaseKey] = $_.Value
                                    }
                                }
                                $webHash['implicitGrantSettings'] = $implicitSettings
                            }
                            else {
                                # Convert to camelCase for API
                                $camelCaseKey = $_.Name.Substring(0, 1).ToLower() + $_.Name.Substring(1)
                                $webHash[$camelCaseKey] = $_.Value
                            }
                        }
                    }
                }
    
                $appBody['web'] = $webHash
            }
            
            if ($PSBoundParameters.ContainsKey('InformationalUrl')) {
                $infoUrlHash = @{}
                $InformationalUrl.PSObject.Properties | ForEach-Object {
                    if ($null -ne $_.Value -and $_.Name -ne 'AdditionalProperties') {
                        $infoUrlHash[$_.Name] = $_.Value
                    }
                }
                $appBody['info'] = $infoUrlHash
            }
            
            if ($PSBoundParameters.ContainsKey('ParentalControlSettings')) {
                $parentalControlHash = @{}
                $ParentalControlSettings.PSObject.Properties | ForEach-Object {
                    if ($null -ne $_.Value -and $_.Name -ne 'AdditionalProperties') {
                        # Validate legalAgeGroupRule property
                        if ($_.Name -eq 'legalAgeGroupRule') {
                            $validValues = @('Allow', 'RequireConsentForMinors', 'RequireConsentForKids', 'RequireConsentForPrivacyServices', 'BlockMinors')
                            if ($validValues -notcontains $_.Value) {
                                Write-Error "Invalid value specified for property 'legalAgeGroupRule'. Valid values are: $($validValues -join ', ')"
                                return
                            }
                        }

                        # Ensure CountriesBlockedForMinors is not set to a non-default value
                        if ($_.Name -eq 'countriesBlockedForMinors' -and ($null -ne $_.Value -and $_.Value.Count -gt 0)) {
                            Write-Warning "The 'countriesBlockedForMinors' property must be set to its default value (null or empty). Ignoring this property."
                            return
                        }

                        $parentalControlHash[$_.Name] = $_.Value
                    }
                }
                $appBody['parentalControlSettings'] = $parentalControlHash
            }
            
            if ($PSBoundParameters.ContainsKey('OptionalClaims')) {
                $optionalClaimsHash = @{}

                # Process each claim type (idToken, accessToken, saml2Token)
                foreach ($claimType in @('idToken', 'accessToken', 'saml2Token')) {
                    if ($OptionalClaims.PSObject.Properties[$claimType] -and $OptionalClaims.$claimType) {
                        $claimsArray = @()
                        foreach ($claim in $OptionalClaims.$claimType) {
                            $claimHash = @{}
                            $claim.PSObject.Properties | ForEach-Object {
                                if ($null -ne $_.Value -and $_.Name -ne 'AdditionalProperties') {
                                    $claimHash[$_.Name] = $_.Value
                                }
                            }
                            $claimsArray += $claimHash
                        }
                        $optionalClaimsHash[$claimType] = $claimsArray
                    }
                }

                $appBody['optionalClaims'] = $optionalClaimsHash
            }
            
            if ($PSBoundParameters.ContainsKey('AddIns')) {
                $addInsArray = @()
                foreach ($addin in $AddIns) {
                    $addinHash = @{
                        id         = $addin.Id
                        type       = $addin.Type
                        properties = @()
                    }

                    if ($addin.Properties) {
                        foreach ($prop in $addin.Properties) {
                            $addinHash.properties += @{
                                key   = $prop.Key
                                value = $prop.Value
                            }
                        }
                    }
                    
                    $addInsArray += $addinHash
                }
                $appBody['addIns'] = $addInsArray
            }
            
            if ($PSBoundParameters.ContainsKey('KeyCredentials')) {
                $keyCredsArray = @()
                foreach ($cred in $KeyCredentials) {
                    $credHash = @{}
                    
                    # Handle hashtable input
                    if ($cred -is [Hashtable] -or $cred -is [PSCustomObject]) {
                        if ($cred.ContainsKey('CustomKeyIdentifier') -or $null -ne $cred.CustomKeyIdentifier) { 
                            $credHash['customKeyIdentifier'] = $cred.CustomKeyIdentifier 
                        }
                        if ($cred.ContainsKey('DisplayName') -or $null -ne $cred.DisplayName) { 
                            $credHash['displayName'] = $cred.DisplayName 
                        }
                        if ($cred.ContainsKey('EndDateTime') -or $null -ne $cred.EndDateTime) { 
                            # Format EndDateTime in UTC ISO 8601
                            $credHash['endDateTime'] = $cred.EndDateTime.ToUniversalTime().ToString("yyyy-MM-ddTHH:mm:ssZ")
                        }
                        if ($cred.ContainsKey('Key') -or $null -ne $cred.Key) { 
                            $credHash['key'] = $cred.Key 
                        }
                        if ($cred.ContainsKey('StartDateTime') -or $null -ne $cred.StartDateTime) { 
                            # Format StartDateTime in UTC ISO 8601
                            $credHash['startDateTime'] = $cred.StartDateTime.ToUniversalTime().ToString("yyyy-MM-ddTHH:mm:ssZ")
                        }
                        if ($cred.ContainsKey('Type') -or $null -ne $cred.Type) { 
                            $credHash['type'] = $cred.Type 
                        }
                        if ($cred.ContainsKey('Usage') -or $null -ne $cred.Usage) { 
                            $credHash['usage'] = $cred.Usage 
                        }
                    }
                    # Handle Microsoft Graph model objects
                    else {
                        if ($null -ne $cred.CustomKeyIdentifier) { 
                            $credHash['customKeyIdentifier'] = $cred.CustomKeyIdentifier 
                        }
                        if ($null -ne $cred.DisplayName) { 
                            $credHash['displayName'] = $cred.DisplayName 
                        }
                        if ($null -ne $cred.EndDateTime) { 
                            # Format EndDateTime in UTC ISO 8601
                            $credHash['endDateTime'] = $cred.EndDateTime.ToUniversalTime().ToString("yyyy-MM-ddTHH:mm:ssZ")
                        }
                        if ($null -ne $cred.Key) { 
                            $credHash['key'] = $cred.Key 
                        }
                        if ($null -ne $cred.StartDateTime) { 
                            # Format StartDateTime in UTC ISO 8601
                            $credHash['startDateTime'] = $cred.StartDateTime.ToUniversalTime().ToString("yyyy-MM-ddTHH:mm:ssZ")
                        }
                        if ($null -ne $cred.Type) { 
                            $credHash['type'] = $cred.Type 
                        }
                        if ($null -ne $cred.Usage) { 
                            $credHash['usage'] = $cred.Usage 
                        }
                    }

                    # Validate required properties
                    if (-not $credHash.ContainsKey('type')) {
                        Write-Error "KeyCredential must specify type"
                        continue
                    }
                    if (-not $credHash.ContainsKey('usage')) {
                        Write-Error "KeyCredential must specify usage"
                        continue
                    }
                    
                    $keyCredsArray += $credHash
                }
                $appBody['keyCredentials'] = $keyCredsArray
            }
            
            if ($PSBoundParameters.ContainsKey('PasswordCredentials')) {
                $passwordCredsArray = @()
                foreach ($cred in $PasswordCredentials) {
                    # Create base credential hash with required displayName
                    $credHash = @{
                        displayName = $cred.DisplayName
                    }
                    
                    # Map all available properties from the MicrosoftGraphPasswordCredential
                    if ($cred.StartDateTime) { 
                        $credHash['startDateTime'] = $cred.StartDateTime.ToString('o') 
                    }
                    if ($cred.EndDateTime) { 
                        $credHash['endDateTime'] = $cred.EndDateTime.ToString('o') 
                    }
                    if ($null -ne $cred.SecretText) { 
                        $credHash['secretText'] = $cred.SecretText 
                    }
                    if ($cred.KeyId) { 
                        $credHash['keyId'] = $cred.KeyId 
                    }
                    if ($cred.Hint) { 
                        $credHash['hint'] = $cred.Hint 
                    }
                    
                    $passwordCredsArray += $credHash
                }
                $appBody['passwordCredentials'] = $passwordCredsArray
            }
        }
        else {
            # Use AdditionalProperties parameter directly
            $appBody = $AdditionalProperties
            
            # Ensure displayName is included
            if (-not $appBody.ContainsKey('displayName')) {
                $errorMessage = "displayName is required when using AdditionalProperties."
                Write-Error -Message $errorMessage -ErrorAction Stop
                return
            }
        }
        
        # Display debug information
        Write-Debug("============================ REQUEST BODY ============================")
        Write-Debug(($appBody | ConvertTo-Json -Depth 10))
        Write-Debug("=========================================================================")
        
        # Use ShouldProcess to support -WhatIf
        $whatIfDescription = "Creating new application '$($appBody.displayName)'"
        $whatIfTarget = "Microsoft Entra ID Application"
        
        if ($PSCmdlet.ShouldProcess($whatIfTarget, $whatIfDescription)) {
            try {
                # Create the application using Microsoft Graph API
                $uri = "/v1.0/applications"
                $response = Invoke-MgGraphRequest -Uri $uri -Method POST -Body ($appBody | ConvertTo-Json -Depth 10) -Headers $customHeaders
                
                # Add an ObjectId alias for backwards compatibility
                $response | Add-Member -NotePropertyName ObjectId -NotePropertyValue $response.id -Force
                
                $response = $response | ConvertTo-Json | ConvertFrom-Json
                $appList = @()
                foreach ($data in $response) {
                    $appObject = New-Object Microsoft.Graph.PowerShell.Models.MicrosoftGraphApplication
                    $data.PSObject.Properties | ForEach-Object {
                        $propertyName = $_.Name
                        $propertyValue = $_.Value
                        $appObject | Add-Member -MemberType NoteProperty -Name $propertyName -Value $propertyValue -Force
                    }
                    $appList += $appObject
                }
                $appList
            }
            catch {
                Write-Error "Failed to create application: $_"
            }
        }
    }
}
