# ------------------------------------------------------------------------------ 
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  
#  Licensed under the MIT License.  See License in the project root for license information. 
# ------------------------------------------------------------------------------ 
function Set-EntraBetaObjectSetting {
    [CmdletBinding(DefaultParameterSetName = 'Default')]
    param (
                
        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
        [System.String] $TargetType,
                
        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
        [Microsoft.Open.MSGraph.Model.DirectorySetting] $DirectorySetting,
                
        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
        [System.String] $Id,
                
        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
        [System.String] $TargetObjectId
    )

    PROCESS {  
        $params = @{}
        $customHeaders = New-EntraBetaCustomHeaders -Command $MyInvocation.MyCommand
        if ($null -ne $PSBoundParameters["TargetType"]) {
            $params["TargetType"] = $PSBoundParameters["TargetType"]
        }
        if ($null -ne $PSBoundParameters["TargetObjectId"]) {
            $params["TargetObjectId"] = $PSBoundParameters["TargetObjectId"]
        }
        if ($null -ne $PSBoundParameters["DirectorySetting"]) {
            $params["DirectorySetting"] = $PSBoundParameters["DirectorySetting"]
        }
        if ($null -ne $PSBoundParameters["ID"]) {
            $params["ID"] = $PSBoundParameters["ID"]
        }
        Write-Debug("============================ TRANSFORMATIONS ============================")
        $params.Keys | ForEach-Object { "$_ : $($params[$_])" } | Write-Debug
        Write-Debug("=========================================================================`n")
        $directorySettingsJson = $DirectorySetting | ForEach-Object {
            $NonEmptyProperties = $_.psobject.Properties | Where-Object { $_.Value } | Select-Object -ExpandProperty Name
            $propertyValues = $_ | Select-Object -Property $NonEmptyProperties | ConvertTo-Json
            [regex]::Replace($propertyValues, '(?<=")(\w+)(?=":)', { $args[0].Groups[1].Value.ToLower() })
        }
        $response = Invoke-GraphRequest -Headers $customHeaders -Method PATCH -Uri https://graph.microsoft.com/beta/$TargetType/$TargetObjectId/settings/$ID -Body $directorySettingsJson
        $response | ConvertTo-Json | ConvertFrom-Json
    }      
}

