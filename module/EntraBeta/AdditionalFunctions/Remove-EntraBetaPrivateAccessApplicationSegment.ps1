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
		$customHeaders = New-EntraBetaCustomHeaders -Command $MyInvocation.MyCommand
		Invoke-GraphRequest -Method DELETE -Headers $customHeaders -OutputType PSObject -Uri "https://graph.microsoft.com/beta/applications/$ApplicationId/onPremisesPublishing/segmentsConfiguration/microsoft.graph.ipSegmentConfiguration/applicationSegments/$ApplicationSegmentId"
	}
}