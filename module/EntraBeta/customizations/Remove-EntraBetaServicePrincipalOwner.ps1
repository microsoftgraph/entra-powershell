@{
    SourceName = "Remove-AzureADServicePrincipalOwner"
    TargetName = "Remove-MgBetaServicePrincipalOwnerByRef"
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