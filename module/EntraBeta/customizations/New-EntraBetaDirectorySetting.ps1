@{
    SourceName = "New-AzureADDirectorySetting"
    TargetName = "New-MgBetaDirectorySetting"
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
        }
    )
    Outputs = $null
}
