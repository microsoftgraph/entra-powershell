# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

$env:USER_PASSWORD = "Pass@1234"

$appId = "45451aa1-24e7-46c8-b9e5-dccb2118f536"
$tenantId = "0e5ab497-530a-4f6f-bd51-2230c84acad8"
$cert = "5C76C328BE9A29C0077398FC52BA531EAF8480F2"
$clientId = "4d3ac7a8-9f8a-405c-9224-72cd737db2ea"

# Connect-Entra -TenantId $tenantId  -AppId $appId -CertificateThumbprint $cert
Connect-Entra -Identity -ClientId $clientId
