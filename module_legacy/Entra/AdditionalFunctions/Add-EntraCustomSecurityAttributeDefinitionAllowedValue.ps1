# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
function Add-EntraCustomSecurityAttributeDefinitionAllowedValue {
    [CmdletBinding(DefaultParameterSetName = 'InvokeByDynamicParameters')]
    param (
        [Parameter(ParameterSetName = "InvokeByDynamicParameters", Mandatory = $true)]
        [System.String] $Id,
        [Parameter(ParameterSetName = "InvokeByDynamicParameters", Mandatory = $true)]
        [System.Nullable`1[System.Boolean]] $IsActive,
        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
        [System.String] $CustomSecurityAttributeDefinitionId
    )

    PROCESS {    
        $params = @{}
        $body = @{}
        $customHeaders = New-EntraCustomHeaders -Command $MyInvocation.MyCommand
    
        if ($null -ne $PSBoundParameters["Id"]) {
            $body["Id"] = $PSBoundParameters["Id"]
        }
        if ($null -ne $PSBoundParameters["IsActive"]) {
            $body["IsActive"] = $PSBoundParameters["IsActive"]
        }

        Write-Debug("============================ TRANSFORMATIONS ============================")
        $params.Keys | ForEach-Object { "$_ : $($params[$_])" } | Write-Debug
        Write-Debug("=========================================================================`n")
        
        $Uri = "https://graph.microsoft.com/v1.0/directory/customSecurityAttributeDefinitions/$CustomSecurityAttributeDefinitionId/allowedValues"
        $Method = "POST"
        $response = Invoke-GraphRequest -Uri $Uri -Method $Method -Body $body -Headers $customHeaders | ConvertTo-Json | ConvertFrom-Json
        if($response)
        {
            $userList = @()
            foreach ($data in $response) {
                $userType = New-Object Microsoft.Graph.PowerShell.Models.MicrosoftGraphAllowedValue
                $data.PSObject.Properties | ForEach-Object {
                    $propertyName = $_.Name
                    $propertyValue = $_.Value
                    $userType | Add-Member -MemberType NoteProperty -Name $propertyName -Value $propertyValue -Force
                }
                $userList += $userType
            }
            $userList
        } 
    }
}
