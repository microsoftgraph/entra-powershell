@{
    SourceName = "Remove-AzureADServicePrincipalOwner"
    TargetName = "Remove-MgBetaServicePrincipalOwnerByRef"
    Parameters = @(
        @{
            SourceName = "ObjectId"
            TargetName = "ServicePrincipalId "
            ConversionType = "Name"
            SpecialMapping = $null
        },
        @{
            SourceName = "OwnerId"
            TargetName = "DirectoryObjectId"
            ConversionType = "Name"
            SpecialMapping = $null
        }
    )
    Outputs = $null
}