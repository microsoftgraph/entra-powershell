# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
@{
    SourceName = "Get-AzureADMSGroup"
    TargetName = "Get-MgGroup"
    Parameters = @(
        @{
            SourceName = "SearchString"
            TargetName = "Filter"
            ConversionType = "SCRIPTBLOCK"
            SpecialMapping = @"
`$Value = "mailNickName eq '`$TmpValue' or (mail eq '`$TmpValue' or (displayName eq '`$TmpValue' or startswith(displayName,'`$TmpValue')))"
"@
        }
    )
    Outputs = $null
}