# ------------------------------------------------------------------------------ 
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  
#  Licensed under the MIT License.  See License in the project root for license information. 
# ------------------------------------------------------------------------------ 
function Get-EntraDeletedApplication {
    [CmdletBinding(DefaultParameterSetName = 'GetQuery')]
    param (
        [Parameter(ParameterSetName = "GetQuery", ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = "The properties to include in the response.")]
        [Alias("Limit")]
        [System.Nullable`1[System.Int32]] $Top,

        [Parameter(ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = "Return all items.")]
        [switch] $All,

        [Parameter(ParameterSetName = "GetQuery", ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = "Filter the results based on specific criteria.")]
        [System.String] $Filter,

        [Parameter(ParameterSetName = "GetVague", ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = "Search for items using a string.")]
        [System.String] $SearchString,

        [Parameter(Mandatory = $false, ValueFromPipeline = $false, ValueFromPipelineByPropertyName = $true, HelpMessage = "The properties to include in the response.")]
        [Alias("Select")]
        [System.String[]] $Property
    )

    PROCESS {    
        $params = @{}
        $topCount = $null
        $customHeaders = New-EntraCustomHeaders -Command $MyInvocation.MyCommand
        $baseUri = "/v1.0/directory/deleteditems/microsoft.graph.application"

        $properties = '$select=*'
        if ($null -ne $PSBoundParameters["Property"]) {
            $selectProperties = $PSBoundParameters["Property"]
            $selectProperties = $selectProperties -Join ','
            $properties = "`$select=$($selectProperties)"
        }
        $params["Uri"] = $baseUri + "?$properties"

        if ($PSBoundParameters.ContainsKey("Top")) {
            $topCount = $PSBoundParameters["Top"]
            if ($topCount -gt 999) {
                $params["Uri"] += "&`$top=999"
            }
            else {
                $params["Uri"] += "&`$top=$topCount"
            }
        }    
        if ($null -ne $PSBoundParameters["Filter"]) {
            $Filter = $PSBoundParameters["Filter"]
            $f = '$' + 'Filter'
            $params["Uri"] += "&$f=$Filter"
        }

        if ($null -ne $PSBoundParameters["SearchString"]) {
            $TmpValue = $PSBoundParameters["SearchString"]
            $SearchString = "`$search=""displayName:$TmpValue OR startsWith(displayName,'$TmpValue')"""
            $params["Uri"] += "&$SearchString"
            $customHeaders['ConsistencyLevel'] = 'eventual'
        }

        Write-Debug("============================ TRANSFORMATIONS ============================")
        $params.Keys | ForEach-Object { "$_ : $($params[$_])" } | Write-Debug
        Write-Debug("=========================================================================`n")
        
        $response = (Invoke-GraphRequest -Headers $customHeaders -Uri $($params.Uri) -Method GET)
        $data = $response | ConvertTo-Json -Depth 10 | ConvertFrom-Json

        try {
            $data = $response.value | ConvertTo-Json -Depth 10 | ConvertFrom-Json
            $all = $All.IsPresent
            $increment = $topCount - $data.Count
            while (($response.'@odata.nextLink' -and (($all -and ($increment -lt 0)) -or $increment -gt 0))) {
                $params["Uri"] = $response.'@odata.nextLink'
                if ($increment -gt 0) {
                    $topValue = [Math]::Min($increment, 999)
                    $params["Uri"] = $params["Uri"].Replace('$top=999', "`$top=$topValue")
                    $increment -= $topValue
                }
                $response = Invoke-GraphRequest @params 
                $data += $response.value | ConvertTo-Json -Depth 10 | ConvertFrom-Json
            }
        }
        catch {
            Write-Error "An error occurred: $_"
        }
        
        $data
    }
}

