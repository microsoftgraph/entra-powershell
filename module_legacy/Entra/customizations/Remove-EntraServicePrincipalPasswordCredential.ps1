# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
@{
    SourceName = "Remove-AzureADServicePrincipalPasswordCredential"
    TargetName = $null
    Parameters = $null
    Outputs = $null
    CustomScript = @'
    [CmdletBinding(DefaultParameterSetName = '')]
    param (
    [Parameter(Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
    [System.String] $KeyId,
    [Alias("ObjectId")]
    [Parameter(Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
    [System.String] $ServicePrincipalId
    )

    PROCESS{
        $customHeaders = New-EntraCustomHeaders -Command $MyInvocation.MyCommand
        Remove-MgServicePrincipalPassword -Headers $customHeaders -ServicePrincipalId $PSBoundParameters["ServicePrincipalId"] -KeyId $PSBoundParameters["KeyId"]
    }
'@
}