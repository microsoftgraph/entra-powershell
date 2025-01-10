# ------------------------------------------------------------------------------ 
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  
#  Licensed under the MIT License.  See License in the project root for license information. 
# ------------------------------------------------------------------------------ 
function New-EntraUser {
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("PSAvoidUsingUserNameAndPassWordParams", "", Scope="Function", Target="*")]
    [CmdletBinding(DefaultParameterSetName = 'InvokeByDynamicParameters')]
    param (
                
    [Parameter(ParameterSetName = "InvokeByDynamicParameters")]
    [System.String] $State,
                
    [Parameter(ParameterSetName = "InvokeByDynamicParameters")]
    [System.String] $FacsimileTelephoneNumber,
                
    [Parameter(ParameterSetName = "InvokeByDynamicParameters")]
    [System.String] $UserType,
                
    [Parameter(ParameterSetName = "InvokeByDynamicParameters")]
    [System.String] $PreferredLanguage,
                
    [Parameter(ParameterSetName = "InvokeByDynamicParameters")]
    [System.String] $StreetAddress,
                
    [Parameter(ParameterSetName = "InvokeByDynamicParameters")]
    [System.String] $CreationType,
                
    [Parameter(ParameterSetName = "InvokeByDynamicParameters")]
    [System.String] $ImmutableId,
                
    [Parameter(ParameterSetName = "InvokeByDynamicParameters")]
    [System.String] $CompanyName,
                
    [Parameter(ParameterSetName = "InvokeByDynamicParameters")]
    [System.String] $PostalCode,
                
    [Parameter(ParameterSetName = "InvokeByDynamicParameters", Mandatory = $true)]
    [System.String] $DisplayName,
                
    [Parameter(ParameterSetName = "InvokeByDynamicParameters")]
    [System.String] $ConsentProvidedForMinor,
                
    [Parameter(ParameterSetName = "InvokeByDynamicParameters")]
    [System.String] $Department,
                
    [Parameter(ParameterSetName = "InvokeByDynamicParameters")]
    [System.String] $Mobile,
                
    [Parameter(ParameterSetName = "InvokeByDynamicParameters")]
    [System.String] $UserStateChangedOn,
                
    [Parameter(ParameterSetName = "InvokeByDynamicParameters")]
    [System.String] $GivenName,
                
    [Parameter(ParameterSetName = "InvokeByDynamicParameters")]
    [System.String] $Country,
                
    [Parameter(ParameterSetName = "InvokeByDynamicParameters")]
    [System.String] $PasswordPolicies,
                
    [Parameter(ParameterSetName = "InvokeByDynamicParameters", Mandatory = $true)]
    [Microsoft.Open.AzureAD.Model.PasswordProfile] $PasswordProfile,
                
    [Parameter(ParameterSetName = "InvokeByDynamicParameters")]
    [System.String] $MailNickName,
                
    [Parameter(ParameterSetName = "InvokeByDynamicParameters")]
    [System.String] $JobTitle,
                
    [Parameter(ParameterSetName = "InvokeByDynamicParameters")]
    [System.String] $UserState,
                
    [Parameter(ParameterSetName = "InvokeByDynamicParameters")]
    [System.String] $City,
                
    [Parameter(ParameterSetName = "InvokeByDynamicParameters")]
    [System.String] $UsageLocation,
                
    [Parameter(ParameterSetName = "InvokeByDynamicParameters")]
    [System.String] $Surname,
                
    [Parameter(ParameterSetName = "InvokeByDynamicParameters")]
    [System.Collections.Generic.List`1[System.String]] $OtherMails,
                
    [Parameter(ParameterSetName = "InvokeByDynamicParameters")]
    [System.String] $UserPrincipalName,
                
    [Parameter(ParameterSetName = "InvokeByDynamicParameters")]
    [System.Collections.Generic.Dictionary`2[System.String,System.String]] $ExtensionProperty,
                
    [Parameter(ParameterSetName = "InvokeByDynamicParameters")]
    [System.Nullable`1[System.Boolean]] $IsCompromised,
                
    [Parameter(ParameterSetName = "InvokeByDynamicParameters")]
    [System.String] $TelephoneNumber,
                
    [Parameter(ParameterSetName = "InvokeByDynamicParameters")]
    [System.String] $PhysicalDeliveryOfficeName,
                
    [Parameter(ParameterSetName = "InvokeByDynamicParameters")]
    [System.String] $AgeGroup,
                
    [Parameter(ParameterSetName = "InvokeByDynamicParameters", Mandatory = $true)]
    [System.Nullable`1[System.Boolean]] $AccountEnabled,
                
    [Parameter(ParameterSetName = "InvokeByDynamicParameters")]
    [System.Nullable`1[System.Boolean]] $ShowInAddressList,
                
    [Parameter(ParameterSetName = "InvokeByDynamicParameters")]
    [System.Collections.Generic.List`1[Microsoft.Open.AzureAD.Model.SignInName]] $SignInNames
    )

    PROCESS {    
        $params = @{}
        $customHeaders = New-EntraCustomHeaders -Command $MyInvocation.MyCommand
        if($null -ne $PSBoundParameters["PostalCode"])
        {
            $params["PostalCode"] = $PSBoundParameters["PostalCode"]
        }
        if($null -ne $PSBoundParameters["MailNickName"])
        {
            $params["MailNickName"] = $PSBoundParameters["MailNickName"]
        }
        if($null -ne $PSBoundParameters["ShowInAddressList"])
        {
            $params["ShowInAddressList"] = $PSBoundParameters["ShowInAddressList"]
        }
        if($null -ne $PSBoundParameters["DisplayName"])
        {
            $params["DisplayName"] = $PSBoundParameters["DisplayName"]
        }
        if($null -ne $PSBoundParameters["Mobile"])
        {
            $params["MobilePhone"] = $PSBoundParameters["Mobile"]
        }
        if($null -ne $PSBoundParameters["JobTitle"])
        {
            $params["JobTitle"] = $PSBoundParameters["JobTitle"]
        }
        if($null -ne $PSBoundParameters["ConsentProvidedForMinor"])
        {
            $params["ConsentProvidedForMinor"] = $PSBoundParameters["ConsentProvidedForMinor"]
        }
        if($null -ne $PSBoundParameters["PhysicalDeliveryOfficeName"])
        {
            $params["PhysicalDeliveryOfficeName"] = $PSBoundParameters["PhysicalDeliveryOfficeName"]
        }
        if($null -ne $PSBoundParameters["OtherMails"])
        {
            $params["OtherMails"] = $PSBoundParameters["OtherMails"]
        }
        if($null -ne $PSBoundParameters["PasswordPolicies"])
        {
            $params["PasswordPolicies"] = $PSBoundParameters["PasswordPolicies"]
        }
        if($null -ne $PSBoundParameters["IsCompromised"])
        {
            $params["IsCompromised"] = $PSBoundParameters["IsCompromised"]
        }
        if($null -ne $PSBoundParameters["SignInNames"])
        {
            $params["Identities"] = $PSBoundParameters["SignInNames"]
        }
        if($null -ne $PSBoundParameters["PreferredLanguage"])
        {
            $params["PreferredLanguage"] = $PSBoundParameters["PreferredLanguage"]
        }
        if($null -ne $PSBoundParameters["UserState"])
        {
            $params["ExternalUserState"] = $PSBoundParameters["UserState"]
        }
        if($null -ne $PSBoundParameters["ImmutableId"])
        {
            $params["OnPremisesImmutableId"] = $PSBoundParameters["ImmutableId"]
        }
        if($null -ne $PSBoundParameters["City"])
        {
            $params["City"] = $PSBoundParameters["City"]
        }
        if($null -ne $PSBoundParameters["AgeGroup"])
        {
            $params["AgeGroup"] = $PSBoundParameters["AgeGroup"]
        }
        if($null -ne $PSBoundParameters["ExtensionProperty"])
        {
            $params["ExtensionProperty"] = $PSBoundParameters["ExtensionProperty"]
        }
        if($null -ne $PSBoundParameters["UsageLocation"])
        {
            $params["UsageLocation"] = $PSBoundParameters["UsageLocation"]
        }
        if($null -ne $PSBoundParameters["UserStateChangedOn"])
        {
            $params["ExternalUserStateChangeDateTime"] = $PSBoundParameters["UserStateChangedOn"]
        }
        if($null -ne $PSBoundParameters["AccountEnabled"])
        {
            $params["AccountEnabled"] = $PSBoundParameters["AccountEnabled"]
        }
        if($null -ne $PSBoundParameters["Country"])
        {
            $params["Country"] = $PSBoundParameters["Country"]
        }
        if($null -ne $PSBoundParameters["UserPrincipalName"])
        {
            $params["UserPrincipalName"] = $PSBoundParameters["UserPrincipalName"]
        }
        if($null -ne $PSBoundParameters["GivenName"])
        {
            $params["GivenName"] = $PSBoundParameters["GivenName"]
        }
        if($null -ne $PSBoundParameters["PasswordProfile"])
        {
            $TmpValue = $PSBoundParameters["PasswordProfile"]
            $Value = @{
                forceChangePasswordNextSignIn = $TmpValue.ForceChangePasswordNextLogin
                forceChangePasswordNextSignInWithMfa = $TmpValue.EnforceChangePasswordPolicy
                password = $TmpValue.Password 
            }
            $params["passwordProfile"] = $Value
        }
        if($null -ne $PSBoundParameters["UserType"])
        {
            $params["UserType"] = $PSBoundParameters["UserType"]
        }
        if($null -ne $PSBoundParameters["StreetAddress"])
        {
            $params["StreetAddress"] = $PSBoundParameters["StreetAddress"]
        }
        if($null -ne $PSBoundParameters["State"])
        {
            $params["State"] = $PSBoundParameters["State"]
        }
        if($null -ne $PSBoundParameters["Department"])
        {
            $params["Department"] = $PSBoundParameters["Department"]
        }
        if($null -ne $PSBoundParameters["CompanyName"])
        {
            $params["CompanyName"] = $PSBoundParameters["CompanyName"]
        }
        if($null -ne $PSBoundParameters["FacsimileTelephoneNumber"])
        {
            $params["FacsimileTelephoneNumber"] = $PSBoundParameters["FacsimileTelephoneNumber"]
        }
        if($null -ne $PSBoundParameters["Surname"])
        {
            $params["Surname"] = $PSBoundParameters["Surname"]
        }
        if($null -ne $PSBoundParameters["TelephoneNumber"])
        {
            $params["BusinessPhones"] = @($PSBoundParameters["TelephoneNumber"])
        }
        if($null -ne $PSBoundParameters["CreationType"])
        {
            $params["CreationType"] = $PSBoundParameters["CreationType"]
        }
    
        Write-Debug("============================ TRANSFORMATIONS ============================")
        $params.Keys | ForEach-Object {"$_ : $($params[$_])" } | Write-Debug
        Write-Debug("=========================================================================`n")
        $params = $params | ConvertTo-Json
        $response = Invoke-GraphRequest -Headers $customHeaders -Uri 'https://graph.microsoft.com/v1.0/users?$select=*' -Method POST -Body $params
        $response = $response | ConvertTo-Json | ConvertFrom-Json
        $response | ForEach-Object {
            if ($null -ne $_) {
                Add-Member -InputObject $_ -MemberType AliasProperty -Name ObjectId -Value Id
                Add-Member -InputObject $_ -MemberType AliasProperty -Name UserState -Value ExternalUserState
                Add-Member -InputObject $_ -MemberType AliasProperty -Name UserStateChangedOn -Value ExternalUserStateChangeDateTime
                Add-Member -InputObject $_ -MemberType AliasProperty -Name Mobile -Value mobilePhone
                Add-Member -InputObject $_ -MemberType AliasProperty -Name DeletionTimestamp -Value DeletedDateTime
                Add-Member -InputObject $_ -MemberType AliasProperty -Name DirSyncEnabled -Value OnPremisesSyncEnabled
                Add-Member -InputObject $_ -MemberType AliasProperty -Name ImmutableId -Value onPremisesImmutableId
                Add-Member -InputObject $_ -MemberType AliasProperty -Name LastDirSyncTime -Value OnPremisesLastSyncDateTime
                Add-Member -InputObject $_ -MemberType AliasProperty -Name ProvisioningErrors -Value onPremisesProvisioningErrors
                Add-Member -InputObject $_ -MemberType AliasProperty -Name TelephoneNumber -Value BusinessPhones
                
                $userData = [Microsoft.Graph.PowerShell.Models.MicrosoftGraphUser]::new()
                $_.PSObject.Properties | ForEach-Object {
                    $userData | Add-Member -MemberType NoteProperty -Name $_.Name -Value $_.Value -Force
                }
            }
        }        
        $userData
    }      
}

