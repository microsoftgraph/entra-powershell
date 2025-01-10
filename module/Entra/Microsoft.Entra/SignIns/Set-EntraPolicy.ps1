# ------------------------------------------------------------------------------ 
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  
#  Licensed under the MIT License.  See License in the project root for license information. 
# ------------------------------------------------------------------------------ 

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
        
        $policyTypeMap = @{
            "ActivityBasedTimeoutPolicy"  = "activityBasedTimeoutPolicies"
            "ApplicationManagementPolicy" = "appManagementPolicies"
            "DefaultAppManagementPolicy" = "defaultAppManagementPolicy"
            "AuthenticationFlowsPolicy" = "authenticationFlowsPolicy"
            "AuthenticationMethodsPolicy" = "authenticationMethodsPolicy"
            "ClaimsMappingPolicy" = "claimsMappingPolicies"
            "FeatureRolloutPolicy" = "featureRolloutPolicies"
            "HomeRealmDiscoveryPolicy" = "homeRealmDiscoveryPolicies"
            "PermissionGrantPolicy" = "permissionGrantPolicies"
            "TokenIssuancePolicy" = "tokenIssuancePolicies"
            "TokenLifetimePolicy" = "tokenLifetimePolicies"
        }

        $policyTypes = $policyTypeMap.Values

        if ($null -ne $PSBoundParameters["type"]) {
            $type = if ($policyTypeMap.ContainsKey($type)) { $policyTypeMap[$type] } else { 
                Write-Error "Set-EntraBetADPolicy : Error occurred while executing SetPolicy 
                Code: Request_BadRequest
                Message: Invalid value specified for property 'type' of resource 'Policy'."
                return;  
            }
        } else {
            $type = $null
        }                
        
        if(!$type) {
            foreach ($pType in $policyTypes) {
                $uri = "https://graph.microsoft.com/v1.0/policies/" + $pType + "/" + $id
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
                    
                Write-Debug("============================ TRANSFORMATIONS ============================")
                $params.Keys | ForEach-Object {"$_ : $($params[$_])" } | Write-Debug
                Write-Debug("=========================================================================`n")
            
                $body = $params | ConvertTo-Json
               Invoke-GraphRequest -Headers $customHeaders -Uri $uri -Body $body -Method $Method
               
        }
        
    }    
}