# ------------------------------------------------------------------------------ 
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  
#  Licensed under the MIT License.  See License in the project root for license information. 
# ------------------------------------------------------------------------------ 
function Get-EntraBetaTrustFrameworkPolicy {
    [CmdletBinding(DefaultParameterSetName = 'GetQuery')]
    param (                
        [Parameter(ParameterSetName = "GetById", ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
        [System.String] $OutputFilePath,
                
        [Parameter(ParameterSetName = "GetById", Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
        [System.String] $Id
    )

    begin {
        # Ensure connection to Microsoft Entra
        if (-not (Get-EntraContext)) {
            $errorMessage = "Not connected to Microsoft Graph. Use 'Connect-Entra -Scopes Policy.Read.All, Policy.ReadWrite.TrustFramework' to authenticate."
            Write-Error -Message $errorMessage -ErrorAction Stop
            return
        }
    }

    PROCESS {    
        $params = @{}
        $customHeaders = New-EntraBetaCustomHeaders -Command $MyInvocation.MyCommand
         
        if ($null -eq $PSBoundParameters["Id"] -and $null -eq $PSBoundParameters["OutputFilePath"]) {
            $response = Get-MgBetaTrustFrameworkPolicy @params -Headers $customHeaders
            $response
        }
        elseif ($null -ne $PSBoundParameters["Id"]) {
            # Define a temporary file path
            $Id = $PSBoundParameters["Id"]
            $tempFilePath = [System.IO.Path]::GetTempFileName()
           
            $outFile = $tempFilePath           
            
            if ($null -ne $PSBoundParameters["OutputFilePath"]) {
                $outFile = $PSBoundParameters["OutputFilePath"]
            }

            $V = '$value'
            $uri = '/beta/trustframework/policies/' + $Id + '/' + $V
           
            $response = Invoke-GraphRequest -Headers $customHeaders -Method 'GET' -Uri $uri -OutputFilePath $outFile

            # Read the content from the temporary file
            $xmlContent = Get-Content -Path $tempFilePath

            # Display the content if output file path not specified
            if ($null -eq $PSBoundParameters["OutputFilePath"]) {
                $xmlContent
            }

            # Clean up the temporary file
            Remove-Item -Path $tempFilePath -Force
        }
    
    }    
}

