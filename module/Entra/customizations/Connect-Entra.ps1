# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
@{
    SourceName = "Connect-AzureAD"
    TargetName = $null
    Parameters = $null
    Outputs = $null
    CustomScript = @'
    $params = @{}

    if($null -ne $PSBoundParameters["TenantId"]){
        params["TenantId"] = $PSBoundParameters["TenantId"]
    }

    if($null -ne $PSBoundParameters["CertificateThumbprint"]){
        params["CertificateThumbprint"] = $PSBoundParameters["CertificateThumbprint"]
    }

    if($null -ne $PSBoundParameters["ApplicationId"]){
        params["ApplicationId"] = $PSBoundParameters["ApplicationId"]
    }

    if($null -ne $PSBoundParameters["InformationAction"]){
        params["ProgressAction"] = $PSBoundParameters["InformationAction"]
    }

    Connect-MgGraph @params
'@
}