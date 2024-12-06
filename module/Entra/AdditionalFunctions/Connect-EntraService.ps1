# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

function Connect-EntraService {    

$cmd = Get-Command -Name Connect-MgGraph -CommandType Cmdlet

# Create metadata object based on the original command
$metaData = New-Object System.Management.Automation.CommandMetaData $cmd

# Generate a proxy command for Connect-Entra using the metadata
$proxyCommand = [System.Management.Automation.ProxyCommand]::Create($metaData)

# Set the generated proxy command as a new function named Connect-Entra
Set-Item -Path Function:Connect-Entra -Value $proxyCommand
}