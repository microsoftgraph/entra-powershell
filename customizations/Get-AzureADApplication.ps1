# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
@{
    SourceName = "Get-AzureADApplication"
    TargetName = "Get-MgApplication"
    Parameters = @(
        @{
            SourceName = "SearchString"
            TargetName = "Filter"
            ConversionType = "SCRIPTBLOCK"
            SpecialMapping = @"
`$Value = "displayName eq '`$TmpValue' or startswith(displayName,'`$TmpValue')"
"@
        }
    )
    Outputs = $null
}