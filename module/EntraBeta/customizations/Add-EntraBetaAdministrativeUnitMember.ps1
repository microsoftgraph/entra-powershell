# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
@{
    SourceName = "Add-AzureADAdministrativeUnitMember"
    TargetName = $null
    Parameters = $null
    Outputs = $null
    CustomScript = @"
    PROCESS {    
        `$params = @{}
        `$customHeaders = New-EntraBetaCustomHeaders -Command `$MyInvocation.MyCommand
        `$keysChanged = @{ObjectId = "Id"; RefObjectId = "BodyParameter"}
        if(`$PSBoundParameters.ContainsKey("Verbose"))
        {
            `$params["Verbose"] = `$Null
        }
        if(`$null -ne `$PSBoundParameters["ObjectId"])
        {
            `$params["AdministrativeUnitId"] = `$PSBoundParameters["ObjectId"]
        }
        if(`$null -ne `$PSBoundParameters["RefObjectId"])
        {
            `$TmpValue = `$PSBoundParameters["RefObjectId"]
            `$Value = @{ "@odata.id" = "https://graph.microsoft.com/v1.0/directoryObjects/`$TmpValue"}
            `$params["BodyParameter"] = `$Value
        }
        if(`$PSBoundParameters.ContainsKey("Debug"))
        {
            `$params["Debug"] = `$Null
        }
    
        Write-Debug("============================ TRANSFORMATIONS ============================")
        `$params.Keys | ForEach-Object {"`$_ : `$(`$params[`$_])" } | Write-Debug
        Write-Debug("=========================================================================`n")
        
        `$response = New-MgBetaAdministrativeUnitMemberByRef @params -Headers `$customHeaders
        `$response | ForEach-Object {
            if(`$null -ne `$_) {
            Add-Member -InputObject `$_ -MemberType AliasProperty -Name ObjectId -Value Id
    
            }
        }
        `$response
        }
"@
}
