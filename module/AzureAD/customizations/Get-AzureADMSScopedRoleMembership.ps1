# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
@{
    SourceName = "Get-AzureADMSScopedRoleMembership"
    TargetName = "Get-MgDirectoryAdministrativeUnitScopedRoleMember"
    Parameters = @(
        @{
            SourceName = "Id"
            TargetName = "AdministrativeUnitId"
            ConversionType = "Name"
            SpecialMapping = $null
        }
    )
    Outputs = $null
}