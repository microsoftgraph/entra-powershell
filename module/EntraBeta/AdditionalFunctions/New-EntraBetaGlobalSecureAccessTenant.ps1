# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
function New-EntraBetaGlobalSecureAccessTenant {

    PROCESS {  
    $customHeaders = New-EntraBetaCustomHeaders -Command $MyInvocation.MyCommand


			$response = Invoke-GraphRequest -Method POST -Headers $customHeaders -OutputType PSObject -Uri "https://graph.microsoft.com/beta/networkAccess/microsoft.graph.networkaccess.onboard"
			$response
            
		}			

}
