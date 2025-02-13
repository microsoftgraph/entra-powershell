# ------------------------------------------------------------------------------ 
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  
#  Licensed under the MIT License.  See License in the project root for license information. 
# ------------------------------------------------------------------------------ 
function Get-EntraDeletedApplication {
    [CmdletBinding(DefaultParameterSetName = 'GetQuery')]
    param (
        [Alias("ObjectId")]
        [Parameter(ParameterSetName = "GetById", Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = "Unique ID of the application object (Application Object ID). Should be a valid GUID value.")]
        [System.String] $ApplicationId,

        [Parameter(ParameterSetName = "GetQuery", ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = "The properties to include in the response.")]
        [Alias("Limit")]
        [System.Nullable`1[System.Int32]] $Top,

        [Parameter(ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = "Return all items.")]
        [switch] $All,

        [Parameter(ParameterSetName = "GetQuery", ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = "Filter the results based on specific criteria.")]
        [System.String] $Filter,

        [Parameter(Mandatory = $false, ValueFromPipeline = $false, ValueFromPipelineByPropertyName = $true, HelpMessage = "The properties to include in the response.")]
        [Alias("Select")]
        [System.String[]] $Property
    )

    PROCESS {    
        $params = @{}
        $topCount = $null
        $customHeaders = New-EntraCustomHeaders -Command $MyInvocation.MyCommand
        $baseUri = "/v1.0/directory/deleteditems"

        $properties = '$select=*'
        if ($null -ne $PSBoundParameters["Property"]) {
            $selectProperties = $PSBoundParameters["Property"]
            if (-not $selectProperties.Contains("DeletedDateTime")) {
                $selectProperties += "DeletedDateTime"
            }
            $selectProperties = $selectProperties -Join ','
            $properties = "`$select=$($selectProperties)"
        }

        if ($null -ne $PSBoundParameters["ApplicationId"]) {
            $params["Uri"] = "$baseUri/$($PSBoundParameters["ApplicationId"])?" + $properties
        }
        else {
            $params["Uri"] = "$baseUri/microsoft.graph.application?$properties"

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
        }

        Write-Debug("============================ TRANSFORMATIONS ============================")
        $params.Keys | ForEach-Object { "$_ : $($params[$_])" } | Write-Debug
        Write-Debug("=========================================================================`n")
        
        $response = (Invoke-GraphRequest -Headers $customHeaders -Uri $($params.Uri) -Method GET)

        try {
            if ($null -ne $PSBoundParameters["ApplicationId"]) {
                $data = @($response)
            }
            else {
                $data = $response.value
                $all = $All.IsPresent
                $increment = $topCount - $data.Count
                while ($response.PSObject.Properties["`@odata.nextLink"] -and (($all -and ($increment -lt 0)) -or $increment -gt 0)) {
                    $params["Uri"] = $response.'@odata.nextLink'
                    if ($increment -gt 0) {
                        $topValue = [Math]::Min($increment, 999)
                        $params["Uri"] = $params["Uri"].Replace('`$top=999', "`$top=$topValue")
                        $increment -= $topValue
                    }
                    $response = Invoke-GraphRequest @params 
                    $data += $response.value
                }
            }
        }
        catch {
            Write-Error "An error occurred: $_"
        }
        
        # Add DeletionAgeInDays property
        $data | ForEach-Object {
            if ($null -ne $_.DeletedDateTime) {
                $deletionAgeInDays = (Get-Date) - ($_.DeletedDateTime)
                $_ | Add-Member -MemberType NoteProperty -Name DeletionAgeInDays -Value ($deletionAgeInDays.Days) -Force
            }
        }

        $data
    }
}