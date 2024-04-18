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
        $customHeaders = New-EntraCustomHeaders -Command $MyInvocation.MyCommand        
        $baseUri = 'https://graph.microsoft.com/v1.0/applications'
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

        Write-Debug("============================ TRANSFORMATIONS ============================")
        $params.Keys | ForEach-Object {"$_ : $($params[$_])" } | Write-Debug
        Write-Debug("=========================================================================`n")
        
        $logoUrl = (Invoke-GraphRequest -Headers $customHeaders -Uri $URI -Method $Method).Info.logoUrl

        if($null -ne $logoUrl){
            $params["FilePath"] = $PSBoundParameters["FilePath"]
            Invoke-WebRequest -Uri $logoUrl -OutFile $($params.FilePath)
        }
    }
'@
}