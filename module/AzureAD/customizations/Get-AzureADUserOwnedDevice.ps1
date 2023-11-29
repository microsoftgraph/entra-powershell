@{
    SourceName = "Get-AzureADUserOwnedDevice"
    TargetName = "Get-MgUserOwnedDevice"
    Parameters = @(
        @{
            SourceName = "ObjectId"
            TargetName = "UserId"
            ConversionType = "Name"
            SpecialMapping = $null
        }
    )
    Outputs = $null
}
