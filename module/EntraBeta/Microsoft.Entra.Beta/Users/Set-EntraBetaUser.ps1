# ------------------------------------------------------------------------------ 
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  
#  Licensed under the MIT License.  See License in the project root for license information. 
# ------------------------------------------------------------------------------ 
function Set-EntraBetaUser {
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("PSAvoidUsingUserNameAndPassWordParams", "", Scope = "Function", Target = "*")]
    [CmdletBinding(DefaultParameterSetName = 'FromParameters')]
    param (
                
        [Parameter(ParameterSetName = "FromParameters")]
        [System.String] $CompanyName,
                
        [Parameter(ParameterSetName = "FromParameters")]
        [System.String] $PostalCode,
                
        [Parameter(ParameterSetName = "FromParameters")]
        [System.String] $State,
                
        [Parameter(ParameterSetName = "FromParameters")]
        [System.String] $GivenName,
                
        [Parameter(ParameterSetName = "FromParameters")]
        [System.String] $FacsimileTelephoneNumber,
                
        [Parameter(ParameterSetName = "FromParameters")]
        [Microsoft.Open.AzureAD.Model.PasswordProfile] $PasswordProfile,
                
        [Parameter(ParameterSetName = "FromParameters")]
        [System.String] $StreetAddress,
                
        [Parameter(ParameterSetName = "FromParameters")]
        [System.String] $PasswordPolicies,
                
        [Parameter(ParameterSetName = "FromParameters")]
        [System.String] $PhysicalDeliveryOfficeName,
                
        [Parameter(ParameterSetName = "FromParameters")]
        [System.String] $UserType,
                
        [Parameter(ParameterSetName = "FromParameters")]
        [System.String] $UserStateChangedOn,
                
        [Parameter(ParameterSetName = "FromParameters")]
        [System.String] $City,
                
        [Parameter(ParameterSetName = "FromParameters")]
        [System.String] $CreationType,
                
        [Parameter(ParameterSetName = "FromParameters")]
        [System.String] $ImmutableId,
                
        [Parameter(ParameterSetName = "FromParameters")]
        [System.String] $ConsentProvidedForMinor,
                
        [Parameter(ParameterSetName = "FromParameters")]
        [System.Nullable`1[System.Boolean]] $ShowInAddressList,
                
        [Parameter(ParameterSetName = "FromParameters")]
        [System.Nullable`1[System.Boolean]] $AccountEnabled,
                
        [Parameter(ParameterSetName = "FromParameters")]
        [System.String] $Department,
                
        [Parameter(ParameterSetName = "FromParameters")]
        [System.Collections.Generic.List`1[Microsoft.Open.AzureAD.Model.SignInName]] $SignInNames,
                
        [Parameter(ParameterSetName = "FromParameters")]
        [System.String] $UsageLocation,
                
        [Parameter(ParameterSetName = "FromParameters")]
        [System.String] $PreferredLanguage,
                
        [Parameter(ParameterSetName = "FromParameters")]
        [System.String] $TelephoneNumber,
                
        [Parameter(ParameterSetName = "FromParameters")]
        [System.String] $DisplayName,
                
        [Parameter(ParameterSetName = "FromParameters")]
        [System.Collections.Generic.List`1[System.String]] $OtherMails,
                
        [Parameter(ParameterSetName = "FromParameters")]
        [System.String] $UserState,
                
        [Parameter(ParameterSetName = "FromParameters")]
        [System.Collections.Generic.Dictionary`2[System.String, System.String]] $ExtensionProperty,
                
        [Parameter(ParameterSetName = "FromParameters")]
        [System.String] $Surname,
                
        [Parameter(ParameterSetName = "FromParameters")]
        [System.String] $JobTitle,
                
        [Parameter(ParameterSetName = "FromParameters")]
        [System.String] $UserPrincipalName,
                
        [Parameter(ParameterSetName = "FromParameters")]
        [System.String] $Mobile,
                
        [Parameter(ParameterSetName = "FromParameters")]
        [System.String] $MailNickName,
        [Alias('ObjectId')]            
        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
        [System.String] $UserId,
                
        [Parameter(ParameterSetName = "FromParameters")]
        [System.String] $AgeGroup,
                
        [Parameter(ParameterSetName = "FromParameters")]
        [System.String] $Country,
                
        [Parameter(ParameterSetName = "FromParameters")]
        [System.Nullable`1[System.Boolean]] $IsCompromised
    )

    PROCESS {    
        $params = @{}
        $customHeaders = New-EntraBetaCustomHeaders -Command $MyInvocation.MyCommand
    
        if ($null -ne $PSBoundParameters["CompanyName"]) {
            $params["CompanyName"] = $PSBoundParameters["CompanyName"]
        }
        if ($null -ne $PSBoundParameters["PostalCode"]) {
            $params["PostalCode"] = $PSBoundParameters["PostalCode"]
        }
        if ($null -ne $PSBoundParameters["State"]) {
            $params["State"] = $PSBoundParameters["State"]
        }
        if ($PSBoundParameters.ContainsKey("Verbose")) {
            $params["Verbose"] = $PSBoundParameters["Verbose"]
        }
        if ($null -ne $PSBoundParameters["GivenName"]) {
            $params["GivenName"] = $PSBoundParameters["GivenName"]
        }
        if ($null -ne $PSBoundParameters["ErrorVariable"]) {
            $params["ErrorVariable"] = $PSBoundParameters["ErrorVariable"]
        }
        if ($PSBoundParameters.ContainsKey("Debug")) {
            $params["Debug"] = $PSBoundParameters["Debug"]
        }
        if ($null -ne $PSBoundParameters["FacsimileTelephoneNumber"]) {
            $params["FacsimileTelephoneNumber"] = $PSBoundParameters["FacsimileTelephoneNumber"]
        }
        if ($null -ne $PSBoundParameters["PasswordProfile"]) {
            $TmpValue = $PSBoundParameters["PasswordProfile"]
            $Value = @{
                forceChangePasswordNextSignIn        = $TmpValue.ForceChangePasswordNextLogin
                forceChangePasswordNextSignInWithMfa = $TmpValue.EnforceChangePasswordPolicy
                password                             = $TmpValue.Password 
            }
            $params["PasswordProfile"] = $Value
        }
        if ($null -ne $PSBoundParameters["StreetAddress"]) {
            $params["StreetAddress"] = $PSBoundParameters["StreetAddress"]
        }
        if ($null -ne $PSBoundParameters["PasswordPolicies"]) {
            $params["PasswordPolicies"] = $PSBoundParameters["PasswordPolicies"]
        }
        if ($null -ne $PSBoundParameters["PhysicalDeliveryOfficeName"]) {
            $params["PhysicalDeliveryOfficeName"] = $PSBoundParameters["PhysicalDeliveryOfficeName"]
        }
        if ($null -ne $PSBoundParameters["UserType"]) {
            $params["UserType"] = $PSBoundParameters["UserType"]
        }
        if ($null -ne $PSBoundParameters["UserStateChangedOn"]) {
            $params["ExternalUserStateChangeDateTime"] = $PSBoundParameters["UserStateChangedOn"]
        }
        if ($null -ne $PSBoundParameters["WarningAction"]) {
            $params["WarningAction"] = $PSBoundParameters["WarningAction"]
        }
        if ($null -ne $PSBoundParameters["City"]) {
            $params["City"] = $PSBoundParameters["City"]
        }
        if ($null -ne $PSBoundParameters["ErrorAction"]) {
            $params["ErrorAction"] = $PSBoundParameters["ErrorAction"]
        }
        if ($null -ne $PSBoundParameters["CreationType"]) {
            $params["CreationType"] = $PSBoundParameters["CreationType"]
        }
        if ($null -ne $PSBoundParameters["ImmutableId"]) {
            $params["OnPremisesImmutableId"] = $PSBoundParameters["ImmutableId"]
        }
        if ($null -ne $PSBoundParameters["PipelineVariable"]) {
            $params["PipelineVariable"] = $PSBoundParameters["PipelineVariable"]
        }
        if ($null -ne $PSBoundParameters["InformationVariable"]) {
            $params["InformationVariable"] = $PSBoundParameters["InformationVariable"]
        }
        if ($null -ne $PSBoundParameters["ConsentProvidedForMinor"]) {
            $params["ConsentProvidedForMinor"] = $PSBoundParameters["ConsentProvidedForMinor"]
        }
        if ($null -ne $PSBoundParameters["ShowInAddressList"]) {
            $params["ShowInAddressList"] = $PSBoundParameters["ShowInAddressList"]
        }
        if ($null -ne $PSBoundParameters["AccountEnabled"]) {
            $params["AccountEnabled"] = $PSBoundParameters["AccountEnabled"]
        }
        if ($null -ne $PSBoundParameters["Department"]) {
            $params["Department"] = $PSBoundParameters["Department"]
        }
        if ($null -ne $PSBoundParameters["OutBuffer"]) {
            $params["OutBuffer"] = $PSBoundParameters["OutBuffer"]
        }
        if ($null -ne $PSBoundParameters["SignInNames"]) {
            $params["Identities"] = $PSBoundParameters["SignInNames"]
        }
        if ($null -ne $PSBoundParameters["OutVariable"]) {
            $params["OutVariable"] = $PSBoundParameters["OutVariable"]
        }
        if ($null -ne $PSBoundParameters["UsageLocation"]) {
            $params["UsageLocation"] = $PSBoundParameters["UsageLocation"]
        }
        if ($null -ne $PSBoundParameters["PreferredLanguage"]) {
            $params["PreferredLanguage"] = $PSBoundParameters["PreferredLanguage"]
        }
        if ($null -ne $PSBoundParameters["TelephoneNumber"]) {
            $params["BusinessPhones"] = $PSBoundParameters["TelephoneNumber"]
        }
        if ($null -ne $PSBoundParameters["DisplayName"]) {
            $params["DisplayName"] = $PSBoundParameters["DisplayName"]
        }
        if ($null -ne $PSBoundParameters["OtherMails"]) {
            $params["OtherMails"] = $PSBoundParameters["OtherMails"]
        }
        if ($null -ne $PSBoundParameters["UserState"]) {
            $params["ExternalUserState"] = $PSBoundParameters["UserState"]
        }
        if ($null -ne $PSBoundParameters["ExtensionProperty"]) {
            $params["ExtensionProperty"] = $PSBoundParameters["ExtensionProperty"]
        }
        if ($null -ne $PSBoundParameters["ProgressAction"]) {
            $params["ProgressAction"] = $PSBoundParameters["ProgressAction"]
        }
        if ($null -ne $PSBoundParameters["Surname"]) {
            $params["Surname"] = $PSBoundParameters["Surname"]
        }
        if ($null -ne $PSBoundParameters["JobTitle"]) {
            $params["JobTitle"] = $PSBoundParameters["JobTitle"]
        }
        if ($null -ne $PSBoundParameters["UserPrincipalName"]) {
            $params["UserPrincipalName"] = $PSBoundParameters["UserPrincipalName"]
        }
        if ($null -ne $PSBoundParameters["Mobile"]) {
            $params["MobilePhone"] = $PSBoundParameters["Mobile"]
        }
        if ($null -ne $PSBoundParameters["InformationAction"]) {
            $params["InformationAction"] = $PSBoundParameters["InformationAction"]
        }
        if ($null -ne $PSBoundParameters["MailNickName"]) {
            $params["MailNickName"] = $PSBoundParameters["MailNickName"]
        }
        if ($null -ne $PSBoundParameters["UserId"]) {
            $params["UserId"] = $PSBoundParameters["UserId"]
        }
        if ($null -ne $PSBoundParameters["WarningVariable"]) {
            $params["WarningVariable"] = $PSBoundParameters["WarningVariable"]
        }
        if ($null -ne $PSBoundParameters["AgeGroup"]) {
            $params["AgeGroup"] = $PSBoundParameters["AgeGroup"]
        }
        if ($null -ne $PSBoundParameters["Country"]) {
            $params["Country"] = $PSBoundParameters["Country"]
        }
        if ($null -ne $PSBoundParameters["IsCompromised"]) {
            $params["IsCompromised"] = $PSBoundParameters["IsCompromised"]
        }

        Write-Debug("============================ TRANSFORMATIONS ============================")
        $params.Keys | ForEach-Object { "$_ : $($params[$_])" } | Write-Debug
        Write-Debug("=========================================================================`n")
    
        $response = Update-MgBetaUser @params -Headers $customHeaders
        $response | ForEach-Object {
            if ($null -ne $_) {
                Add-Member -InputObject $_ -MemberType AliasProperty -Name ObjectId -Value Id

            }
        }
        $response
    }
}

