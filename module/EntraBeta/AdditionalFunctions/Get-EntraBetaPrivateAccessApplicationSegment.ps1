# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
function Get-EntraBetaPrivateAccessApplicationSegment {

	[CmdletBinding(DefaultParameterSetName = 'AllApplicationSegments')]
	param (

		[Alias('id')]
		[Parameter(Mandatory = $True, Position = 1, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
		[string]
		$ObjectId,
		
		[Parameter(Mandatory = $False, Position = 2, ParameterSetName = 'SingleApplicationSegment')]
		[string]
		$ApplicationSegmentId
	)

    PROCESS {  
    $customHeaders = New-EntraBetaCustomHeaders -Command $MyInvocation.MyCommand

	switch ($PSCmdlet.ParameterSetName) {
		"AllApplicationSegments" {
			$response = Invoke-GraphRequest -Method GET -Headers $customHeaders -OutputType PSObject -Uri "https://graph.microsoft.com/beta/applications/$ObjectId/onPremisesPublishing/segmentsConfiguration/microsoft.graph.ipSegmentConfiguration/applicationSegments"
			$response.value
            break
		}			
		"SingleApplicationSegment" {
			Invoke-GraphRequest -Method GET -Headers $customHeaders -OutputType PSObject -Uri "https://graph.microsoft.com/beta/applications/$ObjectId/onPremisesPublishing/segmentsConfiguration/microsoft.graph.ipSegmentConfiguration/applicationSegments/$ApplicationSegmentId"
			break
		}
	    }
    }
}
