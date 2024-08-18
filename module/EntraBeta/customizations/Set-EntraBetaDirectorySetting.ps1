# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
@{
    SourceName = "Set-AzureADDirectorySetting"
    TargetName = "Update-MgBetaDirectorySetting"
    Parameters = @(
        @{
            SourceName = "DirectorySetting"
            TargetName = "BodyParameter"
            ConversionType = "ScriptBlock"
            SpecialMapping = @"
            `$Value =  `$TmpValue | ForEach-Object {
                `$NonEmptyProperties = `$_.psobject.Properties | Where-Object {`$_.Value} | Select-Object -ExpandProperty Name
                `$_ | Select-Object -Property `$NonEmptyProperties | ConvertTo-Json
                 }
"@
        },
        @{
            SourceName = "Id"
            TargetName = "DirectorySettingId"
            ConversionType = "Name"
            SpecialMapping = $null
        }
    )
    Outputs = $null
}