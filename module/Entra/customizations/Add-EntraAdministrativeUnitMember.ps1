# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
@{
    SourceName = "Add-AzureADMSAdministrativeUnitMember"
    TargetName = "New-MgDirectoryAdministrativeUnitMemberByRef" 
    Parameters = @(
        @{
            SourceName = "RefObjectId"
            TargetName = "BodyParameter"
            ConversionType = "ScriptBlock"
            SpecialMapping = @"
`$Value = @{ "@odata.id" = "https://graph.microsoft.com/v1.0/directoryObjects/`$TmpValue"}
"@
        }
    )
    Outputs = $null
}