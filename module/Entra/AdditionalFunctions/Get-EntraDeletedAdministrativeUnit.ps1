# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.
#  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

function Get-EntraDeletedAdministrativeUnit {
    [CmdletBinding(DefaultParameterSetName = 'GetQuery')]
    param (
        [Parameter(ParameterSetName = "GetQuery", ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = "Filter to apply to the query.")]
        [System.String] $Filter,

        [Parameter(ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = "Retrieve all deleted administrative units.")]
        [switch] $All,

        [Parameter(ParameterSetName = "GetVague", ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = "Search string to use for vague queries.")]
        [System.String] $SearchString,

        [Alias('Id')]
        [Parameter(ParameterSetName = "GetById", Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = "Administrative Unit ID to retrieve.")]
        [System.String] $AdministrativeUnitId,

        [Alias('Limit')]
        [Parameter(ParameterSetName = "GetQuery", ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = "Maximum number of results to return.")]
        [System.Nullable`1[System.Int32]] $Top,

        [Alias('Select')]
        [Parameter(Mandatory = $false, ValueFromPipeline = $false, ValueFromPipelineByPropertyName = $true, HelpMessage = "Properties to include in the results.")]
        [System.String[]] $Property
    )

    PROCESS {
        $params = @{}
        $customHeaders = New-EntraCustomHeaders -Command $MyInvocation.MyCommand
        $keysChanged = @{ SearchString = "Filter" }

        # Simplify parameter handling
        foreach ($param in $PSBoundParameters.Keys) {
            if ($null -ne $PSBoundParameters[$param]) {
                $params[$param] = $PSBoundParameters[$param]
            }
        }

        # Handle specific parameter transformations
        if ($null -ne $PSBoundParameters["Filter"]) {
            $TmpValue = $PSBoundParameters["Filter"]
            foreach ($i in $keysChanged.GetEnumerator()) {
                $TmpValue = $TmpValue.Replace($i.Key, $i.Value)
            }
            $params["Filter"] = $TmpValue
        }

        if($null -ne $PSBoundParameters["SearchString"])
        {
            $TmpValue = $PSBoundParameters["SearchString"]
            $Value = "displayName eq '$TmpValue' or startswith(displayName,'$TmpValue')"
            $params["Filter"] = $Value
        }

        # Debug logging for transformations
        Write-Debug "============================ TRANSFORMATIONS ============================"
        $params.Keys | ForEach-Object { "$_ : $($params[$_])" } | Write-Debug
        Write-Debug "=========================================================================`n"

        try {
            # Make the API call
            $response = Get-MgDirectoryDeletedItemAsAdministrativeUnit @params -Headers $customHeaders
            return $response
        }
        catch {
            # Handle any errors that occur during the API call
            Write-Error "An error occurred while retrieving the deleted administrative units: $_"
        }
    }
}