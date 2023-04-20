# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
@{
    SourceName = "Get-AzureADDeletedApplication"
    TargetName = $null
    Parameters = $null
    Outputs = $null
    CustomScript = @"
    PROCESS {    
        `$params = @{}  
        `$filter = ""
        if(`$null -ne `$PSBoundParameters["Filter"])
        {
            `$filter += `$PSBoundParameters["Filter"]            
        }
        if(`$null -ne `$PSBoundParameters["SearchString"])
        {
            `$filterValue += `$PSBoundParameters["SearchString"]
            `$filter += "```$filter=startswith(displayName,'`$filterValue')"
        }
        if(`$null -ne `$PSBoundParameters["Top"])
        {
            `$topValue = `$PSBoundParameters["Top"]
            `$filter += "```$top=```$topValue"
        }
        if(`$PSBoundParameters.ContainsKey("Debug"))
        {
            `$params["Debug"] = `$Null
        }
        if(`$null -ne `$PSBoundParameters["All"])
        {
            if(`$PSBoundParameters["All"])
            {
                `$filter += "```$top=999"
            }            
        }
        if(`$PSBoundParameters.ContainsKey("Verbose"))
        {
            `$params["Verbose"] = `$Null
        }
    
        Write-Debug("============================ TRANSFORMATIONS ============================")
        `$params.Keys | ForEach-Object {"`$_ : `$(`$params[`$_])" } | Write-Debug
        Write-Debug("=========================================================================``n")
        
        `$apiResponse =  Invoke-GraphRequest -Uri "/v1.0/directory/deleteditems/microsoft.graph.application?`$filter"
        `$response = `$apiResponse.Value | Select-Object -Property id, appId, displayName
        `$response | ForEach-Object {
            Add-Member -InputObject `$_ -MemberType AliasProperty -Name ObjectId -Value Id    
        }

        `$response
    }
"@
}