# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
@{
    SourceName = "Get-AzureADUser"
    TargetName = $null
    Parameters = $null
    outputs = $null
    CustomScript = @'
    PROCESS {    
        $params = @{}
        $keysChanged = @{SearchString = "Filter"; ObjectId = "Id"}
        if($null -ne $PSBoundParameters["SearchString"])
        {
            $TmpValue = $PSBoundParameters["SearchString"]
            $Value = "userPrincipalName eq '$TmpValue' or (state eq '$TmpValue' or (mailNickName eq '$TmpValue' or (mail eq '$TmpValue' or (jobTitle eq '$TmpValue' or (displayName eq '$TmpValue' or (startswith(displayName,'$TmpValue') or (department eq '$TmpValue' or (country eq '$TmpValue' or city eq '$TmpValue'))))))))"
            $params["Filter"] = $Value
        }
        if($null -ne $PSBoundParameters["ObjectId"])
        {
            $params["UserId"] = $PSBoundParameters["ObjectId"]
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
        
        $response = Get-MgUser @params -Property AccountEnabled, AgeGroup, AssignedLicenses, AssignedPlans, City, CompanyName, ConsentProvidedForMinor, Country, CreationType, DeletionTimestamp, Department, DirSyncEnabled, DisplayName, ExtensionProperty, FacsimileTelephoneNumber, GivenName, ImmutableId, IsCompromised, JobTitle, LastDirSyncTime, LegalAgeGroupClassification, Mail, MailNickName, Mobile, ObjectId, ObjectType, OnPremisesSecurityIdentifier, OtherMails, PasswordPolicies, PasswordProfile, PhysicalDeliveryOfficeName, PostalCode, PreferredLanguage, ProvisionedPlans, ProvisioningErrors, ProxyAddresses, RefreshTokensValidFromDateTime, ShowInAddressList, SignInNames, SipProxyAddress, State, StreetAddress, Surname, BusinessPhones, UsageLocation, UserPrincipalName, UserState, UserStateChangedOn, UserType
        
        $response | ForEach-Object {
            if($null -ne $_) {
            Add-Member -InputObject $_ -MemberType AliasProperty -Name ObjectId -Value Id
    
            }
        }
        $response | ConvertTo-Json | ConvertFrom-Json
        }
'@
}
