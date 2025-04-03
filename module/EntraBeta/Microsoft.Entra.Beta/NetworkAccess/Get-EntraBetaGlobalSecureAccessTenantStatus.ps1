# ------------------------------------------------------------------------------ 
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  
#  Licensed under the MIT License.  See License in the project root for license information. 
# ------------------------------------------------------------------------------ 
function Get-EntraBetaGlobalSecureAccessTenantStatus {
    PROCESS {
        try {
            # Create custom headers for the request
            $customHeaders = New-EntraBetaCustomHeaders -Command $MyInvocation.MyCommand

            # Invoke the API request to get the tenant status
            $response = Invoke-GraphRequest -Method GET -Headers $customHeaders -OutputType PSObject -Uri "/beta/networkAccess/tenantStatus"

            # Check the response and provide feedback
            if ($response) {
                Write-Output $response
            }
            else {
                Write-Error "Failed to retrieve the Global Secure Access Tenant status."
            }
        }
        catch {
            Write-Error "An error occurred while retrieving the Global Secure Access Tenant status: $_"
        }
    }
}
