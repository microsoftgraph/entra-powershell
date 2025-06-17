# ------------------------------------------------------------------------------ 
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  
#  Licensed under the MIT License.  See License in the project root for license information. 
# ------------------------------------------------------------------------------ 
function New-EntraBetaOauth2PermissionGrant {
    [CmdletBinding(DefaultParameterSetName = 'ByClientAndResourceIds')]
    param (
        [Parameter(ParameterSetName = "ByClientAndResourceIds", Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
        [System.String] $ClientId,

        [Parameter(ParameterSetName = "ByClientAndResourceIds", Mandatory = $true)]
        [System.String] $ConsentType,

        [Parameter(ParameterSetName = "ByClientAndResourceIds")]
        [System.String] $PrincipalId,

        [Parameter(ParameterSetName = "ByClientAndResourceIds", Mandatory = $true)]
        [System.String] $ResourceId,

        [Parameter(ParameterSetName = "ByClientAndResourceIds")]
        [System.String] $Scope,

        [Parameter(ParameterSetName = "ByClientAndResourceIds", Mandatory = $true)]
        [System.Nullable`1[System.DateTime]]$StartTime,
        
        [Parameter(ParameterSetName = "ByClientAndResourceIds", Mandatory = $true)]
        [System.Nullable`1[System.DateTime]]$ExpiryTime
    )

    PROCESS {
        $params = @{}
        $body = @{}
        $params["Uri"] = "/beta/oauth2PermissionGrants"
        $params["Method"] = "POST"
        $customHeaders = New-EntraBetaCustomHeaders -Command $MyInvocation.MyCommand

        if ($null -ne $PSBoundParameters["ClientId"]) {
            $body["clientId"] = $PSBoundParameters["ClientId"]
        }
        if ($null -ne $PSBoundParameters["ConsentType"]) {
            $body["consentType"] = $PSBoundParameters["ConsentType"]
        }
        if ($null -ne $PSBoundParameters["PrincipalId"]) {
            $body["principalId"] = $PSBoundParameters["PrincipalId"]
        }
        if ($null -ne $PSBoundParameters["ResourceId"]) {
            $body["resourceId"] = $PSBoundParameters["ResourceId"]
        }
        if ($null -ne $PSBoundParameters["Scope"]) {
            $body["scope"] = $PSBoundParameters["Scope"]
        }
        if ($null -ne $PSBoundParameters["ExpiryTime"]) {
            $body["expiryTime"] = $PSBoundParameters["ExpiryTime"]
        }
        if ($null -ne $PSBoundParameters["StartTime"]) {
            $body["startTime"] = $PSBoundParameters["StartTime"]
        }
        $params["Body"] = $body

        Write-Debug("============================ TRANSFORMATIONS ============================")
        $params.Keys | ForEach-Object { "$_ : $($params[$_])" } | Write-Debug
        Write-Debug("=========================================================================`n")

        $response = Invoke-GraphRequest @params -Headers $customHeaders
        if ($response) {
            $response = $response | ConvertTo-Json | ConvertFrom-Json
            $response | ForEach-Object {
                if ($null -ne $_) {
                    $userData = [Microsoft.Graph.Beta.PowerShell.Models.MicrosoftGraphOAuth2PermissionGrant]::new()
                    $_.PSObject.Properties | ForEach-Object {
                        $userData | Add-Member -MemberType NoteProperty -Name $_.Name -Value $_.Value -Force
                    }
                }
            }
            $userData
        }
    }
}# ------------------------------------------------------------------------------

