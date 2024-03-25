# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
function Get-EntraPasswordPolicy {
    <#
    .SYNOPSIS
        Retrieves the current password policy for the tenant or the specified domain.
    
    .DESCRIPTION
        The Get-EntraPasswordPolicy cmdlet can be used to retrieve the values associated with the Password Expiry
    window or Password Expiry Notification window for a tenant or specified domain.  When a domain name is
    specified, it must be a verified domain for the company.
    
    .PARAMETER DomainName
        The fully qualified name of the domain to be retrieved.

    .PARAMETER <CommonParameters>
        This cmdlet supports the common parameters: Verbose, Debug,
        ErrorAction, ErrorVariable, WarningAction, WarningVariable,
        OutBuffer, PipelineVariable, and OutVariable. For more information, see
        about_CommonParameters (https:/go.microsoft.com/fwlink/?LinkID=113216).
        
    .EXAMPLE
        Get-EntraPasswordPolicy -DomainName contoso.com

        Returns the password policy.

        Description

        -----------

        Returns the password policy for the domain contoso.com.
    #>
    [CmdletBinding(DefaultParameterSetName = 'GetQuery')]
    param (
        [Parameter(ParameterSetName = "GetById", Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)][System.String] $DomainName
    )

    PROCESS {    
        $params = @{}
        $customHeaders = New-EntraCustomHeaders -Command $MyInvocation.MyCommand
        $keysChanged = @{}
        if ($PSBoundParameters.ContainsKey("Verbose")) {
            $params["Verbose"] = $Null
        }
        if ($null -ne $PSBoundParameters["DomainName"]) {
            $params["DomainId"] = $PSBoundParameters["DomainName"]
        }
        if ($PSBoundParameters.ContainsKey("Debug")) {
            $params["Debug"] = $Null
        }
        Write-Debug("============================ TRANSFORMATIONS ============================")
        $params.Keys | ForEach-Object { "$_ : $($params[$_])" } | Write-Debug
        Write-Debug("=========================================================================`n")
        $response = Get-MgDomain @params -Headers $customHeaders
        # Create a custom table
        $customTable = [PSCustomObject]@{
            "NotificationDays" = $response.PasswordNotificationWindowInDays
            "ValidityPeriod"      = $response.PasswordValidityPeriodInDays
        }
        $customTable 
    }
}