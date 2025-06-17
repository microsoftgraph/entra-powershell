# ------------------------------------------------------------------------------ 
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  
#  Licensed under the MIT License.  See License in the project root for license information. 
# ------------------------------------------------------------------------------ 
function Get-EntraApplicationLogo {
    [CmdletBinding(DefaultParameterSetName = 'Default')]
    param (
        [Alias('ObjectId')]
        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = "Unique ID of the application object (Application Object ID).")]
        [ValidateNotNullOrEmpty()]
        [System.String] $ApplicationId,

        [Parameter(ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
        [System.Boolean] $View,

        [Parameter(ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
        [System.String] $FileName,

        [Parameter(ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = "Path to save the logo.")]
        [System.String] $FilePath
    )

    begin {
        # Ensure connection to Microsoft Entra
        if (-not (Get-EntraContext)) {
            $errorMessage = "Not connected to Microsoft Graph. Use 'Connect-Entra -Scopes Application.Read.All' to authenticate."
            Write-Error -Message $errorMessage -ErrorAction Stop
            return
        }
    }
    
    PROCESS {    
        $params = @{}
        $customHeaders = New-EntraCustomHeaders -Command $MyInvocation.MyCommand        
        $baseUri = '/v1.0/applications'
        $Method = "GET"        
        if ($null -ne $PSBoundParameters["ApplicationId"]) {
            $params["ApplicationId"] = $PSBoundParameters["ApplicationId"]
            $URI = "$baseUri/$($params.ApplicationId)"
        }

        if ($null -ne $PSBoundParameters["FilePath"]) {
            $params["FilePath"] = $PSBoundParameters["FilePath"]   
            
            $imageExtensions = @(".jpg", ".jpeg", ".png", ".gif", ".bmp")

            if (-not (Test-Path $($params.FilePath) -PathType Leaf) -and $imageExtensions -notcontains [System.IO.Path]::GetExtension($($params.FilePath))) {
                Write-Error -Message "Get-EntraApplicationLogo : FilePath is invalid"
                break;
            }
        }

        Write-Debug("============================ TRANSFORMATIONS ============================")
        $params.Keys | ForEach-Object { "$_ : $($params[$_])" } | Write-Debug
        Write-Debug("=========================================================================`n")
        
        $logoUrl = (Invoke-GraphRequest -Headers $customHeaders -Uri $URI -Method $Method).Info.logoUrl

        if ($null -ne $logoUrl) {
            try {
                Invoke-WebRequest -Uri $logoUrl -OutFile $($params.FilePath)
            }
            catch {
                
            }
        }
    }    
}

