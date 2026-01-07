# ------------------------------------------------------------------------------ 
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  
#  Licensed under the MIT License.  See License in the project root for license information. 
# ------------------------------------------------------------------------------ 
function Set-EntraBetaApplication {
    [CmdletBinding(DefaultParameterSetName = 'UpdateApplication')]
    param (
        [Parameter(ParameterSetName = "UpdateApplication")]
        [Microsoft.Open.MSGraph.Model.ApiApplication] $Api,
        [Parameter(ParameterSetName = "UpdateApplication")]
        [System.Collections.Generic.List`1[Microsoft.Open.MSGraph.Model.AddIn]] $AddIns,
        [Parameter(ParameterSetName = "UpdateApplication")]
        [Microsoft.Open.MSGraph.Model.WebApplication] $Web,
        [Parameter(ParameterSetName = "UpdateApplication")]
        [System.String] $DisplayName,
        [Parameter(ParameterSetName = "UpdateApplication")]
        [System.Collections.Generic.List`1[System.String]] $IdentifierUris,
        [Parameter(ParameterSetName = "UpdateApplication")]
        [Microsoft.Open.MSGraph.Model.ParentalControlSettings] $ParentalControlSettings,
        [Parameter(ParameterSetName = "UpdateApplication")]
        [System.Collections.Generic.List`1[Microsoft.Open.MSGraph.Model.PreAuthorizedApplication]] $PreAuthorizedApplications,
        [Parameter(ParameterSetName = "UpdateApplication")]
        [System.Nullable`1[System.Boolean]] $IsDeviceOnlyAuthSupported,
        [Parameter(ParameterSetName = "UpdateApplication")]
        [System.Collections.Generic.List`1[System.String]] $Tags,
        [Parameter(ParameterSetName = "UpdateApplication")]
        [System.Collections.Generic.List`1[Microsoft.Open.MSGraph.Model.KeyCredential]] $KeyCredentials,
        [Parameter(ParameterSetName = "UpdateApplication")]
        [System.String] $TokenEncryptionKeyId,
        [Alias("ObjectId")]
        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
        [System.String] $ApplicationId,
        [Parameter(ParameterSetName = "UpdateApplication")]
        [System.Nullable`1[System.Boolean]] $IsFallbackPublicClient,
        [Parameter(ParameterSetName = "UpdateApplication")]
        [Microsoft.Open.MSGraph.Model.OptionalClaims] $OptionalClaims,
        [Parameter(ParameterSetName = "UpdateApplication")]
        [System.String] $GroupMembershipClaims,
        [Parameter(ParameterSetName = "UpdateApplication")]
        [Microsoft.Open.MSGraph.Model.PublicClientApplication] $PublicClient,
        [Parameter(ParameterSetName = "UpdateApplication")]
        [System.Collections.Generic.List`1[Microsoft.Open.MSGraph.Model.PasswordCredential]] $PasswordCredentials,
        [Parameter(ParameterSetName = "UpdateApplication")]
        [System.Collections.Generic.List`1[System.String]] $OrgRestrictions,
        [Parameter(ParameterSetName = "UpdateApplication")]
        [System.String] $SignInAudience,
        [Parameter(ParameterSetName = "UpdateApplication")]
        [Microsoft.Open.MSGraph.Model.InformationalUrl] $InformationalUrl,
        [Parameter(ParameterSetName = "UpdateApplication")]
        [System.Collections.Generic.List`1[Microsoft.Open.MSGraph.Model.RequiredResourceAccess]] $RequiredResourceAccess,
        [Parameter(ParameterSetName = "UpdateApplication")]
        [System.Collections.Generic.List`1[Microsoft.Open.MSGraph.Model.AppRole]] $AppRoles
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
        $customHeaders = New-EntraBetaCustomHeaders -Command $MyInvocation.MyCommand
        
        if ($null -ne $PSBoundParameters["Api"]) {
            $TmpValue = $PSBoundParameters["Api"]
            $Temp = $TmpValue | ConvertTo-Json
            $Value = @{}
        
            (ConvertFrom-Json $Temp).psobject.properties | Foreach { $Value[$_.Name] = $_.Value } 
            $params["Api"] = $Value
        }

        if ($null -ne $PSBoundParameters["PreAuthorizedApplications"]) {
            $TmpPAValue = $PSBoundParameters["PreAuthorizedApplications"]
            if ($null -ne $params["Api"]) {
                $ApiObject = $params["Api"] | ConvertTo-Json

                if ($null -eq $ApiObject.PreAuthorizedApplications) {
                    $ApiObject["PreAuthorizedApplications"] = $TmpPAValue | ConvertTo-Json
                }
            }
            else {
                $Value = $TmpPAValue | ForEach-Object { $_ | ConvertTo-Json }
                $params["Api"] = @{ "PreAuthorizedApplications" = $Value }
            }
        }

        if ($null -ne $PSBoundParameters["OptionalClaims"]) {
            $TmpValue = $PSBoundParameters["OptionalClaims"]
            $Temp = $TmpValue | ConvertTo-Json
            $Value = @{}
        
            (ConvertFrom-Json $Temp).psobject.properties | Foreach { $Value[$_.Name] = $_.Value } 
            $params["OptionalClaims"] = $Value
        }
        if ($PSBoundParameters.ContainsKey("Verbose")) {
            $params["Verbose"] = $PSBoundParameters["Verbose"]
        }
        if ($null -ne $PSBoundParameters["DisplayName"]) {
            $params["DisplayName"] = $PSBoundParameters["DisplayName"]
        }
        if ($null -ne $PSBoundParameters["Tags"]) {
            $params["Tags"] = $PSBoundParameters["Tags"]
        }
        if ($null -ne $PSBoundParameters["Web"]) {
            $TmpValue = $PSBoundParameters["Web"]
            $Value = @{} 
            if ($TmpValue.LogoutUrl) { $Value["LogoutUrl"] = $TmpValue.LogoutUrl }
            if ($TmpValue.RedirectUris) { $Value["RedirectUris"] = $TmpValue.RedirectUris }
            if ($TmpValue.ImplicitGrantSettings) { $Value["ImplicitGrantSettings"] = $TmpValue.ImplicitGrantSettings }
    
            $params["Web"] = $Value
        }
        if ($null -ne $PSBoundParameters["IsFallbackPublicClient"]) {
            $params["IsFallbackPublicClient"] = $PSBoundParameters["IsFallbackPublicClient"]
        }
        if ($null -ne $PSBoundParameters["RequiredResourceAccess"]) {
            $TmpValue = $PSBoundParameters["RequiredResourceAccess"]
            $Value = $TmpValue | ForEach-Object { $_ | ConvertTo-Json }
            $params["RequiredResourceAccess"] = $Value
        }
        if ($null -ne $PSBoundParameters["PublicClient"]) {
            $TmpValue = $PSBoundParameters["PublicClient"]
            $Temp = $TmpValue | ConvertTo-Json
            $Value = @{}
        
            (ConvertFrom-Json $Temp).psobject.properties | Foreach { $Value[$_.Name] = $_.Value } 
            $params["PublicClient"] = $Value
        }
        if ($PSBoundParameters.ContainsKey("Debug")) {
            $params["Debug"] = $PSBoundParameters["Debug"]
        }
        if ($null -ne $PSBoundParameters["IsDeviceOnlyAuthSupported"]) {
            $params["IsDeviceOnlyAuthSupported"] = $PSBoundParameters["IsDeviceOnlyAuthSupported"]
        }
        if ($null -ne $PSBoundParameters["KeyCredentials"]) {
            $TmpValue = $PSBoundParameters["KeyCredentials"]
            $a = @()
            $inpu = $TmpValue
            foreach ($v in $inpu) {
                $hash = @{}
                if ($TmpValue.CustomKeyIdentifier) { $hash["CustomKeyIdentifier"] = $v.CustomKeyIdentifier }
                if ($TmpValue.EndDateTime) { $hash["EndDateTime"] = $v.EndDateTime }
                if ($TmpValue.Key) { $hash["Key"] = $v.Key }
                if ($TmpValue.StartDateTime) { $hash["StartDateTime"] = $v.StartDateTime }
                if ($TmpValue.Type) { $hash["Type"] = $v.Type }
                if ($TmpValue.Usage) { $hash["Usage"] = $v.Usage }
                if ($TmpValue.KeyId) { $hash["KeyId"] = $v.KeyId }

                $a += $hash
            }
    
            $Value = $a
            $params["KeyCredentials"] = $Value
        }
        if ($null -ne $PSBoundParameters["TokenEncryptionKeyId"]) {
            $params["TokenEncryptionKeyId"] = $PSBoundParameters["TokenEncryptionKeyId"]
        }
        if ($null -ne $PSBoundParameters["IdentifierUris"]) {
            $params["IdentifierUris"] = $PSBoundParameters["IdentifierUris"]
        }
        if ($null -ne $PSBoundParameters["ParentalControlSettings"]) {
            $TmpValue = $PSBoundParameters["ParentalControlSettings"]
            $Temp = $TmpValue | ConvertTo-Json
            $Value = @{}
        
                (ConvertFrom-Json $Temp).psobject.properties | Foreach { $Value[$_.Name] = $_.Value }
            $params["ParentalControlSettings"] = $Value
        }
        if ($null -ne $PSBoundParameters["GroupMembershipClaims"]) {
            $params["GroupMembershipClaims"] = $PSBoundParameters["GroupMembershipClaims"]
        }
        if ($null -ne $PSBoundParameters["ApplicationId"]) {
            $params["ApplicationId"] = $PSBoundParameters["ApplicationId"]
        }
        if ($null -ne $PSBoundParameters["AppRoles"]) {
            $TmpValue = $PSBoundParameters["AppRoles"]
            $a = @()
            $inpu = $TmpValue
            foreach ($v in $inpu) {
                $hash = @{}
                if ($TmpValue.AllowedMemberTypes) { $hash["AllowedMemberTypes"] = $v.AllowedMemberTypes }
                if ($TmpValue.Description) { $hash["Description"] = $v.Description }
                if ($TmpValue.DisplayName) { $hash["DisplayName"] = $v.DisplayName }
                if ($TmpValue.Id) { $hash["Id"] = $v.Id }
                if ($TmpValue.IsEnabled) { $hash["IsEnabled"] = $v.IsEnabled }
                if ($TmpValue.Value) { $hash["Value"] = $v.Value }

                $a += $hash
            }
    
            $Value = $a
            $params["AppRoles"] = $Value
        }
        if ($null -ne $PSBoundParameters["PasswordCredentials"]) {
            $TmpValue = $PSBoundParameters["PasswordCredentials"]
            $a = @()
            $inpu = $TmpValue
            foreach ($v in $inpu) {
                $hash = @{}
                if ($TmpValue.CustomKeyIdentifier) { $hash["CustomKeyIdentifier"] = $v.CustomKeyIdentifier }
                if ($TmpValue.EndDateTime) { $hash["EndDateTime"] = $v.EndDateTime }
                if ($TmpValue.Hint) { $hash["Hint"] = $v.Hint }
                if ($TmpValue.StartDateTime) { $hash["StartDateTime"] = $v.StartDateTime }
                if ($TmpValue.SecretText) { $hash["SecretText"] = $v.SecretText }
                if ($TmpValue.KeyId) { $hash["KeyId"] = $v.KeyId }

                $a += $hash
            }
    
            $Value = $a
            $params["PasswordCredentials"] = $Value
        }
        if ($null -ne $PSBoundParameters["SignInAudience"]) {
            $params["SignInAudience"] = $PSBoundParameters["SignInAudience"]
        }
        if ($null -ne $PSBoundParameters["InformationalUrl"]) {
            $TmpValue = $PSBoundParameters["InformationalUrl"]
            $Temp = $TmpValue | ConvertTo-Json
            $Value = @{}
        
            (ConvertFrom-Json $Temp).psobject.properties | Foreach { $Value[$_.Name] = $_.Value } 
            $params["Info"] = $Value
        }
        if ($null -ne $PSBoundParameters["WarningVariable"]) {
            $params["WarningVariable"] = $PSBoundParameters["WarningVariable"]
        }
        if ($null -ne $PSBoundParameters["InformationVariable"]) {
            $params["InformationVariable"] = $PSBoundParameters["InformationVariable"]
        }
        if ($null -ne $PSBoundParameters["InformationAction"]) {
            $params["InformationAction"] = $PSBoundParameters["InformationAction"]
        }
        if ($null -ne $PSBoundParameters["OutVariable"]) {
            $params["OutVariable"] = $PSBoundParameters["OutVariable"]
        }
        if ($null -ne $PSBoundParameters["OutBuffer"]) {
            $params["OutBuffer"] = $PSBoundParameters["OutBuffer"]
        }
        if ($null -ne $PSBoundParameters["ErrorVariable"]) {
            $params["ErrorVariable"] = $PSBoundParameters["ErrorVariable"]
        }
        if ($null -ne $PSBoundParameters["PipelineVariable"]) {
            $params["PipelineVariable"] = $PSBoundParameters["PipelineVariable"]
        }
        if ($null -ne $PSBoundParameters["ErrorAction"]) {
            $params["ErrorAction"] = $PSBoundParameters["ErrorAction"]
        }
        if ($null -ne $PSBoundParameters["WarningAction"]) {
            $params["WarningAction"] = $PSBoundParameters["WarningAction"]
        }
        Write-Debug("============================ TRANSFORMATIONS ============================")
        $params.Keys | ForEach-Object { "$_ : $($params[$_])" } | Write-Debug
        Write-Debug("=========================================================================`n")
        
        $response = Update-MgBetaApplication @params -Headers $customHeaders
        $response | ForEach-Object {
            if ($null -ne $_) {
                Add-Member -InputObject $_ -MemberType AliasProperty -Name ObjectId -Value Id
            }
        }
        $response
    }      
}

