# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
@{
    SourceName = "Set-AzureADMSServicePrincipal"
    TargetName = $null
    Parameters = $null
    Outputs = $null
    CustomScript = @'
    PROCESS {    
        $params = @{}
        $customHeaders = New-CustomHeaders -Module Entra -Command $MyInvocation.MyCommand
        $body = @{}
        $Web = @{}
        $keysChanged = @{ObjectId = "Id"}
        if($null -ne $PSBoundParameters["AccountEnabled"])
        {
            $body["AccountEnabled"] = $PSBoundParameters["AccountEnabled"]
        }
        if($null -ne $PSBoundParameters["Tags"])
        {
            $body["Tags"] = $PSBoundParameters["Tags"]
        }
        if($PSBoundParameters.ContainsKey("Verbose"))
        {
            $params["Verbose"] = $Null
        }
        if($null -ne $PSBoundParameters["DisplayName"])
        {
            $body["DisplayName"] = $PSBoundParameters["DisplayName"]
        }
        if($null -ne $PSBoundParameters["AppId"])
        {
            $body["AppId"] = $PSBoundParameters["AppId"]
        }
        if($PSBoundParameters.ContainsKey("Debug"))
        {
            $params["Debug"] = $Null
        }
        if($null -ne $PSBoundParameters["ErrorUrl"])
        {
            $params["ErrorUrl"] = $PSBoundParameters["ErrorUrl"]
        }
        if($null -ne $PSBoundParameters["KeyCredentials"])
        {
            $a = @()
            $inpu = $PSBoundParameters["KeyCredentials"]
            foreach($value in $inpu)
            {
                $hash = @{
                    CustomKeyIdentifier= $value.CustomKeyIdentifier
                    EndDateTime =  $value.EndDate
                    Key= $value.Value
                    StartDateTime= $value.StartDate
                    Type= $value.Type
                    Usage= $value.Usage
                }
                $a += $hash
            }
            $params["KeyCredentials"] = $a
        }
        if($null -ne $PSBoundParameters["ReplyUrls"])
        {
            $params["ReplyUrls"] =  $PSBoundParameters["ReplyUrls"]
        }
        if($null -ne $PSBoundParameters["Id"])
        {
            $params["ServicePrincipalId"] = $PSBoundParameters["Id"]
        }
        if($null -ne $PSBoundParameters["LogoutUrl"])
        {
            $params["LogoutUrl"] =  $PSBoundParameters["LogoutUrl"]
        }
        if($null -ne $PSBoundParameters["SamlMetadataUrl"])
        {
            $params["SamlMetadataUrl"] = $PSBoundParameters["SamlMetadataUrl"]
        }
        if($null -ne $PSBoundParameters["Homepage"])
        {
            $params["HomePage"]  =  $PSBoundParameters["Homepage"]
        }
        if($null -ne $PSBoundParameters["AppRoleAssignmentRequired"])
        {
            $body["AppRoleAssignmentRequired"] = $PSBoundParameters["AppRoleAssignmentRequired"]
        }
        if($null -ne $PSBoundParameters["PasswordCredentials"])
        {
            $a = @()
            $inpu = $PSBoundParameters["PasswordCredentials"]
            foreach($value in $inpu)
            {
                $hash = @{
                    CustomKeyIdentifier= $value.CustomKeyIdentifier
                    EndDateTime =  $value.EndDate
                    SecretText= $value.Value
                    StartDateTime= $value.StartDate
                    }
                $a += $hash
            }
            
            $params["PasswordCredentials"] = $a
        }
        if($null -ne $PSBoundParameters["PublisherName"])
        {
            $params["PublisherName"] = $PSBoundParameters["PublisherName"]
        }
        if($null -ne $PSBoundParameters["ServicePrincipalNames"])
        {
            $body["ServicePrincipalNames"] = $PSBoundParameters["ServicePrincipalNames"]
        }
        if($null -ne $PSBoundParameters["PreferredTokenSigningKeyThumbprint"])
        {
            $body["PreferredTokenSigningKeyThumbprint"] = $PSBoundParameters["PreferredTokenSigningKeyThumbprint"]
        }
        if($null -ne $PSBoundParameters["CustomSecurityAttributes"])
        {
            $params["CustomSecurityAttributes"] = $PSBoundParameters["CustomSecurityAttributes"]
        }
        if($body.Count -gt 0)
        {
            $params["BodyParameter"] = $body
        }
        Write-Debug("============================ TRANSFORMATIONS ============================")
        $params.Keys | ForEach-Object {"$_ : $($params[$_])" } | Write-Debug
        Write-Debug("=========================================================================
")  
        $response = Update-MgBetaServicePrincipal @params -Headers $customHeaders
        $response | ForEach-Object {
            if($null -ne $_) {
            Add-Member -InputObject $_ -MemberType AliasProperty -Name ObjectId -Value Id
            }
        }
        $response
    } 
'@
}