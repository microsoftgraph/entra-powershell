# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
@{
    SourceName = "Add-AzureADApplicationOwner"
    TargetName = "New-MgBetaApplicationOwnerByRef"
    Parameters = @(
        @{
            SourceName = "RefObjectId"
            TargetName = "OdataId"
            ConversionType = "ScriptBlock"
            SpecialMapping = @"
            `$Value = "https://graph.microsoft.com/v1.0/directoryObjects/`$TmpValue"
"@
        }
    )
    Outputs = $null
}