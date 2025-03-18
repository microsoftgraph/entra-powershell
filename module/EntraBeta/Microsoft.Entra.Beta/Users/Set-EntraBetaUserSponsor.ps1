# ------------------------------------------------------------------------------ 
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  
#  Licensed under the MIT License.  See License in the project root for license information. 
# ------------------------------------------------------------------------------ 

function Set-EntraBetaUserSponsor {
    [CmdletBinding(DefaultParameterSetName = "User")]
    param ( 
        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = "The unique identifier (User ID) of the user whose sponsor information you want to set.")]
        [System.String] $UserId,

        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = "Type of sponsor to assign to a User.")]
        [ValidateSet("User", "Group")]
        [System.String] $Type,
        
        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = "List of sponsors to assign to the user.")]
        [string[]] $SponsorIds
    )

    PROCESS {
        # Set up headers
        $customHeaders = New-EntraBetaCustomHeaders -Command $MyInvocation.MyCommand     
        $customHeaders['Content-Type'] = 'application/json'

        $batchEndpoint = "https://graph.microsoft.com/beta/`$batch"
        
        # Initialize request collection
        $requests = @()
        
        # Determine target endpoint based on parameter set
        $targetResource = if ($Type -eq "User") { "users" } else { "groups" }
        $targetEndpoint = "users/$UserId/sponsors/`$ref"

        foreach ($sponsorId in $SponsorIds) {
            $request = @{
                id = $sponsorId
                method = "POST"
                url = "/$targetEndpoint"
                body = @{
                    "@odata.id" = "https://graph.microsoft.com/beta/$targetResource/$sponsorId"
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
            
            $response = Invoke-GraphRequest -Method POST -Uri $batchEndpoint -Body ($batchBody | ConvertTo-Json -Depth 4) -Headers $customHeaders | ConvertTo-Json -Depth 10 | ConvertFrom-Json

            $batchResponse = $response.responses | ForEach-Object {
                if ($_.status -ne 204) {
                    [PSCustomObject]@{
                        Id = $_.id
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