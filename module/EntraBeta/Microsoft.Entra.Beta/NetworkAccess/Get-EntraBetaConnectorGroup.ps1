# ------------------------------------------------------------------------------ 
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  
#  Licensed under the MIT License.  See License in the project root for license information. 
# ------------------------------------------------------------------------------ 
function Get-EntraBetaConnectorGroup {
    
    [CmdletBinding(DefaultParameterSetName = 'applicationProxy')]
    param (
        [Alias('ObjectId')]
        [string]$ProfileId = "applicationProxy"
    )

    PROCESS {
        try {
            # Create custom headers for the request
            $customHeaders = New-EntraBetaCustomHeaders -Command $MyInvocation.MyCommand

            # Construct the URI for the API request
            $uri = "/beta/onPremisesPublishingProfiles/$ProfileId/connectorGroups"

            # Invoke the API request to get connector groups
            $response = Invoke-GraphRequest -Method GET -Headers $customHeaders -OutputType PSObject -Uri $uri

            # Show the response value if it exists
            $response.value
        }
        catch {
            Write-Error "An error occurred while retrieving connector groups: $_"
        }
    }
}