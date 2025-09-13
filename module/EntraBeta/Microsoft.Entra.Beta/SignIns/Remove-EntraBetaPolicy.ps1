# ------------------------------------------------------------------------------ 
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  
#  Licensed under the MIT License.  See License in the project root for license information. 
# ------------------------------------------------------------------------------ 
function Remove-EntraBetaPolicy {
    [CmdletBinding(DefaultParameterSetName = 'Default')]
    param (                
        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
        [System.String] $Id
    )

    begin {
        # Ensure connection to Microsoft Entra
        if (-not (Get-EntraContext)) {
            $errorMessage = "Not connected to Microsoft Graph. Use 'Connect-Entra -Scopes Policy.Read.ApplicationConfiguration' to authenticate."
            Write-Error -Message $errorMessage -ErrorAction Stop
            return
        }
    }

    PROCESS {    
        $params = @{}
        $customHeaders = New-EntraBetaCustomHeaders -Command $MyInvocation.MyCommand
        $array = ("activityBasedTimeoutPolicies",	"defaultAppManagementPolicy",	"appManagementPolicies",	"authenticationFlowsPolicy",	"authenticationMethodsPolicy",	"claimsMappingPolicies",	"featureRolloutPolicies",	"homeRealmDiscoveryPolicies",	"permissionGrantPolicies",	"tokenIssuancePolicies",	"tokenLifetimePolicies")
    
        foreach ($a in $array) {
            $uri = "/beta/policies/" + $a + "/" + $id
            try {
                $response = Invoke-GraphRequest -Uri $uri -Method GET
                break
            }
            catch {}
        }
        $policy = ($response.'@odata.context') -match 'policies/([^/]+)/\$entity'
    
        $type = $Matches[1]
        if (($null -ne $PSBoundParameters["id"]) -and ($null -ne $type )) {
            $URI = "/beta/policies/" + $type + "/" + $id
        }
        $Method = "DELETE"
        Write-Debug("============================ TRANSFORMATIONS ============================")
        $params.Keys | ForEach-Object { "$_ : $($params[$_])" } | Write-Debug
        Write-Debug("=========================================================================`n")
        $response = Invoke-GraphRequest -Headers $customHeaders -Uri $uri -Method $Method
        $response
    }     
}

