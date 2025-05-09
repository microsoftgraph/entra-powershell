# ------------------------------------------------------------------------------ 
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  
#  Licensed under the MIT License.  See License in the project root for license information. 
# ------------------------------------------------------------------------------ 
function Enable-EntraBetaGlobalSecureAccessTenant {
    PROCESS {
        try {
            # Create custom headers for the request
            $customHeaders = New-EntraBetaCustomHeaders -Command $MyInvocation.MyCommand

            # Invoke the API request to enable global secure access tenant
            $response = Invoke-GraphRequest -Method POST -Headers $customHeaders -OutputType PSObject -Uri "/beta/networkAccess/microsoft.graph.networkaccess.onboard"

            # Check the response and provide feedback
            if ($response) {
                Write-Output "Global Secure Access Tenant has been successfully enabled."
            }
            else {
                Write-Error "Failed to enable Global Secure Access Tenant."
            }
        }
        catch {
            Write-Error "An error occurred while enabling the Global Secure Access Tenant: $_"
        }
    }
}

