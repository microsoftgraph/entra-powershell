# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
function Get-EntraApplicationTemplate {
    [CmdletBinding(DefaultParameterSetName = 'GetQuery')]
    param (
    [Parameter(ParameterSetName = "GetById", Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
    [System.String] $Id
    )

    PROCESS {
        $params = @{}
        $customHeaders = New-EntraCustomHeaders -Command $MyInvocation.MyCommand
        $uri = "https://graph.microsoft.com/v1.0/applicationTemplates"

        if($null -ne $PSBoundParameters["Id"])
        {
            $params["ApplicationTemplateId"] = $PSBoundParameters["Id"]
            $uri += "/$Id"
        }

        $response = Invoke-GraphRequest -Uri $uri -Method GET -Headers $customHeaders
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