# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
function Get-EntraBetaAccountSku {
    <#
    .SYNOPSIS
        Retrieves all the SKUs for a company.
    
    .DESCRIPTION
        The Get-EntraBetaAccountSku will return all the SKUs that the company owns.
    
    .PARAMETER TenantId
        The unique ID of the tenant to perform the operation on. If this is not provided then the value will default to
        the tenant of the current user. This parameter is only applicable to partner users.

    .PARAMETER <CommonParameters>
        This cmdlet supports the common parameters: Verbose, Debug,
        ErrorAction, ErrorVariable, WarningAction, WarningVariable,
        OutBuffer, PipelineVariable, and OutVariable. For more information, see
        about_CommonParameters (https:/go.microsoft.com/fwlink/?LinkID=113216).
        
    .EXAMPLE
        Get-EntraBetaAccountSku
        
        Description
        
        -----------
        
        This command returns a list of SKUs.
    #>
    [CmdletBinding(DefaultParameterSetName = 'GetQuery')]
    param (
        [Parameter(ParameterSetName = "GetById", ValueFromPipelineByPropertyName = $true)][System.Guid] $TenantId
        )

    PROCESS {    
        $params = @{}
        $customHeaders = New-EntraBetaCustomHeaders -Command $MyInvocation.MyCommand
        $keysChanged = @{}
        if ($PSBoundParameters.ContainsKey("Verbose")) {
            $params["Verbose"] = $Null
        }
        if ($PSBoundParameters.ContainsKey("Debug")) {
            $params["Debug"] = $Null
        }
        if($null -ne $PSBoundParameters["WarningVariable"])
        {
            $params["WarningVariable"] = $PSBoundParameters["WarningVariable"]
        }
        if($null -ne $PSBoundParameters["InformationVariable"])
        {
            $params["InformationVariable"] = $PSBoundParameters["InformationVariable"]
        }
	    if($null -ne $PSBoundParameters["InformationAction"])
        {
            $params["InformationAction"] = $PSBoundParameters["InformationAction"]
        }
        if($null -ne $PSBoundParameters["OutVariable"])
        {
            $params["OutVariable"] = $PSBoundParameters["OutVariable"]
        }
        if($null -ne $PSBoundParameters["OutBuffer"])
        {
            $params["OutBuffer"] = $PSBoundParameters["OutBuffer"]
        }
        if($null -ne $PSBoundParameters["ErrorVariable"])
        {
            $params["ErrorVariable"] = $PSBoundParameters["ErrorVariable"]
        }
        if($null -ne $PSBoundParameters["PipelineVariable"])
        {
            $params["PipelineVariable"] = $PSBoundParameters["PipelineVariable"]
        }
        if($null -ne $PSBoundParameters["ErrorAction"])
        {
            $params["ErrorAction"] = $PSBoundParameters["ErrorAction"]
        }
        if($null -ne $PSBoundParameters["WarningAction"])
        {
            $params["WarningAction"] = $PSBoundParameters["WarningAction"]
        }
        Write-Debug("============================ TRANSFORMATIONS ============================")
        $params.Keys | ForEach-Object { "$_ : $($params[$_])" } | Write-Debug
        Write-Debug("=========================================================================`n")
        $response = Get-MgBetaSubscribedSku @params -Headers $customHeaders
        $response | ForEach-Object {
            if($null -ne $_) {
            Add-Member -InputObject $_ -MemberType NoteProperty -Name ActiveUnits -Value $_.PrepaidUnits.Enabled
            Add-Member -InputObject $_ -MemberType NoteProperty -Name LockedOutUnits -Value $_.PrepaidUnits.LockedOut
            Add-Member -InputObject $_ -MemberType NoteProperty -Name SuspendedUnits -Value $_.PrepaidUnits.Suspended
            Add-Member -InputObject $_ -MemberType NoteProperty -Name WarningUnits -Value $_.PrepaidUnits.Warning
            Add-Member -InputObject $_ -MemberType NoteProperty -Name AccountObjectId -Value $_.AccountId
            Add-Member -InputObject $_ -MemberType NoteProperty -Name TargetClass -Value $_.AppliesTo
            }
        }
        $response
    }
}