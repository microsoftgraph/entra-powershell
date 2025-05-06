# ------------------------------------------------------------------------------ 
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  
#  Licensed under the MIT License.  See License in the project root for license information. 
# ------------------------------------------------------------------------------ 
function Get-EntraCustomSecurityAttributeDefinitionAllowedValue {
    [CmdletBinding(DefaultParameterSetName = 'GetQuery')]
    param (
        [Parameter(ParameterSetName = "GetById", Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
        [System.String] $Id,
        [Parameter(ParameterSetName = "GetQuery", ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
        [System.String] $Filter,
        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
        [System.String] $CustomSecurityAttributeDefinitionId
    )

    PROCESS {    
        $params = @{}
        $params["Uri"] = "/v1.0/directory/customSecurityAttributeDefinitions/$CustomSecurityAttributeDefinitionId/allowedValues/"
        $params["Method"] = "GET"
        $customHeaders = New-EntraCustomHeaders -Command $MyInvocation.MyCommand

        if ($null -ne $PSBoundParameters["Id"]) {
            $params["Uri"] += $Id
        }
        if ($null -ne $PSBoundParameters["Filter"]) {
            $params["Uri"] += '?$filter=' + $Filter
        }

        Write-Debug("============================ TRANSFORMATIONS ============================")
        $params.Keys | ForEach-Object { "$_ : $($params[$_])" } | Write-Debug
        Write-Debug("=========================================================================`n")
    
        $response = (Invoke-GraphRequest @params -Headers $customHeaders) | ConvertTo-Json -Depth 5 | ConvertFrom-Json 
        try {    
            $response = $response.value 
        }
        catch {}
        if($response)
        {
            $userList = @()
            foreach ($data in $response) {
                $userType = New-Object Microsoft.Graph.PowerShell.Models.MicrosoftGraphAllowedValue
                $data.PSObject.Properties | ForEach-Object {
                    $propertyName = $_.Name.Substring(0,1).ToUpper() + $_.Name.Substring(1)
                    $propertyValue = $_.Value
                    $userType | Add-Member -MemberType NoteProperty -Name $propertyName -Value $propertyValue -Force
                }
                $userList += $userType
            }
            $userList
        }
    }
}# ------------------------------------------------------------------------------

