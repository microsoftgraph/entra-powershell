# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

function Get-EntraDirSyncConfiguration {
    [CmdletBinding(DefaultParameterSetName = 'GetQuery')]
    param (
        [Parameter(ParameterSetName = "GetQuery", Mandatory = $false, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)][ValidateNotNullOrEmpty()][ValidateScript({ if ($_ -is [System.Guid]) { $true } else { throw "TenantId must be of type [System.Guid]." } })][System.guid] $TenantId
    )

    PROCESS {    
        $params = @{}
        $customHeaders = New-EntraCustomHeaders -Command $MyInvocation.MyCommand       
        if ($PSBoundParameters.ContainsKey("Verbose")) {
            $params["Verbose"] = $PSBoundParameters["Verbose"]
        }
        if ($null -ne $PSBoundParameters["TenantId"]) {
            $params["OnPremisesDirectorySynchronizationId"] = $PSBoundParameters["TenantId"]
        }
        if ($PSBoundParameters.ContainsKey("Debug")) {
            $params["Debug"] = $PSBoundParameters["Debug"]
        }
        if($null -ne $PSBoundParameters["WarningVariable"])
        {
            $params["WarningVariable"] = $PSBoundParameters["WarningVariable"]
        }
        if($null -ne $PSBoundParameters["InformationVariable"])
        {
            $params["InformationVariable"] = $PSBoundParameters["InformationVariable"]
        }
	    if($null -ne $PSBoundParameters["InformationAction"])
        {
            $params["InformationAction"] = $PSBoundParameters["InformationAction"]
        }
        if($null -ne $PSBoundParameters["OutVariable"])
        {
            $params["OutVariable"] = $PSBoundParameters["OutVariable"]
        }
        if($null -ne $PSBoundParameters["OutBuffer"])
        {
            $params["OutBuffer"] = $PSBoundParameters["OutBuffer"]
        }
        if($null -ne $PSBoundParameters["ErrorVariable"])
        {
            $params["ErrorVariable"] = $PSBoundParameters["ErrorVariable"]
        }
        if($null -ne $PSBoundParameters["PipelineVariable"])
        {
            $params["PipelineVariable"] = $PSBoundParameters["PipelineVariable"]
        }
        if($null -ne $PSBoundParameters["ErrorAction"])
        {
            $params["ErrorAction"] = $PSBoundParameters["ErrorAction"]
        }
        if($null -ne $PSBoundParameters["WarningAction"])
        {
            $params["WarningAction"] = $PSBoundParameters["WarningAction"]
        }
        Write-Debug("============================ TRANSFORMATIONS ============================")
        $params.Keys | ForEach-Object { "$_ : $($params[$_])" } | Write-Debug
        Write-Debug("=========================================================================`n")
        $response = ((Get-MgDirectoryOnPremiseSynchronization @params -Headers $customHeaders).configuration | Select-Object -Property AccidentalDeletionPrevention).AccidentalDeletionPrevention
        # Create a custom table
        $customTable = [PSCustomObject]@{
            "AccidentalDeletionThreshold" = $response.AlertThreshold
            "DeletionPreventionType"      = $response.SynchronizationPreventionType
        }
        $customTable 
    }
}