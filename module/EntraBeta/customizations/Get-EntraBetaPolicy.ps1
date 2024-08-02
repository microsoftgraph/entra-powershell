# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
@{
    SourceName = "Get-AzureADPolicy"
    TargetName = $null
    Parameters = $null
    Outputs = $null
    CustomScript = @'
    PROCESS {    
        $params = @{}
        $customHeaders = New-EntraBetaCustomHeaders -Command $MyInvocation.MyCommand
        $baseUrl = "https://graph.microsoft.com/beta/policies/"
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
            $params["Debug"] = $PSBoundParameters["Debug"]
        }
        if ($PSBoundParameters.ContainsKey("Verbose")) {
            $params["Verbose"] = $PSBoundParameters["Verbose"]
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

        Write-Host($response.type)

        # $response | ForEach-Object {
        #     if ($null -ne $_) {
        #         foreach ($Keys in $_.Keys) { 
        #             $Keys=$Keys.SubString(0, 1).ToUpper() + $Keys.Substring(1)
        #             $_ | Add-Member -MemberType NoteProperty -Name $Keys -Value ($_.$Keys) -Force
        #         }
        #     }
        # }
        
        if ($PSBoundParameters.ContainsKey("ID")) {
            $response = $response | Where-Object { $_.id -eq $Id }
            if($Null -eq $response ) {
                Write-Error "Get-EntraBetaPolicy : Error occurred while executing Get-Policy 
                Code: Request_BadRequest
                Message: Invalid object identifier '$Id' ."
            }
        } elseif (-not $All -and $Top) {
            $response = $response | Select-Object -First $Top
        }
         
        $data = $response | ConvertTo-Json -Depth 10 | ConvertFrom-Json        
        $respList = @()
       
        foreach ($res in $data) {                      
            switch ($res.type) {
                "activityBasedTimeoutPolicy" { $respType = New-Object Microsoft.Graph.Beta.PowerShell.Models.MicrosoftGrphActivityBasedTimeoutPolicy }
                "appManagementPolicy" { $respType = New-Object Microsoft.Graph.Beta.PowerShell.Models.MicrosoftGraphAppManagementPolicy }
                "claimsMappingPolicies" { $respType = New-Object Microsoft.Graph.Beta.PowerShell.Models.MicrosoftGraphClaimsMappingPolicy }
                "featureRolloutPolicy" { $respType = New-Object Microsoft.Graph.Beta.PowerShell.Models.MicrosoftGraphFeatureRolloutPolicy }
                "HomeRealmDiscoveryPolicy" { $respType = New-Object Microsoft.Graph.Beta.PowerShell.Models.MicrosoftGraphHomeRealmDiscoveryPolicy }
                "tokenIssuancePolicy" { $respType = New-Object Microsoft.Graph.Beta.PowerShell.Models.MicrosoftGraphTokenIssuancePolicy }
                "tokenLifetimePolicy" { $respType = New-Object Microsoft.Graph.Beta.PowerShell.Models.MicrosoftGraphTokenLifetimePolicy }
                "permissionGrantPolicy" { $respType = New-Object Microsoft.Graph.Beta.PowerShell.Models.MicrosoftGraphPermissionGrantPolicy }
                default { Write-Error "Unknown type: $Type" }
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
 
'@
}