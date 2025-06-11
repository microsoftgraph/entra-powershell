# ------------------------------------------------------------------------------ 
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  
#  Licensed under the MIT License.  See License in the project root for license information. 
# ------------------------------------------------------------------------------ 
function New-EntraBetaServicePrincipal {
    [CmdletBinding(DefaultParameterSetName = 'CreateServicePrincipal')]
    param (
                
        [Parameter(ParameterSetName = "CreateServicePrincipal")]
        [System.String] $ServicePrincipalType,
                
        [Parameter(ParameterSetName = "CreateServicePrincipal")]
        [System.String] $LogoutUrl,
                
        [Parameter(ParameterSetName = "CreateServicePrincipal")]
        [System.String] $DisplayName,
                
        [Parameter(ParameterSetName = "CreateServicePrincipal")]
        [System.String] $Homepage,
                
        [Parameter(ParameterSetName = "CreateServicePrincipal")]
        [System.Collections.Generic.List`1[System.String]] $ServicePrincipalNames,
                
        [Parameter(ParameterSetName = "CreateServicePrincipal")]
        [System.String] $PublisherName,
                
        [Parameter(ParameterSetName = "CreateServicePrincipal")]
        [System.Collections.Generic.List`1[System.String]] $AlternativeNames,
                
        [Parameter(ParameterSetName = "CreateServicePrincipal")]
        [System.Nullable`1[System.Boolean]] $AppRoleAssignmentRequired,
                
        [Parameter(ParameterSetName = "CreateServicePrincipal")]
        [System.Collections.Generic.List`1[System.String]] $ReplyUrls,
                
        [Parameter(ParameterSetName = "CreateServicePrincipal")]
        [System.String] $ErrorUrl,
                
        [Parameter(ParameterSetName = "CreateServicePrincipal")]
        [System.String] $AccountEnabled,
                
        [Parameter(ParameterSetName = "CreateServicePrincipal")]
        [System.Collections.Generic.List`1[Microsoft.Open.AzureAD.Model.PasswordCredential]] $PasswordCredentials,
                
        [Parameter(ParameterSetName = "CreateServicePrincipal", Mandatory = $true)]
        [System.String] $AppId,
                
        [Parameter(ParameterSetName = "CreateServicePrincipal")]
        [System.Collections.Generic.List`1[Microsoft.Open.AzureAD.Model.KeyCredential]] $KeyCredentials,
                
        [Parameter(ParameterSetName = "CreateServicePrincipal")]
        [System.String] $SamlMetadataUrl,
                
        [Parameter(ParameterSetName = "CreateServicePrincipal")]
        [System.Collections.Generic.List`1[System.String]] $Tags
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
    
        if ($null -ne $PSBoundParameters["ServicePrincipalType"]) {
            $params["ServicePrincipalType"] = $PSBoundParameters["ServicePrincipalType"]
        }
        if ($null -ne $PSBoundParameters["LogoutUrl"]) {
            $params["LogoutUrl"] = $PSBoundParameters["LogoutUrl"]
        }
        if ($null -ne $PSBoundParameters["ErrorVariable"]) {
            $params["ErrorVariable"] = $PSBoundParameters["ErrorVariable"]
        }
        if ($null -ne $PSBoundParameters["DisplayName"]) {
            $params["DisplayName"] = $PSBoundParameters["DisplayName"]
        }
        if ($null -ne $PSBoundParameters["Homepage"]) {
            $params["Homepage"] = $PSBoundParameters["Homepage"]
        }
        if ($null -ne $PSBoundParameters["WarningAction"]) {
            $params["WarningAction"] = $PSBoundParameters["WarningAction"]
        }
        if ($null -ne $PSBoundParameters["ServicePrincipalNames"]) {
            $params["ServicePrincipalNames"] = $PSBoundParameters["ServicePrincipalNames"]
        }
        if ($null -ne $PSBoundParameters["PublisherName"]) {
            $params["PublisherName"] = $PSBoundParameters["PublisherName"]
        }
        if ($null -ne $PSBoundParameters["AlternativeNames"]) {
            $params["AlternativeNames"] = $PSBoundParameters["AlternativeNames"]
        }
        if ($null -ne $PSBoundParameters["AppRoleAssignmentRequired"]) {
            $params["AppRoleAssignmentRequired"] = $PSBoundParameters["AppRoleAssignmentRequired"]
        }
        if ($null -ne $PSBoundParameters["ReplyUrls"]) {
            $params["ReplyUrls"] = $PSBoundParameters["ReplyUrls"]
        }
        if ($null -ne $PSBoundParameters["ErrorAction"]) {
            $params["ErrorAction"] = $PSBoundParameters["ErrorAction"]
        }
        if ($null -ne $PSBoundParameters["PipelineVariable"]) {
            $params["PipelineVariable"] = $PSBoundParameters["PipelineVariable"]
        }
        if ($null -ne $PSBoundParameters["ErrorUrl"]) {
            $params["ErrorUrl"] = $PSBoundParameters["ErrorUrl"]
        }
        if ($null -ne $PSBoundParameters["InformationVariable"]) {
            $params["InformationVariable"] = $PSBoundParameters["InformationVariable"]
        }
        if ($null -ne $PSBoundParameters["AccountEnabled"]) {
            $TmpValue = $PSBoundParameters["AccountEnabled"]
            $Value = $null
            
            if (-not [bool]::TryParse($TmpValue, [ref]$Value)) {
                throw 'Invalid input for AccountEnabled'
                return
            }
            $params["AccountEnabled"] = $Value
        }
        if ($PSBoundParameters.ContainsKey("Debug")) {
            $params["Debug"] = $PSBoundParameters["Debug"]
        }
        if ($null -ne $PSBoundParameters["PasswordCredentials"]) {
            $TmpValue = $PSBoundParameters["PasswordCredentials"]
            $a = @()
            $input = $TmpValue
            foreach ($v in $input) {
                $hash = @{
                    CustomKeyIdentifier = $v.CustomKeyIdentifier
                    EndDateTime         = $v.EndDate
                    SecretText          = $v.Value
                    StartDateTime       = $v.StartDate
                }
                
                $a += $hash
            }
            $Value = $a
            $params["PasswordCredentials"] = $Value
        }
        if ($null -ne $PSBoundParameters["OutBuffer"]) {
            $params["OutBuffer"] = $PSBoundParameters["OutBuffer"]
        }
        if ($null -ne $PSBoundParameters["OutVariable"]) {
            $params["OutVariable"] = $PSBoundParameters["OutVariable"]
        }
        if ($PSBoundParameters.ContainsKey("Verbose")) {
            $params["Verbose"] = $PSBoundParameters["Verbose"]
        }
        if ($null -ne $PSBoundParameters["AppId"]) {
            $params["AppId"] = $PSBoundParameters["AppId"]
        }
        if ($null -ne $PSBoundParameters["KeyCredentials"]) {
            $TmpValue = $PSBoundParameters["KeyCredentials"]
            $a = @()
            $input = $TmpValue
            foreach ($v in $input) {
                $hash = @{
                    CustomKeyIdentifier = $v.CustomKeyIdentifier
                    EndDateTime         = $v.EndDate
                    Key                 = $v.Value
                    StartDateTime       = $v.StartDate
                    Type                = $v.Type
                    Usage               = $v.Usage
                }
                
                $a += $hash
            }
            $Value = $a
            $params["KeyCredentials"] = $Value
        }
        if ($null -ne $PSBoundParameters["SamlMetadataUrl"]) {
            $params["SamlMetadataUrl"] = $PSBoundParameters["SamlMetadataUrl"]
        }
        if ($null -ne $PSBoundParameters["InformationAction"]) {
            $params["InformationAction"] = $PSBoundParameters["InformationAction"]
        }
        if ($null -ne $PSBoundParameters["WarningVariable"]) {
            $params["WarningVariable"] = $PSBoundParameters["WarningVariable"]
        }
        if ($null -ne $PSBoundParameters["ProgressAction"]) {
            $params["ProgressAction"] = $PSBoundParameters["ProgressAction"]
        }
        if ($null -ne $PSBoundParameters["Tags"]) {
            $params["Tags"] = $PSBoundParameters["Tags"]
        }

        Write-Debug("============================ TRANSFORMATIONS ============================")
        $params.Keys | ForEach-Object { "$_ : $($params[$_])" } | Write-Debug
        Write-Debug("=========================================================================`n")
    
        $response = New-MgBetaServicePrincipal @params -Headers $customHeaders
        $response | ForEach-Object {
            if ($null -ne $_) {
                Add-Member -InputObject $_ -MemberType AliasProperty -Name AppOwnerTenantId -Value AppOwnerOrganizationId
                Add-Member -InputObject $_ -MemberType AliasProperty -Name ObjectId -Value Id

            }
        }
        $response
    }
}

