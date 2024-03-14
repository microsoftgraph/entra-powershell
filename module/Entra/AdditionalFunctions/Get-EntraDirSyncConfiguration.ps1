# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
function Get-EntraDirSyncConfiguration {
    <#
.PARAMETER TenantId

.PARAMETER <CommonParameters>
    This cmdlet supports the common parameters: Verbose, Debug,
    ErrorAction, ErrorVariable, WarningAction, WarningVariable,
    OutBuffer, PipelineVariable, and OutVariable. For more information, see 
    about_CommonParameters (https:/go.microsoft.com/fwlink/?LinkID=113216). 

.INPUTS 
    System.Nullable`1[[System.Guid, mscorlib, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089]]


#>
    [CmdletBinding(DefaultParameterSetName = 'GetQuery')]
    param (
        [Parameter(ParameterSetName = "GetQuery", Mandatory = $false, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)][ValidateNotNullOrEmpty()][ValidateScript({ if ($_ -is [System.Guid]) { $true } else { throw "TenantId must be of type [System.Guid]." } })][System.guid] $TenantId
    )

    PROCESS {    
        $params = @{}
        $customHeaders = New-CustomHeaders -Module Entra -Command $MyInvocation.MyCommand
        $keysChanged = @{}
        if ($PSBoundParameters.ContainsKey("Verbose")) {
            $params["Verbose"] = $Null
        }
        if ($null -ne $PSBoundParameters["TenantId"]) {
            $params["OnPremisesDirectorySynchronizationId"] = $PSBoundParameters["TenantId"]
        }
        if ($PSBoundParameters.ContainsKey("Debug")) {
            $params["Debug"] = $Null
        }
        Write-Debug("============================ TRANSFORMATIONS ============================")
        $params.Keys | ForEach-Object { "$_ : $($params[$_])" } | Write-Debug
        Write-Debug("=========================================================================`n")
        $response = ((Get-MgDirectoryOnPremiseSynchronization @params).configuration | Select-Object -Property AccidentalDeletionPrevention).AccidentalDeletionPrevention
        # Create a custom table
        $customTable = [PSCustomObject]@{
            "AccidentalDeletionThreshold" = $response.AlertThreshold
            "DeletionPreventionType"      = $response.SynchronizationPreventionType
        }
        $customTable 
    }
}