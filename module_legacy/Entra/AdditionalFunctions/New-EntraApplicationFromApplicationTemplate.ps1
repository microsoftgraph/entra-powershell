# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
function New-EntraApplicationFromApplicationTemplate {
    [CmdletBinding(DefaultParameterSetName = '')]
    param (
    [Parameter(Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
    [System.String] $Id,
    [Parameter(Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
    [System.String] $DisplayName
    )

    PROCESS {
        $params = @{}
        $customHeaders = New-EntraCustomHeaders -Command $MyInvocation.MyCommand
        if ($null -ne $PSBoundParameters["Id"]) {
            $params["ApplicationTemplateId"] = $PSBoundParameters["Id"]
        }
        if ($null -ne $PSBoundParameters["DisplayName"]) {
            $params["DisplayName"] = $PSBoundParameters["DisplayName"]
        }

        Write-Debug("============================ TRANSFORMATIONS ============================")
        $params.Keys | ForEach-Object {"$_ : $($params[$_])" } | Write-Debug
        Write-Debug("=========================================================================`n")

        $body = @{
            displayName = $DisplayName
        }

        $uri = "https://graph.microsoft.com/v1.0/applicationTemplates/$Id/instantiate"
        $response =  invoke-graphrequest -uri $uri -Headers $customHeaders -Body $body -Method POST | ConvertTo-Json -Depth 5 | ConvertFrom-Json
        $memberList = @()
        foreach($data in $response){
            $memberType = New-Object Microsoft.Graph.PowerShell.Models.MicrosoftGraphApplicationServicePrincipal
            if (-not ($data -is [psobject])) {
                $data = [pscustomobject]@{ Value = $data }
            }
            $data.PSObject.Properties | ForEach-Object {
                $propertyName = $_.Name
                $propertyValue = $_.Value
                $memberType | Add-Member -MemberType NoteProperty -Name $propertyName -Value $propertyValue -Force
            }
            $memberList += $memberType
        }
        $memberList
    }
}