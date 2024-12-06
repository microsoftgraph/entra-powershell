# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
$cmd = Get-Command  Connect-MgGraph -CommandType cmdlets
$metaData = New-Object System.Management.Automation.CommandMetaData $cmd

[System.Management.Automation.ProxyCommand]::Create($metaData) | Set-Item Path function:Connect-Entra