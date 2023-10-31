@{
    SourceName = "Remove-AzureADGroupAppRoleAssignment"
    TargetName = "Remove-MgBetaGroupAppRoleAssignment "
    Parameters = @(
        @{
            SourceName = "ObjectId"
            TargetName = "GroupId"
            ConversionType = "Name"
            SpecialMapping = $null
        },
        @{
            SourceName = "AppRoleAssignmentId"
            TargetName = "AppRoleAssignmentId"
            ConversionType = "Name"
            SpecialMapping = $null
        }
    )
    Outputs = $null
}