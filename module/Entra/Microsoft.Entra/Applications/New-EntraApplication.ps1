# ------------------------------------------------------------------------------ 
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  
#  Licensed under the MIT License.  See License in the project root for license information. 
# ------------------------------------------------------------------------------ 
function New-EntraApplication {
    [CmdletBinding(DefaultParameterSetName = 'CreateApplication')]
    param (
                
    [Parameter(ParameterSetName = "CreateApplication")]
    [System.String] $TokenEncryptionKeyId,
                
    [Parameter(ParameterSetName = "CreateApplication")]
    [System.Collections.Generic.List`1[Microsoft.Open.MSGraph.Model.KeyCredential]] $KeyCredentials,
                
    [Parameter(ParameterSetName = "CreateApplication")]
    [Microsoft.Open.MSGraph.Model.WebApplication] $Web,
                
    [Parameter(ParameterSetName = "CreateApplication", Mandatory = $true)]
    [System.String] $DisplayName,
                
    [Parameter(ParameterSetName = "CreateApplication")]
    [System.Nullable`1[System.Boolean]] $IsDeviceOnlyAuthSupported,
                
    [Parameter(ParameterSetName = "CreateApplication")]
    [System.Collections.Generic.List`1[Microsoft.Open.MSGraph.Model.AppRole]] $AppRoles,
                
    [Parameter(ParameterSetName = "CreateApplication")]
    [System.Collections.Generic.List`1[System.String]] $IdentifierUris,
                
    [Parameter(ParameterSetName = "CreateApplication")]
    [System.Collections.Generic.List`1[Microsoft.Open.MSGraph.Model.RequiredResourceAccess]] $RequiredResourceAccess,
                
    [Parameter(ParameterSetName = "CreateApplication")]
    [System.Nullable`1[System.Boolean]] $IsFallbackPublicClient,
                
    [Parameter(ParameterSetName = "CreateApplication")]
    [System.Collections.Generic.List`1[Microsoft.Open.MSGraph.Model.AddIn]] $AddIns,
                
    [Parameter(ParameterSetName = "CreateApplication")]
    [Microsoft.Open.MSGraph.Model.InformationalUrl] $InformationalUrl,
                
    [Parameter(ParameterSetName = "CreateApplication")]
    [System.Collections.Generic.List`1[Microsoft.Open.MSGraph.Model.PasswordCredential]] $PasswordCredentials,
                
    [Parameter(ParameterSetName = "CreateApplication")]
    [System.Collections.Generic.List`1[System.String]] $Tags,
                
    [Parameter(ParameterSetName = "CreateApplication")]
    [Microsoft.Open.MSGraph.Model.ParentalControlSettings] $ParentalControlSettings,
                
    [Parameter(ParameterSetName = "CreateApplication")]
    [System.String] $GroupMembershipClaims,
                
    [Parameter(ParameterSetName = "CreateApplication")]
    [System.String] $SignInAudience,
                
    [Parameter(ParameterSetName = "CreateApplication")]
    [Microsoft.Open.MSGraph.Model.OptionalClaims] $OptionalClaims,
                
    [Parameter(ParameterSetName = "CreateApplication")]
    [Microsoft.Open.MSGraph.Model.PublicClientApplication] $PublicClient,
                
    [Parameter(ParameterSetName = "CreateApplication")]
    [Microsoft.Open.MSGraph.Model.ApiApplication] $Api
    )

    PROCESS {    
    $params = @{}
    $customHeaders = New-EntraCustomHeaders -Command $MyInvocation.MyCommand
    
    if ($null -ne $PSBoundParameters["InformationVariable"])
    {
        $params["InformationVariable"] = $PSBoundParameters["InformationVariable"]
    }
    if ($null -ne $PSBoundParameters["TokenEncryptionKeyId"])
    {
        $params["TokenEncryptionKeyId"] = $PSBoundParameters["TokenEncryptionKeyId"]
    }
    if ($null -ne $PSBoundParameters["PipelineVariable"])
    {
        $params["PipelineVariable"] = $PSBoundParameters["PipelineVariable"]
    }
    if($null -ne $PSBoundParameters["KeyCredentials"])
    {
        $TmpValue = $PSBoundParameters["KeyCredentials"]
                    $a = @()
            $input = $TmpValue
            foreach($v in $input)
            {
                $hash = @{
                    CustomKeyIdentifier= $v.CustomKeyIdentifier
                    EndDateTime = $v.EndDateTime
                    Key= $v.Key
                    StartDateTime= $v.StartDateTime
                    Type= $v.Type
                    Usage= $v.Usage
                }
                
                $a += $hash
            }

            $Value = $a
        $params["KeyCredentials"] = $Value
    }
    if($null -ne $PSBoundParameters["Web"])
    {
        $TmpValue = $PSBoundParameters["Web"]
                   $Temp = $TmpValue | ConvertTo-Json 
            
            $Value = $Temp
        $params["Web"] = $Value
    }
    if ($null -ne $PSBoundParameters["ProgressAction"])
    {
        $params["ProgressAction"] = $PSBoundParameters["ProgressAction"]
    }
    if ($null -ne $PSBoundParameters["ErrorAction"])
    {
        $params["ErrorAction"] = $PSBoundParameters["ErrorAction"]
    }
    if ($null -ne $PSBoundParameters["DisplayName"])
    {
        $params["DisplayName"] = $PSBoundParameters["DisplayName"]
    }
    if ($null -ne $PSBoundParameters["IsDeviceOnlyAuthSupported"])
    {
        $params["IsDeviceOnlyAuthSupported"] = $PSBoundParameters["IsDeviceOnlyAuthSupported"]
    }
    if($null -ne $PSBoundParameters["AppRoles"])
    {
        $TmpValue = $PSBoundParameters["AppRoles"]
                    $a = @()
            $input = $TmpValue
            foreach($v in $input)
            {
                $Temp = $v | ConvertTo-Json
                $hash = @{}

                (ConvertFrom-Json $Temp).psobject.properties | Foreach { if($null -ne $_.Value){ $hash[$_.Name] = $_.Value }}
                $a += $hash
            }

            $Value = $a
        $params["AppRoles"] = $Value
    }
    if ($null -ne $PSBoundParameters["IdentifierUris"])
    {
        $params["IdentifierUris"] = $PSBoundParameters["IdentifierUris"]
    }
    if($null -ne $PSBoundParameters["RequiredResourceAccess"])
    {
        $TmpValue = $PSBoundParameters["RequiredResourceAccess"]
                    $Value = $TmpValue | ConvertTo-Json
        $params["RequiredResourceAccess"] = $Value
    }
    if ($null -ne $PSBoundParameters["ErrorVariable"])
    {
        $params["ErrorVariable"] = $PSBoundParameters["ErrorVariable"]
    }
    if ($null -ne $PSBoundParameters["IsFallbackPublicClient"])
    {
        $params["IsFallbackPublicClient"] = $PSBoundParameters["IsFallbackPublicClient"]
    }
    if ($null -ne $PSBoundParameters["OutVariable"])
    {
        $params["OutVariable"] = $PSBoundParameters["OutVariable"]
    }
    if($null -ne $PSBoundParameters["AddIns"])
    {
        $TmpValue = $PSBoundParameters["AddIns"]
                    $Temp = $TmpValue | ConvertTo-Json 
            
            $Value = $Temp
        $params["AddIns"] = $Value
    }
    if ($null -ne $PSBoundParameters["WarningVariable"])
    {
        $params["WarningVariable"] = $PSBoundParameters["WarningVariable"]
    }
    if($null -ne $PSBoundParameters["InformationalUrl"])
    {
        $TmpValue = $PSBoundParameters["InformationalUrl"]
                    $Temp = $TmpValue | ConvertTo-Json 
            
            $Value = $Temp
        $params["Info"] = $Value
    }
    if($null -ne $PSBoundParameters["PasswordCredentials"])
    {
        $TmpValue = $PSBoundParameters["PasswordCredentials"]
                    $a = @()
            $input = $TmpValue
            foreach($v in $input)
            {
                $Temp = $v | ConvertTo-Json
                $hash = @{}

                (ConvertFrom-Json $Temp).psobject.properties | Foreach { if($null -ne $_.Value){ $hash[$_.Name] = $_.Value }}
                $a += $hash
            }

            $Value = $a
        $params["PasswordCredentials"] = $Value
    }
    if ($null -ne $PSBoundParameters["Tags"])
    {
        $params["Tags"] = $PSBoundParameters["Tags"]
    }
    if ($null -ne $PSBoundParameters["InformationAction"])
    {
        $params["InformationAction"] = $PSBoundParameters["InformationAction"]
    }
    if($PSBoundParameters.ContainsKey("Debug"))
    {
        $params["Debug"] = $PSBoundParameters["Debug"]
    }
    if ($null -ne $PSBoundParameters["OutBuffer"])
    {
        $params["OutBuffer"] = $PSBoundParameters["OutBuffer"]
    }
    if($PSBoundParameters.ContainsKey("Verbose"))
    {
        $params["Verbose"] = $PSBoundParameters["Verbose"]
    }
    if($null -ne $PSBoundParameters["ParentalControlSettings"])
    {
        $TmpValue = $PSBoundParameters["ParentalControlSettings"]
                    $Temp = $TmpValue | ConvertTo-Json 
            
            $Value = $Temp
        $params["ParentalControlSettings"] = $Value
    }
    if ($null -ne $PSBoundParameters["GroupMembershipClaims"])
    {
        $params["GroupMembershipClaims"] = $PSBoundParameters["GroupMembershipClaims"]
    }
    if ($null -ne $PSBoundParameters["SignInAudience"])
    {
        $params["SignInAudience"] = $PSBoundParameters["SignInAudience"]
    }
    if ($null -ne $PSBoundParameters["WarningAction"])
    {
        $params["WarningAction"] = $PSBoundParameters["WarningAction"]
    }
    if($null -ne $PSBoundParameters["OptionalClaims"])
    {
        $TmpValue = $PSBoundParameters["OptionalClaims"]
                   $Temp = $TmpValue | ConvertTo-Json 
            
            $Value = $Temp
        $params["OptionalClaims"] = $Value
    }
    if($null -ne $PSBoundParameters["PublicClient"])
    {
        $TmpValue = $PSBoundParameters["PublicClient"]
                    $Temp = $TmpValue | ConvertTo-Json 
            
            $Value = $Temp
        $params["PublicClient"] = $Value
    }
    if($null -ne $PSBoundParameters["Api"])
    {
        $TmpValue = $PSBoundParameters["Api"]
                
            $Temp = $TmpValue | ConvertTo-Json 
            
            $Value = $Temp
        $params["Api"] = $Value
    }

    Write-Debug("============================ TRANSFORMATIONS ============================")
    $params.Keys | ForEach-Object {"$_ : $($params[$_])" } | Write-Debug
    Write-Debug("=========================================================================`n")
    
    $response = New-MgApplication @params -Headers $customHeaders
    $response | ForEach-Object {
        if($null -ne $_) {
        Add-Member -InputObject $_ -NotePropertyMembers $_.AdditionalProperties
        Add-Member -InputObject $_ -MemberType AliasProperty -Name ObjectId -Value Id

        }
    }
    $response
    }
}

