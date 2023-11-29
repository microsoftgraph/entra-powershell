# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
function Get-EntraHasObjectsWithDirSyncProvisioningErrors {
    <#
.PARAMETER TenantId

.PARAMETER <commonParameters>
        This cmdlet supports the common parameters: Verbose, Debug,
        ErrorAction, ErrorVariable, WarningAction, WarningVariable,
        OutBuffer, PipelineVariable, and OutVariable. For more information, see 
        about_CommonParameters (https:/go.microsoft.com/fwlink/?LinkID=113216). 

.INPUTS
System.Nullable`1[[System.Guid, mscorlib, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089]]
#>
    [CmdletBinding(DefaultParameterSetName = 'GetById')]
    param (
        [Parameter(ParameterSetName = "GetById")][ValidateNotNullOrEmpty()][ValidateScript({if ($_ -is [System.Guid]) { $true } else {throw "TenantId must be of type [System.Guid]."}})][System.Guid] $TenantId
    )
    PROCESS {    
        $params = @{}
        if ($PSBoundParameters.ContainsKey("Verbose")) {
            $params["Verbose"] = $Null
        }
        if ($null -ne $PSBoundParameters["TenantId"]) {
            $params["TenantId"] = $PSBoundParameters["TenantId"]
        }
        if ($PSBoundParameters.ContainsKey("Debug")) {
            $params["Debug"] = $Null
        }
        Write-Debug("============================ TRANSFORMATIONS ============================")
        $params.Keys | ForEach-Object { "$_ : $($params[$_])" } | Write-Debug
        Write-Debug("=========================================================================`n")
        $Object = @("users", "groups", "contacts")
        $response = @()
        
        foreach ($obj in $object) {
            $obj = ($obj | Out-String).trimend()
            $uri = 'https://graph.microsoft.com/v1.0/' + $obj + '?$select=onPremisesProvisioningErrors'
            $response += ((Invoke-GraphRequest -Uri $uri -Method GET).value).onPremisesProvisioningErrors   
        }
        if ([string]::IsNullOrWhiteSpace($response)) {
            write-host "False"
        }
        else {
            $response
        }
        
    }
}