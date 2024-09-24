# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
function Get-EntraAdministrativeUnitMember {
    [CmdletBinding(DefaultParameterSetName = 'GetQuery')]
    param (
        [Parameter(ParameterSetName = "GetQuery", ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
        [System.Int32] $Top,
        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
        [System.String] $ObjectId,
        [Parameter(ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
        [switch] $All
    )

    PROCESS {
        $params = @{}
        $topCount = $null
        $customHeaders = New-EntraCustomHeaders -Command $MyInvocation.MyCommand
        $baseUri = "/v1.0/directory/administrativeUnits/$ObjectId/members?`$select=*"
        $params["Uri"] = "$baseUri"
        if ($null -ne $PSBoundParameters["ObjectId"]) {
            $params["AdministrativeUnitId"] = $PSBoundParameters["ObjectId"]
        }
        if ($PSBoundParameters.ContainsKey("Top")) {
            $topCount = $PSBoundParameters["Top"]
            if ($topCount -gt 999) {
                $minTop = 999
                $params["Uri"] += "&`$top=999"
            }
            else {
                $params["Uri"] += "&`$top=$topCount"
            }
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
                    if ($minTop) {
                        $params["Uri"] = $params["Uri"].Replace("`$top=$minTop", "`$top=$topValue")
                    }
                    else {
                        $params["Uri"] = $params["Uri"].Replace("`$top=$topCount", "`$top=$topValue")
                    }
                    $increment -= $topValue
                }
                $response = (Invoke-GraphRequest -Headers $customHeaders -Uri $($params.Uri) -Method GET)
                $data += $response.value | ConvertTo-Json -Depth 10 | ConvertFrom-Json
            }
        }
        catch {}
        $data | ForEach-Object {
            if ($null -ne $_) {
                Add-Member -InputObject $_ -MemberType AliasProperty -Name ObjectId -Value Id
            }
        }
        if ($data) {
            $memberList = @()
            foreach ($response in $data) {
                $memberType = New-Object Microsoft.Graph.PowerShell.Models.MicrosoftGraphDirectoryObject
                if (-not ($response -is [psobject])) {
                    $response = [pscustomobject]@{ Value = $response }
                }
                $response.PSObject.Properties | ForEach-Object {
                    $propertyName = $_.Name
                    $propertyValue = $_.Value
                    $memberType | Add-Member -MemberType NoteProperty -Name $propertyName -Value $propertyValue -Force
                }
                $memberList += $memberType
            }
            $memberList
        }
    }
}