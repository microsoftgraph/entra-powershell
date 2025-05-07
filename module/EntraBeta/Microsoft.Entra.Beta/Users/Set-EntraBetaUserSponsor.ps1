# ------------------------------------------------------------------------------ 
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  
#  Licensed under the MIT License.  See License in the project root for license information. 
# ------------------------------------------------------------------------------ 

function Set-EntraBetaUserSponsor {
    [CmdletBinding(DefaultParameterSetName = "SetUserSponsor")]
    param (            
        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = "The unique identifier (User ID or User Principal Name) of the user whose sponsor information you want to set.")]
        [Alias('ObjectId', 'UPN', 'Identity', 'UserPrincipalName')]
        [ValidateNotNullOrEmpty()]
        [ValidateScript({
                if ($_ -match '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$' -or 
                    $_ -match '^[0-9a-fA-F]{8}-([0-9a-fA-F]{4}-){3}[0-9a-fA-F]{12}$') {
                    return $true
                }
                throw "UserId must be a valid email address or GUID."
            })]
        [System.String] $UserId,

        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = "Type of sponsor to assign to a User. Can be either 'User' or 'Group'.")]
        [ValidateSet("User", "Group")]
        [ValidateNotNullOrEmpty()]
        [System.String] $Type,
        
        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = "List of sponsors to assign to the user.")]
        [ValidateNotNullOrEmpty()]
        [System.String[]] $SponsorIds
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
        # Set up headers
        $customHeaders = New-EntraBetaCustomHeaders -Command $MyInvocation.MyCommand     
        $customHeaders['Content-Type'] = 'application/json'

        $rootUri = (Get-EntraEnvironment -Name (Get-EntraContext).Environment).GraphEndpoint

        if (-not $rootUri) {
            $rootUri = "https://graph.microsoft.com"
            Write-Verbose "Using default Graph endpoint: $rootUri"
        }

        $batchEndpoint = "/beta/`$batch"
        
        # Initialize request collection
        $requests = @()
        
        # Determine target endpoint based on parameter set
        $targetResource = if ($Type -eq "User") { "users" } else { "groups" }
        $targetEndpoint = "users/$UserId/sponsors/`$ref"

        foreach ($sponsorId in $SponsorIds) {
            $request = @{
                id      = $sponsorId
                method  = "POST"
                url     = "/$targetEndpoint"
                body    = @{
                    "@odata.id" = "$rootUri/beta/$targetResource/$sponsorId"
                }
                headers = @{
                    "Content-Type" = "application/json"
                }
            }
            $requests += $request
        }

        # Execute batch request with all sponsors
        if ($requests.Count -gt 0) {
            $batchBody = @{
                requests = $requests
            }
            
            $response = Invoke-MgGraphRequest -Method POST -Uri $batchEndpoint -Body ($batchBody | ConvertTo-Json -Depth 4) -Headers $customHeaders | ConvertTo-Json -Depth 10 | ConvertFrom-Json

            $batchResponse = $response.responses | ForEach-Object {
                if ($_.status -ne 204) {
                    [PSCustomObject]@{
                        Id    = $_.id
                        Error = $_.body.error.message
                    }
                }
            }
            $batchResponse
        } 
        else {
            Write-Error "No sponsors to add."
        }
    }
}
Set-Alias -Name Update-EntraBetaUserSponsor -Value Set-EntraBetaUserSponsor -Description "Set or update the sponsor information for a user." -Scope Global -Force
