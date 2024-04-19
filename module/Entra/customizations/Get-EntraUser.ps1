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
        $customHeaders = New-EntraCustomHeaders -Command $MyInvocation.MyCommand
        $params = @{}
        $topCount = $null
        $baseUri = 'https://graph.microsoft.com/v1.0/users'
        $properties = '$select=Id,AccountEnabled,AgeGroup,OfficeLocation,AssignedLicenses,AssignedPlans,City,CompanyName,ConsentProvidedForMinor,Country,CreationType,Department,DisplayName,GivenName,OnPremisesImmutableId,JobTitle,LegalAgeGroupClassification,Mail,MailNickName,MobilePhone,OnPremisesSecurityIdentifier,OtherMails,PasswordPolicies,PasswordProfile,PostalCode,PreferredLanguage,ProvisionedPlans,OnPremisesProvisioningErrors,ProxyAddresses,RefreshTokensValidFromDateTime,ShowInAddressList,State,StreetAddress,Surname,BusinessPhones,UsageLocation,UserPrincipalName,ExternalUserState,ExternalUserStateChangeDateTime,UserType,OnPremisesLastSyncDateTime,ImAddresses,SecurityIdentifier,OnPremisesUserPrincipalName,ServiceProvisioningErrors,IsResourceAccount,OnPremisesExtensionAttributes,DeletedDateTime,OnPremisesSyncEnabled,EmployeeType,EmployeeHireDate,CreatedDateTime,EmployeeOrgData,preferredDataLocation,Identities,onPremisesSamAccountName,EmployeeId,EmployeeLeaveDateTime,AuthorizationInfo,FaxNumber,OnPremisesDistinguishedName,OnPremisesDomainName,IsLicenseReconciliationNeeded,signInSessionsValidFromDateTime'
        $params["Method"] = "GET"

        if($PSBoundParameters.ContainsKey("Top") -and $PSBoundParameters.ContainsKey("Filter"))
        {
            $topCount = $PSBoundParameters["Top"]
            $Filter = $PSBoundParameters["Filter"]
            $params["Uri"] = "$baseUri/?`$top=$topCount&`$filter=$Filter&$properties"
            $params["Headers"] = @{ ConsistencyLevel = 'eventual'}
        }
        if($null -ne $PSBoundParameters["SearchString"])
        {
            $TmpValue = $PSBoundParameters["SearchString"]
            $SearchString = "`$search=`"userprincipalname:$TmpValue`" OR `"state:$TmpValue`" OR `"mailNickName:$TmpValue`" OR `"mail:$TmpValue`" OR `"jobTitle:$TmpValue`" OR `"displayName:$TmpValue`" OR `"department:$TmpValue`" OR `"country:$TmpValue`" OR `"city:$TmpValue`""
            $params["Uri"] = "$baseUri/?$SearchString&$properties"
            $params["Headers"] = @{ ConsistencyLevel = 'eventual'}
        }
        if($null -ne $PSBoundParameters["ObjectId"])
        {
            $UserId = $PSBoundParameters["ObjectId"]
            $params["Uri"] = "$baseUri/$($UserId)?$properties"
        }
        if($null -ne $PSBoundParameters["Filter"])
        {
            $Filter = $PSBoundParameters["Filter"]
            $f = '$' + 'Filter'
            $params["Uri"] = "$baseUri/?$f=$Filter&$properties"
        }
        if($PSBoundParameters.ContainsKey("Verbose"))
        {
            $params["Verbose"] = $Null
        }
        if($null -ne $PSBoundParameters["All"])
        {
            $params["Uri"] = "$baseUri/?$properties"
        }
        if($PSBoundParameters.ContainsKey("Debug"))
        {
            $params["Debug"] = $Null
        }
        if($null -ne $PSBoundParameters["Top"])
        {
            $topCount = $PSBoundParameters["Top"]
            $params["Uri"] = "$baseUri/?`$top=$topCount&$properties"
        }
    
        Write-Debug("============================ TRANSFORMATIONS ============================")
        $params.Keys | ForEach-Object {"$_ : $($params[$_])" } | Write-Debug
        Write-Debug("=========================================================================`n")
        
        $response = Invoke-GraphRequest @params 
        $data = $response | ConvertTo-Json -Depth 10 | ConvertFrom-Json
        try {
            $data = $response.value | ConvertTo-Json -Depth 10 | ConvertFrom-Json
            if($null -eq $PSBoundParameters["Top"]){
                while($response.'@odata.nextLink'){
                    $params["Uri"] = $response.'@odata.nextLink'
                    $response = Invoke-GraphRequest @params 
                    $data += $response.value
                }
            }   
        }catch {}
        $data | ForEach-Object {
            if ($null -ne $_) {
                Add-Member -InputObject $_ -MemberType AliasProperty -Name ObjectId -Value Id
                Add-Member -InputObject $_ -MemberType AliasProperty -Name UserState -Value ExternalUserState
                Add-Member -InputObject $_ -MemberType AliasProperty -Name UserStateChangedOn -Value ExternalUserStateChangeDateTime
                Add-Member -InputObject $_ -MemberType AliasProperty -Name Mobile -Value mobilePhone
                Add-Member -InputObject $_ -MemberType AliasProperty -Name DeletionTimestamp -Value DeletedDateTime
            }
        }
        $data
    }    
'@
}
