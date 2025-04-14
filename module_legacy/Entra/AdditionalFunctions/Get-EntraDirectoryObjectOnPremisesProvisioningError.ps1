# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

function Get-EntraDirectoryObjectOnPremisesProvisioningError {
    [CmdletBinding(DefaultParameterSetName = 'GetById')]
    param (
        [Parameter(ParameterSetName = 'GetById')]
        [Obsolete("This parameter provides compatibility with Azure AD and MSOnline for partner scenarios. TenantID is the signed-in user's tenant ID. It should not be used for any other purpose.")]
        [System.Guid] $TenantId
    )
    PROCESS {
        $params = @{}
        $customHeaders = New-EntraCustomHeaders -Command $MyInvocation.MyCommand
        if ($null -ne $PSBoundParameters['TenantId']) {
            $params['TenantId'] = $PSBoundParameters['TenantId']
        }
        Write-Debug('============================ TRANSFORMATIONS ============================')
        $params.Keys | ForEach-Object { "$_ : $($params[$_])" } | Write-Debug
        Write-Debug("=========================================================================`n")
        $Object = @('users', 'groups', 'contacts')
        $response = @()

        try {
            foreach ($obj in $object) {
                $obj = ($obj | Out-String).trimend()
                $uri = 'https://graph.microsoft.com/v1.0/' + $obj + '?$select=onPremisesProvisioningErrors'
                $response += ((Invoke-GraphRequest -Headers $customHeaders -Uri $uri -Method GET).value).onPremisesProvisioningErrors
            }
        } catch {
            Write-Error $_.Exception.Message
        }
        if ([string]::IsNullOrWhiteSpace($response)) {
            Write-Host 'False'
        } else {
            $response
        }

    }
}
Set-Alias -Name Get-EntraHasObjectsWithDirSyncProvisioningError -Value Get-EntraDirectoryObjectOnPremisesProvisioningError -Scope Global -Force
