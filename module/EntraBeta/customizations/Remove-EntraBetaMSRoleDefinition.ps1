# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
@{
    SourceName = "Remove-AzureADMSRoleDefinition"
    TargetName = $null
    Parameters = $null
    Outputs = $null
    CustomScript = @'
        Remove-MgBetaRoleManagementDirectoryRoleDefinition -UnifiedRoleDefinitionId $PSBoundParameters["Id"]
'@
}