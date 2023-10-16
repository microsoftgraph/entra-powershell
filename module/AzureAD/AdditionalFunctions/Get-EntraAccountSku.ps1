# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
function Get-EntraAccountSku {
    [CmdletBinding(DefaultParameterSetName = 'GetQuery')]
    param (
        [Parameter(ParameterSetName = "GetById", ValueFromPipelineByPropertyName = $true)][System.Guid] $TenantId
        )

    PROCESS {    
        $params = @{}
        $keysChanged = @{}
        if ($PSBoundParameters.ContainsKey("Verbose")) {
            $params["Verbose"] = $Null
        }
        if ($PSBoundParameters.ContainsKey("Debug")) {
            $params["Debug"] = $Null
        }
        Write-Debug("============================ TRANSFORMATIONS ============================")
        $params.Keys | ForEach-Object { "$_ : $($params[$_])" } | Write-Debug
        Write-Debug("=========================================================================`n")
        $response = Get-MgSubscribedSku @params
        $response | ForEach-Object {
            if($null -ne $_) {
            Add-Member -InputObject $_ -MemberType NoteProperty -Name ActiveUnits -Value $_.PrepaidUnits.Enabled
            Add-Member -InputObject $_ -MemberType NoteProperty -Name LockedOutUnits -Value $_.PrepaidUnits.LockedOut
            Add-Member -InputObject $_ -MemberType NoteProperty -Name SuspendedUnits -Value $_.PrepaidUnits.Suspended
            Add-Member -InputObject $_ -MemberType NoteProperty -Name WarningUnits -Value $_.PrepaidUnits.Warning
            Add-Member -InputObject $_ -MemberType NoteProperty -Name AccountObjectId -Value $_.AccountId
            }
        }
        $response
    }
}