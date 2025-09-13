# ------------------------------------------------------------------------------ 
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  
#  Licensed under the MIT License.  See License in the project root for license information. 
# ------------------------------------------------------------------------------ 
function New-EntraBetaTrustFrameworkPolicy {
    [CmdletBinding(DefaultParameterSetName = 'Content')]
    param (                
        [Parameter(ParameterSetName = "Content", Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
        [System.String] $Content,
                
        [Parameter(ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
        [Parameter(ParameterSetName = "Content")]
        [Parameter(ParameterSetName = "File")]
        [System.String] $OutputFilePath,
                
        [Parameter(ParameterSetName = "File", Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
        [System.String] $InputFilePath
    )

    begin {
        # Ensure connection to Microsoft Entra
        if (-not (Get-EntraContext)) {
            $errorMessage = "Not connected to Microsoft Graph. Use 'Connect-Entra -Scopes Policy.ReadWrite.TrustFramework' to authenticate."
            Write-Error -Message $errorMessage -ErrorAction Stop
            return
        }
    }

    PROCESS {
        $customHeaders = New-EntraBetaCustomHeaders -Command $MyInvocation.MyCommand

        # Define a temporary file path
        $tempFilePath = [System.IO.Path]::GetTempFileName()
        
        $outFile = $tempFilePath
        
        if ($null -ne $PSBoundParameters["OutputFilePath"]) {
            $outFile = $PSBoundParameters["OutputFilePath"]
        }

        $Body = $PSBoundParameters["Content"]

        if ($null -ne $PSBoundParameters["InputFilePath"]) {
            $Body = Get-Content -Path $PSBoundParameters["InputFilePath"]
        }

        $uri = '/beta/trustframework/policies'        
        
        Invoke-GraphRequest -Headers $customHeaders -Method 'POST' -ContentType 'application/xml' -Uri $uri -Body $Body -OutputFilePath $outFile

        # Read the content from the temporary file
        # Display the content if output file path not specified
        if ($null -eq $PSBoundParameters["OutputFilePath"]) {
            $xmlContent = Get-Content -Path $tempFilePath
            $xmlContent
        }

        # Clean up the temporary file
        Remove-Item -Path $tempFilePath -Force
    }    
}

