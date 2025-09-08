# ------------------------------------------------------------------------------ 
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  
#  Licensed under the MIT License.  See License in the project root for license information. 
# ------------------------------------------------------------------------------ 
function Set-EntraDevice {
    [CmdletBinding(DefaultParameterSetName = 'UpdateDevice')]
    param (
    [Parameter(ParameterSetName = "UpdateDevice")]
    [System.Nullable`1[System.Int32]] $DeviceObjectVersion,
    [Parameter(ParameterSetName = "UpdateDevice")]
    [System.String] $DeviceOSVersion,
    [Parameter(ParameterSetName = "UpdateDevice")]
    [System.Collections.Generic.List`1[Microsoft.Open.AzureAD.Model.AlternativeSecurityId]] $AlternativeSecurityIds,
    [Parameter(ParameterSetName = "UpdateDevice")]
    [System.String] $DeviceId,
    [Parameter(ParameterSetName = "UpdateDevice")]
    [System.Nullable`1[System.DateTime]] $ApproximateLastLogonTimeStamp,
    [Parameter(ParameterSetName = "UpdateDevice")]
    [System.Collections.Generic.List`1[System.String]] $DevicePhysicalIds,
    [Parameter(ParameterSetName = "UpdateDevice")]
    [System.Nullable`1[System.Boolean]] $IsCompliant,
    [Parameter(ParameterSetName = "UpdateDevice")]
    [System.String] $DeviceTrustType,
    [Parameter(ParameterSetName = "UpdateDevice")]
    [System.Nullable`1[System.Boolean]] $IsManaged,
    [Parameter(ParameterSetName = "UpdateDevice")]
    [System.String] $ProfileType,
    [Parameter(ParameterSetName = "UpdateDevice")]
    [System.String] $DeviceOSType,
    [Parameter(ParameterSetName = "UpdateDevice")]
    [System.String] $DisplayName,
    [Parameter(ParameterSetName = "UpdateDevice")]
    [System.Nullable`1[System.Boolean]] $AccountEnabled,
    [Parameter(ParameterSetName = "UpdateDevice")]
    [System.String] $DeviceMetadata,
    [Alias("ObjectId")]
    [Parameter(Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
    [System.String] $DeviceObjectId,
    [Parameter(ParameterSetName = "UpdateDevice")]
    [System.Collections.Generic.List`1[System.String]] $SystemLabels
    )

    begin {
        # Ensure connection to Microsoft Entra
        if (-not (Get-EntraContext)) {
            $errorMessage = "Not connected to Microsoft Graph. Use 'Connect-Entra -Scopes Directory.AccessAsUser.All, Device.ReadWrite.All' to authenticate."
            Write-Error -Message $errorMessage -ErrorAction Stop
            return
        }
    }

    PROCESS {    
        $params = @{}
        $customHeaders = New-EntraCustomHeaders -Command $MyInvocation.MyCommand
        
        if($null -ne $PSBoundParameters["DeviceObjectVersion"])
        {
            $params["DeviceVersion"] = $PSBoundParameters["DeviceObjectVersion"]
        }
        if($null -ne $PSBoundParameters["DeviceOSVersion"])
        {
            $params["OperatingSystemVersion"] = $PSBoundParameters["DeviceOSVersion"]
        }
        if($null -ne $PSBoundParameters["AlternativeSecurityIds"])
        {
            $TmpValue = $PSBoundParameters["AlternativeSecurityIds"]
                        $key = [System.Text.Encoding]::UTF8.GetString($TmpValue.key)
                $Temp = @{
                    alternativeSecurityIds = @(
                        @{
                            type = $TmpValue.type
                            key = [System.Text.Encoding]::ASCII.GetBytes($key)
                        }
                    )
                }
                $Value = $Temp 
            $params["BodyParameter"] = $Value
        }
        if($null -ne $PSBoundParameters["OutBuffer"])
        {
            $params["OutBuffer"] = $PSBoundParameters["OutBuffer"]
        }
        if($null -ne $PSBoundParameters["WarningAction"])
        {
            $params["WarningAction"] = $PSBoundParameters["WarningAction"]
        }
        if($null -ne $PSBoundParameters["DeviceId"])
        {
            $params["DeviceId1"] = $PSBoundParameters["DeviceId"]
        }
        if($null -ne $PSBoundParameters["PipelineVariable"])
        {
            $params["PipelineVariable"] = $PSBoundParameters["PipelineVariable"]
        }
        if($null -ne $PSBoundParameters["ApproximateLastLogonTimeStamp"])
        {
            $params["ApproximateLastSignInDateTime"] = $PSBoundParameters["ApproximateLastLogonTimeStamp"]
        }
        if($null -ne $PSBoundParameters["InformationVariable"])
        {
            $params["InformationVariable"] = $PSBoundParameters["InformationVariable"]
        }
        if($null -ne $PSBoundParameters["DevicePhysicalIds"])
        {
            $params["PhysicalIds"] = $PSBoundParameters["DevicePhysicalIds"]
        }
        if($null -ne $PSBoundParameters["OutVariable"])
        {
            $params["OutVariable"] = $PSBoundParameters["OutVariable"]
        }
        if($null -ne $PSBoundParameters["IsCompliant"])
        {
            $params["IsCompliant"] = $PSBoundParameters["IsCompliant"]
        }
        if($null -ne $PSBoundParameters["DeviceTrustType"])
        {
            $params["TrustType"] = $PSBoundParameters["DeviceTrustType"]
        }
        if($null -ne $PSBoundParameters["IsManaged"])
        {
            $params["IsManaged"] = $PSBoundParameters["IsManaged"]
        }
        if($null -ne $PSBoundParameters["ErrorAction"])
        {
            $params["ErrorAction"] = $PSBoundParameters["ErrorAction"]
        }
        if($PSBoundParameters.ContainsKey("Verbose"))
        {
            $params["Verbose"] = $PSBoundParameters["Verbose"]
        }
        if($PSBoundParameters.ContainsKey("Debug"))
        {
            $params["Debug"] = $PSBoundParameters["Debug"]
        }
        if($null -ne $PSBoundParameters["ProfileType"])
        {
            $params["ProfileType"] = $PSBoundParameters["ProfileType"]
        }
        if($null -ne $PSBoundParameters["DeviceOSType"])
        {
            $params["OperatingSystem"] = $PSBoundParameters["DeviceOSType"]
        }
        if($null -ne $PSBoundParameters["WarningVariable"])
        {
            $params["WarningVariable"] = $PSBoundParameters["WarningVariable"]
        }
        if($null -ne $PSBoundParameters["DisplayName"])
        {
            $params["DisplayName"] = $PSBoundParameters["DisplayName"]
        }
        if($null -ne $PSBoundParameters["AccountEnabled"])
        {
            $params["AccountEnabled"] = $PSBoundParameters["AccountEnabled"]
        }
        if($null -ne $PSBoundParameters["DeviceMetadata"])
        {
            $params["DeviceMetadata"] = $PSBoundParameters["DeviceMetadata"]
        }
        if($null -ne $PSBoundParameters["InformationAction"])
        {
            $params["InformationAction"] = $PSBoundParameters["InformationAction"]
        }
        if($null -ne $PSBoundParameters["DeviceObjectId"])
        {
            $params["DeviceId"] = $PSBoundParameters["DeviceObjectId"]
        }
        if($null -ne $PSBoundParameters["SystemLabels"])
        {
            $params["SystemLabels"] = $PSBoundParameters["SystemLabels"]
        }
        if($null -ne $PSBoundParameters["ProgressAction"])
        {
            $params["ProgressAction"] = $PSBoundParameters["ProgressAction"]
        }
        if($null -ne $PSBoundParameters["ErrorVariable"])
        {
            $params["ErrorVariable"] = $PSBoundParameters["ErrorVariable"]
        }

        Write-Debug("============================ TRANSFORMATIONS ============================")
        $params.Keys | ForEach-Object {"$_ : $($params[$_])" } | Write-Debug
        Write-Debug("=========================================================================`n")
        
        $response = Update-MgDevice @params -Headers $customHeaders
        $response | ForEach-Object {
            if($null -ne $_) {
            Add-Member -InputObject $_ -MemberType AliasProperty -Name ObjectId -Value Id

            }
        }
        $response
    }    
}

