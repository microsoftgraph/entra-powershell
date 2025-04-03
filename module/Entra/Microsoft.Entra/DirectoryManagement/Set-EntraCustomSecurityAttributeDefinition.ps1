# ------------------------------------------------------------------------------ 
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  
#  Licensed under the MIT License.  See License in the project root for license information. 
# ------------------------------------------------------------------------------ 
function Set-EntraCustomSecurityAttributeDefinition {
    [CmdletBinding(DefaultParameterSetName = 'Default')]
    param (
    [Parameter(Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
    [System.String] $Id,
    
    [Parameter(ParameterSetName = "Default")]
    [System.String] $Description,

    [Parameter(ParameterSetName = "Default")]
    [System.Nullable`1[System.Boolean]] $UsePreDefinedValuesOnly,

    [Parameter(ParameterSetName = "Default")]
    [System.String] $Status
    )

    PROCESS {
        $params = @{}
        $body = @{}
        $customHeaders = New-EntraCustomHeaders -Command $MyInvocation.MyCommand
        $Uri = "/v1.0/directory/customSecurityAttributeDefinitions/$Id"
        $Method = "PATCH"

        if($null -ne $PSBoundParameters["Id"])
        {
            $params["Id"] = $PSBoundParameters["Id"]
        }
        if($null -ne $PSBoundParameters["Description"])
        {
            $body["description"] = $PSBoundParameters["Description"]
        }
        if($null -ne $PSBoundParameters["UsePreDefinedValuesOnly"])
        {
            $body["usePreDefinedValuesOnly"] = $PSBoundParameters["UsePreDefinedValuesOnly"]
        }
        if($null -ne $PSBoundParameters["Status"])
        {
            $body["status"] = $PSBoundParameters["Status"]
        }

        Write-Debug("============================ TRANSFORMATIONS ============================")
        $params.Keys | ForEach-Object {"$_ : $($params[$_])" } | Write-Debug
        Write-Debug("=========================================================================`n")

        $response = Invoke-GraphRequest -Uri $Uri -Method $Method -Body $body -Headers $customHeaders
        $response
    }
}# ------------------------------------------------------------------------------

