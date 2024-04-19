# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
@{
    SourceName = "Set-AzureADApplicationLogo"
    TargetName = $null
    Parameters = $null
    outputs = $null
    CustomScript = @'   
    PROCESS {    
        $params = @{}
        $customHeaders = New-EntraCustomHeaders -Command $MyInvocation.MyCommand        
        $baseUri = 'https://graph.microsoft.com/v1.0/applications'
        $Method = "PUT"
        if($PSBoundParameters.ContainsKey("Verbose"))
        {
            $params["Verbose"] = $Null
        }
        if($null -ne $PSBoundParameters["ObjectId"])
        {
            $params["ApplicationId"] = $PSBoundParameters["ObjectId"]
            $URI = "$baseUri/$($params.ApplicationId)/logo"
        }
        if($null -ne $PSBoundParameters["FilePath"]){
            $params["FilePath"] = $PSBoundParameters["FilePath"]
            $isUrl = [System.Uri]::IsWellFormedUriString($($params.FilePath), [System.UriKind]::Absolute)
            $isLocalFile = [System.IO.File]::Exists($($params.FilePath))
            
            if($isUrl){
                $logoBytes = (Invoke-WebRequest $($params.FilePath)).Content
            }

            if($isLocalFile){
                $logoBytes = Get-Content $($params.FilePath) -Raw -Encoding Byte
            }
        }

        Write-Debug("============================ TRANSFORMATIONS ============================")
        $params.Keys | ForEach-Object {"$_ : $($params[$_])" } | Write-Debug
        Write-Debug("=========================================================================`n")

        Invoke-GraphRequest -Headers $customHeaders -Uri $URI -Method $Method -ContentType "image/*" -Body $logoBytes
    }
'@
}