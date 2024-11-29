# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.
#  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

function Get-EntraUserRole {
    [CmdletBinding(DefaultParameterSetName = 'GetQuery')]
    param (
        [Parameter(ParameterSetName = "GetQuery", ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = "Filter to apply to the query.")]
        [System.String] $Filter,

        [Parameter(ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = "Retrieve all user roles.")]
        [switch] $All,

        [Parameter(ParameterSetName = "GetVague", ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = "Search for user roles.")]
        [System.String] $SearchString,

        [Alias('ObjectId')]
        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = "User object ID to retrieve.")]
        [System.String] $UserId,

        [Alias('DirectoryObjectId')]
        [Parameter(Mandatory = $false, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = "Directory Role ID to retrieve.")]
        [System.String] $DirectoryRoleId,

        [Alias('Limit')]
        [Parameter(ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = "Maximum number of results to return.")]
        [System.Nullable`1[System.Int32]] $Top,

        [Alias('Select')]
        [Parameter(Mandatory = $false, ValueFromPipeline = $false, ValueFromPipelineByPropertyName = $true, HelpMessage = "Properties to include in the results.")]
        [System.String[]] $Property
    )

    PROCESS {
        $params = @{}
        $customHeaders = New-EntraCustomHeaders -Command $MyInvocation.MyCommand
        $keysChanged = @{ SearchString = "Filter" }

        if ($null -ne $PSBoundParameters["ErrorAction"]) {
            $params["ErrorAction"] = $PSBoundParameters["ErrorAction"]
        }
        if ($null -ne $PSBoundParameters["DirectoryRoleId"]) {
            $params["DirectoryObjectId"] = $PSBoundParameters["DirectoryRoleId"]
        }
        if ($null -ne $PSBoundParameters["UserId"]) {
            $params["UserId"] = $PSBoundParameters["UserId"]
        }
        if ($PSBoundParameters.ContainsKey("Verbose")) {
            $params["Verbose"] = $PSBoundParameters["Verbose"]
        }
        if ($null -ne $PSBoundParameters["OutVariable"]) {
            $params["OutVariable"] = $PSBoundParameters["OutVariable"]
        }
        if ($null -ne $PSBoundParameters["InformationAction"]) {
            $params["InformationAction"] = $PSBoundParameters["InformationAction"]
        }
        if ($null -ne $PSBoundParameters["WarningVariable"]) {
            $params["WarningVariable"] = $PSBoundParameters["WarningVariable"]
        }
        if ($PSBoundParameters.ContainsKey("Debug")) {
            $params["Debug"] = $PSBoundParameters["Debug"]
        }
        if ($null -ne $PSBoundParameters["PipelineVariable"]) {
            $params["PipelineVariable"] = $PSBoundParameters["PipelineVariable"]
        }
        if ($null -ne $PSBoundParameters["SearchString"]) {
            $TmpValue = $PSBoundParameters["SearchString"]
            $Value = "displayName eq '$TmpValue' or startsWith(displayName,'$TmpValue')"
            $params["Filter"] = $Value
        }
        if ($null -ne $PSBoundParameters["ErrorVariable"]) {
            $params["ErrorVariable"] = $PSBoundParameters["ErrorVariable"]
        }
        if ($null -ne $PSBoundParameters["Top"]) {
            $params["Top"] = $PSBoundParameters["Top"]
        }
        if ($null -ne $PSBoundParameters["OutBuffer"]) {
            $params["OutBuffer"] = $PSBoundParameters["OutBuffer"]
        }
        if ($null -ne $PSBoundParameters["All"]) {
            if ($PSBoundParameters["All"]) {
                $params["All"] = $PSBoundParameters["All"]
            }
        }
        if ($null -ne $PSBoundParameters["WarningAction"]) {
            $params["WarningAction"] = $PSBoundParameters["WarningAction"]
        }
        if ($null -ne $PSBoundParameters["Filter"]) {
            $TmpValue = $PSBoundParameters["Filter"]
            foreach ($i in $keysChanged.GetEnumerator()) {
                $TmpValue = $TmpValue.Replace($i.Key, $i.Value)
            }
            $Value = $TmpValue
            $params["Filter"] = $Value
        }
        if ($null -ne $PSBoundParameters["InformationVariable"]) {
            $params["InformationVariable"] = $PSBoundParameters["InformationVariable"]
        }
        if ($null -ne $PSBoundParameters["Property"]) {
            $params["Property"] = $PSBoundParameters["Property"]
        }

        # Debug logging for transformations
        Write-Debug "============================ TRANSFORMATIONS ============================"
        $params.Keys | ForEach-Object { "$_ : $($params[$_])" } | Write-Debug
        Write-Debug "=========================================================================`n"

        try {
            # Make the API call with -PageSize 999 if -All is used
            if ($PSBoundParameters.ContainsKey("All") -and $All) {
                $response = Get-MgUserMemberOfAsDirectoryRole @params -PageSize 999 -Headers $customHeaders
            }
            else {
                $response = Get-MgUserMemberOfAsDirectoryRole @params -Headers $customHeaders
            }

            return $response
        }
        catch {
            # Handle any errors that occur during the API call
            Write-Error "An error occurred while retrieving the user roles: $_"
        }
    }
}