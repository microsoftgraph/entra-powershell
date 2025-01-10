# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
function Update-EntraOauth2PermissionGrant {
    [CmdletBinding(DefaultParameterSetName = 'InvokeByDynamicParameters')]
    param (
        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
        [Alias("Id")]
        [System.String] $OAuth2PermissionGrantId,
               
        [Parameter(Mandatory = $false)]
        [System.String] $Scope
    )

    PROCESS {
        $params = @{}
        $body = @{}
        $customHeaders = New-EntraCustomHeaders -Command $MyInvocation.MyCommand
        $params["Uri"] = "https://graph.microsoft.com/v1.0/oauth2PermissionGrants/"
        $params["Method"] = "PATCH"
        
        if ($null -ne $PSBoundParameters["OAuth2PermissionGrantId"]) {
            $params["Uri"] += $OAuth2PermissionGrantId
        }
               
        if ($null -ne $PSBoundParameters["Scope"]) {
            $body["scope"] = $PSBoundParameters["Scope"]
        }
        
        $params["Body"] = $body

        Write-Debug("============================ TRANSFORMATIONS ============================")
        $params.Keys | ForEach-Object { "$_ : $($params[$_])" } | Write-Debug
        Write-Debug("=========================================================================`n")
        
        $response = Invoke-GraphRequest @params -Headers $customHeaders
        $response
    }
}