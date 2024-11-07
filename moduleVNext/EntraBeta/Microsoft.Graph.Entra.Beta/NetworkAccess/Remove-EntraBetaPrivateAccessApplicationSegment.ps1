# ------------------------------------------------------------------------------ 
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  
#  Licensed under the MIT License.  See License in the project root for license information. 
# ------------------------------------------------------------------------------ 
function Remove-EntraBetaPrivateAccessApplicationSegment {

	[CmdletBinding()]
	param (
		[Alias('ObjectId')]
		[Parameter(Mandatory = $True, Position = 1)]
		[string]
		$ApplicationId,
		[Parameter(Mandatory = $False, Position = 2)]
		[string]
		$ApplicationSegmentId
	)

	PROCESS {
		$customHeaders = New-EntraBetaCustomHeaders -Command $MyInvocation.MyCommand
		Invoke-GraphRequest -Method DELETE -Headers $customHeaders -OutputType PSObject -Uri "https://graph.microsoft.com/beta/applications/$ApplicationId/onPremisesPublishing/segmentsConfiguration/microsoft.graph.ipSegmentConfiguration/applicationSegments/$ApplicationSegmentId"
	}
}function Restore-EntraBetaDeletedDirectoryObject {
    [CmdletBinding(DefaultParameterSetName = '')]
    param (
    [Parameter(Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
    [System.String] $Id,
    [Parameter(ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
    [switch] $AutoReconcileProxyConflict
    )

    PROCESS {    
        $params = @{}
        $customHeaders = New-EntraBetaCustomHeaders -Command $MyInvocation.MyCommand
        $params["Uri"] = 'https://graph.microsoft.com/beta/directory/deletedItems/'   
        $params["Method"] = "POST"    
        if($null -ne $PSBoundParameters["Id"])
        {
            $params["Uri"] += $Id+"/microsoft.graph.restore"      
        }
        if($PSBoundParameters.ContainsKey("AutoReconcileProxyConflict"))
        {
            $params["Body"] = @{
                autoReconcileProxyConflict = $true
            }
        }
    
        Write-Debug("============================ TRANSFORMATIONS ============================")
        $params.Keys | ForEach-Object {"$_ : $($params[$_])" } | Write-Debug
        Write-Debug("=========================================================================`n")
        
        $response = Invoke-GraphRequest @params -Headers $customHeaders
        if($response){
            $userList = @()
            foreach ($data in $response) {
                $userType = New-Object Microsoft.Graph.Beta.PowerShell.Models.MicrosoftGraphDirectoryObject
                $data.PSObject.Properties | ForEach-Object {
                    $propertyName = $_.Name
                    $propertyValue = $_.Value
                    $userType | Add-Member -MemberType NoteProperty -Name $propertyName -Value $propertyValue -Force
                }
                $userList += $userType
            }
            $userList
        }
    }
}# ------------------------------------------------------------------------------

