# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
@{
    SourceName = "Get-AzureADApplicationLogo"
    TargetName = $null
    Parameters = $null
    outputs = $null
    CustomScript = @'   
    PROCESS {    
        $params = @{}
        $customHeaders = New-EntraBetaCustomHeaders -Command $MyInvocation.MyCommand        
        $baseUri = 'https://graph.microsoft.com/beta/applications'
        $Method = "GET"
        if($PSBoundParameters.ContainsKey("Verbose"))
        {
            $params["Verbose"] = $Null
        }
        if($null -ne $PSBoundParameters["ObjectId"])
        {
            $params["ApplicationId"] = $PSBoundParameters["ObjectId"]
            $URI = "$baseUri/$($params.ApplicationId)"
        }
        if($null -ne $PSBoundParameters["FilePath"]){
            $params["FilePath"] = $PSBoundParameters["FilePath"]  
            
            $imageExtensions = @(".jpg", ".jpeg", ".png", ".gif", ".bmp")

            if(-not (Test-Path $($params.FilePath) -PathType Leaf) -and $imageExtensions -notcontains [System.IO.Path]::GetExtension($($params.FilePath))){
                Write-Error -Message "Get-EntraApplicationLogo : FilePath is invalid"
                break;
            }
        }

        Write-Debug("============================ TRANSFORMATIONS ============================")
        $params.Keys | ForEach-Object {"$_ : $($params[$_])" } | Write-Debug
        Write-Debug("=========================================================================`n")
        
        $logoUrl = (Invoke-GraphRequest -Headers $customHeaders -Uri $URI -Method $Method).Info.logoUrl

        if($null -ne $logoUrl){
            try {
                Invoke-WebRequest -Uri $logoUrl -OutFile $($params.FilePath)
            }
            catch {
                
            }
        }
    }
'@
}