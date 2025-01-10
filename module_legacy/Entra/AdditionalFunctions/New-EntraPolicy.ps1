# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
function New-EntraPolicy {
    [CmdletBinding(DefaultParameterSetName = 'NewPolicy')]
    param (
    [Parameter(ParameterSetName = "NewPolicy", Mandatory = $true)]
    [System.Collections.Generic.List`1[System.String]] $Definition,
    [Parameter(ParameterSetName = "NewPolicy", Mandatory = $true)]
    [System.String] $DisplayName,
    [Parameter(ParameterSetName = "NewPolicy", Mandatory = $true)]
    [System.String] $Type,
    [Parameter(ParameterSetName = "NewPolicy")]
    [System.Collections.Generic.List`1[Microsoft.Open.MSGraph.Model.KeyCredential]] $KeyCredentials,
    [Parameter(ParameterSetName = "NewPolicy")]
    [System.Nullable`1[System.Boolean]] $IsOrganizationDefault,
    [Parameter(ParameterSetName = "NewPolicy")]
    [System.String] $AlternativeIdentifier
    )

    PROCESS {    
        $params = @{}
        $customHeaders = New-EntraCustomHeaders -Command $MyInvocation.MyCommand
        $params["Type"] = $Type
        $respType = $null

        if($params.type -eq "activityBasedTimeoutPolicy" ) {
            $params.type  = "activityBasedTimeoutPolicies"
            $respType = New-Object -TypeName Microsoft.Graph.PowerShell.Models.MicrosoftGraphActivityBasedTimeoutPolicy 
        }
        elseif ($params.type -eq "ApplicationManagementPolicy") {
         $params.type = "appManagementPolicies"
         $respType = New-Object -TypeName Microsoft.Graph.PowerShell.Models.MicrosoftGraphAppManagementPolicy
        }
        elseif ($params.type -eq "claimsMappingPolicies") {
             $params.type = "claimsMappingPolicies"
             $respType = New-Object -TypeName Microsoft.Graph.PowerShell.Models.MicrosoftGraphClaimsMappingPolicy 
        }
        elseif ($params.type -eq "featureRolloutPolicy") {
            $params.type = "featureRolloutPolicies"
            $respType = New-Object -TypeName Microsoft.Graph.PowerShell.Models.MicrosoftGraphFeatureRolloutPolicy
        }
        elseif ($params.type -eq "HomeRealmDiscoveryPolicy") {
             $params.type = "homeRealmDiscoveryPolicies"
             $respType = New-Object -TypeName Microsoft.Graph.PowerShell.Models.MicrosoftGraphHomeRealmDiscoveryPolicy
        }
        elseif ($params.type -eq "tokenIssuancePolicy") {
            $params.type = "tokenIssuancePolicies"
            $respType = New-Object -TypeName Microsoft.Graph.PowerShell.Models.MicrosoftGraphTokenIssuancePolicy  
        }
        elseif ($params.type -eq "tokenLifetimePolicy") {
            $params.type = "tokenLifetimePolicies"
            $respType = New-Object -TypeName Microsoft.Graph.PowerShell.Models.MicrosoftGraphTokenLifetimePolicy
        }
        elseif ($params.type -eq "permissionGrantPolicy") {
            $params.type = "permissionGrantPolicies"
            $respType = New-Object -TypeName Microsoft.Graph.PowerShell.Models.MicrosoftGraphPermissionGrantPolicy 
        }
        $params["Uri"] = "https://graph.microsoft.com/v1.0/policies/" + $params.type
        $Definition =$PSBoundParameters["Definition"]
        $DisplayName=$PSBoundParameters["DisplayName"]
        $AlternativeIdentifier = $PSBoundParameters["AlternativeIdentifier"]
        $KeyCredentials = $PSBoundParameters["KeyCredentials"]
        $IsOrganizationDefault =$PSBoundParameters["IsOrganizationDefault"]
        $params["Method"] = "POST"
       
        $body = @{
            Definition = $Definition
            DisplayName = $DisplayName
            IsOrganizationDefault = $IsOrganizationDefault
            AlternativeIdentifier =$AlternativeIdentifier
            KeyCredentials = $KeyCredentials
            Type = $Type
        }
        $body = $body | ConvertTo-Json
        Write-Debug("============================ TRANSFORMATIONS ============================")
        $params.Keys | ForEach-Object {"$_ : $($params[$_])" } | Write-Debug
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