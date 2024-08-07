# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
@{
    SourceName = "Remove-AzureADMSServicePrincipalDelegatedPermissionClassification"
    TargetName = $null
    Parameters = $null
    Outputs = $null
    CustomScript = @'
    PROCESS{
        $customHeaders = New-EntraCustomHeaders -Command $MyInvocation.MyCommand
        Remove-MgServicePrincipalDelegatedPermissionClassification -Headers $customHeaders -ServicePrincipalId $PSBoundParameters["ServicePrincipalId"] -DelegatedPermissionClassificationId $PSBoundParameters["Id"]
    }
'@
}