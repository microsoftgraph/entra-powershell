# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

function Get-EntraBetaPrivateAccessApplicationSegment {

	[CmdletBinding(DefaultParameterSetName = 'AllApplicationSegments')]
	param (
		[Alias('ObjectId')]
		[Parameter(Mandatory = $True, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
		[System.String]
		$ApplicationId,
		[Parameter(Mandatory = $False, ParameterSetName = 'SingleApplicationSegment')]
		[System.String]
		$ApplicationSegmentId
	)

    PROCESS {
        $customHeaders = New-EntraBetaCustomHeaders -Command $MyInvocation.MyCommand
		switch ($PSCmdlet.ParameterSetName) {
			"AllApplicationSegments" {
				$response = Invoke-GraphRequest -Method GET -Headers $customHeaders -OutputType PSObject -Uri "https://graph.microsoft.com/beta/applications/$ApplicationId/onPremisesPublishing/segmentsConfiguration/microsoft.graph.ipSegmentConfiguration/applicationSegments"
				$response.value
				break
			}
			"SingleApplicationSegment" {
				Invoke-GraphRequest -Method GET -Headers $customHeaders -OutputType PSObject -Uri "https://graph.microsoft.com/beta/applications/$ApplicationId/onPremisesPublishing/segmentsConfiguration/microsoft.graph.ipSegmentConfiguration/applicationSegments/$ApplicationSegmentId"
				break
			}
	    }
    }
}
