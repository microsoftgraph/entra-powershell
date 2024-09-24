# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
function Get-EntraApplicationTemplate {
    [CmdletBinding(DefaultParameterSetName = 'GetQuery')]
    param (
    [Parameter(ParameterSetName = "GetById", Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
    [System.String] $Id,
    [Parameter(ParameterSetName = "GetQuery", ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
    [System.Int32] $Top,
    [Parameter(ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
    [switch] $All,
    [Parameter(ParameterSetName = "GetQuery", ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
    [System.String] $Filter,
    [Parameter(Mandatory = $false, ValueFromPipeline = $false, ValueFromPipelineByPropertyName = $true)]
    [System.String[]] $Property
    )

    PROCESS {
        $params = @{}
        $customHeaders = New-EntraCustomHeaders -Command $MyInvocation.MyCommand
        $topCount = $null
        $uri = "https://graph.microsoft.com/v1.0/applicationTemplates"
        $params["Method"] = "GET"
        $params["Uri"] = $uri+'?$select=*'
        
        if($null -ne $PSBoundParameters["Property"])
        {
            $selectProperties = $PSBoundParameters["Property"]
            $selectProperties = $selectProperties -Join ','
            $params["Uri"] = $uri+"?`$select=$($selectProperties)"
        }
        if(($PSBoundParameters.ContainsKey("Top") -and  (-not $PSBoundParameters.ContainsKey("All"))) -or ($PSBoundParameters.ContainsKey("Top") -and  $null -ne $PSBoundParameters["All"]))
        {
            $topCount = $PSBoundParameters["Top"]            
            $params["Uri"] += "&`$top=$topCount"
        }
        if($null -ne $PSBoundParameters["Filter"])
        {
            $Filter = $PSBoundParameters["Filter"]
            $f = '$' + 'Filter'
            $params["Uri"] += "&$f=$Filter"
        }        
        if((-not $PSBoundParameters.ContainsKey("Top")) -and (-not $PSBoundParameters.ContainsKey("All")))
        {
            $params["Uri"] += "&`$top=100"
        }
        if($null -ne $PSBoundParameters["Id"])
        {
            $params["ApplicationTemplateId"] = $PSBoundParameters["Id"]
            $params["Uri"] = $uri + "/$Id"
        }

        $response = Invoke-GraphRequest -Uri $($params.Uri) -Method GET -Headers $customHeaders

        if($response.ContainsKey('value')){
            $response = $response.value
        }

        $data = $response | ConvertTo-Json -Depth 10 | ConvertFrom-Json       
        
        $userList = @()
        foreach ($res in $data) {
            $userType = New-Object Microsoft.Graph.PowerShell.Models.MicrosoftGraphApplicationTemplate
            $res.PSObject.Properties | ForEach-Object {
                $propertyName = $_.Name.Substring(0,1).ToUpper() + $_.Name.Substring(1)
                $propertyValue = $_.Value
                $userType | Add-Member -MemberType NoteProperty -Name $propertyName -Value $propertyValue -Force
            }
            $userList += $userType
        }
        $userList
    }
}