# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
function Convert-EntraFederatedUser {
    <#
.SYNOPSIS
    Updates a user in a domain that was recently converted from single sign-on (also known as identity federation) to standard authentication type.

.DESCRIPTION
    The Convert-EntraFederatedUser cmdlet is used to update a user in a domain that was recently converted from single sign-on (also known as identity federation) to
    standard authentication type.  A new password must be provided for the user.

.PARAMETER NewPassword
    The new password of the user.

.PARAMETER TenantId
    The unique ID of the tenant to perform the operation on.  If this is not provided then it will default to the tenant of the current user.  This parameter is only
    applicable to partner users.

.PARAMETER UserPrincipalName
    The Microsoft Azure Active Directory UserID for the user to convert.

.PARAMETER <CommonParameters>
    This cmdlet supports the common parameters: Verbose, Debug,
    ErrorAction, ErrorVariable, WarningAction, WarningVariable,
    OutBuffer, PipelineVariable, and OutVariable. For more information, see 
    about_CommonParameters (https:/go.microsoft.com/fwlink/?LinkID=113216). 

.EXAMPLE
    Convert-EntraFederatedUser -UserPrincipalName "pattifuller@contoso.com"
#>
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