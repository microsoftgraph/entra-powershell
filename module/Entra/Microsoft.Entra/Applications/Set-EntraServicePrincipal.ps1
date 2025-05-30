# ------------------------------------------------------------------------------ 
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  
#  Licensed under the MIT License.  See License in the project root for license information. 
# ------------------------------------------------------------------------------ 
function Set-EntraServicePrincipal {
    [CmdletBinding(DefaultParameterSetName = 'UpdateServicePrincipal')]
    param (
    [Parameter(ParameterSetName = "UpdateServicePrincipal")]
    [System.Collections.Generic.List`1[System.String]] $AlternativeNames,
    [Parameter(ParameterSetName = "UpdateServicePrincipal")]
    [System.String] $PublisherName,
    [Parameter(ParameterSetName = "UpdateServicePrincipal")]
    [System.Collections.Generic.List`1[System.String]] $ReplyUrls,
    [Parameter(ParameterSetName = "UpdateServicePrincipal")]
    [System.String] $DisplayName,
    [Parameter(ParameterSetName = "UpdateServicePrincipal")]
    [System.Nullable`1[System.Boolean]] $AppRoleAssignmentRequired,
    [Parameter(ParameterSetName = "UpdateServicePrincipal")]
    [System.Collections.Generic.List`1[Microsoft.Open.AzureAD.Model.KeyCredential]] $KeyCredentials,
    [Parameter(ParameterSetName = "UpdateServicePrincipal")]
    [System.Collections.Generic.List`1[System.String]] $ServicePrincipalNames,
    [Parameter(ParameterSetName = "UpdateServicePrincipal")]
    [System.String] $LogoutUrl,
    [Parameter(ParameterSetName = "UpdateServicePrincipal")]
    [System.String] $ErrorUrl,
    [Parameter(ParameterSetName = "UpdateServicePrincipal")]
    [System.String] $SamlMetadataUrl,
    [Parameter(ParameterSetName = "UpdateServicePrincipal")]
    [System.String] $AccountEnabled,
    [Parameter(ParameterSetName = "UpdateServicePrincipal")]
    [System.String] $ServicePrincipalType,
    [Parameter(ParameterSetName = "UpdateServicePrincipal")]
    [System.Collections.Generic.List`1[System.String]] $Tags,
    [Alias("ObjectId")]
    [Parameter(Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
    [System.String] $ServicePrincipalId,
    [Parameter(ParameterSetName = "UpdateServicePrincipal")]
    [System.Collections.Generic.List`1[Microsoft.Open.AzureAD.Model.PasswordCredential]] $PasswordCredentials,
    [Parameter(ParameterSetName = "UpdateServicePrincipal")]
    [System.String] $Homepage,
    [Parameter(ParameterSetName = "UpdateServicePrincipal")]
    [System.String] $AppId,
    [Parameter(ParameterSetName = "UpdateServicePrincipal")]
    [System.String] $PreferredSingleSignOnMode
    )

    begin {
        # Ensure connection to Microsoft Entra
        if (-not (Get-EntraContext)) {
            $errorMessage = "Not connected to Microsoft Graph. Use 'Connect-Entra -Scopes Application.ReadWrite.All' to authenticate."
            Write-Error -Message $errorMessage -ErrorAction Stop
            return
        }
    }

    PROCESS {    
        $params = @{}
        $params["Uri"] = "/v1.0/servicePrincipals"
        $params["Method"] = "PATCH"
        $customHeaders = New-EntraCustomHeaders -Command $MyInvocation.MyCommand
        $body = @{}        
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
        if($null -ne $PSBoundParameters["DisplayName"])
        {
            $body["displayName"] = $PSBoundParameters["DisplayName"]
        }
        if($null -ne $PSBoundParameters["AppId"])
        {
            $body["appId"] = $PSBoundParameters["AppId"]
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
        if($null -ne $PSBoundParameters["ServicePrincipalId"])
        {
            $params["Uri"] += "/$ServicePrincipalId" 
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
        $params["Body"] = $body
        Write-Debug("============================ TRANSFORMATIONS ============================")
        $params.Keys | ForEach-Object {"$_ : $($params[$_])" } | Write-Debug
        Write-Debug("=========================================================================
")  
        $response = Invoke-GraphRequest @params -Headers $customHeaders
        $response
    }     
}# ------------------------------------------------------------------------------

