function Get-EntraUserExtensions {
    [CmdletBinding()]
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
        [string[]]$Property
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
            $extensionResponse = Invoke-MgGraphRequest -Method POST `
                -Uri "/v1.0/directoryObjects/getAvailableExtensionProperties" `
                -Body (@{ isSyncedFromOnPremises = $false } | ConvertTo-Json -Depth 3)

            $extensions = $extensionResponse.value | Where-Object { $_.name -like 'extension_*' } | Select-Object -ExpandProperty name

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

            Write-Verbose "Retrieving user data for UserId: $UserId with properties: $selectQuery"

            # Retrieve user data
            $userUri = "/v1.0/users/$UserId`?`$select=$selectQuery"
            $userData = Invoke-MgGraphRequest -Uri $userUri -Method GET

            # Return user data directly
            return $userData
        }
        catch {
            Write-Error "Failed to retrieve user data for UserId '$UserId': $_"
        }
    }
}
