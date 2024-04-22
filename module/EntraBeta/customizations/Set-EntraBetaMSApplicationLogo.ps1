# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
@{
    SourceName = "Set-AzureADMSApplicationLogo"
    TargetName = $null
    Parameters = $null
    outputs = $null
    CustomScript = @'   
    PROCESS {    
        try{
            $params = @{}
            $customHeaders = New-EntraBetaCustomHeaders -Command $MyInvocation.MyCommand        
            $baseUri = 'https://graph.microsoft.com/beta/applications'
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
                elseif($isLocalFile){
                    $logoBytes = Get-Content $($params.FilePath) -Raw -Encoding Byte
                }
                else{
                    Write-Error -Message "Invalid file path" -ErrorAction Stop
                }
            }

            Write-Debug("============================ TRANSFORMATIONS ============================")
            $params.Keys | ForEach-Object {"$_ : $($params[$_])" } | Write-Debug
            Write-Debug("=========================================================================`n")

            Invoke-GraphRequest -Headers $customHeaders -Uri $URI -Method $Method -ContentType "image/*" -Body $logoBytes
        }
        catch [System.Net.WebException]{
            Write-Error -Message "Issue in file url. invalid or malformed url" -ErrorAction Stop
        }
    }
'@
}