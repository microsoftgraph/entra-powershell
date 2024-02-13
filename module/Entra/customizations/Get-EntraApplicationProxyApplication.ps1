# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
@{
    SourceName = "Get-AzureADApplicationProxyApplication"
    TargetName = $null
    Parameters = $null
    outputs = $null
    CustomScript = @'   
    PROCESS {    
        $params = @{}
        $topCount = $null
        $baseUri = 'https://graph.microsoft.com/beta/applications'
        $properties = '$select=*'
        $Method = "GET"
        $keysChanged = @{ObjectId = "Id"}
        if($PSBoundParameters.ContainsKey("Verbose"))
        {
            $params["Verbose"] = $Null
        }
        if($null -ne $PSBoundParameters["ObjectId"])
        {
            $params["ApplicationId"] = $PSBoundParameters["ObjectId"]
            $URI = "$baseUri/$($params.ApplicationId)/OnPremisesPublishing?$properties"
        }
        
        if($null -ne $PSBoundParameters["All"])
        {
            $URI = "$baseUri/$($params.ApplicationId)/OnPremisesPublishing?$properties"
        }
        if($PSBoundParameters.ContainsKey("Debug"))
        {
            $params["Debug"] = $Null
        }
        if($null -ne $PSBoundParameters["Top"])
        {
            $topCount = $PSBoundParameters["Top"]
            $URI = "$baseUri/$($params.ApplicationId)/OnPremisesPublishing?`$top=$topCount&$properties"
        }
    
        Write-Debug("============================ TRANSFORMATIONS ============================")
        $params.Keys | ForEach-Object {"$_ : $($params[$_])" } | Write-Debug
        Write-Debug("=========================================================================`n")
        
        $response = Invoke-GraphRequest -Uri $URI -Method $Method
        $response = $response | ConvertTo-Json | ConvertFrom-Json
        $response = $response | Select-Object ExternalUrl, InternalUrl, ExternalAuthenticationType, IsTranslateHostHeaderEnabled, IsTranslateLinksInBodyEnabled, ApplicationServerTimeout | format-table
        $response 
        }
'@
}