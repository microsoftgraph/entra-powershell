# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.
#  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
function Get-EntraBetaDirectoryObjectOnPremisesProvisioningError {
    [CmdletBinding(DefaultParameterSetName = 'GetById')]
    [OutputType([System.Object])]
    param (
        [Parameter(ParameterSetName = 'GetById')]
        [ValidateNotNullOrEmpty()]
        [ValidateScript({ if ($_ -is [System.Guid]) { $true } else { throw 'TenantId must be of type [System.Guid].' } })]
        [System.Guid] $TenantId
    )

    begin { }

    process {
        $params = @{}
        $customHeaders = New-EntraBetaCustomHeaders -Command $MyInvocation.MyCommand
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
                $obj = ($obj | Out-String).TrimEnd()
                $uri = 'https://graph.microsoft.com/beta/' + $obj + '?$select=onPremisesProvisioningErrors'
                $response += ((Invoke-GraphRequest -Headers $customHeaders -Uri $uri -Method GET).value).onPremisesProvisioningErrors
            }
        } catch {
            Write-Error $_.Exception.Message
        }
    }

    end {
        if ([string]::IsNullOrWhiteSpace($response)) {
            Write-Host 'False'
        } else {
            $response
        }
    }
}
