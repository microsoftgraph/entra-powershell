# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
# $env:TEST_APPID = "45451aa1-24e7-46c8-b9e5-dccb2118f536"
# $env:TEST_TENANTID = "0e5ab497-530a-4f6f-bd51-2230c84acad8"
# $env:CERTIFICATETHUMBPRINT = "5C76C328BE9A29C0077398FC52BA531EAF8480F2"


$appId = "45451aa1-24e7-46c8-b9e5-dccb2118f536"
$tenantId = "0e5ab497-530a-4f6f-bd51-2230c84acad8"
$cert = "5C76C328BE9A29C0077398FC52BA531EAF8480F2"

Connect-Entra -TenantId $tenantId  -AppId $appId -CertificateThumbprint $cert