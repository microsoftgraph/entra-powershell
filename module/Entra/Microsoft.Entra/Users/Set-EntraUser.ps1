# ------------------------------------------------------------------------------ 
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  
#  Licensed under the MIT License.  See License in the project root for license information. 
# ------------------------------------------------------------------------------ 
function Set-EntraUser {
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("PSAvoidUsingUserNameAndPassWordParams", "", Scope = "Function", Target = "*")]
    [CmdletBinding(DefaultParameterSetName = 'DefaultSet')]
    param (
        [Alias('ObjectId')]            
        [Parameter(ParameterSetName = "DefaultSet", Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
        [Parameter(ParameterSetName = "BodyParameter", Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
        [ValidateNotNullOrEmpty()]
        [System.String] $UserId,

        [Parameter(ParameterSetName = "DefaultSet")]
        [System.String] $State,
                
        [Parameter(ParameterSetName = "DefaultSet")]
        [System.String] $FacsimileTelephoneNumber,
                
        [Parameter(ParameterSetName = "DefaultSet")]
        [System.String] $UserType,
                
        [Parameter(ParameterSetName = "DefaultSet")]
        [System.String] $PreferredLanguage,
                
        [Parameter(ParameterSetName = "DefaultSet")]
        [System.String] $StreetAddress,
                
        [Parameter(ParameterSetName = "DefaultSet")]
        [System.String] $CreationType,
                
        [Parameter(ParameterSetName = "DefaultSet")]
        [System.String] $ImmutableId,
                
        [Parameter(ParameterSetName = "DefaultSet")]
        [System.String] $CompanyName,
                
        [Parameter(ParameterSetName = "DefaultSet")]
        [System.String] $PostalCode,
                
        [Parameter(ParameterSetName = "DefaultSet")]
        [System.String] $DisplayName,
                
        [Parameter(ParameterSetName = "DefaultSet")]
        [System.String] $ConsentProvidedForMinor,
                
        [Parameter(ParameterSetName = "DefaultSet")]
        [System.String] $Department,
                
        [Parameter(ParameterSetName = "DefaultSet")]
        [System.String] $Mobile,
                
        [Parameter(ParameterSetName = "DefaultSet")]
        [System.String] $UserStateChangedOn,
                
        [Parameter(ParameterSetName = "DefaultSet")]
        [System.String] $GivenName,
                
        [Parameter(ParameterSetName = "DefaultSet")]
        [System.String] $Country,
                
        [Parameter(ParameterSetName = "DefaultSet")]
        [System.String] $PasswordPolicies,
                
        [Parameter(ParameterSetName = "DefaultSet")]
        [Microsoft.Open.AzureAD.Model.PasswordProfile] $PasswordProfile,
                
        [Parameter(ParameterSetName = "DefaultSet")]
        [System.Collections.Generic.List`1[Microsoft.Open.AzureAD.Model.SignInName]] $SignInNames,
                
        [Parameter(ParameterSetName = "DefaultSet")]
        [System.String] $MailNickName,
                
        [Parameter(ParameterSetName = "DefaultSet")]
        [System.String] $JobTitle,
                
        [Parameter(ParameterSetName = "DefaultSet")]
        [System.String] $UserState,
                
        [Parameter(ParameterSetName = "DefaultSet")]
        [System.String] $City,
                
        [Parameter(ParameterSetName = "DefaultSet")]
        [System.String] $UsageLocation,
                
        [Parameter(ParameterSetName = "DefaultSet")]
        [System.String] $Surname,
                
        [Parameter(ParameterSetName = "DefaultSet")]
        [System.Collections.Generic.List`1[System.String]] $OtherMails,
                
        [Parameter(ParameterSetName = "DefaultSet")]
        [System.String] $UserPrincipalName,
                
        [Parameter(ParameterSetName = "DefaultSet")]
        [System.Collections.Generic.Dictionary`2[System.String, System.String]] $ExtensionProperty,
                
        [Parameter(ParameterSetName = "DefaultSet")]
        [System.String] $TelephoneNumber,
                
        [Parameter(ParameterSetName = "DefaultSet")]
        [System.String] $PhysicalDeliveryOfficeName,
                
        [Parameter(ParameterSetName = "DefaultSet")]
        [System.String] $AgeGroup,
                
        [Parameter(ParameterSetName = "DefaultSet")]
        [System.Nullable`1[System.Boolean]] $AccountEnabled,
                
        [Parameter(ParameterSetName = "DefaultSet")]
        [System.Nullable`1[System.Boolean]] $ShowInAddressList,
                
        [Parameter(ParameterSetName = "DefaultSet")]
        [System.Nullable`1[System.Boolean]] $IsCompromised,

        [Parameter(ParameterSetName = "DefaultSet")]
        [System.Collections.Hashtable] $AdditionalProperties,

        [Parameter(ParameterSetName = "BodyParameter", Mandatory = $true)]
        [System.Collections.Hashtable] $BodyParameter
    )
    begin {
        # Ensure Microsoft Entra PowerShell module is available
        if (-not (Get-Module -ListAvailable -Name Microsoft.Entra.Users)) {
            Write-Error "Microsoft.Entra.Users module is required. Install it using 'Install-Module Microsoft.Entra.Users'. See http://aka.ms/entra/ps/installation for more details."
            return
        }

        # Ensure connection to Microsoft Entra
        if (-not (Get-EntraContext)) {
            Write-Error "Not connected to Microsoft Graph. Use 'Connect-Entra -Scopes User.ReadWrite.All, Directory.AccessAsUser.All' to authenticate."
            return
        }
    }

    PROCESS {    
        $params = @{}
        $customHeaders = New-EntraCustomHeaders -Command $MyInvocation.MyCommand

        if ($PSCmdlet.ParameterSetName -eq "DefaultSet") {
            if ($null -ne $PSBoundParameters["State"]) {
                $params["State"] = $PSBoundParameters["State"]
            }
            if ($null -ne $PSBoundParameters["InformationVariable"]) {
                $params["InformationVariable"] = $PSBoundParameters["InformationVariable"]
            }
            if ($null -ne $PSBoundParameters["FacsimileTelephoneNumber"]) {
                $params["FacsimileTelephoneNumber"] = $PSBoundParameters["FacsimileTelephoneNumber"]
            }
            if ($null -ne $PSBoundParameters["UserType"]) {
                $params["UserType"] = $PSBoundParameters["UserType"]
            }
            if ($null -ne $PSBoundParameters["PreferredLanguage"]) {
                $params["PreferredLanguage"] = $PSBoundParameters["PreferredLanguage"]
            }
            if ($null -ne $PSBoundParameters["StreetAddress"]) {
                $params["StreetAddress"] = $PSBoundParameters["StreetAddress"]
            }
            if ($null -ne $PSBoundParameters["PipelineVariable"]) {
                $params["PipelineVariable"] = $PSBoundParameters["PipelineVariable"]
            }
            if ($null -ne $PSBoundParameters["CreationType"]) {
                $params["CreationType"] = $PSBoundParameters["CreationType"]
            }
            if ($null -ne $PSBoundParameters["ImmutableId"]) {
                $params["OnPremisesImmutableId"] = $PSBoundParameters["ImmutableId"]
            }
            if ($null -ne $PSBoundParameters["ProgressAction"]) {
                $params["ProgressAction"] = $PSBoundParameters["ProgressAction"]
            }
            if ($null -ne $PSBoundParameters["CompanyName"]) {
                $params["CompanyName"] = $PSBoundParameters["CompanyName"]
            }
            if ($null -ne $PSBoundParameters["ErrorAction"]) {
                $params["ErrorAction"] = $PSBoundParameters["ErrorAction"]
            }
            if ($null -ne $PSBoundParameters["PostalCode"]) {
                $params["PostalCode"] = $PSBoundParameters["PostalCode"]
            }
            if ($null -ne $PSBoundParameters["DisplayName"]) {
                $params["DisplayName"] = $PSBoundParameters["DisplayName"]
            }
            if ($null -ne $PSBoundParameters["ConsentProvidedForMinor"]) {
                $params["ConsentProvidedForMinor"] = $PSBoundParameters["ConsentProvidedForMinor"]
            }
            if ($null -ne $PSBoundParameters["Department"]) {
                $params["Department"] = $PSBoundParameters["Department"]
            }
            if ($null -ne $PSBoundParameters["Mobile"]) {
                $params["MobilePhone"] = $PSBoundParameters["Mobile"]
            }
            if ($null -ne $PSBoundParameters["UserStateChangedOn"]) {
                $params["ExternalUserStateChangeDateTime"] = $PSBoundParameters["UserStateChangedOn"]
            }
            if ($null -ne $PSBoundParameters["GivenName"]) {
                $params["GivenName"] = $PSBoundParameters["GivenName"]
            }
            if ($null -ne $PSBoundParameters["Country"]) {
                $params["Country"] = $PSBoundParameters["Country"]
            }
            if ($null -ne $PSBoundParameters["PasswordPolicies"]) {
                $params["PasswordPolicies"] = $PSBoundParameters["PasswordPolicies"]
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
            if ($null -ne $PSBoundParameters["ErrorVariable"]) {
                $params["ErrorVariable"] = $PSBoundParameters["ErrorVariable"]
            }
            if ($null -ne $PSBoundParameters["SignInNames"]) {
                $params["Identities"] = $PSBoundParameters["SignInNames"]
            }
            if ($null -ne $PSBoundParameters["OutVariable"]) {
                $params["OutVariable"] = $PSBoundParameters["OutVariable"]
            }
            if ($null -ne $PSBoundParameters["MailNickName"]) {
                $params["MailNickName"] = $PSBoundParameters["MailNickName"]
            }
            if ($null -ne $PSBoundParameters["WarningVariable"]) {
                $params["WarningVariable"] = $PSBoundParameters["WarningVariable"]
            }
            if ($null -ne $PSBoundParameters["JobTitle"]) {
                $params["JobTitle"] = $PSBoundParameters["JobTitle"]
            }
            if ($null -ne $PSBoundParameters["UserState"]) {
                $params["ExternalUserState"] = $PSBoundParameters["UserState"]
            }
            if ($null -ne $PSBoundParameters["City"]) {
                $params["City"] = $PSBoundParameters["City"]
            }
            if ($null -ne $PSBoundParameters["UsageLocation"]) {
                $params["UsageLocation"] = $PSBoundParameters["UsageLocation"]
            }
            if ($null -ne $PSBoundParameters["InformationAction"]) {
                $params["InformationAction"] = $PSBoundParameters["InformationAction"]
            }
            if ($null -ne $PSBoundParameters["Surname"]) {
                $params["Surname"] = $PSBoundParameters["Surname"]
            }
            if ($null -ne $PSBoundParameters["OtherMails"]) {
                $params["OtherMails"] = $PSBoundParameters["OtherMails"]
            }
            if ($null -ne $PSBoundParameters["UserPrincipalName"]) {
                $params["UserPrincipalName"] = $PSBoundParameters["UserPrincipalName"]
            }
            if ($null -ne $PSBoundParameters["ExtensionProperty"]) {
                $params["ExtensionProperty"] = $PSBoundParameters["ExtensionProperty"]
            }
            if ($null -ne $PSBoundParameters["OutBuffer"]) {
                $params["OutBuffer"] = $PSBoundParameters["OutBuffer"]
            }
            if ($PSBoundParameters.ContainsKey("Verbose")) {
                $params["Verbose"] = $PSBoundParameters["Verbose"]
            }
            if ($PSBoundParameters.ContainsKey("Debug")) {
                $params["Debug"] = $PSBoundParameters["Debug"]
            }
            if ($null -ne $PSBoundParameters["TelephoneNumber"]) {
                $params["BusinessPhones"] = $PSBoundParameters["TelephoneNumber"]
            }
            if ($null -ne $PSBoundParameters["PhysicalDeliveryOfficeName"]) {
                $params["PhysicalDeliveryOfficeName"] = $PSBoundParameters["PhysicalDeliveryOfficeName"]
            }
            if ($null -ne $PSBoundParameters["AgeGroup"]) {
                $params["AgeGroup"] = $PSBoundParameters["AgeGroup"]
            }
            if ($null -ne $PSBoundParameters["WarningAction"]) {
                $params["WarningAction"] = $PSBoundParameters["WarningAction"]
            }
            if ($null -ne $PSBoundParameters["AccountEnabled"]) {
                $params["AccountEnabled"] = $PSBoundParameters["AccountEnabled"]
            }
            if ($null -ne $PSBoundParameters["ShowInAddressList"]) {
                $params["ShowInAddressList"] = $PSBoundParameters["ShowInAddressList"]
            }
            if ($null -ne $PSBoundParameters["UserId"]) {
                $params["UserId"] = $PSBoundParameters["UserId"]
            }
            if ($null -ne $PSBoundParameters["IsCompromised"]) {
                $params["IsCompromised"] = $PSBoundParameters["IsCompromised"]
            }

            # Add additional properties if provided
            if ($null -ne $PSBoundParameters["AdditionalProperties"]) {
                foreach ($key in $AdditionalProperties.Keys) {
                    $params[$key] = $AdditionalProperties[$key]
                }
            }
        }
        elseif ($PSCmdlet.ParameterSetName -eq "BodyParameter") {
            $params = $BodyParameter
        }

        Write-Debug("============================ TRANSFORMATIONS ============================")
        $params.Keys | ForEach-Object { "$_ : $($params[$_])" } | Write-Debug
        Write-Debug("=========================================================================`n")
    
        $response = Update-MgUser -UserId $UserId @params -Headers $customHeaders
        $response | ForEach-Object {
            if ($null -ne $_) {
                Add-Member -InputObject $_ -MemberType AliasProperty -Name ObjectId -Value Id
            }
        }
        $response
    }
}
Set-Alias -Name Update-EntraUser -Value Set-EntraUser -Scope Global -Force