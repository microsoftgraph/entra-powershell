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
         
        if(`$null -eq `$PSBoundParameters["Id"] -and `$null -eq `$PSBoundParameters["OutputFilePath"])
        {
            `$response = Get-MgBetaTrustFrameworkPolicy @params
            `$response
        }
        elseif(`$null -ne `$PSBoundParameters["Id"]) {
            # Define a temporary file path
            `$Id = `$PSBoundParameters["Id"]
           `$tempFilePath = [System.IO.Path]::GetTempFileName()
           
           `$outFile =  `$tempFilePath
           
            if(`$null -ne `$PSBoundParameters["OutputFilePath"]){
                `$outFile = `$PSBoundParameters["OutputFilePath"]
            }

           `$V = '`$value'
           `$uri = '/beta/trustframework/policies/'+`$Id+'/'+`$V
           
            `$response = Invoke-GraphRequest -Method 'GET' -Uri `$uri -OutputFilePath `$outFile

            # Read the content from the temporary file
            `$xmlContent = Get-Content -Path `$tempFilePath

            # Display the content if output file path not specified
            if(`$null -eq `$PSBoundParameters["OutputFilePath"]){
               `$xmlContent
            }

            # Clean up the temporary file
            Remove-Item -Path `$tempFilePath -Force
        }
    
    }
"@
}