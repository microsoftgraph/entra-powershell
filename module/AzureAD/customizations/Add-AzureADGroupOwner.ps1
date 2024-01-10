# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
@{
    SourceName = "Add-AzureADGroupOwner"
    TargetName = "New-MgGroupOwnerByRef"
    Parameters = @(
        @{
            SourceName = "ObjectId"
            TargetName = "GroupId"
            ConversionType = "Name"
            SpecialMapping = $null
        },
        @{
            SourceName = "RefObjectId"
            TargetName = "BodyParameter"
            ConversionType = "ScriptBlock"
            SpecialMapping = @"
`$Value = @{ "@odata.id" = "https://graph.microsoft.com/beta/users/`$TmpValue"}
"@
        }
    )
    Outputs = $null
}