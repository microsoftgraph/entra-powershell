# ------------------------------------------------------------------------------ 
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  
#  Licensed under the MIT License.  See License in the project root for license information. 
# ------------------------------------------------------------------------------ 
function Set-EntraApplicationLogo {
    [CmdletBinding(DefaultParameterSetName = 'File')]
    param (
    [Alias('ObjectId')]
    [Parameter(Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
    [Parameter(ParameterSetName = "Stream")]
    [Parameter(ParameterSetName = "File")]
    [Parameter(ParameterSetName = "ByteArray")]
    [System.String] $ApplicationId,
    [Parameter(ParameterSetName = "ByteArray", Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
    [System.Byte[]] $ImageByteArray,
    [Parameter(ParameterSetName = "File", Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
    [System.String] $FilePath,
    [Parameter(ParameterSetName = "Stream", Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
    [System.IO.Stream] $FileStream
    )
    PROCESS {    
        try{
            $params = @{}
            $customHeaders = New-EntraCustomHeaders -Command $MyInvocation.MyCommand        
            $baseUri = 'https://graph.microsoft.com/v1.0/applications'
            $Method = "PUT"            
            if($null -ne $PSBoundParameters["ApplicationId"])
            {
                $params["ApplicationId"] = $PSBoundParameters["ApplicationId"]
                $URI = "$baseUri/$($params.ApplicationId)/logo"
            }
            if($null -ne $PSBoundParameters["FilePath"]){
                $params["FilePath"] = $PSBoundParameters["FilePath"]
                $isUrl = [System.Uri]::IsWellFormedUriString($($params.FilePath), [System.UriKind]::Absolute)
                $isLocalFile = [System.IO.File]::Exists($($params.FilePath))
                
                if($isUrl){
                    $logoBytes = (Invoke-WebRequest $($params.FilePath)).Content
                }
                elseif($isLocalFile){
                    $logoBytes = [System.IO.File]::ReadAllBytes($($params.FilePath))
                }
                else{
                    Write-Error -Message "FilePath is invalid" -ErrorAction Stop
                }
            }
    
            Write-Debug("============================ TRANSFORMATIONS ============================")
            $params.Keys | ForEach-Object {"$_ : $($params[$_])" } | Write-Debug
            Write-Debug("=========================================================================`n")
    
            Invoke-GraphRequest -Headers $customHeaders -Uri $URI -Method $Method -ContentType "image/*" -Body $logoBytes
        }
        catch [System.Net.WebException]{
            Write-Error -Message "FilePath is invalid. Invalid or malformed url" -ErrorAction Stop
        }
    }    
}

