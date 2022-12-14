# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
@{
    SourceName = "Get-AzureADUser"
    TargetName = "Get-MgUser"
    Parameters = @(
        @{
            SourceName = "SearchString"
            TargetName = "Filter"
            ConversionType = 99
            SpecialMapping = @"
`$Value = "userPrincipalName eq '`$TmpValue' or (state eq '`$TmpValue' or (mailNickName eq '`$TmpValue' or (mail eq '`$TmpValue' or (jobTitle eq '`$TmpValue' or (displayName eq '`$TmpValue' or (startswith(displayName,'`$TmpValue') or (department eq '`$TmpValue' or (country eq '`$TmpValue' or city eq '`$TmpValue'))))))))"
"@
        }
    )
    Outputs = $null
}