# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

function Set-EntraBetaServicePrincipal {
    [CmdletBinding(DefaultParameterSetName = 'InvokeByDynamicParameters')]
    param (
    [Parameter(ParameterSetName = "InvokeByDynamicParameters")]
    [System.Collections.Generic.List`1[System.String]] $AlternativeNames,
    [Parameter(ParameterSetName = "InvokeByDynamicParameters")]
    [System.String] $PublisherName,
    [Parameter(ParameterSetName = "InvokeByDynamicParameters")]
    [System.Collections.Generic.List`1[System.String]] $ReplyUrls,
    [Parameter(ParameterSetName = "InvokeByDynamicParameters")]
    [System.String] $DisplayName,
    [Parameter(ParameterSetName = "InvokeByDynamicParameters")]
    [System.Nullable`1[System.Boolean]] $AppRoleAssignmentRequired,
    [Parameter(ParameterSetName = "InvokeByDynamicParameters")]
    [System.Collections.Generic.List`1[Microsoft.Open.AzureAD.Model.KeyCredential]] $KeyCredentials,
    [Parameter(ParameterSetName = "InvokeByDynamicParameters")]
    [System.Collections.Generic.List`1[System.String]] $ServicePrincipalNames,
    [Parameter(ParameterSetName = "InvokeByDynamicParameters")]
    [System.String] $LogoutUrl,
    [Parameter(ParameterSetName = "InvokeByDynamicParameters")]
    [System.String] $ErrorUrl,
    [Parameter(ParameterSetName = "InvokeByDynamicParameters")]
    [System.String] $SamlMetadataUrl,
    [Parameter(ParameterSetName = "InvokeByDynamicParameters")]
    [System.String] $AccountEnabled,
    [Parameter(ParameterSetName = "InvokeByDynamicParameters")]
    [System.String] $ServicePrincipalType,
    [Parameter(ParameterSetName = "InvokeByDynamicParameters")]
    [System.Collections.Generic.List`1[System.String]] $Tags,
    [Parameter(Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
    [System.String] $ObjectId,
    [Parameter(ParameterSetName = "InvokeByDynamicParameters")]
    [System.Collections.Generic.List`1[Microsoft.Open.AzureAD.Model.PasswordCredential]] $PasswordCredentials,
    [Parameter(ParameterSetName = "InvokeByDynamicParameters")]
    [System.String] $Homepage,
    [Parameter(ParameterSetName = "InvokeByDynamicParameters")]
    [System.String] $AppId,
    [Parameter(ParameterSetName = "InvokeByDynamicParameters")]
    [System.String] $PreferredSingleSignOnMode
    )

    PROCESS {    
        $params = @{}
        $params["Uri"] = "https://graph.microsoft.com/beta/servicePrincipals"
        $params["Method"] = "PATCH"
        $customHeaders = New-EntraBetaCustomHeaders -Command $MyInvocation.MyCommand
        $body = @{}
        $Web = @{}
        $keysChanged = @{ObjectId = "Id"}
        if($null -ne $PSBoundParameters["AccountEnabled"])
        {
            $body["accountEnabled"] = $PSBoundParameters["AccountEnabled"]
        }
        if($null -ne $PSBoundParameters["AlternativeNames"])
        {
            $body["alternativeNames"] = $PSBoundParameters["AlternativeNames"]
        }
        if($null -ne $PSBoundParameters["PreferredSingleSignOnMode"])
        {
            $body["preferredSingleSignOnMode"] = $PSBoundParameters["PreferredSingleSignOnMode"]
        }
        if($null -ne $PSBoundParameters["Tags"])
        {
            $body["tags"] = $PSBoundParameters["Tags"]
        }
        if($PSBoundParameters.ContainsKey("Verbose"))
        {
            $params["Verbose"] = $Null
        }
        if($null -ne $PSBoundParameters["DisplayName"])
        {
            $body["displayName"] = $PSBoundParameters["DisplayName"]
        }
        if($null -ne $PSBoundParameters["AppId"])
        {
            $body["appId"] = $PSBoundParameters["AppId"]
        }
        if($PSBoundParameters.ContainsKey("Debug"))
        {
            $params["Debug"] = $Null
        }
        if($null -ne $PSBoundParameters["ErrorUrl"])
        {
            $body["ErrorUrl"] = $PSBoundParameters["ErrorUrl"]
        }
        if($null -ne $PSBoundParameters["KeyCredentials"])
        {
            $a = @()
            $inpu = $PSBoundParameters["KeyCredentials"]
            foreach($value in $inpu)
            {
                $hash = @{
                    customKeyIdentifier= $value.CustomKeyIdentifier
                    endDateTime =  $value.EndDate
                    key= $value.Value
                    startDateTime= $value.StartDate
                    type= $value.Type
                    usage= $value.Usage
                }
                $a += $hash
            }
            $body["keyCredentials"] = $a
        }
        if($null -ne $PSBoundParameters["ReplyUrls"])
        {
            $body["replyUrls"] =  $PSBoundParameters["ReplyUrls"]
        }
        if($null -ne $PSBoundParameters["ObjectId"])
        {
            $params["Uri"] += "/$ObjectId" 
        }
        if($null -ne $PSBoundParameters["LogoutUrl"])
        {
            $body["logoutUrl"] =  $PSBoundParameters["LogoutUrl"]
        }
        if($null -ne $PSBoundParameters["SamlMetadataUrl"])
        {
            $body["samlMetadataUrl"] = $PSBoundParameters["SamlMetadataUrl"]
        }
        if($null -ne $PSBoundParameters["Homepage"])
        {
            $body["homePage"]  =  $PSBoundParameters["Homepage"]
        }
        if($null -ne $PSBoundParameters["AppRoleAssignmentRequired"])
        {
            $body["appRoleAssignmentRequired"] = $PSBoundParameters["AppRoleAssignmentRequired"]
        }
        if($null -ne $PSBoundParameters["PasswordCredentials"])
        {
            $a = @()
            $inpu = $PSBoundParameters["PasswordCredentials"]
            foreach($value in $inpu)
            {
                $hash = @{
                    customKeyIdentifier= $value.CustomKeyIdentifier
                    endDateTime =  $value.EndDate
                    secretText= $value.Value
                    startDateTime= $value.StartDate
                    }
                $a += $hash
            }
            
            $body["passwordCredentials"] = $a
        }
        if($null -ne $PSBoundParameters["ServicePrincipalType"])
        {
            $body["servicePrincipalType"] = $PSBoundParameters["ServicePrincipalType"]
        }
        if($null -ne $PSBoundParameters["PublisherName"])
        {
            $body["publisherName"] = $PSBoundParameters["PublisherName"]
        }
        if($null -ne $PSBoundParameters["ServicePrincipalNames"])
        {
            $body["servicePrincipalNames"] = $PSBoundParameters["ServicePrincipalNames"]
        }
        if($null -ne $PSBoundParameters["PreferredTokenSigningKeyThumbprint"])
        {
            $body["preferredTokenSigningKeyThumbprint"] = $PSBoundParameters["PreferredTokenSigningKeyThumbprint"]
        }
        if($null -ne $PSBoundParameters["CustomSecurityAttributes"])
        {
            $body["customSecurityAttributes"] = $PSBoundParameters["CustomSecurityAttributes"]
        }
        if($null -ne $PSBoundParameters["WarningVariable"])
        {
            $params["WarningVariable"] = $PSBoundParameters["WarningVariable"]
        }
        if($null -ne $PSBoundParameters["InformationVariable"])
        {
            $params["InformationVariable"] = $PSBoundParameters["InformationVariable"]
        }
	    if($null -ne $PSBoundParameters["InformationAction"])
        {
            $params["InformationAction"] = $PSBoundParameters["InformationAction"]
        }
        if($null -ne $PSBoundParameters["OutVariable"])
        {
            $params["OutVariable"] = $PSBoundParameters["OutVariable"]
        }
        if($null -ne $PSBoundParameters["OutBuffer"])
        {
            $params["OutBuffer"] = $PSBoundParameters["OutBuffer"]
        }
        if($null -ne $PSBoundParameters["ErrorVariable"])
        {
            $params["ErrorVariable"] = $PSBoundParameters["ErrorVariable"]
        }
        if($null -ne $PSBoundParameters["PipelineVariable"])
        {
            $params["PipelineVariable"] = $PSBoundParameters["PipelineVariable"]
        }
        if($null -ne $PSBoundParameters["ErrorAction"])
        {
            $params["ErrorAction"] = $PSBoundParameters["ErrorAction"]
        }
        if($null -ne $PSBoundParameters["WarningAction"])
        {
            $params["WarningAction"] = $PSBoundParameters["WarningAction"]
        }
        $params["Body"] = $body
        Write-Debug("============================ TRANSFORMATIONS ============================")
        $params.Keys | ForEach-Object {"$_ : $($params[$_])" } | Write-Debug
        Write-Debug("=========================================================================
")  
        $response = Invoke-GraphRequest @params -Headers $customHeaders
        $response
    }     
}