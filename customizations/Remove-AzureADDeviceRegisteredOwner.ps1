@{
    SourceName = "Remove-AzureADDeviceRegisteredOwner"
    TargetName = "Remove-MgDeviceRegisteredOwnerByRef"
    Parameters = @(
        @{
            SourceName = "OwnerId"
            TargetName = "DirectoryObjectId"
            ConversionType = "Name"
            SpecialMapping = $null
        }
    )
    Outputs = $null
}