# ------------------------------------------------------------------------------ 
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  
#  Licensed under the MIT License.  See License in the project root for license information. 
# ------------------------------------------------------------------------------ 
function Update-EntraBetaOauth2PermissionGrant {
    [CmdletBinding(DefaultParameterSetName = 'Default')]
    param (
        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
        [Alias("Id")]
        [System.String] $OAuth2PermissionGrantId,
               
        [Parameter(Mandatory = $false)]
        [System.String] $Scope
    )

    begin {
        # Ensure connection to Microsoft Entra
        if (-not (Get-EntraContext)) {
            $errorMessage = "Not connected to Microsoft Graph. Use 'Connect-Entra -Scopes DelegatedPermissionGrant.ReadWrite.All' to authenticate."
            Write-Error -Message $errorMessage -ErrorAction Stop
            return
        }
    }

    PROCESS {
        $params = @{}
        $body = @{}
        $customHeaders = New-EntraBetaCustomHeaders -Command $MyInvocation.MyCommand
        $params["Uri"] = "/beta/oauth2PermissionGrants/"
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
}# ------------------------------------------------------------------------------

