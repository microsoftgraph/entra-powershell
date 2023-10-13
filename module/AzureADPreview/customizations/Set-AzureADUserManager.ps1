# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
@{
    SourceName = "Set-AzureADUserManager"
    TargetName = "Set-MgBetaUserManagerByRef"
    Parameters = @(
        @{
            SourceName = "RefObjectId"
            TargetName = "BodyParameter"
            ConversionType = "ScriptBlock"
            SpecialMapping = @"
`$Value = @{ "@odata.id" = "https://graph.microsoft.com/v1.0/users/`$TmpValue"}
"@
        }
    )
    Outputs = $null
}