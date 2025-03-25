# ------------------------------------------------------------------------------ 
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  
#  Licensed under the MIT License.  See License in the project root for license information. 
# ------------------------------------------------------------------------------ 
function Remove-EntraBetaServicePrincipalPasswordCredential {
    [CmdletBinding(DefaultParameterSetName = 'Default')]
    param (
    [Parameter(Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
    [System.String] $KeyId,
    [Parameter(Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
    [Alias("ObjectId")]
    [System.String] $ServicePrincipalId
    )

    PROCESS{
        $params = @{}
        $customHeaders = New-EntraBetaCustomHeaders -Command $MyInvocation.MyCommand
        $baseUri = 'https://graph.microsoft.com/beta/servicePrincipals'
        $Method = "POST"
        if($null -ne $PSBoundParameters["ServicePrincipalId"] -and $null -ne $PSBoundParameters["KeyId"])
        {
            $params["ServicePrincipalId"] = $PSBoundParameters["ServicePrincipalId"]
            $params["KeyId"] = $PSBoundParameters["KeyId"]
            $URI = "$baseUri/$($params.ServicePrincipalId)/removePassword"
            $body = @{
                "keyId" = $($params.KeyId)
            }
        }
        Write-Debug("============================ TRANSFORMATIONS ============================")
        $params.Keys | ForEach-Object {"$_ : $($params[$_])" } | Write-Debug
        Write-Debug("=========================================================================`n")
        (Invoke-GraphRequest -Headers $customHeaders -Uri $URI -Method $Method -Body $body)
    }    
}

