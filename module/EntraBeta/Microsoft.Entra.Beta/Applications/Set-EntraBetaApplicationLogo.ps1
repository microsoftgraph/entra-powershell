# ------------------------------------------------------------------------------ 
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  
#  Licensed under the MIT License.  See License in the project root for license information. 
# ------------------------------------------------------------------------------ 
function Set-EntraBetaApplicationLogo {
    [CmdletBinding(DefaultParameterSetName = 'File')]
    param (
        [Alias('ObjectId')]
        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = "Unique ID of the application object (Application Object ID).")]
        [ValidateNotNullOrEmpty()]
        [Parameter(ParameterSetName = "Stream")]
        [Parameter(ParameterSetName = "File")]
        [Parameter(ParameterSetName = "ByteArray")]
        [System.String] $ApplicationId,

        [Parameter(ParameterSetName = "ByteArray", Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = "Byte array of the logo image.")]
        [ValidateNotNullOrEmpty()]
        [System.Byte[]] $ImageByteArray,

        [Parameter(ParameterSetName = "File", Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = "Path to the logo image file.")]
        [ValidateNotNullOrEmpty()]
        [System.String] $FilePath,
    
        [Parameter(ParameterSetName = "Stream", Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = "Stream of the logo image file.")]
        [ValidateNotNullOrEmpty()]
        [System.IO.Stream] $FileStream
    )

    begin {
        # Ensure connection to Microsoft Entra
        if (-not (Get-EntraContext)) {
            $errorMessage = "Not connected to Microsoft Graph. Use 'Connect-Entra -Scopes Application.ReadWrite.All' to authenticate."
            Write-Error -Message $errorMessage -ErrorAction Stop
            return
        }
    }
    
    PROCESS {    
        try {
            $params = @{}
            $customHeaders = New-EntraBetaCustomHeaders -Command $MyInvocation.MyCommand        
            $baseUri = '/beta/applications'
            $Method = "PUT"
            
            if ($null -ne $PSBoundParameters["ApplicationId"]) {
                $params["ApplicationId"] = $PSBoundParameters["ApplicationId"]
                $URI = "$baseUri/$($params.ApplicationId)/logo"
            }
            if ($null -ne $PSBoundParameters["FilePath"]) {
                $params["FilePath"] = $PSBoundParameters["FilePath"]
                $isUrl = [System.Uri]::IsWellFormedUriString($($params.FilePath), [System.UriKind]::Absolute)
                $isLocalFile = [System.IO.File]::Exists($($params.FilePath))
                
                if ($isUrl) {
                    $logoBytes = (Invoke-WebRequest $($params.FilePath)).Content
                }
                elseif ($isLocalFile) {
                    $logoBytes = [System.IO.File]::ReadAllBytes($($params.FilePath))
                }
                else {
                    Write-Error -Message "FilePath is invalid" -ErrorAction Stop
                }
            }
    
            Write-Debug("============================ TRANSFORMATIONS ============================")
            $params.Keys | ForEach-Object { "$_ : $($params[$_])" } | Write-Debug
            Write-Debug("=========================================================================`n")
    
            Invoke-GraphRequest -Headers $customHeaders -Uri $URI -Method $Method -ContentType "image/*" -Body $logoBytes
        }
        catch [System.Net.WebException] {
            Write-Error -Message "FilePath is invalid. Invalid or malformed url" -ErrorAction Stop
        }
    }    
}

