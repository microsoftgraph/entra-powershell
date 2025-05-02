# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.
#  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

function New-EntraApplication {
    [CmdletBinding(DefaultParameterSetName = 'CreateApplication', SupportsShouldProcess)]
    [OutputType([PSCustomObject])]
    param (
        [Parameter(ParameterSetName = "CreateApplication", Mandatory = $true)]
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
        [System.Collections.Generic.List`1[Microsoft.Graph.PowerShell.Models.MicrosoftGraphRequiredResourceAccess]] $RequiredResourceAccess,

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
        [System.Collections.Generic.List`1[Microsoft.Graph.PowerShell.Models.MicrosoftGraphAddIn]] $AddIns,
        
        [Parameter(ParameterSetName = "CreateApplication")]
        [System.Collections.Generic.List`1[Microsoft.Graph.PowerShell.Models.MicrosoftGraphKeyCredential]] $KeyCredentials,

        [Parameter(ParameterSetName = "CreateApplication")]
        [System.Collections.Generic.List`1[Microsoft.Graph.PowerShell.Models.MicrosoftGraphPasswordCredential]] $PasswordCredentials,
        
        [Parameter(ParameterSetName = "CreateWithAdditionalProperties")]
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
                    $roleHash = @{}
                    $role.PSObject.Properties | ForEach-Object {
                        if ($null -ne $_.Value) {
                            $roleHash[$_.Name] = $_.Value
                        }
                    }
                    $appRolesArray += $roleHash
                }
                $appBody['appRoles'] = $appRolesArray
            }
            
            if ($PSBoundParameters.ContainsKey('RequiredResourceAccess')) {
                $resourceAccessArray = @()
                foreach ($resource in $RequiredResourceAccess) {
                    $resourceHash = @{}
                    $resource.PSObject.Properties | ForEach-Object {
                        if ($null -ne $_.Value) {
                            $resourceHash[$_.Name] = $_.Value
                        }
                    }
                    $resourceAccessArray += $resourceHash
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
                    $addinHash = @{}
                    $addin.PSObject.Properties | ForEach-Object {
                        if ($null -ne $_.Value) {
                            $addinHash[$_.Name] = $_.Value
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
                    $credHash = @{}
                    $cred.PSObject.Properties | ForEach-Object {
                        if ($null -ne $_.Value) {
                            $credHash[$_.Name] = $_.Value
                        }
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
        $whatIfTarget = "Microsoft Entra Application"
        
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
