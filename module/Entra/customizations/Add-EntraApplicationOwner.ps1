# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
@{
    SourceName = "Add-AzureADApplicationOwner"
    TargetName = $null
    Parameters = $null
    Outputs = $null
    CustomScript = @"
    `$params = @{}
    `$customHeaders = New-EntraCustomHeaders -Command `$MyInvocation.MyCommand
    if(`$PSBoundParameters.ContainsKey("Verbose"))
    {
        `$params["Verbose"] = `$Null
    }
    if(`$null -ne `$PSBoundParameters["ObjectId"])
    {
        `$params["ApplicationId"] = `$PSBoundParameters["ObjectId"]
    }

    `$newOwner = @{}

    if(`$null -ne `$PSBoundParameters["RefObjectId"])
    {
        `$newOwner["@odata.id"]  = "https://graph.microsoft.com/v1.0/directoryObjects/"+`$PSBoundParameters["RefObjectId"]
        `$params["BodyParameter"] = `$newOwner
    }
    if(`$PSBoundParameters.ContainsKey("Debug"))
    {
        `$params["Debug"] = `$Null
    }

    Write-Debug("============================ TRANSFORMATIONS ============================")
    $`params.Keys | ForEach-Object {"`$_ : `$(`$params[`$_])" } | Write-Debug
    Write-Debug("=========================================================================``n")
    
    New-MgApplicationOwnerByRef @params -Headers `$customHeaders
"@
}