# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
@{
    SourceName = "New-AzureADServicePrincipalPasswordCredential"
    TargetName = $null
    Parameters = $null
    Outputs = $null
    CustomScript = @'
    [CmdletBinding(DefaultParameterSetName = '')]
    param (
    [Alias("ObjectId")]
    [Parameter(Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
    [System.String] $ServicePrincipalId,
    [Parameter(ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
    [System.String] $Value,
    [Parameter(ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
    [System.Nullable`1[System.DateTime]] $StartDate,
    [Parameter(ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
    [System.String] $CustomKeyIdentifier,
    [Parameter(ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
    [System.Nullable`1[System.DateTime]] $EndDate,
    [Parameter(ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
    [System.Nullable`1[System.DateTime]] $DisplayName
    )

    $customHeaders = New-EntraCustomHeaders -Command $MyInvocation.MyCommand
    $body = @{
        passwordCredential = @{
            startDateTime = $PSBoundParameters["StartDate"];
            endDateTime = $PSBoundParameters["EndDate"];
            displayName = $PSBoundParameters["DisplayName"];
        }
    }
    $response = Add-MgServicePrincipalPassword -Headers $customHeaders -ServicePrincipalId $PSBoundParameters["ServicePrincipalId"] -BodyParameter $body
    $response | ForEach-Object {
        if($null -ne $_) {
        Add-Member -InputObject $_ -MemberType AliasProperty -Name StartDate -Value StartDateTime
        Add-Member -InputObject $_ -MemberType AliasProperty -Name EndDate -Value EndDateTime
        }
    }
    $response
'@
}