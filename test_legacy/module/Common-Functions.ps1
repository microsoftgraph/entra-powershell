# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

$psVersion = $global:PSVersionTable.PSVersion
if($null -ne (Get-Module -Name Microsoft.Graph.Entra.Beta)){
    $entraVersion = (Get-module Microsoft.Graph.Entra.Beta | select version).Version.ToString() 
}
if($null -ne (Get-Module -Name Microsoft.Graph.Entra)){
    $entraVersion = (Get-module Microsoft.Graph.Entra | select version).Version.ToString() 
}

function Get-Parameters{
    param(
        $data
    )

    PROCESS{
        $params = @{}
        for ($i = 0; $i -lt $data.Length; $i += 2) {
            $key = $data[$i] -replace '-', '' -replace ':', ''
            $value = $data[$i + 1]
            $params[$key] = $value
        }

        $params
    }
}