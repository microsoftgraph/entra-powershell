# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
@{
    SourceName = "Remove-AzureADObjectSetting"
    TargetName = $null
    Parameters = $null
    Outputs = $null
    CustomScript = @'
    PROCESS {  
        $params = @{}
        $customHeaders = New-EntraBetaCustomHeaders -Command $MyInvocation.MyCommand
        if ($null -ne $PSBoundParameters["TargetType"]) {
            $params["TargetType"] = $PSBoundParameters["TargetType"]
        }
        if ($null -ne $PSBoundParameters["TargetObjectId"]) {
            $params["TargetObjectId"] = $PSBoundParameters["TargetObjectId"]
        }
        if ($null -ne $PSBoundParameters["Id"]) {
            $params["Id"] = $PSBoundParameters["Id"]
        } 
        Write-Debug("============================ TRANSFORMATIONS ============================")
        $params.Keys | ForEach-Object {"$_ : $($params[$_])" } | Write-Debug
        Write-Debug("=========================================================================`n")
        $Method = "DELETE"
        $URI = ' https://graph.microsoft.com/beta/{0}/{1}/settings/{2}' -f $TargetType,$TargetObjectId, $ID
        $response = Invoke-GraphRequest -Headers $customHeaders -Uri $uri -Method $Method
        $response
    }   
'@
}