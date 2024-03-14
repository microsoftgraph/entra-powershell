# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
@{
    SourceName = "Set-AzureADMSApplication"
    TargetName = $null
    Parameters = $null
    outputs = $null
    CustomScript = @'
    PROCESS {    
        $params = @{}
        $keysChanged = @{ObjectId = "Id"}
        if($null -ne $PSBoundParameters["Api"])
        {
            $TmpValue = $PSBoundParameters["Api"]
                    $Temp = $TmpValue | ConvertTo-Json
            $Value = @{}
        
            (ConvertFrom-Json $Temp).psobject.properties | Foreach { $Value[$_.Name] = $_.Value } 
            $params["Api"] = $Value
        }
        if($null -ne $PSBoundParameters["OptionalClaims"])
        {
            $TmpValue = $PSBoundParameters["OptionalClaims"]
                    $Temp = $TmpValue | ConvertTo-Json
            $Value = @{}
        
            (ConvertFrom-Json $Temp).psobject.properties | Foreach { $Value[$_.Name] = $_.Value } 
            $params["OptionalClaims"] = $Value
        }
        if($PSBoundParameters.ContainsKey("Verbose"))
        {
            $params["Verbose"] = $Null
        }
        if($null -ne $PSBoundParameters["DisplayName"])
        {
            $params["DisplayName"] = $PSBoundParameters["DisplayName"]
        }
        if($null -ne $PSBoundParameters["Tags"])
        {
            $params["Tags"] = $PSBoundParameters["Tags"]
        }
        if($null -ne $PSBoundParameters["Web"])
        {
            $TmpValue = $PSBoundParameters["Web"]
            $Value = @{}
            if($TmpValue.HomePageUrl) { $Value["HomePageUrl"] = $TmpValue.HomePageUrl } 
            if($TmpValue.LogoutUrl) { $Value["LogoutUrl"] = $TmpValue.LogoutUrl }
            if($TmpValue.RedirectUris) { $Value["RedirectUris"] = $TmpValue.RedirectUris }
            if($TmpValue.ImplicitGrantSettings) { $Value["ImplicitGrantSettings"] = $TmpValue.ImplicitGrantSettings }
    
            $params["Web"] = $Value
        }
        if($null -ne $PSBoundParameters["IsFallbackPublicClient"])
        {
            $params["IsFallbackPublicClient"] = $PSBoundParameters["IsFallbackPublicClient"]
        }
        if($null -ne $PSBoundParameters["RequiredResourceAccess"])
        {
            $TmpValue = $PSBoundParameters["RequiredResourceAccess"]
                        $Value = $TmpValue | ConvertTo-Json 
            $params["RequiredResourceAccess"] = $Value
        }
        if($null -ne $PSBoundParameters["PublicClient"])
        {
            $TmpValue = $PSBoundParameters["PublicClient"]
                    $Temp = $TmpValue | ConvertTo-Json
            $Value = @{}
        
            (ConvertFrom-Json $Temp).psobject.properties | Foreach { $Value[$_.Name] = $_.Value } 
            $params["PublicClient"] = $Value
        }
        if($PSBoundParameters.ContainsKey("Debug"))
        {
            $params["Debug"] = $Null
        }
        if($null -ne $PSBoundParameters["IsDeviceOnlyAuthSupported"])
        {
            $params["IsDeviceOnlyAuthSupported"] = $PSBoundParameters["IsDeviceOnlyAuthSupported"]
        }
        if($null -ne $PSBoundParameters["KeyCredentials"])
        {
            $TmpValue = $PSBoundParameters["KeyCredentials"]
                        $a = @()
                $inpu = $TmpValue
                foreach($v in $inpu)
                {
                    $hash = @{}
                    if($TmpValue.CustomKeyIdentifier) { $hash["CustomKeyIdentifier"] = $v.CustomKeyIdentifier }
                    if($TmpValue.EndDateTime) { $hash["EndDateTime"] = $v.EndDateTime }
                    if($TmpValue.Key) { $hash["Key"] = $v.Key }
                    if($TmpValue.StartDateTime) { $hash["StartDateTime"] = $v.StartDateTime }
                    if($TmpValue.Type) { $hash["Type"] = $v.Type }
                    if($TmpValue.Usage) { $hash["Usage"] = $v.Usage }
                    if($TmpValue.DisplayName) { $hash["DisplayName"] = $v.DisplayName }
                    if($TmpValue.KeyId) { $hash["KeyId"] = $v.KeyId }

                    $a += $hash
                }
    
                $Value = $a
            $params["KeyCredentials"] = $Value
        }
        if($null -ne $PSBoundParameters["TokenEncryptionKeyId"])
        {
            $params["TokenEncryptionKeyId"] = $PSBoundParameters["TokenEncryptionKeyId"]
        }
        if($null -ne $PSBoundParameters["IdentifierUris"])
        {
            $params["IdentifierUris"] = $PSBoundParameters["IdentifierUris"]
        }
        if($null -ne $PSBoundParameters["ParentalControlSettings"])
        {
            $TmpValue = $PSBoundParameters["ParentalControlSettings"]
                        $Temp = $TmpValue | ConvertTo-Json
                $Value = @{}
        
                (ConvertFrom-Json $Temp).psobject.properties | Foreach { $Value[$_.Name] = $_.Value }
            $params["ParentalControlSettings"] = $Value
        }
        if($null -ne $PSBoundParameters["GroupMembershipClaims"])
        {
            $params["GroupMembershipClaims"] = $PSBoundParameters["GroupMembershipClaims"]
        }
        if($null -ne $PSBoundParameters["ObjectId"])
        {
            $params["ApplicationId"] = $PSBoundParameters["ObjectId"]
        }
        if($null -ne $PSBoundParameters["AddIns"])
        {
            $TmpValue = $PSBoundParameters["AddIns"]
            $Value = @()
            $Properties = @()
    
            foreach($prop in $TmpValue.Properties)
            {
                $Temp = $prop | ConvertTo-Json
                $hash = @{}
    
                (ConvertFrom-Json $Temp).psobject.properties | Foreach { $hash[$_.Name] = $_.Value }
                $Properties += $hash
            }
        
            foreach($data in $TmpValue)
            {
                $hash = @{
                    Id= $data.Id
                    Type =  $data.Type
                    Properties = $Properties
                    }
    
                $Value += $hash
            }
            $params["AddIns"] = $Value
        }
        if($null -ne $PSBoundParameters["AppRoles"])
        {
            $TmpValue = $PSBoundParameters["AppRoles"]
                        $a = @()
                $inpu = $TmpValue
                foreach($v in $inpu)
                {
                    $hash = @{}
                    if($TmpValue.AllowedMemberTypes) { $hash["AllowedMemberTypes"] = $v.AllowedMemberTypes }
                    if($TmpValue.Description) { $hash["Description"] = $v.Description }
                    if($TmpValue.DisplayName) { $hash["DisplayName"] = $v.DisplayName }
                    if($TmpValue.Id) { $hash["Id"] = $v.Id }
                    if($TmpValue.IsEnabled) { $hash["IsEnabled"] = $v.IsEnabled }
                    if($TmpValue.Origin) { $hash["Origin"] = $v.Origin }
                    if($TmpValue.Value) { $hash["Value"] = $v.Value }

                    $a += $hash
                }
    
                $Value = $a
            $params["AppRoles"] = $Value
        }
        if($null -ne $PSBoundParameters["PasswordCredentials"])
        {
            $TmpValue = $PSBoundParameters["PasswordCredentials"]
                        $a = @()
                $inpu = $TmpValue
                foreach($v in $inpu)
                {
                    $hash = @{}
                    if($TmpValue.CustomKeyIdentifier) { $hash["CustomKeyIdentifier"] = $v.CustomKeyIdentifier }
                    if($TmpValue.EndDateTime) { $hash["EndDateTime"] = $v.EndDateTime }
                    if($TmpValue.Hint) { $hash["Hint"] = $v.Hint }
                    if($TmpValue.StartDateTime) { $hash["StartDateTime"] = $v.StartDateTime }
                    if($TmpValue.SecretText) { $hash["SecretText"] = $v.SecretText }
                    if($TmpValue.DisplayName) { $hash["DisplayName"] = $v.DisplayName }
                    if($TmpValue.KeyId) { $hash["KeyId"] = $v.KeyId }
                    
                    $a += $hash
                }
    
                $Value = $a
            $params["PasswordCredentials"] = $Value
        }
        if($null -ne $PSBoundParameters["SignInAudience"])
        {
            $params["SignInAudience"] = $PSBoundParameters["SignInAudience"]
        }
        if($null -ne $PSBoundParameters["InformationalUrl"])
        {
            $TmpValue = $PSBoundParameters["InformationalUrl"]
                    $Temp = $TmpValue | ConvertTo-Json
            $Value = @{}
        
            (ConvertFrom-Json $Temp).psobject.properties | Foreach { $Value[$_.Name] = $_.Value } 
            $params["Info"] = $Value
        }
        Write-Debug("============================ TRANSFORMATIONS ============================")
        $params.Keys | ForEach-Object {"$_ : $($params[$_])" } | Write-Debug
        Write-Debug("=========================================================================")
        
        $response = Update-MgApplication @params
        $response | ForEach-Object {
            if($null -ne $_) {
            Add-Member -InputObject $_ -MemberType AliasProperty -Name ObjectId -Value Id
    
            }
        }
        $response
    }
'@
}