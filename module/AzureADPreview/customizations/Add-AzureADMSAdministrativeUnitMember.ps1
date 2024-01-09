# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
@{
    SourceName = "Add-AzureADMSAdministrativeUnitMember"
    TargetName = "New-MgBetaDirectoryAdministrativeUnitMemberByRef"
    Parameters = @(
        @{
            SourceName = "RefObjectId"
            TargetName = "BodyParameter"
            ConversionType = "ScriptBlock"
            SpecialMapping = @"
`$Value = @{ "@odata.id" = "https://graph.microsoft.com/beta/directoryObjects/`$TmpValue"}
"@
        }
    )
    Outputs = $null
}