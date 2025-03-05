# ------------------------------------------------------------------------------ 
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  
#  Licensed under the MIT License.  See License in the project root for license information. 
# ------------------------------------------------------------------------------ 
function Get-EntraSubscription {
    [CmdletBinding(DefaultParameterSetName = 'GetQuery')]
    param (
        [Alias("ObjectId")]
        [Parameter(ParameterSetName = "GetById", Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = "Specifies the unique object ID of the subscription to retrieve.")]
        [System.String] $SubscriptionId,
        [Parameter(ParameterSetName = "GetQuery", ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $false, HelpMessage = "Specifies the number of objects to return.")]
        [Alias("Limit")]
        [System.Nullable`1[System.Int32]] $Top,
        [Parameter(ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $false, HelpMessage = "Specifies whether to return all objects.")]
        [switch] $All,
        [Parameter(ParameterSetName = "GetQuery", ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $false, HelpMessage = "Filter the results based on the specified criteria.")]
        [System.String] $Filter
    )

    PROCESS {    
        $params = @{}
        $customHeaders = New-EntraCustomHeaders -Command $MyInvocation.MyCommand
        $baseUri = "/v1.0/directory/subscriptions"
        $properties = '$select=*'
        $params["Uri"] = "$baseUri/?$properties"    
        if ($null -ne $PSBoundParameters["SubscriptionId"]) {
            $params["SubscriptionId"] = $PSBoundParameters["SubscriptionId"]
            $params["Uri"] = "$baseUri/$($params.SubscriptionId)?$properties"
        }    
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
        catch {} 
        $data | ForEach-Object {
            if ($null -ne $_) {
                Add-Member -InputObject $_ -MemberType AliasProperty -Name ObjectId -Value Id -Force
            }
        }
        
        if ($data) {
            $aulist = @()
            foreach ($item in $data) {
                $auType = New-Object Microsoft.Graph.PowerShell.Models.MicrosoftGraphDirectorySubscription
                $item.PSObject.Properties | ForEach-Object {
                    $propertyName = $_.Name.Substring(0, 1).ToUpper() + $_.Name.Substring(1)
                    $propertyValue = $_.Value
                    $auType | Add-Member -MemberType NoteProperty -Name $propertyName -Value $propertyValue -Force
                }
                $aulist += $auType
            }
            $aulist
        }
    }
}# ------------------------------------------------------------------------------

