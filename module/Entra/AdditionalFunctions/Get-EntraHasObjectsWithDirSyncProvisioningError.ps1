# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
function Get-EntraHasObjectsWithDirSyncProvisioningError {
    [CmdletBinding(DefaultParameterSetName = 'GetById')]
    param (
        [Parameter(ParameterSetName = "GetById")][ValidateNotNullOrEmpty()][ValidateScript({if ($_ -is [System.Guid]) { $true } else {throw "TenantId must be of type [System.Guid]."}})][System.Guid] $TenantId
    )
    PROCESS {    
        $params = @{}
        $customHeaders = New-EntraCustomHeaders -Command $MyInvocation.MyCommand
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
        
        try {
            foreach ($obj in $object) {
                $obj = ($obj | Out-String).trimend()
                $uri = 'https://graph.microsoft.com/v1.0/' + $obj + '?$select=onPremisesProvisioningErrors'
                $response += ((Invoke-GraphRequest -Headers $customHeaders -Uri $uri -Method GET).value).onPremisesProvisioningErrors
            }
        }
        catch {}
        if ([string]::IsNullOrWhiteSpace($response)) {
            write-host "False"
        }
        else {
            $response
        }
        
    }
}