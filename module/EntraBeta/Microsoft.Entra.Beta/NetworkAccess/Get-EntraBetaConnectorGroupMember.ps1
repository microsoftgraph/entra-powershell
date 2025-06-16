# ------------------------------------------------------------------------------ 
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  
#  Licensed under the MIT License.  See License in the project root for license information. 
# ------------------------------------------------------------------------------ 
function Get-EntraBetaConnectorGroupMember {

    [CmdletBinding()]
    param (
        [string]$ProfileId = "applicationProxy",
        [Parameter(Mandatory)]
        [string]$ConnectorGroupId
    )

    PROCESS {
        try {
            # Create custom headers for the request
            $customHeaders = New-EntraBetaCustomHeaders -Command $MyInvocation.MyCommand

            # Construct the URI for the API request
            $uri = "/beta/onPremisesPublishingProfiles/$ProfileId/connectorGroups/$ConnectorGroupId/members"

            # Invoke the API request to get connector group members
            $response = Invoke-GraphRequest -Method GET -Headers $customHeaders -OutputType PSObject -Uri $uri

            # Show the response value if it exists
            if ($response) {
                Write-Output $response.value
            }
            else {
                Write-Error "Failed to retrieve connector group members."
            }
        }
        catch {
            Write-Error "An error occurred while retrieving connector group members: $_"
        }
    }
}