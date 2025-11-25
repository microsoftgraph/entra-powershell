# ------------------------------------------------------------------------------ 
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  
#  Licensed under the MIT License.  See License in the project root for license information. 
# ------------------------------------------------------------------------------ 
function Get-EntraBetaGroup {
    [CmdletBinding(DefaultParameterSetName = 'GetQuery')]
    param (
        [Parameter(ParameterSetName = "GetQuery", ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = "The maximum number of items to return.")]
        [Parameter(ParameterSetName = "Append", ValueFromPipeline = $false, ValueFromPipelineByPropertyName = $true, HelpMessage = "The maximum number of items to return.")]
        [Alias("Limit")]
        [System.Nullable`1[System.Int32]] $Top,
                
        [Parameter(ParameterSetName = "GetQuery", ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = "Filter the results based on the specified criteria.")]
        [Parameter(ParameterSetName = "Append", ValueFromPipeline = $false, ValueFromPipelineByPropertyName = $true, HelpMessage = "Filter the results based on the specified criteria.")]
        [System.String] $Filter,
                
        [Parameter(ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = "Specifies whether to return all objects.")]
        [switch] $All,
                
        [Parameter(ParameterSetName = "GetVague", ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = "Search for a group by its name`, email`, or mail nickname.")]
        [Parameter(ParameterSetName = "Append", ValueFromPipeline = $false, ValueFromPipelineByPropertyName = $true, HelpMessage = "Search for a group by its name`, email`, or mail nickname.")]
        [System.String] $SearchString,
        
        [Alias('ObjectId')]
        [Parameter(ParameterSetName = "GetById", Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = "The ID of the group to retrieve. Should be a valid GUID value.")]
        [Parameter(ParameterSetName = "Append", Mandatory = $false, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = "The ID of the group to retrieve. Should be a valid GUID value.")]
        [ValidateNotNullOrEmpty()]
        [Guid] $GroupId,

        [Parameter(ParameterSetName = "GetQuery", Mandatory = $false, ValueFromPipeline = $false, ValueFromPipelineByPropertyName = $true, HelpMessage = "Properties to include in the results.")]
        [Parameter(ParameterSetName = "GetVague", Mandatory = $false, ValueFromPipeline = $false, ValueFromPipelineByPropertyName = $true, HelpMessage = "Properties to include in the results.")]
        [Parameter(ParameterSetName = "GetById", Mandatory = $false, ValueFromPipeline = $false, ValueFromPipelineByPropertyName = $true, HelpMessage = "Properties to include in the results.")]
        [Parameter(ParameterSetName = "Append", Mandatory = $true, ValueFromPipeline = $false, ValueFromPipelineByPropertyName = $true, HelpMessage = "Properties to include in the results.")]
        [Alias("Select")]
        [System.String[]] $Property,

        [Parameter(ParameterSetName = "Append", Mandatory = $true, HelpMessage = "Specifies whether to append the selected properties.")]
        [switch] $AppendSelected,

        [Parameter(ParameterSetName = "GetQuery", Mandatory = $false, ValueFromPipeline = $false, ValueFromPipelineByPropertyName = $false, HelpMessage = "Returns only groups that have errors.")]
        [Parameter(ParameterSetName = "GetVague", Mandatory = $false, ValueFromPipeline = $false, ValueFromPipelineByPropertyName = $false, HelpMessage = "Returns only groups that have errors.")]
        [Parameter(ParameterSetName = "Append", Mandatory = $false, ValueFromPipeline = $false, ValueFromPipelineByPropertyName = $false, HelpMessage = "Returns only groups that have errors.")]
        [Switch] $HasErrorsOnly,

        [Parameter(ParameterSetName = "GetQuery", Mandatory = $false, ValueFromPipeline = $false, ValueFromPipelineByPropertyName = $false, HelpMessage = "Returns only groups that have license errors.")]
        [Parameter(ParameterSetName = "GetVague", Mandatory = $false, ValueFromPipeline = $false, ValueFromPipelineByPropertyName = $false, HelpMessage = "Returns only groups that have license errors.")]
        [Parameter(ParameterSetName = "Append", Mandatory = $false, ValueFromPipeline = $false, ValueFromPipelineByPropertyName = $false, HelpMessage = "Returns only groups that have license errors.")]
        [Switch] $HasLicenseErrorsOnly
    )

    begin {
        # Ensure connection to Microsoft Entra
        if (-not (Get-EntraContext)) {
            $errorMessage = "Not connected to Microsoft Graph. Use 'Connect-Entra -Scopes GroupMember.Read.All' to authenticate."
            Write-Error -Message $errorMessage -ErrorAction Stop
            return
        }
    }

    PROCESS {    
        $params = @{}
        $customHeaders = New-EntraBetaCustomHeaders -Command $MyInvocation.MyCommand
        $keysChanged = @{SearchString = "Filter"; ObjectId = "Id" }
        $defaultProperties = "id,displayName,createdDateTime,deletedDateTime,groupTypes,mailEnabled,mailNickname,securityEnabled,visibility,description"
        if ($null -ne $PSBoundParameters["ProgressAction"]) {
            $params["ProgressAction"] = $PSBoundParameters["ProgressAction"]
        }
        if ($null -ne $PSBoundParameters["SearchString"]) {
            $TmpValue = $PSBoundParameters["SearchString"]
            $Value = "mailNickName eq '$TmpValue' or (mail eq '$TmpValue' or (displayName eq '$TmpValue' or startswith(displayName,'$TmpValue')))"
            $params["Filter"] = $Value
        }
        if ($PSBoundParameters.ContainsKey("Debug")) {
            $params["Debug"] = $PSBoundParameters["Debug"]
        }
        if ($null -ne $PSBoundParameters["Filter"]) {
            $TmpValue = $PSBoundParameters["Filter"]
            foreach ($i in $keysChanged.GetEnumerator()) {
                $TmpValue = $TmpValue.Replace($i.Key, $i.Value)
            }
            $Value = $TmpValue
            $params["Filter"] = $Value
        }
        if ($null -ne $PSBoundParameters["ErrorAction"]) {
            $params["ErrorAction"] = $PSBoundParameters["ErrorAction"]
        }
        if ($null -ne $PSBoundParameters["WarningVariable"]) {
            $params["WarningVariable"] = $PSBoundParameters["WarningVariable"]
        }
        if ($null -ne $PSBoundParameters["WarningAction"]) {
            $params["WarningAction"] = $PSBoundParameters["WarningAction"]
        }
        if ($null -ne $PSBoundParameters["GroupId"]) {
            $params["GroupId"] = $PSBoundParameters["GroupId"]
        }
        if ($null -ne $PSBoundParameters["OutVariable"]) {
            $params["OutVariable"] = $PSBoundParameters["OutVariable"]
        }
        if ($PSBoundParameters.ContainsKey("Verbose")) {
            $params["Verbose"] = $PSBoundParameters["Verbose"]
        }
        if ($null -ne $PSBoundParameters["All"]) {
            if ($PSBoundParameters["All"]) {
                $params["All"] = $PSBoundParameters["All"]
            }
        }
        if ($null -ne $PSBoundParameters["PipelineVariable"]) {
            $params["PipelineVariable"] = $PSBoundParameters["PipelineVariable"]
        }
        if ($null -ne $PSBoundParameters["OutBuffer"]) {
            $params["OutBuffer"] = $PSBoundParameters["OutBuffer"]
        }
        if ($null -ne $PSBoundParameters["InformationVariable"]) {
            $params["InformationVariable"] = $PSBoundParameters["InformationVariable"]
        }
        if ($null -ne $PSBoundParameters["InformationAction"]) {
            $params["InformationAction"] = $PSBoundParameters["InformationAction"]
        }
        if ($null -ne $PSBoundParameters["ErrorVariable"]) {
            $params["ErrorVariable"] = $PSBoundParameters["ErrorVariable"]
        }
        if ($PSBoundParameters.ContainsKey("Top")) {
            $params["Top"] = $PSBoundParameters["Top"]
        }
        if ($null -ne $Property -and $Property.Count -gt 0) {
            $params["Property"] = $Property -join ','
        }
        if ($PSBoundParameters.ContainsKey("AppendSelected")) {
            $params["Property"] = $defaultProperties + "," + ($Property -join ',')
        }

        if ($null -ne $PSBoundParameters["HasErrorsOnly"]) {
            if ($params.ContainsKey("Property")) {
                if ($params["Property"] -notcontains "ServiceProvisioningErrors") {
                    $params["Property"] = $params["Property"] + ",ServiceProvisioningErrors"
                }
            } else {
                $params["Property"] = $defaultProperties + ",ServiceProvisioningErrors"
            }
        }

        if ($null -ne $PSBoundParameters["HasLicenseErrorsOnly"]) {
            $licenseQuery = "hasMembersWithLicenseErrors eq true"

            if ($params.ContainsKey("Filter")) {
                if ($params["Filter"] -notcontains "hasMembersWithLicenseErrors") {
                    $params["Filter"] = "($($params["Filter"])) and $licenseQuery"
                }
            } else {
                $params["Filter"] = $licenseQuery
            }
        }

        Write-Debug("============================ TRANSFORMATIONS ============================")
        $params.Keys | ForEach-Object { "$_ : $($params[$_])" } | Write-Debug
        Write-Debug("=========================================================================`n")
    
        $response = Get-MgBetaGroup @params -Headers $customHeaders
        $response | ForEach-Object {
            if ($null -ne $_) {
                if ($PSBoundParameters.ContainsKey("HasErrorsOnly") -and ($null -eq $_.ServiceProvisioningErrors -or $_.ServiceProvisioningErrors.Count -eq 0)) {
                    continue
                }

                Add-Member -InputObject $_ -MemberType AliasProperty -Name ObjectId -Value Id

            }
        }
        $response
    }
}

