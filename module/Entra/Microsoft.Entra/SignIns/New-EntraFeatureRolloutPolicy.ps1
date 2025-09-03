# ------------------------------------------------------------------------------ 
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  
#  Licensed under the MIT License.  See License in the project root for license information. 
# ------------------------------------------------------------------------------ 

function New-EntraFeatureRolloutPolicy {
    [CmdletBinding(DefaultParameterSetName = 'ByFeatureRolloutProperties')]
    param (
        [Parameter(ParameterSetName = "ByFeatureRolloutProperties")]
        [System.String] $Description,

        [Parameter(ParameterSetName = "ByFeatureRolloutProperties")]
        [System.Nullable`1[System.Boolean]] $IsAppliedToOrganization,

        [Parameter(ParameterSetName = "ByFeatureRolloutProperties", Mandatory = $true)]
        [System.String] $DisplayName,

        [Parameter(ParameterSetName = "ByFeatureRolloutProperties", Mandatory = $true)]
        [System.String] $Feature,

        [Parameter(ParameterSetName = "ByFeatureRolloutProperties", Mandatory = $true)]
        [System.Nullable`1[System.Boolean]] $IsEnabled,
        
        [Parameter(ParameterSetName = "ByFeatureRolloutProperties")]
        [System.Collections.Generic.List`1[Microsoft.Open.MSGraph.Model.MsDirectoryObject]] $AppliesTo
    )

    begin {
        # Ensure connection to Microsoft Entra
        if (-not (Get-EntraContext)) {
            $errorMessage = "Not connected to Microsoft Graph. Use 'Connect-Entra -Scopes Directory.ReadWrite.All' to authenticate."
            Write-Error -Message $errorMessage -ErrorAction Stop
            return
        }
    }

    PROCESS {    
        $params = @{}
        $customHeaders = New-EntraCustomHeaders -Command $MyInvocation.MyCommand
        $params = @{}
        $body = @{}
        $params["Uri"] = '/v1.0/policies/featureRolloutPolicies/'
        $params["Method"] = "POST"
    
        if ($null -ne $PSBoundParameters["Description"]) {
            $body["Description"] = $PSBoundParameters["Description"]
        }
        if ($null -ne $PSBoundParameters["IsAppliedToOrganization"]) {
            $body["IsAppliedToOrganization"] = $PSBoundParameters["IsAppliedToOrganization"]
        }
        if ($null -ne $PSBoundParameters["DisplayName"]) {
            $body["DisplayName"] = $PSBoundParameters["DisplayName"]
        }
        if ($null -ne $PSBoundParameters["Feature"]) {
            $body["Feature"] = $PSBoundParameters["Feature"]
        }
        if ($null -ne $PSBoundParameters["IsEnabled"]) {
            $body["IsEnabled"] = $PSBoundParameters["IsEnabled"]
        }
        if ($null -ne $PSBoundParameters["AppliesTo"]) {
            $body["AppliesTo"] = $PSBoundParameters["AppliesTo"]
        }

        $params["Body"] = $body

        Write-Debug("============================ TRANSFORMATIONS ============================")
        $params.Keys | ForEach-Object { "$_ : $($params[$_])" } | Write-Debug
        Write-Debug("=========================================================================`n")
    
        $data = Invoke-GraphRequest @params -Headers $customHeaders | ConvertTo-Json | ConvertFrom-Json
        if ($data) {
            $userList = @()
            foreach ($response in $data) {
                $userType = New-Object Microsoft.Graph.PowerShell.Models.MicrosoftGraphFeatureRolloutPolicy
                $response.PSObject.Properties | ForEach-Object {
                    $propertyName = $_.Name
                    $propertyValue = $_.Value
                    $userType | Add-Member -MemberType NoteProperty -Name $propertyName -Value $propertyValue -Force
                }
                $userList += $userType
            }
            $userList
        }  
    }
}

