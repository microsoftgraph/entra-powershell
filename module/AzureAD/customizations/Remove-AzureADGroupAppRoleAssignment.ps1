@{
    SourceName = "Remove-AzureADGroupAppRoleAssignment"
    TargetName = "Remove-MgGroupAppRoleAssignment"
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