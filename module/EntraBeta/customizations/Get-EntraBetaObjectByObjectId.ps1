# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
@{
    SourceName = "Get-AzureADObjectByObjectId"
    TargetName = $null
    Parameters = $null
    Outputs = $null
    CustomScript = @'
    PROCESS {    
    $params = @{}
    $keysChanged = @{ObjectIds = "Ids"}
    if($PSBoundParameters.ContainsKey("Debug"))
    {
        $params["Debug"] = $Null
    }
    if($null -ne $PSBoundParameters["Types"])
    {
        $params["Types"] = $PSBoundParameters["Types"]
    }
    if($PSBoundParameters.ContainsKey("Verbose"))
    {
        $params["Verbose"] = $Null
    }
    if($null -ne $PSBoundParameters["ObjectIds"])
    {
        $params["Ids"] = $PSBoundParameters["ObjectIds"]
    }

    Write-Debug("============================ TRANSFORMATIONS ============================")
    $params.Keys | ForEach-Object {"$_ : $($params[$_])" } | Write-Debug
    Write-Debug("=========================================================================`n")
    
    $response = Get-MgBetaDirectoryObjectById @params
    $response | ForEach-Object {
        if($null -ne $_) {
            Add-Member -InputObject $_ -MemberType AliasProperty -Name ObjectId -Value Id

            $dictionary = $_.AdditionalProperties
             
            foreach ($key in $dictionary.Keys) {
               $value = ($dictionary[$key] | Convertto-json -Depth 10) | ConvertFrom-Json
               $_ | Add-Member -MemberType NoteProperty -Name $key -Value ($value) -Force
            }
        }
    }

    $response 
}
'@
}