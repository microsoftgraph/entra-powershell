# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
@{
    SourceName = "Remove-AzureADMSAdministrativeUnitMember"
    TargetName = "Remove-MgBetaDirectoryAdministrativeUnitMemberByRef"
    Parameters = @(
        @{
            SourceName = "Id"
            TargetName = "AdministrativeUnitId"
            ConversionType = "Name"
            SpecialMapping = $null
        },
        @{
            SourceName = "MemberId"
            TargetName = "DirectoryObjectId"
            ConversionType = "Name"
            SpecialMapping = $null
        }
    )
    Outputs = $null
}