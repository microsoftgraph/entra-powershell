# ------------------------------------------------------------------------------ 
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  
#  Licensed under the MIT License.  See License in the project root for license information. 
# ------------------------------------------------------------------------------ 
function Get-EntraBetaSubscription {
    [CmdletBinding(DefaultParameterSetName = 'GetQuery')]
    param (
        [Parameter(ParameterSetName = "GetById", Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = "Specifies the unique object ID of the subscription to retrieve.")]
        [Alias('SubscriptionId')]
        [System.String] $CommerceSubscriptionId,

        [Parameter(ParameterSetName = "GetQuery", ValueFromPipeline = $false, ValueFromPipelineByPropertyName = $false, HelpMessage = "Specifies the number of objects to return.")]
        [Alias("Limit")]
        [System.Int32] $Top,

        [Parameter(ValueFromPipeline = $false, ValueFromPipelineByPropertyName = $false, HelpMessage = "Specifies whether to return all objects.")]
        [switch] $All,

        [Parameter(ParameterSetName = "GetQuery", ValueFromPipeline = $false, ValueFromPipelineByPropertyName = $false, HelpMessage = "Filter the results based on the specified criteria.")]
        [System.String] $Filter,

        [Parameter(Mandatory = $false, ValueFromPipeline = $false, ValueFromPipelineByPropertyName = $false, HelpMessage = "Specifies the properties to include in the response.")]
        [Alias("Select")]
        [System.String[]] $Property
    )

    PROCESS {    
        $params = @{}
        $topCount = 0
        $customHeaders = New-EntraBetaCustomHeaders -Command $MyInvocation.MyCommand
        $baseUri = "/beta/directory/subscriptions"
        $properties = "`$select=*"
    
        if ($PSBoundParameters.ContainsKey("Property")) {
            $selectProperties = $Property -join ','
            $properties = "`$select=$selectProperties"
        }
    
        if ($PSBoundParameters.ContainsKey("CommerceSubscriptionId")) {
            $commerceSubscriptionId = $PSBoundParameters["CommerceSubscriptionId"]
            $params["Uri"] = "${baseUri}/${commerceSubscriptionId}?$properties"
        }
        else {
            $params["Uri"] = "${baseUri}?$properties"
            
            if ($PSBoundParameters.ContainsKey("Top")) {
                $topCount = $Top
                $params["Uri"] += if ($topCount -gt 999) { "&`$top=999" } else { "&`$top=$topCount" }
            }
    
            if ($PSBoundParameters.ContainsKey("Filter")) {
                $params["Uri"] += "&`$filter=$Filter"
            }
        }
    
        Write-Debug("============================ TRANSFORMATIONS ============================")
        $params.Keys | ForEach-Object { "$_ : $($params[$_])" } | Write-Debug
        Write-Debug("=========================================================================`n")
    
        $response = Invoke-GraphRequest -Headers $customHeaders -Uri $params["Uri"] -Method GET
    
        try {
            if ($PSBoundParameters.ContainsKey("CommerceSubscriptionId")) {
                $data = @($response)
            }
            else {
                $data = $response.value
                $all = $All.IsPresent
                $increment = $topCount - ($data.Count)
    
                while ($response.PSObject.Properties["`@odata.nextLink"] -and (($all -and $increment -lt 0) -or $increment -gt 0)) {
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
            Write-Error "An error occurred while retrieving data: $_"
        }
    
        if ($Property -and $Property.Count -gt 0) {
            $data | Select-Object -Property $Property
        }
        else {
            $data | Select-Object -Property *
        }
    }
}
Set-Alias -Name Get-EntraBetaDirectorySubscription -Value Get-EntraBetaSubscription -Description "Retrieves the organization's commercial subscriptions." -Scope Global -Force