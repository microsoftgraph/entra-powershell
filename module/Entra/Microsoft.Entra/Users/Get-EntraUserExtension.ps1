# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

function Get-EntraUserExtension {
    [CmdletBinding(DefaultParameterSetName = 'Default', SupportsShouldProcess)]
    [OutputType([PSCustomObject])]
    param (
        [Parameter(Mandatory, ValueFromPipeline, ValueFromPipelineByPropertyName)]
        [Alias('ObjectId', 'UPN', 'Identity', 'UserPrincipalName')]
        [ValidateNotNullOrEmpty()]
        [ValidateScript({
                if ($_ -match '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$' -or 
                    $_ -match '^[0-9a-fA-F]{8}-([0-9a-fA-F]{4}-){3}[0-9a-fA-F]{12}$') {
                    return $true
                }
                throw "UserId must be a valid email address or GUID."
            })]
        [string]$UserId,

        [Parameter(HelpMessage = "Properties to include in the results.")]
        [Alias("Select")]
        [string[]]$Property,

        [Parameter(HelpMessage = "Filter to only show properties synced from on-premises")]
        [System.Nullable[bool]]$IsSyncedFromOnPremises
    )

    begin {
        # Ensure connection to Microsoft Entra
        if (-not (Get-EntraContext)) {
            $errorMessage = "Not connected to Microsoft Graph. Use 'Connect-Entra -Scopes User.Read.All' to authenticate."
            Write-Error -Message $errorMessage -ErrorAction Stop
            return
        }

        # Define standard user properties
        $standardProperties = @(
            'id',
            'userPrincipalName',
            'createdDateTime',
            'employeeId',
            'onPremisesDistinguishedName',
            'identities'
        )

        # Retrieve available extension properties once
        try {
            Write-Verbose "Retrieving available extension properties..."
            
            # Call Microsoft Graph API directly instead of using Get-EntraExtensionProperty
            $requestBody = @{
                isSyncedFromOnPremises = $IsSyncedFromOnPremises
            } | ConvertTo-Json

            $customHeaders = New-EntraCustomHeaders -Command $MyInvocation.MyCommand
            $extensionResponse = Invoke-MgGraphRequest -Method POST -Uri "/v1.0/directoryObjects/getAvailableExtensionProperties" `
                -Body $requestBody
            
            # Extract extension property names
            $extensions = if ($PSBoundParameters.ContainsKey('IsSyncedFromOnPremises')) {
                $extensionResponse.value | Where-Object { $_.isSyncedFromOnPremises -eq $IsSyncedFromOnPremises } | 
                ForEach-Object { $_.name }
            }
            else {
                $extensionResponse.value | ForEach-Object { $_.name }
            }

            # Combine standard and extension properties
            $allProperties = $standardProperties + $extensions
        }
        catch {
            Write-Warning "Failed to retrieve extension properties: $_"
            $extensions = @()
            $allProperties = $standardProperties
        }

    }

    process {
        try {
            # Validate and select properties
            if ($Property) {
                $invalidProperties = $Property | Where-Object { $_ -notin $allProperties }
                if ($invalidProperties) {
                    throw "Invalid property/properties specified: $($invalidProperties -join ', ')"
                }
                $selectedProperties = $Property
            }
            else {
                $selectedProperties = $allProperties
            }

            # Construct $select query parameter
            $selectQuery = $selectedProperties -join ','

            # Create description for -WhatIf
            $whatIfDescription = "Retrieving user extension data for UserId: $UserId"
            if ($Property) {
                $whatIfDescription += " with properties: $($Property -join ',')"
            }
            if ($PSBoundParameters.ContainsKey('IsSyncedFromOnPremises')) {
                $whatIfDescription += " (SyncedFromOnPremises: $IsSyncedFromOnPremises)"
            }

            # Construct URI for the operation
            $userUri = "/v1.0/users/$UserId`?`$select=$selectQuery"

            # Add ShouldProcess check
            if ($PSCmdlet.ShouldProcess($userUri, $whatIfDescription)) {
                Write-Verbose "Retrieving user data for UserId: $UserId with properties: $selectQuery"

                # Retrieve user data
                $customHeaders = New-EntraCustomHeaders -Command $MyInvocation.MyCommand
                $data = Invoke-MgGraphRequest -Uri $userUri -Method GET -Headers $customHeaders | 
                ConvertTo-Json | 
                ConvertFrom-Json

                $data | ForEach-Object {
                    if ($null -ne $_) {
                        Add-Member -InputObject $_ -MemberType AliasProperty -Name userIdentities -Value identities
                    }
                }    
                $data | Select-Object *
            }
        }
        catch {
            Write-Error "Failed to retrieve user data for UserId '$UserId': $_"
        }
    }
}
