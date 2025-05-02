# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.
#  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

function New-EntraApplication {
    [CmdletBinding(DefaultParameterSetName = 'CreateApplication', SupportsShouldProcess)]
    [OutputType([PSCustomObject])]
    param (
        [Parameter(ParameterSetName = "CreateApplication", Mandatory = $true, Position = 0)]
        [Parameter(ParameterSetName = "CreateWithAdditionalProperties", Mandatory = $false, Position = 0)]
        [System.String] $DisplayName,

        [Parameter(ParameterSetName = "CreateApplication")]
        [System.String] $SignInAudience,

        [Parameter(ParameterSetName = "CreateApplication")]
        [System.Collections.Generic.List`1[System.String]] $IdentifierUris,

        [Parameter(ParameterSetName = "CreateApplication")]
        [System.Collections.Generic.List`1[System.String]] $Tags,

        [Parameter(ParameterSetName = "CreateApplication")]
        [System.String] $GroupMembershipClaims,

        [Parameter(ParameterSetName = "CreateApplication")]
        [System.String] $TokenEncryptionKeyId,

        [Parameter(ParameterSetName = "CreateApplication")]
        [System.Nullable`1[System.Boolean]] $IsDeviceOnlyAuthSupported,

        [Parameter(ParameterSetName = "CreateApplication")]
        [System.Nullable`1[System.Boolean]] $IsFallbackPublicClient,

        [Parameter(ParameterSetName = "CreateApplication")]
        [System.Collections.Generic.List`1[Microsoft.Graph.PowerShell.Models.MicrosoftGraphAppRole]] $AppRoles,

        [Parameter(ParameterSetName = "CreateApplication")]
        [Microsoft.Graph.PowerShell.Models.MicrosoftGraphRequiredResourceAccess[]] $RequiredResourceAccess,

        [Parameter(ParameterSetName = "CreateApplication")]
        [Microsoft.Graph.PowerShell.Models.MicrosoftGraphApiApplication] $Api,

        [Parameter(ParameterSetName = "CreateApplication")]
        [Microsoft.Graph.PowerShell.Models.MicrosoftGraphPublicClientApplication] $PublicClient,

        [Parameter(ParameterSetName = "CreateApplication")]
        [Microsoft.Graph.PowerShell.Models.MicrosoftGraphWebApplication] $Web,

        [Parameter(ParameterSetName = "CreateApplication")]
        [Microsoft.Graph.PowerShell.Models.MicrosoftGraphInformationalUrl] $InformationalUrl,

        [Parameter(ParameterSetName = "CreateApplication")]
        [Microsoft.Graph.PowerShell.Models.MicrosoftGraphParentalControlSettings] $ParentalControlSettings,

        [Parameter(ParameterSetName = "CreateApplication")]
        [Microsoft.Graph.PowerShell.Models.MicrosoftGraphOptionalClaims] $OptionalClaims,

        [Parameter(ParameterSetName = "CreateApplication")]
        [System.Object[]] $AddIns,
        
        [Parameter(ParameterSetName = "CreateApplication")]
        [System.Object[]] $KeyCredentials,
        #[System.Collections.Generic.List`1[Microsoft.Graph.PowerShell.Models.MicrosoftGraphKeyCredential]] $KeyCredentials,

        [Parameter(ParameterSetName = "CreateApplication")]
        [Microsoft.Graph.PowerShell.Models.MicrosoftGraphPasswordCredential[]] $PasswordCredentials,
        
        [Parameter(ParameterSetName = "CreateWithAdditionalProperties")]
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
                    if ($null -ne $_.Value) {
                        $apiHash[$_.Name] = $_.Value
                    }
                }
                $appBody['api'] = $apiHash
            }
            
            if ($PSBoundParameters.ContainsKey('PublicClient')) {
                $publicClientHash = @{}
                $PublicClient.PSObject.Properties | ForEach-Object {
                    if ($null -ne $_.Value) {
                        $publicClientHash[$_.Name] = $_.Value
                    }
                }
                $appBody['publicClient'] = $publicClientHash
            }
            
            if ($PSBoundParameters.ContainsKey('Web')) {
                $webHash = @{}
                $Web.PSObject.Properties | ForEach-Object {
                    if ($null -ne $_.Value) {
                        $webHash[$_.Name] = $_.Value
                    }
                }
                $appBody['web'] = $webHash
            }
            
            if ($PSBoundParameters.ContainsKey('InformationalUrl')) {
                $infoUrlHash = @{}
                $InformationalUrl.PSObject.Properties | ForEach-Object {
                    if ($null -ne $_.Value) {
                        $infoUrlHash[$_.Name] = $_.Value
                    }
                }
                $appBody['info'] = $infoUrlHash
            }
            
            if ($PSBoundParameters.ContainsKey('ParentalControlSettings')) {
                $parentalControlHash = @{}
                $ParentalControlSettings.PSObject.Properties | ForEach-Object {
                    if ($null -ne $_.Value) {
                        $parentalControlHash[$_.Name] = $_.Value
                    }
                }
                $appBody['parentalControlSettings'] = $parentalControlHash
            }
            
            if ($PSBoundParameters.ContainsKey('OptionalClaims')) {
                $optionalClaimsHash = @{}
                $OptionalClaims.PSObject.Properties | ForEach-Object {
                    if ($null -ne $_.Value) {
                        $optionalClaimsHash[$_.Name] = $_.Value
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
                    $credHash = @{
                        customKeyIdentifier = $cred.CustomKeyIdentifier
                        endDateTime         = $cred.EndDateTime
                        key                 = $cred.Key
                        startDateTime       = $cred.StartDateTime
                        type                = $cred.Type
                        usage               = $cred.Usage
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
                
                return $response
            }
            catch {
                Write-Error "Failed to create application: $_"
            }
        }
    }
}
