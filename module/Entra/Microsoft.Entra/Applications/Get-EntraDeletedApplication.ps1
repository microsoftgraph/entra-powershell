# ------------------------------------------------------------------------------ 
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  
#  Licensed under the MIT License.  See License in the project root for license information. 
# ------------------------------------------------------------------------------ 
# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.
#  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
function Get-EntraDeletedApplication {
    [CmdletBinding(DefaultParameterSetName = 'GetQuery')]
    param (
        [Parameter(ParameterSetName = "GetQuery", ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = "The maximum number of items to retrieve.")]
        [Alias("Limit")]
        [System.Nullable`1[System.Int32]] $Top,

        [Parameter(ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = "Return all items.")]
        [switch] $All,

        [Parameter(ParameterSetName = "GetQuery", ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = "Filter the results based on specific criteria.")]
        [System.String] $Filter,

        [Parameter(ParameterSetName = "GetVague", ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = "Search for items using a string.")]
        [System.String] $SearchString,

        [Parameter(Mandatory = $false, ValueFromPipeline = $false, ValueFromPipelineByPropertyName = $true, HelpMessage = "Specify properties to include in the response.")]
        [Alias("Select")]
        [System.String[]] $Property
    )

    PROCESS {
        try {
            # Initialize parameters
            $customHeaders = New-EntraCustomHeaders -Command $MyInvocation.MyCommand
            $baseUri = "/v1.0/directory/deleteditems/microsoft.graph.application"
            $params = @{ Uri = $baseUri }

            # Handle property selection
            if ($Property) {
                $properties = $Property -join ','
                $params["Uri"] += "?`$select=$properties"
            }
            else {
                $params["Uri"] += "?`$select=*"
            }

            # Handle $Top parameter
            if ($Top) {
                $topValue = [Math]::Min($Top, 999)
                $params["Uri"] += "&`$top=$topValue"
            }

            # Handle $Filter parameter
            if ($Filter) {
                $params["Uri"] += "&`$filter=$Filter"
            }

            # Handle $SearchString parameter
            if ($SearchString) {
                $searchQuery = "`$search=""displayName:$SearchString OR startsWith(displayName,'$SearchString')"""
                $params["Uri"] += "&$searchQuery"
                $customHeaders['ConsistencyLevel'] = 'eventual'
            }

            # Debug output
            Write-Debug "Constructed URI: $($params["Uri"])"

            # Fetch data using pagination
            $allResults = @()
            do {
                $response = Invoke-GraphRequest -Headers $customHeaders -Uri $params["Uri"] -Method GET
                $allResults += $response.value

                # Handle pagination
                if ($response.'@odata.nextLink' -and $All) {
                    $params["Uri"] = $response.'@odata.nextLink'
                }
                else {
                    break
                }
            } while ($true)

            # Transform results
            if ($allResults) {
                $allResults | ForEach-Object {
                    $result = $_

                    # Add DeletionAgeInDays property
                    if ($result.DeletedDateTime) {
                        $deletionAgeInDays = (Get-Date) - [datetime]$result.DeletedDateTime
                        $result | Add-Member -MemberType NoteProperty -Name DeletionAgeInDays -Value ($deletionAgeInDays.Days) -Force
                    }

                    $result.PSObject.Properties | ForEach-Object {
                        $newName = $_.Name.Substring(0, 1).ToUpper() + $_.Name.Substring(1)
                        $result | Add-Member -MemberType NoteProperty -Name $newName -Value $_.Value -Force
                    }
                }
            }

            return $allResults
        }
        catch {
            Write-Error "An error occurred: $_"
        }
    }
}

