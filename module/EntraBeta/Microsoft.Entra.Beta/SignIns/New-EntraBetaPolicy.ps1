# ------------------------------------------------------------------------------ 
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  
#  Licensed under the MIT License.  See License in the project root for license information. 
# ------------------------------------------------------------------------------ 
function New-EntraBetaPolicy {
    [CmdletBinding(DefaultParameterSetName = 'ByTypeAndDefinition')]
    param (                
        [Parameter(ParameterSetName = "ByTypeAndDefinition")]
        [System.Nullable`1[System.Boolean]] $IsOrganizationDefault,
                
        [Parameter(ParameterSetName = "ByTypeAndDefinition", Mandatory = $true)]
        [System.String] $DisplayName,
                
        [Parameter(ParameterSetName = "ByTypeAndDefinition")]
        [System.Collections.Generic.List`1[Microsoft.Open.MSGraph.Model.KeyCredential]] $KeyCredentials,
                
        [Parameter(ParameterSetName = "ByTypeAndDefinition", Mandatory = $true)]
        [System.Collections.Generic.List`1[System.String]] $Definition,
                
        [Parameter(ParameterSetName = "ByTypeAndDefinition", Mandatory = $true)]
        [System.String] $Type,
                
        [Parameter(ParameterSetName = "ByTypeAndDefinition")]
        [System.String] $AlternativeIdentifier
    )

    PROCESS {    
        $params = @{}
        $customHeaders = New-EntraBetaCustomHeaders -Command $MyInvocation.MyCommand
        $params["Type"] = $Type        
        $respType = $null

        if ($params.type -eq "activityBasedTimeoutPolicy" ) {
            $params.type = "activityBasedTimeoutPolicies"    
            $respType = New-Object -TypeName Microsoft.Graph.Beta.PowerShell.Models.MicrosoftGraphActivityBasedTimeoutPolicy    
        }
        elseif ($params.type -eq "appManagementPolicy") {
            $params.type = "appManagementPolicies"
            $respType = New-Object -TypeName Microsoft.Graph.Beta.PowerShell.Models.MicrosoftGraphAppManagementPolicy
        }
        elseif ($params.type -eq "claimsMappingPolicies") {
            $params.type = "claimsMappingPolicies"         
            $respType = New-Object -TypeName Microsoft.Graph.Beta.PowerShell.Models.MicrosoftGraphClaimsMappingPolicy     
        } 
        elseif ($params.type -eq "featureRolloutPolicy") {
            $params.type = "featureRolloutPolicies"
            $respType = New-Object -TypeName Microsoft.Graph.Beta.PowerShell.Models.MicrosoftGraphFeatureRolloutPolicy   
        }
        elseif ($params.type -eq "HomeRealmDiscoveryPolicy") {
            $params.type = "homeRealmDiscoveryPolicies"
            $respType = New-Object -TypeName Microsoft.Graph.Beta.PowerShell.Models.MicrosoftGraphHomeRealmDiscoveryPolicy 
        }
        elseif ($params.type -eq "tokenIssuancePolicy") {
            $params.type = "tokenIssuancePolicies"
            $respType = New-Object -TypeName Microsoft.Graph.Beta.PowerShell.Models.MicrosoftGraphTokenIssuancePolicy   
        }
        elseif ($params.type -eq "tokenLifetimePolicy") {
            $params.type = "tokenLifetimePolicies"
            $respType = New-Object -TypeName Microsoft.Graph.Beta.PowerShell.Models.MicrosoftGraphTokenLifetimePolicy 
        }
        elseif ($params.type -eq "permissionGrantPolicy") {
            $params.type = "permissionGrantPolicies"
            $respType = New-Object -TypeName Microsoft.Graph.Beta.PowerShell.Models.MicrosoftGraphPermissionGrantPolicy 
        }

        $params["Uri"] = "/beta/policies/" + $params.type
        $Definition = $PSBoundParameters["Definition"]
        $DisplayName = $PSBoundParameters["DisplayName"]
        $AlternativeIdentifier = $PSBoundParameters["AlternativeIdentifier"]
        $KeyCredentials = $PSBoundParameters["KeyCredentials"]
        $IsOrganizationDefault = $PSBoundParameters["IsOrganizationDefault"]
        $params["Method"] = "POST"
       
        $body = @{
            Definition            = $Definition
            DisplayName           = $DisplayName
            IsOrganizationDefault = $IsOrganizationDefault
            AlternativeIdentifier = $AlternativeIdentifier
            KeyCredentials        = $KeyCredentials
            Type                  = $Type
        }
        $body = $body | ConvertTo-Json        
        Write-Debug("============================ TRANSFORMATIONS ============================")
        $params.Keys | ForEach-Object { "$_ : $($params[$_])" } | Write-Debug
        Write-Debug("=========================================================================`n")


        $response = Invoke-GraphRequest -Headers $customHeaders -Uri $params.uri -Method $params.method -Body $body | ConvertTo-Json | ConvertFrom-Json
       
        $response.PSObject.Properties | ForEach-Object {
            $propertyName = $_.Name
            $propertyValue = $_.Value
            $respType | Add-Member -MemberType NoteProperty -Name $propertyName -Value $propertyValue -Force
    
        }
            
        $respType
    }        
}

