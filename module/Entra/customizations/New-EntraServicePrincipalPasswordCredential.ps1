# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
@{
    SourceName = "New-AzureADServicePrincipalPasswordCredential"
    TargetName = $null
    Parameters = $null
    Outputs = $null
    CustomScript = @'
    $body = @{
        passwordCredential = @{
            startDateTime = $PSBoundParameters["StartDate"];
            endDateTime = $PSBoundParameters["EndDate"];
        }
    }
    $response = Add-MgServicePrincipalPassword -ServicePrincipalId $PSBoundParameters["ObjectId"] -BodyParameter $body
    $response | ForEach-Object {
        if($null -ne $_) {
        Add-Member -InputObject $_ -MemberType AliasProperty -Name StartDate -Value StartDateTime
        Add-Member -InputObject $_ -MemberType AliasProperty -Name EndDate -Value EndDateTime
        }
    }
    $response
'@
}