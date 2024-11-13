# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
function Remove-EntraBetaPrivateAccessApplicationSegment {

    [CmdletBinding()]
    param (
        [Alias('ObjectId')]
        [Parameter(Mandatory = $True)]
        [System.String]
        $ApplicationId,

        [Parameter(Mandatory = $False)]
        [System.String]
        $ApplicationSegmentId
    )

    PROCESS {
        try {
            # Create custom headers for the request
            $customHeaders = New-EntraBetaCustomHeaders -Command $MyInvocation.MyCommand

            # Construct the URI for the API request
            $uri = "https://graph.microsoft.com/beta/applications/$ApplicationId/onPremisesPublishing/segmentsConfiguration/microsoft.graph.ipSegmentConfiguration/applicationSegments/$ApplicationSegmentId"

            # Invoke the API request to delete the application segment
            Invoke-GraphRequest -Method DELETE -Headers $customHeaders -OutputType PSObject -Uri $uri

            Write-Output "Application segment with ID $ApplicationSegmentId has been removed successfully."
        } catch {
            Write-Error "Failed to remove the application segment: $_"
        }
    }
}