# ------------------------------------------------------------------------------ 
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  
#  Licensed under the MIT License.  See License in the project root for license information. 
# ------------------------------------------------------------------------------ 
function Get-EntraDevice {
    [CmdletBinding(DefaultParameterSetName = 'GetQuery')]
    param (
                
        [Parameter(ParameterSetName = "GetQuery", ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
        [Alias("Limit")]
        [System.Nullable`1[System.Int32]] $Top,
                
        [Parameter(ParameterSetName = "GetQuery", ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
        [System.String] $Filter,
                
        [Parameter(ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
        [switch] $All,
                
        [Parameter(ParameterSetName = "GetVague", ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
        [System.String] $SearchString,

        [Alias('ObjectId')]            
        [Parameter(ParameterSetName = "GetById", Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
        [System.String] $DeviceId,

        [Parameter(Mandatory = $false, ValueFromPipeline = $false, ValueFromPipelineByPropertyName = $true)]
        [Alias("Select")]
        [System.String[]] $Property,

        [Parameter(Mandatory = $false, ValueFromPipeline = $false, ValueFromPipelineByPropertyName = $true, HelpMessage = "Filter devices with last sign-in before a specified date.")]
        [DateTime] $LogonTimeBefore,

        [Parameter(Mandatory = $false, ValueFromPipeline = $false, ValueFromPipelineByPropertyName = $true, HelpMessage = "Filter devices that haven't signed in for 2 months or more.")]
        [Switch] $Stale,

        [Parameter(Mandatory = $false, ValueFromPipeline = $false, ValueFromPipelineByPropertyName = $true, HelpMessage = "Filter devices that are not compliant with organizational policies.")]
        [Switch] $NonCompliant,

        [Parameter(Mandatory = $false, ValueFromPipeline = $false, ValueFromPipelineByPropertyName = $true, HelpMessage = "Filter devices onwhether they are managed by a Mobile Device Management (MDM) solution. Use `$true for managed devices or `$false for unmanaged devices.")]
        [System.Nullable`1[System.Boolean]] $IsManaged,

        [Parameter(Mandatory = $false, ValueFromPipeline = $false, ValueFromPipelineByPropertyName = $true, HelpMessage = "Filter devices by join type: MicrosoftEntraJoined, MicrosoftEntraHybridJoined, or MicrosoftEntraRegistered.")]
        [ValidateSet("MicrosoftEntraJoined", "MicrosoftEntraHybridJoined", "MicrosoftEntraRegistered")]
        [System.String] $JoinType
    )

    begin {
        # Ensure connection to Microsoft Entra
        if (-not (Get-EntraContext)) {
            $errorMessage = "Not connected to Microsoft Graph. Use 'Connect-Entra -Scopes Device.Read.All' to authenticate."
            Write-Error -Message $errorMessage -ErrorAction Stop
            return
        }
    }

    PROCESS {    
        $params = @{}
        $customHeaders = New-EntraCustomHeaders -Command $MyInvocation.MyCommand
        $keysChanged = @{SearchString = "Filter"; ObjectId = "Id" }
        if ($null -ne $PSBoundParameters["OutVariable"]) {
            $params["OutVariable"] = $PSBoundParameters["OutVariable"]
        }
        if ($PSBoundParameters.ContainsKey("Top")) {
            $params["Top"] = $PSBoundParameters["Top"]
        }
        if ($PSBoundParameters.ContainsKey("Debug")) {
            $params["Debug"] = $PSBoundParameters["Debug"]
        }
        if ($null -ne $PSBoundParameters["PipelineVariable"]) {
            $params["PipelineVariable"] = $PSBoundParameters["PipelineVariable"]
        }
        if ($null -ne $PSBoundParameters["InformationVariable"]) {
            $params["InformationVariable"] = $PSBoundParameters["InformationVariable"]
        }
        if ($null -ne $PSBoundParameters["Filter"]) {
            $TmpValue = $PSBoundParameters["Filter"]
            foreach ($i in $keysChanged.GetEnumerator()) {
                $TmpValue = $TmpValue.Replace($i.Key, $i.Value)
            }
            $Value = $TmpValue
            $params["Filter"] = $Value
        }
        if ($null -ne $PSBoundParameters["OutBuffer"]) {
            $params["OutBuffer"] = $PSBoundParameters["OutBuffer"]
        }
        if ($null -ne $PSBoundParameters["WarningVariable"]) {
            $params["WarningVariable"] = $PSBoundParameters["WarningVariable"]
        }
        if ($null -ne $PSBoundParameters["InformationAction"]) {
            $params["InformationAction"] = $PSBoundParameters["InformationAction"]
        }
        if ($null -ne $PSBoundParameters["All"]) {
            if ($PSBoundParameters["All"]) {
                $params["All"] = $PSBoundParameters["All"]
            }
        }
        if ($null -ne $PSBoundParameters["ErrorVariable"]) {
            $params["ErrorVariable"] = $PSBoundParameters["ErrorVariable"]
        }
        if ($null -ne $PSBoundParameters["SearchString"]) {
            $TmpValue = $PSBoundParameters["SearchString"]
            $Value = "displayName eq '$TmpValue' or startswith(displayName,'$TmpValue')"
            $params["Filter"] = $Value
        }
        if ($null -ne $PSBoundParameters["ErrorAction"]) {
            $params["ErrorAction"] = $PSBoundParameters["ErrorAction"]
        }
        if ($PSBoundParameters.ContainsKey("Verbose")) {
            $params["Verbose"] = $PSBoundParameters["Verbose"]
        }
        if ($null -ne $PSBoundParameters["DeviceId"]) {
            $params["DeviceId"] = $PSBoundParameters["DeviceId"]
        }
        if ($null -ne $PSBoundParameters["WarningAction"]) {
            $params["WarningAction"] = $PSBoundParameters["WarningAction"]
        }
        if ($null -ne $PSBoundParameters["ProgressAction"]) {
            $params["ProgressAction"] = $PSBoundParameters["ProgressAction"]
        }
        if ($null -ne $PSBoundParameters["Property"]) {
            $params["Property"] = $PSBoundParameters["Property"]
        }

        if ($null -ne $PSBoundParameters["LogonTimeBefore"]) {
            $logonDate = $PSBoundParameters["LogonTimeBefore"].ToUniversalTime().ToString("yyyy-MM-ddTHH:mm:ssZ")
            if ($params.ContainsKey("Filter")) {
                $params["Filter"] += " and approximateLastSignInDateTime le $logonDate"
            } else {
                $params["Filter"] = "approximateLastSignInDateTime le $logonDate"
            }
        }

        # Ref: https://learn.microsoft.com/en-us/entra/identity/devices/manage-stale-devices
        if ($null -ne $PSBoundParameters["Stale"]) {
            $staleDate = (Get-Date).AddMonths(-2).ToUniversalTime().ToString("yyyy-MM-ddTHH:mm:ssZ")
            if ($params.ContainsKey("Filter")) {
                $params["Filter"] += " and approximateLastSignInDateTime le $staleDate"
            } else {
                $params["Filter"] = "approximateLastSignInDateTime le $staleDate"
            }
        }

        if ($null -ne $PSBoundParameters["NonCompliant"]) {
            if ($params.ContainsKey("Filter")) {
                $params["Filter"] += " and isCompliant eq false"
            } else {
                $params["Filter"] = "isCompliant eq false"
            }
        }

        if ($null -ne $PSBoundParameters["IsManaged"]) {
            $isManagedState = $PSBoundParameters["IsManaged"]
            if ($params.ContainsKey("Filter")) {
                $params["Filter"] += " and isManaged eq $isManagedState"
            } else {
                $params["Filter"] = "isManaged eq $isManagedState"
            }
        }

        if ($null -ne $PSBoundParameters["JoinType"]) {
            $filterValue = switch ($PSBoundParameters["JoinType"]) {
                "MicrosoftEntraJoined" { "trustType eq 'AzureAd'" }
                "MicrosoftEntraHybridJoined" { "trustType eq 'ServerAd'" }
                "MicrosoftEntraRegistered" { "trustType eq 'Workplace'" }
            }
            
            if ($params.ContainsKey("Filter")) {
                $params["Filter"] += " and $filterValue"
            } else {
                $params["Filter"] = $filterValue
            }
        }

        Write-Debug("============================ TRANSFORMATIONS ============================")
        $params.Keys | ForEach-Object { "$_ : $($params[$_])" } | Write-Debug
        Write-Debug("=========================================================================`n")
    
        $response = Get-MgDevice @params -Headers $customHeaders
        $response | ForEach-Object {
            if ($null -ne $_) {
                Add-Member -InputObject $_ -MemberType AliasProperty -Name ApproximateLastLogonTimestamp -Value ApproximateLastSignInDateTime
                Add-Member -InputObject $_ -MemberType AliasProperty -Name LastDirSyncTime -Value OnPremisesLastSyncDateTime
                Add-Member -InputObject $_ -MemberType AliasProperty -Name DevicePhysicalIds -Value PhysicalIds
                Add-Member -InputObject $_ -MemberType AliasProperty -Name ComplianceExpiryTime -Value ComplianceExpirationDateTime
                Add-Member -InputObject $_ -MemberType AliasProperty -Name DeletionTimestamp -Value DeletedDateTime
                Add-Member -InputObject $_ -MemberType AliasProperty -Name DeviceOSVersion -Value OperatingSystemVersion
                Add-Member -InputObject $_ -MemberType AliasProperty -Name DirSyncEnabled -Value OnPremisesSyncEnabled
                Add-Member -InputObject $_ -MemberType AliasProperty -Name DeviceOSType -Value OperatingSystem
                Add-Member -InputObject $_ -MemberType AliasProperty -Name DeviceTrustType -Value TrustType
                Add-Member -InputObject $_ -MemberType AliasProperty -Name DeviceObjectVersion -Value DeviceVersion
                Add-Member -InputObject $_ -MemberType AliasProperty -Name ObjectId -Value Id
            }
        }
        $response
    }
}

