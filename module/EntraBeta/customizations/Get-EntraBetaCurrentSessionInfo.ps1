# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
@{
    SourceName = "Get-AzureADCurrentSessionInfo"
    TargetName = $null
    Parameters = $null
    Outputs = $null
    CustomScript = @'
    PROCESS {    
        $params = @{}
        $keysChanged = @{}
        if($PSBoundParameters.ContainsKey("Debug"))
        {
            $params["Debug"] = $Null
        }
        if($null -ne $PSBoundParameters["Confirm"])
        {
            $params["Confirm"] = $PSBoundParameters["Confirm"]
        }
        if($null -ne $PSBoundParameters["WhatIf"])
        {
            $params["WhatIf"] = $PSBoundParameters["WhatIf"]
        }
        if($PSBoundParameters.ContainsKey("Verbose"))
        {
            $params["Verbose"] = $Null
        }
    
        Write-Debug("============================ TRANSFORMATIONS ============================")
        $params.Keys | ForEach-Object {"$_ : $($params[$_])" } | Write-Debug
        Write-Debug("=========================================================================`n")
        
        $response = Get-MgContext @params 
        $response | ForEach-Object {
            if($null -ne $_) {
            Add-Member -InputObject $_ -MemberType AliasProperty -Name ObjectId -Value Id
            }
        }
        $response
        }
'@
}