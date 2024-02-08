# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
@{
    SourceName = "Get-AzureADDeletedApplication"
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
        
        $response = Get-MgBetaDirectoryDeletedItemAsApplication @params
        
        $response | ForEach-Object {
            if($null -ne $_) {
                Add-Member -InputObject $_ -MemberType AliasProperty -Name ObjectId -Value Id
                Add-Member -InputObject $_ -NotePropertyMembers $_.AdditionalProperties

                $propsToConvert = @(
                     'addIns','AppRoles','GroupMembershipClaims','IdentifierUris','Info',
                     'IsDeviceOnlyAuthSupported','KeyCredentials','OptionalClaims',
                     'ParentalControlSettings','PasswordCredentials','Api','PublicClient',
                     'PublisherDomain','Web','RequiredResourceAccess')
                     
                foreach ($prop in $propsToConvert) {
                    $value = $_.$prop | ConvertTo-Json | ConvertFrom-Json
                    $_ | Add-Member -MemberType NoteProperty -Name $prop -Value ($value) -Force
                }
               
                Add-Member -InputObject $_ -MemberType AliasProperty -Name AppLogoUrl -Value Logo
                Add-Member -InputObject $_ -MemberType AliasProperty -Name InformationalUrls -Value Info
                Add-Member -InputObject $_ -MemberType AliasProperty -Name HomePage -Value Web.HomePageUrl
                Add-Member -InputObject $_ -MemberType AliasProperty -Name LogoutUrl -Value Web.LogoutUrl
                Add-Member -InputObject $_ -MemberType AliasProperty -Name ReplyUrls -Value Web.RedirectUris
                Add-Member -InputObject $_ -MemberType AliasProperty -Name KnownClientApplications -Value Api.KnownClientApplications
                Add-Member -InputObject $_ -MemberType AliasProperty -Name PreAuthorizedApplications -Value	Api.PreAuthorizedApplications
                Add-Member -InputObject $_ -MemberType AliasProperty -Name Oauth2AllowImplicitFlow -Value Web.Oauth2AllowImplicitFlow
            }
                
        }
        
        $response
        }
'@
}