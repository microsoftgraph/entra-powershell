# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
@{
    SourceName = "Set-AzureADApplication"
    TargetName = $null
    Parameters = $null
    outputs = $null
    CustomScript = @'
    $params = @{}
    if($PSBoundParameters.ContainsKey("Verbose"))
    {
        $params["Verbose"] = $Null
    }
    
    $ApplicationID = $PSBoundParameters["ObjectId"]
    
    $params["ApplicationId"] = $ApplicationID

    if($null -ne $PSBoundParameters["DisplayName"])
    {
        $params["DisplayName"] = $PSBoundParameters["DisplayName"]
    }
    
    if($null -ne $PSBoundParameters["AddIns"])
    {
        $a = @()
        foreach($value in $PSBoundParameters["AddIns"])
        {
           $Temp = $value | ConvertTo-Json
            $hash = @{}

            (ConvertFrom-Json $Temp).psobject.properties | Foreach { $hash[$_.Name] = $_.Value }
            $a += $hash
        }

        $params["AddIns"] = $a
    }

    if($null -ne $PSBoundParameters["AppLogoUrl"])
    {
        $params["LogoInputFile"] = $PSBoundParameters["AppLogoUrl"]
    }
    if($null -ne $PSBoundParameters["AppRoles"])
    {
        $a = @()
        $input = $PSBoundParameters["AppRoles"]
        foreach($value in $input)
        {
           $Temp = $value | ConvertTo-Json
            $hash = @{}

            (ConvertFrom-Json $Temp).psobject.properties | Foreach { $hash[$_.Name] = $_.Value }
            $a += $hash
        }
        
        $params["AppRoles"] = $a
    }
    if($null -ne $PSBoundParameters["GroupMembershipClaims"])
    {
        $params["GroupMembershipClaims"] =  $PSBoundParameters["GroupMembershipClaims"]
    }

    $Web = @{}

    if($null -ne $PSBoundParameters["Homepage"])
    {
        $Web["HomePageUrl"]  =  $PSBoundParameters["Homepage"]
    }
    
    if($null -ne $PSBoundParameters["ReplyUrls"])
    {
        $Web["RedirectUris"]  =  $PSBoundParameters["ReplyUrls"]
    }

    if($null -ne $PSBoundParameters["IdentifierUris"])
    {
        $params["IdentifierUris"] =  $PSBoundParameters["IdentifierUris"]
    }
    
    if($null -ne $PSBoundParameters["InformationalUrls"])
    {
        $Temp = $PSBoundParameters["InformationalUrls"]
        $hash = @{}

        $hash["MarketingUrl"] = $Temp.Marketing
        $hash["PrivacyStatementUrl"] = $Temp.Privacy
        $hash["SupportUrl"] = $Temp.Support 
        $hash["TermsOfServiceUrl"] = $Temp.TermsOfService
        
        $params["Info"] =  $hash
    }

    if($null -ne $PSBoundParameters["IsDeviceOnlyAuthSupported"])
    {
        $params["IsDeviceOnlyAuthSupported"] =  $PSBoundParameters["IsDeviceOnlyAuthSupported"]
    }

    if($null -ne $PSBoundParameters["KeyCredentials"])
    {
        $a = @()
        $input = $PSBoundParameters["KeyCredentials"]
        foreach($value in $input)
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

    $Api = @{}

    if($null -ne $PSBoundParameters["KnownClientApplications"])
    {
        $Api["KnownClientApplications"] =  $PSBoundParameters["KnownClientApplications"]
    }
    if($null -ne $PSBoundParameters["LogoutUrl"])
    {
        $Web["LogoutUrl"] =  $PSBoundParameters["LogoutUrl"]
    }

    if($null -ne $PSBoundParameters["Oauth2RequirePostResponse"])
    {
        $params["Oauth2RequirePostResponse"] =  $PSBoundParameters["Oauth2RequirePostResponse"]
    }
    if($null -ne $PSBoundParameters["ParentalControlSettings"])
    {
        $Temp = $PSBoundParameters["ParentalControlSettings"] | ConvertTo-Json
        $hash = @{}

        (ConvertFrom-Json $Temp).psobject.properties | Foreach { $hash[$_.Name] = $_.Value }

        $params["ParentalControlSettings"] = $hash 
    }

    if($null -ne $PSBoundParameters["PasswordCredentials"])
    {
        $a = @()
        $input = $PSBoundParameters["PasswordCredentials"]
        foreach($value in $input)
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

    if($null -ne $PSBoundParameters["PreAuthorizedApplications"])
    {
        $a = @()
        $input = $PSBoundParameters["PreAuthorizedApplications"]
        foreach($value in $input)
        {
           $Temp = $value | ConvertTo-Json
            $hash = @{}

            (ConvertFrom-Json $Temp).psobject.properties | Foreach { $hash[$_.Name] = $_.Value }
            $a += $hash
        }
        
        $Api["PreAuthorizedApplications"] = $a   
    }

    if($null -ne $PSBoundParameters["PublicClient"])
    {
        $params["PublicClient"] =  $PSBoundParameters["PublicClient"]
    }
    if($null -ne $PSBoundParameters["PublisherDomain"])
    {
        $params["PublisherDomain"] =  $PSBoundParameters["PublisherDomain"]
    }

    if($null -ne $PSBoundParameters["RequiredResourceAccess"])
    {
        $input = $PSBoundParameters["RequiredResourceAccess"]
        
        $params["RequiredResourceAccess"] =  $input | ConvertTo-Json 
    }

    if($null -ne $PSBoundParameters["SamlMetadataUrl"])
    {
        $params["SamlMetadataUrl"] =  $PSBoundParameters["SamlMetadataUrl"]
    }
    if($null -ne $PSBoundParameters["SignInAudience"])
    {
        $params["SignInAudience"] =  $PSBoundParameters["SignInAudience"]
    }

    $params["Web"] = $Web
    $params["Api"] = $Api

    if($PSBoundParameters.ContainsKey("Debug"))
    {
        $params["Debug"] = $Null
    }

    Write-Debug("============================ TRANSFORMATIONS ============================")
    $params.Keys | ForEach-Object {"$_ : $($params[$_])" } | Write-Debug
    Write-Debug("=========================================================================``n")

    Update-MgBetaApplication @params
'@
}