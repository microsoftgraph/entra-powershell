# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

function Get-EntraGroupMemberAsServicePrincipal {
    [CmdletBinding(DefaultParameterSetName = 'List', PositionalBinding = $false)]
    param(
        [Parameter(ParameterSetName = 'Get', Mandatory = $true)]
        [string]$DirectoryObjectId,

        [Parameter(ParameterSetName = 'List', Mandatory = $true)]
        [Parameter(ParameterSetName = 'Get', Mandatory = $true)]
        [string]$GroupId,

        [Alias('Select')]
        [AllowEmptyCollection()][string[]]$Property,

        [Parameter(ParameterSetName = 'List')]
        [string]$Filter,

        [Parameter(ParameterSetName = 'List')]
        [string]$SearchString,

        [Parameter(ParameterSetName = 'List')]
        [Alias('Limit')]
        [int]$Top,

        [Parameter(ParameterSetName = 'List')]
        [switch]$All
    )
    
    PROCESS {
        $customHeaders = New-EntraCustomHeaders -Command $MyInvocation.MyCommand
        $params = @{}
        $topCount = $null
        $baseUri = "https://graph.microsoft.com/v1.0/groups/$GroupId/members/microsoft.graph.servicePrincipal"
        $params["Method"] = "GET"
        $params["Uri"] = "$baseUri"
        
        if($null -ne $PSBoundParameters["Property"])
        {
            $selectProperties = $PSBoundParameters["Property"]
            $selectProperties = $selectProperties -Join ','
            $properties = "`$select=$($selectProperties)"
            $params["Uri"] = "$baseUri/?$properties"
        }

        if($null -ne $PSBoundParameters["Top"] -and  (-not $PSBoundParameters.ContainsKey("All")))
        {
            $topCount = $PSBoundParameters["Top"]
            if ($topCount -gt 999) {
                $params["Uri"] += "&`$top=999"
            }
            else{
                $params["Uri"] += "&`$top=$topCount"
            }
        }
        
        if($null -ne $PSBoundParameters["SearchString"])
        {
            $TmpValue = $PSBoundParameters["SearchString"]
            $SearchString = "`$search=`"displayName:$TmpValue`" OR `"description:$TmpValue`""
            $params["Uri"] += "&$SearchString"
            $customHeaders['ConsistencyLevel'] = 'eventual'
        }
        if($null -ne $PSBoundParameters["DirectoryObjectId"])
        {
            $params["Uri"] = "https://graph.microsoft.com/v1.0/groups/$GroupId/members/$DirectoryObjectId/microsoft.graph.servicePrincipal"
        }
        if($null -ne $PSBoundParameters["Filter"])
        {
            $Filter = $PSBoundParameters["Filter"]
            $f = '$' + 'Filter'
            $params["Uri"] += "&$f=$Filter"
        }    
	    
        Write-Debug("============================ TRANSFORMATIONS ============================")
        $params.Keys | ForEach-Object {"$_ : $($params[$_])" } | Write-Debug
        Write-Debug("=========================================================================`n")
        
        $response = Invoke-GraphRequest @params -Headers $customHeaders
        $data = $response | ConvertTo-Json -Depth 10 | ConvertFrom-Json
        try {
            $data = $response.value | ConvertTo-Json -Depth 10 | ConvertFrom-Json
            $all = $All.IsPresent
            $increment = $topCount - $data.Count
            while ($response.'@odata.nextLink' -and (($all) -or ($increment -gt 0 -and -not $all))) {
                $params["Uri"] = $response.'@odata.nextLink'
                if (-not $all) {
                    $topValue = [Math]::Min($increment, 999)
                    $params["Uri"] = $params["Uri"].Replace('$top=999', "`$top=$topValue")
                    $increment -= $topValue
                }
                $response = Invoke-GraphRequest @params 
                $data += $response.value | ConvertTo-Json -Depth 10 | ConvertFrom-Json
            }
        } catch {}        
        $data | ForEach-Object {
            if ($null -ne $_) {
                Add-Member -InputObject $_ -MemberType AliasProperty -Name ObjectId -Value Id
                Add-Member -InputObject $_ -MemberType AliasProperty -Name InformationalUrls -Value Info
                Add-Member -InputObject $_ -MemberType AliasProperty -Name DeletionTimestamp -Value DeletedDateTime
            }
        }
        $userList = @()
        foreach ($response in $data) {
            $userType = New-Object Microsoft.Graph.PowerShell.Models.MicrosoftGraphServicePrincipal
            $response.PSObject.Properties | ForEach-Object {
                $propertyName = $_.Name
                $propertyValue = $_.Value
                $userType | Add-Member -MemberType NoteProperty -Name $propertyName -Value $propertyValue -Force
            }
            $userList += $userType
        }
        $userList 
    } 
}