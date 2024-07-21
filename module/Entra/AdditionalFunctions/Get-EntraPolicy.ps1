# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
function Get-EntraPolicy {
    [CmdletBinding(DefaultParameterSetName = 'GetQuery')]
    param (
    [Parameter(ParameterSetName = "GetById", Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
    [System.String] $Id,
    [Parameter(ParameterSetName = "GetQuery", ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
    [System.Nullable`1[System.Int32]] $Top,
    [Parameter(ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
    [switch] $All
    )

    PROCESS {    
        $params = @{}
        $customHeaders = New-EntraCustomHeaders -Command $MyInvocation.MyCommand
        $baseUrl = "https://graph.microsoft.com/v1.0/policies/"
        $endpoints = @("homeRealmDiscoveryPolicies", "claimsMappingPolicies", "tokenIssuancePolicies", "tokenLifetimePolicies", "activityBasedTimeoutPolicies", "featureRolloutPolicies", 	"defaultAppManagementPolicy", "appManagementPolicies", "authenticationFlowsPolicy",	"authenticationMethodsPolicy", "permissionGrantPolicies")
        
        $response = @()
        foreach ($endpoint in $endpoints) {
            $url = "${baseUrl}${endpoint}"
            try {
                $policies = (Invoke-GraphRequest -Headers $customHeaders -Uri $url -Method GET).value
            }
            catch {
                $policies = (Invoke-GraphRequest -Headers $customHeaders -Uri $url -Method GET)
            }
            $policies | ForEach-Object {
                $_.Type = ($endpoint.Substring(0, 1).ToUpper() + $endpoint.Substring(1) -replace "ies", "y")
                $response += $_
                if ($Top -and ($response.Count -ge $Top)) {
                    break 
                }
            }
        }

        if ($PSBoundParameters.ContainsKey("Debug")) {
            $params["Debug"] = $Null
        }
        if ($PSBoundParameters.ContainsKey("Verbose")) {
            $params["Verbose"] = $Null
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
        $params.Keys | ForEach-Object {"$_ : $($params[$_])" } | Write-Debug
        Write-Debug("=========================================================================
")

        $response | ForEach-Object {
            if ($null -ne $_) {
                foreach ($Keys in $_.Keys) { 
                    $Keys=$Keys.SubString(0, 1).ToUpper() + $Keys.Substring(1)
                    $_ | Add-Member -MemberType NoteProperty -Name $Keys -Value ($_.$Keys) -Force
                }
            }
        }
        
        if ($PSBoundParameters.ContainsKey("ID")) {
            $response = $response | Where-Object { $_.id -eq $Id }
            if($Null -eq $response ) {
                Write-Error "Get-EntraPolicy : Error occurred while executing Get-Policy 
                Code: Request_BadRequest
                Message: Invalid object identifier '$Id' ."
            }
        } elseif (-not $All -and $Top) {
            $response = $response | Select-Object -First $Top
        }
        
        $response  
    }     
}