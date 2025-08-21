# ------------------------------------------------------------------------------ 
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  
#  Licensed under the MIT License.  See License in the project root for license information. 
# ------------------------------------------------------------------------------ 
function Remove-EntraBetaPrivateAccessApplicationSegment {

    [CmdletBinding(DefaultParameterSetName = 'Default')]
    param (
        [Alias('ObjectId')]
        [Parameter(Mandatory = $True, HelpMessage = "The object ID of a Private Access application object.")]
        [ValidateNotNullOrEmpty()]
        [System.String] $ApplicationId,

        [Parameter(Mandatory = $False, HelpMessage = "The application segment ID of the application segment to be deleted.")]
        [System.String] $ApplicationSegmentId
    )

    PROCESS {
        try {
            # Create custom headers for the request
            $customHeaders = New-EntraBetaCustomHeaders -Command $MyInvocation.MyCommand

            # Construct the URI for the API request
            $uri = "/beta/applications/$ApplicationId/onPremisesPublishing/segmentsConfiguration/microsoft.graph.ipSegmentConfiguration/applicationSegments/$ApplicationSegmentId"

            # Invoke the API request to delete the application segment
            Invoke-GraphRequest -Method DELETE -Headers $customHeaders -OutputType PSObject -Uri $uri

            Write-Output "Application segment with ID $ApplicationSegmentId has been removed successfully."
        }
        catch {
            Write-Error "Failed to remove the application segment: $_"
        }
    }
}
