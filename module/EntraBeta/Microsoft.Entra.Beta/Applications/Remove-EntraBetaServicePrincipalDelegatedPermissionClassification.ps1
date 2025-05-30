# ------------------------------------------------------------------------------ 
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  
#  Licensed under the MIT License.  See License in the project root for license information. 
# ------------------------------------------------------------------------------ 
function Remove-EntraBetaServicePrincipalDelegatedPermissionClassification {
    [CmdletBinding(DefaultParameterSetName = 'Default')]
    param (
        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = "Unique ID of the service principal object (Service Principal Object ID).")]
        [ValidateNotNullOrEmpty()]
        [System.String] $ServicePrincipalId,
                
        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = "Unique ID of the delegated permission classification object (Delegated Permission Classification Object ID).")]
        [ValidateNotNullOrEmpty()]
        [System.String] $Id
    )

    begin {
        # Ensure connection to Microsoft Entra
        if (-not (Get-EntraContext)) {
            $errorMessage = "Not connected to Microsoft Graph. Use 'Connect-Entra -Scopes Policy.ReadWrite.PermissionGrant' to authenticate."
            Write-Error -Message $errorMessage -ErrorAction Stop
            return
        }
    }

    PROCESS {
        $customHeaders = New-EntraBetaCustomHeaders -Command $MyInvocation.MyCommand
        Remove-MgBetaServicePrincipalDelegatedPermissionClassification -Headers $customHeaders -ServicePrincipalId $PSBoundParameters["ServicePrincipalId"] -DelegatedPermissionClassificationId $PSBoundParameters["Id"]
    }    
}

