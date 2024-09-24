# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
@{
    SourceName = "Get-AzureADApplication"
    TargetName = $null
    Parameters = $null
    Outputs = $null
    CustomScript = @'
    PROCESS {  
        $params = @{}
        $customHeaders = New-EntraBetaCustomHeaders -Command $MyInvocation.MyCommand
        $keysChanged = @{SearchString = "Filter"; ObjectId = "Id"}
        if($null -ne $PSBoundParameters["SearchString"])
        {
            $TmpValue = $PSBoundParameters["SearchString"]
            $Value = "displayName eq '$TmpValue' or startswith(displayName,'$TmpValue')"
            $params["Filter"] = $Value
        }
        if($null -ne $PSBoundParameters["ObjectId"])
        {
            $params["ApplicationId"] = $PSBoundParameters["ObjectId"]
        }
        if($null -ne $PSBoundParameters["Filter"])
        {
            $TmpValue = $PSBoundParameters["Filter"]
            foreach($i in $keysChanged.GetEnumerator()){
                $TmpValue = $TmpValue.Replace($i.Key, $i.Value)
            }
            $Value = $TmpValue
            $params["Filter"] = $Value
        }
        if($PSBoundParameters.ContainsKey("Verbose"))
        {
            $params["Verbose"] = $PSBoundParameters["Verbose"]
        }
        if($null -ne $PSBoundParameters["All"])
        {
            if($PSBoundParameters["All"])
            {
                $params["All"] = $PSBoundParameters["All"]
            }
        }
        if($PSBoundParameters.ContainsKey("Debug"))
        {
            $params["Debug"] = $PSBoundParameters["Debug"]
        }
        if($PSBoundParameters.ContainsKey("Top"))
        {
            $params["Top"] = $PSBoundParameters["Top"]
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
        if($null -ne $PSBoundParameters["Property"])
        {
            $params["Property"] = $PSBoundParameters["Property"]
        }
    
        Write-Debug("============================ TRANSFORMATIONS ============================")
        $params.Keys | ForEach-Object {"$_ : $($params[$_])" } | Write-Debug
        Write-Debug("=========================================================================")
        
        $response = Get-MgBetaApplication @params -Headers $customHeaders
        $response | ForEach-Object {
            if($null -ne $_) {
            Add-Member -InputObject $_ -MemberType AliasProperty -Name ObjectId -Value Id
            Add-Member -InputObject $_ -MemberType AliasProperty -Name DeletionTimestamp -Value DeletedDateTime
            Add-Member -InputObject $_ -MemberType AliasProperty -Name InformationalUrls -Value Info
    
            $myAppRoles = New-Object System.Collections.Generic.List[Microsoft.Open.AzureAD.Model.AppRole]
            foreach ($appRole in $_.AppRoles) {
                $hash = New-Object Microsoft.Open.AzureAD.Model.AppRole
                foreach ($propertyName in $hash.psobject.Properties.Name) {
                    $hash.$propertyName = $appRole.$propertyName
                }
                $myAppRoles.Add($hash)
            }
            Add-Member -InputObject $_ -MemberType NoteProperty -Name AppRoles -Value ($myAppRoles) -Force
            $propsToConvert = @(
                 'Logo','GroupMembershipClaims','IdentifierUris','Info',
                 'IsDeviceOnlyAuthSupported','KeyCredentials','Oauth2RequirePostResponse','OptionalClaims',
                 'ParentalControlSettings','PasswordCredentials','Api','PublicClient',
                 'PublisherDomain','Web','RequiredResourceAccess','SignInAudience')
                 try {
                    foreach ($prop in $propsToConvert) {
                            $value = $_.$prop | ConvertTo-Json | ConvertFrom-Json
                            $_ | Add-Member -MemberType NoteProperty -Name $prop -Value ($value) -Force
                    }
                 }
                 catch {}
            }
            foreach ($credType in @('KeyCredentials', 'PasswordCredentials')) {
                if ($null -ne $_.PSObject.Properties[$credType]) {
                    $_.$credType | ForEach-Object {
                        try {
                            if ($null -ne $_.EndDateTime -or $null -ne $_.StartDateTime) {
                                Add-Member -InputObject $_ -MemberType NoteProperty -Name EndDate -Value $_.EndDateTime
                                Add-Member -InputObject $_ -MemberType NoteProperty -Name StartDate -Value $_.StartDateTime
                                $_.PSObject.Properties.Remove('EndDateTime')
                                $_.PSObject.Properties.Remove('StartDateTime')
                            }
                        }
                        catch {}
                    }
                }
            }
        }
    
        $response
    }    
'@
}