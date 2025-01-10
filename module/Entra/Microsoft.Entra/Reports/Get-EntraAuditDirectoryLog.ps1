# ------------------------------------------------------------------------------ 
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  
#  Licensed under the MIT License.  See License in the project root for license information. 
# ------------------------------------------------------------------------------ 
function Get-EntraAuditDirectoryLog {
    [CmdletBinding(DefaultParameterSetName = 'GetQuery')]
    param (
    [Parameter(ParameterSetName = "GetById", ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
    [System.String] $Id,
    [Parameter(ParameterSetName = "GetQuery", ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
    [System.Int32] $Top,
    [Parameter(ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
    [switch] $All,
    [Parameter(ParameterSetName = "GetQuery", ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
    [System.String] $Filter
    )

    PROCESS {
        $customHeaders = New-EntraCustomHeaders -Command $MyInvocation.MyCommand
        $params = @{}
        $topCount = $null
        $baseUri = 'https://graph.microsoft.com/v1.0/auditLogs/directoryAudits'
        $params["Method"] = "GET"
        $params["Uri"] = "$baseUri"+"?"

        if($PSBoundParameters.ContainsKey("Top"))
        {
            $topCount = $PSBoundParameters["Top"]
            if ($topCount -gt 999) {
                $params["Uri"] += "&`$top=999"
            }
            else{
                $params["Uri"] += "&`$top=$topCount"
            }
        }
        if($null -ne $PSBoundParameters["Id"])
        {
            $LogId = $PSBoundParameters["Id"]
            $params["Uri"] = "$baseUri/$($LogId)"
        }
        if($null -ne $PSBoundParameters["Filter"])
        {
            $Filter = $PSBoundParameters["Filter"]
            $f = '$Filter'
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
        } catch {}

        $userList = @()
        foreach ($response in $data) {
            $userType = New-Object Microsoft.Graph.PowerShell.Models.MicrosoftGraphDirectoryAudit
            $response.PSObject.Properties | ForEach-Object {
                $propertyName = $_.Name
                $propertyValue = $_.Value
                $userType | Add-Member -MemberType NoteProperty -Name $propertyName -Value $propertyValue -Force
            }
            $userList += $userType
        }
        $userList
    }
}# ------------------------------------------------------------------------------

