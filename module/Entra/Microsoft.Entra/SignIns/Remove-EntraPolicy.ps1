# ------------------------------------------------------------------------------ 
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  
#  Licensed under the MIT License.  See License in the project root for license information. 
# ------------------------------------------------------------------------------ 

function Remove-EntraPolicy {
    [CmdletBinding(DefaultParameterSetName = 'Default')]
    param (
        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
        [System.String] $Id
    )

    begin {
        # Ensure connection to Microsoft Entra
        if (-not (Get-EntraContext)) {
            $errorMessage = "Not connected to Microsoft Graph. Use 'Connect-Entra -Scopes Policy.ReadWrite.ApplicationConfiguration' to authenticate."
            Write-Error -Message $errorMessage -ErrorAction Stop
            return
        }
    }

    PROCESS {    
        $params = @{}
        $customHeaders = New-EntraCustomHeaders -Command $MyInvocation.MyCommand
        $policyTypes = "activityBasedTimeoutPolicies", "DefaultAppManagementPolicy", "appManagementPolicies", "authenticationFlowsPolicy", "authenticationMethodsPolicy", "claimsMappingPolicies", "featureRolloutPolicies", "homeRealmDiscoveryPolicies", "permissionGrantPolicies", "tokenIssuancePolicies", "tokenLifetimePolicies"
    
        foreach ($policyType in $policyTypes) {
            $uri = "/v1.0/policies/" + $policyType + "/" + $id
            try {
                $response = Invoke-GraphRequest -Headers $customHeaders -Uri $uri -Method GET
                break
            }
            catch {}
        }
        $policy = ($response.'@odata.context') -match 'policies/([^/]+)/\$entity'
    
        $policyType = $Matches[1]

        Write-Debug("============================ Matches ============================")

        Write-Debug($Matches[1])

        if (($null -ne $PSBoundParameters["id"]) -and ($null -ne $policyType )) {
            $URI = "/v1.0/policies/" + $policyType + "/" + $id
        }
        $Method = "DELETE"
        Write-Debug("============================ TRANSFORMATIONS ============================")
        $params.Keys | ForEach-Object { "$_ : $($params[$_])" } | Write-Debug
        Write-Debug("=========================================================================`n")
        $response = Invoke-GraphRequest -Headers $customHeaders -Uri $uri -Method $Method
        $response
    }     
}

