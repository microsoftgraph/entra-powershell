# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
@{
    SourceName = "Set-AzureADMSNamedLocationPolicy"
    TargetName = $null
    Parameters = $null
    Outputs = $null
    CustomScript = @'
    PROCESS {    
        $params = @{}
        $customHeaders = New-EntraBetaCustomHeaders -Command $MyInvocation.MyCommand
        $body = @{}
        $keysChanged = @{}
        if($null -ne $PSBoundParameters["IncludeUnknownCountriesAndRegions"])
        {
            $body["IncludeUnknownCountriesAndRegions"] = $PSBoundParameters["IncludeUnknownCountriesAndRegions"]
        }
        if($null -ne $PSBoundParameters["Id"])
        {
            $body["Id"] = $PSBoundParameters["Id"]
        }
        if($null -ne $PSBoundParameters["PolicyId"])
        {
            $params["NamedLocationId"] = $PSBoundParameters["PolicyId"]
        }
        if($PSBoundParameters.ContainsKey("Verbose"))
        {
            $params["Verbose"] = $Null
        }
        if($PSBoundParameters.ContainsKey("Debug"))
        {
            $params["Debug"] = $Null
        }
        if($null -ne $PSBoundParameters["IsTrusted"])
        {
            $body["IsTrusted"] = $PSBoundParameters["IsTrusted"]
        }
        if($null -ne $PSBoundParameters["OdataType"])
        {
            $body["@odata.type"] = $PSBoundParameters["OdataType"]
        }
        if($null -ne $PSBoundParameters["CountriesAndRegions"])
        {
            $body["CountriesAndRegions"] = $PSBoundParameters["CountriesAndRegions"]
        }
        if($null -ne $PSBoundParameters["IpRanges"])
        {
            $Tmp = $PSBoundParameters["IpRanges"]
            $hash =@()
            foreach($i in $Tmp){
                $hash += @{cidrAddress=$i.CidrAddress}
            }
            $body["IpRanges"] = $hash
        }
        if($null -ne $PSBoundParameters["DisplayName"])
        {
            $body["DisplayName"] = $PSBoundParameters["DisplayName"]
        }

        $params["BodyParameter"] = $body
    
        Write-Debug("============================ TRANSFORMATIONS ============================")
        $params.Keys | ForEach-Object {"$_ : $($params[$_])" } | Write-Debug
        Write-Debug("=========================================================================`n")
        
        $response = Update-MgBetaIdentityConditionalAccessNamedLocation @params -Headers $customHeaders
        $response | ForEach-Object {
            if($null -ne $_) {
            Add-Member -InputObject $_ -MemberType AliasProperty -Name ObjectId -Value Id
            }
        }
        $response
        }
'@
}