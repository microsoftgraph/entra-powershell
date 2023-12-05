# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
@{
    SourceName = "Get-AzureADDirectorySettingTemplate"
    TargetName = $null
    Parameters = $null
    Outputs = $null
    CustomScript = @"
    PROCESS {    
        `$params = @{}
        `$keysChanged = @{}
        if(`$PSBoundParameters.ContainsKey("Verbose"))
        {
            `$params["Verbose"] = `$Null
        }
        if(`$PSBoundParameters.ContainsKey("Debug"))
        {
            `$params["Debug"] = `$Null
        }
        if(`$null -ne `$PSBoundParameters["Id"])
        {
            `$params["DirectorySettingTemplateId"] = `$PSBoundParameters["Id"]
        }
    
        Write-Debug("============================ TRANSFORMATIONS ============================")
        `$params.Keys | ForEach-Object {"`$_ : `$(`$params[`$_])" } | Write-Debug
        Write-Debug("=========================================================================``n")
        
        `$apiResponse = Get-MgBetaDirectorySettingTemplate @params
        `$response = @()
        `$apiResponse | ForEach-Object {
            if(`$null -ne `$_) {
                `$item = New-Object -TypeName Microsoft.Open.MSGraph.Model.DirectorySettingTemplate
                `$item.Id = `$_.Id
                `$item.DisplayName = `$_.DisplayName
                `$item.Description = `$_.Description
                `$item.Values = @()
                `$_.Values | ForEach-Object {
                    `$value = New-Object -TypeName Microsoft.Open.MSGraph.Model.SettingTemplateValue
                    `$value.Name = `$_.Name
                    `$value.DefaultValue = `$_.DefaultValue
                    `$item.Values.Add(`$value)
                }
                `$response += `$item
            }
        }
        `$response
    }
"@
}
