# ------------------------------------------------------------------------------ 
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  
#  Licensed under the MIT License.  See License in the project root for license information. 
# ------------------------------------------------------------------------------ 
function Set-EntraBetaApplicationProxyConnectorGroup {
    [CmdletBinding(DefaultParameterSetName = 'Default')]
    param (
        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = "Unique ID of the connector group object (Connector Group Object ID).")]
        [ValidateNotNullOrEmpty()]
        [System.String] $Id,
    
        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = "Name of the connector group.")]
        [ValidateNotNullOrEmpty()]
        [System.String] $Name
    )

    PROCESS {    
        $params = @{}
        $customHeaders = New-EntraBetaCustomHeaders -Command $MyInvocation.MyCommand
        $params["Method"] = "PATCH"
        $body = @{}
        if ($null -ne $PSBoundParameters["Id"]) {
            $params["Uri"] = "/beta/onPremisesPublishingProfiles/applicationProxy/connectorGroups/$Id"
        }
        if ($null -ne $PSBoundParameters["Name"]) {
            $body["Name"] = $PSBoundParameters["Name"]
        }

        $body = $body | ConvertTo-Json

        Write-Debug("============================ TRANSFORMATIONS ============================")
        $params.Keys | ForEach-Object { "$_ : $($params[$_])" } | Write-Debug
        Write-Debug("=========================================================================`n")

        Invoke-GraphRequest -Headers $customHeaders -Method $params.method -Uri $params.uri -Body $body
    }        
}

