function Set-EntraPolicy {
    [CmdletBinding(DefaultParameterSetName = 'InvokeByDynamicParameters')]
    param (
    [Parameter(ParameterSetName = "InvokeByDynamicParameters")]
    [System.String] $AlternativeIdentifier,
    [Parameter(Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
    [System.String] $Id,
    [Parameter(ParameterSetName = "InvokeByDynamicParameters")]
    [System.Collections.Generic.List`1[System.String]] $Definition,
    [Parameter(ParameterSetName = "InvokeByDynamicParameters")]
    [System.String] $DisplayName,
    [Parameter(ParameterSetName = "InvokeByDynamicParameters")]
    [System.String] $Type,
    [Parameter(ParameterSetName = "InvokeByDynamicParameters")]
    [System.Collections.Generic.List`1[Microsoft.Open.MSGraph.Model.KeyCredential]] $KeyCredentials,
    [Parameter(ParameterSetName = "InvokeByDynamicParameters")]
    [System.Nullable`1[System.Boolean]] $IsOrganizationDefault
    )

    PROCESS {    
        $params = @{}
        $customHeaders = New-EntraCustomHeaders -Command $MyInvocation.MyCommand
        
        $policyTypes = "activityBasedTimeoutPolicies", "defaultAppManagementPolicy", "appManagementPolicies", "authenticationFlowsPolicy", "authenticationMethodsPolicy",	"claimsMappingPolicies", "featureRolloutPolicies", "homeRealmDiscoveryPolicies", "permissionGrantPolicies",	"tokenIssuancePolicies", "tokenLifetimePolicies"
        if ($null -ne $PSBoundParameters["type"]) {
            $toPolicytype = $type
        }
         else {
             $toPolicytype = $null
         }
        
         if($null -eq $toPolicytype) {
            foreach ($policyType in $policyTypes) {
                $uri = "https://graph.microsoft.com/v1.0/policies/" + $policyTypes + "/" + $id
                try {
                    $response = Invoke-GraphRequest -Uri $uri -Method GET
                    break
                }
                catch {}
            }
            $policy = ($response.'@odata.context') -match 'policies/([^/]+)/\$entity'
            $type = $Matches[1]
        }
            if($policyTypes -notcontains $type) {
                Write-Error "Set-AzureADPolicy : Error occurred while executing SetPolicy 
                Code: Request_BadRequest
                Message: Invalid value specified for property 'type' of resource 'Policy'."
            }
            else {
                if ($null -ne $PSBoundParameters["Definition"]) {
                    $params["Definition"] = $PSBoundParameters["Definition"]
                }
                if ($null -ne $PSBoundParameters["DisplayName"]) {
                    $params["DisplayName"] = $PSBoundParameters["DisplayName"]
                }
                if ($null -ne $PSBoundParameters["Definition"]) {
                    $params["Definition"] = $PSBoundParameters["Definition"]
                }
                if ($null -ne $PSBoundParameters["IsOrganizationDefault"]) {
                    $params["IsOrganizationDefault"] = $PSBoundParameters["IsOrganizationDefault"]
                }
                if (($null -ne $PSBoundParameters["id"]) -and ($null -ne $type )) {
                    $URI = "https://graph.microsoft.com/v1.0/policies/" + $type + "/" + $id
                }
                
                $Method = "PATCH"
            
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
                    Write-Debug("=========================================================================`n")
                
                    $body = $params | ConvertTo-Json
                    $response = Invoke-GraphRequest -Headers $customHeaders -Uri $uri -Body $body -Method $Method
                    $response
            }
        
    }    
}