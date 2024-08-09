# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
function Get-EntraBetaGlobalSecureAccessTenantStatus {

    PROCESS {  
    $customHeaders = New-EntraBetaCustomHeaders -Command $MyInvocation.MyCommand


			$response = Invoke-GraphRequest -Method GET -Headers $customHeaders -OutputType PSObject -Uri "https://graph.microsoft.com/beta/networkAccess/tenantStatus"
			$response
            
		}			

}
