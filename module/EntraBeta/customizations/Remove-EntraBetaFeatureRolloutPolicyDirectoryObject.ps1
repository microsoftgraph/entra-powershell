@{
    SourceName = "Remove-AzureADMSFeatureRolloutPolicyDirectoryObject"
    TargetName = "Remove-MgBetaPolicyFeatureRolloutPolicyApplyToByRef"
    Parameters = @(
        @{
            SourceName = "Id"
            TargetName = "FeatureRolloutPolicyId"
            ConversionType = "Name"
            SpecialMapping = $null
        },
        @{
            SourceName = "ObjectId"
            TargetName = "DirectoryObjectId"
            ConversionType = "Name"
            SpecialMapping = $null
        }
    )
    Outputs = $null
}