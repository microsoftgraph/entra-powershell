@{
    SourceName = "Get-AzureADUserOwnedDevice"
    TargetName = "Get-MgBetaUserOwnedDevice"
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
