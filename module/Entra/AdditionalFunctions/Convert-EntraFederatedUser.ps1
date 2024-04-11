# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
function Convert-EntraFederatedUser {
    [CmdletBinding(DefaultParameterSetName = 'GetQuery')]
    param (
        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)][System.String] $UserPrincipalName,
        [Parameter(Mandatory=$false, ValueFromPipeline = $false, ValueFromPipelineByPropertyName=$true)][string] $NewPassword,
        [Parameter(Mandatory=$false, ValueFromPipeline = $false, ValueFromPipelineByPropertyName=$true)][guid] $TenantId
          
    )

    PROCESS {    
        $params = @{}
        $customHeaders = New-EntraCustomHeaders -Command $MyInvocation.MyCommand
        $keysChanged = @{}
        if ($null -ne $PSBoundParameters["UserPrincipalName"]) {
            $UserPrincipalName = $PSBoundParameters.UserPrincipalName
            $UserId = Get-MgUser -Search "UserPrincipalName:$UserPrincipalName" -ConsistencyLevel eventual
            if ($null -ne $UserId)
            {
                $AuthenticationMethodId = Get-MgUserAuthenticationMethod -UserId $UserId.Id
                $params["AuthenticationMethodId"] = $AuthenticationMethodId.Id
                $params["UserId"] = $UserId.Id
            }
        }
        if ($PSBoundParameters.ContainsKey("NewPassword")) {
            $params["NewPassword"] = $PSBoundParameters["NewPassword"]
        }
        if ($PSBoundParameters.ContainsKey("Verbose")) {
            $params["Verbose"] = $Null
        }
        if ($PSBoundParameters.ContainsKey("Debug")) {
            $params["Debug"] = $Null
        }
        Write-Debug("============================ TRANSFORMATIONS ============================")
        $params.Keys | ForEach-Object { "$_ : $($params[$_])" } | Write-Debug
        Write-Debug("=========================================================================`n")
        if($null -ne $AuthenticationMethodId)
        {
            $response = Reset-MgUserAuthenticationMethodPassword @params -Headers $customHeaders
        }
        $response
        }
}