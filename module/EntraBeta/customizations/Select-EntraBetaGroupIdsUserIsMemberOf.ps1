# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
@{
    SourceName = "Select-AzureADGroupIdsUserIsMemberOf"
    TargetName = $null
    Parameters = $null
    outputs = $null
    CustomScript = @"
    PROCESS {    
        `$params = @{}
        `$customHeaders = New-EntraBetaCustomHeaders -Command `$MyInvocation.MyCommand
        if(`$null -ne `$PSBoundParameters["ObjectId"])
        {
            `$params["UserId"] = `$PSBoundParameters["ObjectId"]
        }
        if(`$PSBoundParameters.ContainsKey("Debug"))
        {
            `$params["Debug"] = `$Null
        }
        if(`$PSBoundParameters.ContainsKey("Verbose"))
        {
            `$params["Verbose"] = `$Null
        }
        Write-Debug("============================ TRANSFORMATIONS ============================")
        `$params.Keys | ForEach-Object {"`$_ : `$(`$params[`$_])" } | Write-Debug
        Write-Debug("=========================================================================``n")
        `$initalResponse = Get-MgBetaUserMemberOfAsGroup -Headers `$customHeaders -UserId `$params["UserId"]
        `$response = `$initalResponse | Where-Object -Filterscript {`$_.ID -in (`$GroupIdsForMembershipCheck.GroupIds)} 
        if(`$response){
            `$response.ID
        }
        }
"@
}