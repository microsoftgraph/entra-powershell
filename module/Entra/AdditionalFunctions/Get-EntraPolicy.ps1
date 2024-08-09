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
        Write-Debug("=========================================================================")

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
        
        $data = $response | ConvertTo-Json -Depth 50 | ConvertFrom-Json
        $respList = @()
       
        foreach ($res in $data) {                                  
            switch ($res.type) {
                "ActivityBasedTimeoutPolicy" { $respType = New-Object Microsoft.Graph.PowerShell.Models.MicrosoftGraphActivityBasedTimeoutPolicy }
                "AppManagementPolicy" { $respType = New-Object Microsoft.Graph.PowerShell.Models.MicrosoftGraphAppManagementPolicy }
                "ClaimsMappingPolicy" { $respType = New-Object Microsoft.Graph.PowerShell.Models.MicrosoftGraphClaimsMappingPolicy }
                "FeatureRolloutPolicy" { $respType = New-Object Microsoft.Graph.PowerShell.Models.MicrosoftGraphFeatureRolloutPolicy }
                "HomeRealmDiscoveryPolicy" { $respType = New-Object Microsoft.Graph.PowerShell.Models.MicrosoftGraphHomeRealmDiscoveryPolicy }
                "TokenIssuancePolicy" { $respType = New-Object Microsoft.Graph.PowerShell.Models.MicrosoftGraphTokenIssuancePolicy }
                "TokenLifetimePolicy" { $respType = New-Object Microsoft.Graph.PowerShell.Models.MicrosoftGraphTokenLifetimePolicy }
                "PermissionGrantPolicy" { $respType = New-Object Microsoft.Graph.PowerShell.Models.MicrosoftGraphPermissionGrantPolicy }
                "DefaultAppManagementPolicy" { $respType = New-Object Microsoft.Graph.PowerShell.Models.MicrosoftGraphappManagementPolicy }
                "AuthenticationFlowsPolicy" { $respType = New-Object Microsoft.Graph.PowerShell.Models.MicrosoftGraphauthenticationFlowsPolicy }
                "AuthenticationMethodsPolicy" { $respType = New-Object Microsoft.Graph.PowerShell.Models.MicrosoftGraphauthenticationMethodsPolicy}
                default { Write-Error "Unknown type: " + $res.type}
            }

            $res.PSObject.Properties | ForEach-Object {
                $propertyName = $_.Name.Substring(0,1).ToUpper() + $_.Name.Substring(1)
                $propertyValue = $_.Value
                $respType | Add-Member -MemberType NoteProperty -Name $propertyName -Value $propertyValue -Force
            }
            $respList += $respType
        }
        $respList  
    }     
}