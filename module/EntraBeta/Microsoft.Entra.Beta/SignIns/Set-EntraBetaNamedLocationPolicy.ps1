# ------------------------------------------------------------------------------ 
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  
#  Licensed under the MIT License.  See License in the project root for license information. 
# ------------------------------------------------------------------------------ 
function Set-EntraBetaNamedLocationPolicy {
    [CmdletBinding(DefaultParameterSetName = 'ByNamedLocationPolicyId')]
    param (                
        [Parameter(ParameterSetName = "ByNamedLocationPolicyId")]
        [System.Collections.Generic.List`1[Microsoft.Open.MSGraph.Model.IpRange]] $IpRanges,
                
        [Parameter(ParameterSetName = "ByNamedLocationPolicyId")]
        [System.Nullable`1[System.Boolean]] $IncludeUnknownCountriesAndRegions,
                
        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
        [System.String] $PolicyId,
                
        [Parameter(ParameterSetName = "ByNamedLocationPolicyId")]
        [System.String] $DisplayName,
                
        [Parameter(ParameterSetName = "ByNamedLocationPolicyId")]
        [System.Nullable`1[System.Boolean]] $IsTrusted,
                
        [Parameter(ParameterSetName = "ByNamedLocationPolicyId")]
        [System.String] $Id,
                
        [Parameter(ParameterSetName = "ByNamedLocationPolicyId")]
        [System.String] $OdataType,
                
        [Parameter(ParameterSetName = "ByNamedLocationPolicyId")]
        [System.Collections.Generic.List`1[Microsoft.Open.MSGraph.Model.CountriesAndRegion]] $CountriesAndRegions
    )

    begin {
        # Ensure connection to Microsoft Entra
        if (-not (Get-EntraContext)) {
            $errorMessage = "Not connected to Microsoft Graph. Use 'Connect-Entra -Scopes Policy.ReadWrite.ConditionalAccess' to authenticate."
            Write-Error -Message $errorMessage -ErrorAction Stop
            return
        }
    }

    PROCESS {    
        $params = @{}
        $customHeaders = New-EntraBetaCustomHeaders -Command $MyInvocation.MyCommand
        $body = @{}
        if ($null -ne $PSBoundParameters["IncludeUnknownCountriesAndRegions"]) {
            $body["IncludeUnknownCountriesAndRegions"] = $PSBoundParameters["IncludeUnknownCountriesAndRegions"]
        }
        if ($null -ne $PSBoundParameters["Id"]) {
            $body["Id"] = $PSBoundParameters["Id"]
        }
        if ($null -ne $PSBoundParameters["PolicyId"]) {
            $params["NamedLocationId"] = $PSBoundParameters["PolicyId"]
        }
        if ($PSBoundParameters.ContainsKey("Verbose")) {
            $params["Verbose"] = $PSBoundParameters["Verbose"]
        }
        if ($PSBoundParameters.ContainsKey("Debug")) {
            $params["Debug"] = $PSBoundParameters["Debug"]
        }
        if ($null -ne $PSBoundParameters["WarningVariable"]) {
            $params["WarningVariable"] = $PSBoundParameters["WarningVariable"]
        }
        if ($null -ne $PSBoundParameters["InformationVariable"]) {
            $params["InformationVariable"] = $PSBoundParameters["InformationVariable"]
        }
        if ($null -ne $PSBoundParameters["InformationAction"]) {
            $params["InformationAction"] = $PSBoundParameters["InformationAction"]
        }
        if ($null -ne $PSBoundParameters["OutVariable"]) {
            $params["OutVariable"] = $PSBoundParameters["OutVariable"]
        }
        if ($null -ne $PSBoundParameters["OutBuffer"]) {
            $params["OutBuffer"] = $PSBoundParameters["OutBuffer"]
        }
        if ($null -ne $PSBoundParameters["ErrorVariable"]) {
            $params["ErrorVariable"] = $PSBoundParameters["ErrorVariable"]
        }
        if ($null -ne $PSBoundParameters["PipelineVariable"]) {
            $params["PipelineVariable"] = $PSBoundParameters["PipelineVariable"]
        }
        if ($null -ne $PSBoundParameters["ErrorAction"]) {
            $params["ErrorAction"] = $PSBoundParameters["ErrorAction"]
        }
        if ($null -ne $PSBoundParameters["WarningAction"]) {
            $params["WarningAction"] = $PSBoundParameters["WarningAction"]
        }
        if ($null -ne $PSBoundParameters["IsTrusted"]) {
            $body["IsTrusted"] = $PSBoundParameters["IsTrusted"]
        }
        if ($null -ne $PSBoundParameters["OdataType"]) {
            $body["@odata.type"] = $PSBoundParameters["OdataType"]
        }
        if ($null -ne $PSBoundParameters["CountriesAndRegions"]) {
            $body["CountriesAndRegions"] = $PSBoundParameters["CountriesAndRegions"]
        }
        if ($null -ne $PSBoundParameters["IpRanges"]) {
            $Tmp = $PSBoundParameters["IpRanges"]
            $hash = @()
            foreach ($i in $Tmp) {
                $hash += @{cidrAddress = $i.CidrAddress }
            }
            $body["IpRanges"] = $hash
        }
        if ($null -ne $PSBoundParameters["DisplayName"]) {
            $body["DisplayName"] = $PSBoundParameters["DisplayName"]
        }

        $params["BodyParameter"] = $body
    
        Write-Debug("============================ TRANSFORMATIONS ============================")
        $params.Keys | ForEach-Object { "$_ : $($params[$_])" } | Write-Debug
        Write-Debug("=========================================================================`n")
        
        $response = Update-MgBetaIdentityConditionalAccessNamedLocation @params -Headers $customHeaders
        $response | ForEach-Object {
            if ($null -ne $_) {
                Add-Member -InputObject $_ -MemberType AliasProperty -Name ObjectId -Value Id
            }
        }
        $response
    }    
}

