# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
@{
    SourceName = "Set-AzureADMSTrustFrameworkPolicy"
    TargetName = $null
    Parameters = $null
    Outputs = $null
    CustomScript = @"
    PROCESS {
        `$customHeaders = New-EntraBetaCustomHeaders -Command `$MyInvocation.MyCommand
        # Define a temporary file path
        `$tempFilePath = [System.IO.Path]::GetTempFileName()        
        
        `$outFile =  `$tempFilePath        
        
        if(`$null -ne `$PSBoundParameters["OutputFilePath"]){
            `$outFile = `$PSBoundParameters["OutputFilePath"]
        }

        `$Body = `$PSBoundParameters["Content"]

        if(`$null -ne `$PSBoundParameters["InputFilePath"]) {
            `$Body = Get-Content -Path `$PSBoundParameters["InputFilePath"]
        }

        `$Id = `$PSBoundParameters["Id"]        
        
        `$V = '`$value'
        `$uri = '/beta/trustframework/policies/'+`$Id+'/'+`$V        
        
        `$response = Invoke-GraphRequest -Headers `$customHeaders -Method 'PUT' -ContentType 'application/xml' -Uri `$uri -Body `$Body -OutputFilePath `$outFile

        # Read the content from the temporary file
        # Display the content if output file path not specified
        if(`$null -eq `$PSBoundParameters["OutputFilePath"]){
            `$xmlContent = Get-Content -Path `$tempFilePath
            `$xmlContent
        }

        # Clean up the temporary file
        Remove-Item -Path `$tempFilePath -Force
    }
"@
}