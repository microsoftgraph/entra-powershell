# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
@{
    SourceName = "Get-AzureADApplicationPasswordCredential"
    TargetName = $null
    Parameters = $null
    Outputs = $null
    CustomScript = @'
    [CmdletBinding(DefaultParameterSetName = '')]
    param (
    [Alias('ObjectId')]
    [Parameter(Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
    [System.String] $ApplicationId,
    [Parameter(Mandatory = $false, ValueFromPipeline = $false, ValueFromPipelineByPropertyName = $true)]
    [System.String[]] $Property
    )
    $params = @{}
    $customHeaders = New-EntraCustomHeaders -Command $MyInvocation.MyCommand

    if($null -ne $PSBoundParameters["Property"])
    {
        $params["Property"] = $PSBoundParameters["Property"]
    }

    # TODO : Invoke API and apply the correct Select query

    $response = (Get-MgApplication -Headers $customHeaders -ApplicationId $PSBoundParameters["ApplicationId"]).PasswordCredentials

    if($null -ne $PSBoundParameters["Property"])
    {
        $response | Select-Object $PSBoundParameters["Property"]
    }
    else {
        $response
    } 
'@
}