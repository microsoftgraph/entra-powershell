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
        $params["Verbose"] = $Null
    }
    if($null -ne $PSBoundParameters["All"])
    {
        if($PSBoundParameters["All"])
        {
            $params["All"] = $Null
        }
    }
    if($PSBoundParameters.ContainsKey("Debug"))
    {
        $params["Debug"] = $Null
    }
    if($null -ne $PSBoundParameters["Top"])
    {
        $params["Top"] = $PSBoundParameters["Top"]
    }

    Write-Debug("============================ TRANSFORMATIONS ============================")
        $params.Keys | ForEach-Object {"$_ : $($params[$_])" } | Write-Debug
        Write-Debug("=========================================================================`n")
    
    $response = Get-MgBetaApplication @params
    $response | ForEach-Object {
        if($null -ne $_) {
        Add-Member -InputObject $_ -MemberType AliasProperty -Name ObjectId -Value Id
        Add-Member -InputObject $_ -MemberType AliasProperty -Name DeletionTimestamp -Value DeletedDateTime
        Add-Member -InputObject $_ -MemberType AliasProperty -Name InformationalUrls -Value Info
        $propsToConvert = @(
             'AddIns','Logo','AppRoles','GroupMembershipClaims','IdentifierUris','Info',
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
