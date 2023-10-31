# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
@{
    SourceName = "Get-AzureADMSTrustFrameworkPolicy"
    TargetName = $null
    Parameters = $null
    Outputs = $null
    CustomScript = @"
    PROCESS {    
        `$params = @{}  
         
        if(`$null -ne `$PSBoundParameters["Id"])
        {
            `$params["TrustFrameworkPolicyId"] = `$PSBoundParameters["Id"]  
        }

        if(`$null -ne `$PSBoundParameters["OutputFilePath"])
        {
        `$response = Get-MgBetaTrustFrameworkPolicy @params | Out-File `$PSBoundParameters["OutputFilePath"]
        `$response
        }else{
        `$response = Get-MgBetaTrustFrameworkPolicy @params
        `$response
        }
    
    }
"@
}