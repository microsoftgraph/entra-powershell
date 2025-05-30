# ------------------------------------------------------------------------------ 
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  
#  Licensed under the MIT License.  See License in the project root for license information. 
# ------------------------------------------------------------------------------ 
function Set-EntraBetaApplicationProxyApplicationSingleSignOn {
    [CmdletBinding(DefaultParameterSetName = 'Default')]
    param (
        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = "Unique ID of the application object (Application Object ID).")]
        [ValidateNotNullOrEmpty()]
        [Alias("ObjectId")]
        [System.String] $ApplicationId,

        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = "The single sign-on mode to set for the application. For example, 'none', 'headerbased', 'saml', 'oAuth2IdToken', 'oAuth2AccessToken', 'oAuth2IdTokenAndAccessToken', 'oAuth2ClientCredentials', 'oAuth2ClientCredentialsAndIdToken'")]
        [ValidateNotNullOrEmpty()]
        [System.String] $SingleSignOnMode,

        [Parameter(Mandatory = $false, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = "The identity type for Kerberos delegation. For example, 'servicePrincipalName', 'userPrincipalName', 'userId'")]
        [System.String] $KerberosDelegatedLoginIdentity,

        [Parameter(Mandatory = $false, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = "The service principal name for Kerberos delegation. For example, 'HTTP/contoso.com'")]
        [String] $KerberosInternalApplicationServicePrincipalName
    )

    PROCESS {
        $params = @{}
        $customHeaders = New-EntraBetaCustomHeaders -Command $MyInvocation.MyCommand
        $params["Method"] = "PATCH"
        $body = @{}
        if ($null -ne $PSBoundParameters["ApplicationId"]) {
            $params["Uri"] = "/beta/applications/$ApplicationId"
        }
        if ($null -ne $PSBoundParameters["SingleSignOnMode"]) {
            $SingleSignOnMode = $PSBoundParameters["SingleSignOnMode"]
            $SingleSignOnMode = $SingleSignOnMode.Substring(0, 1).ToLower() + $SingleSignOnMode.Substring(1)
        }
        if ($null -ne $PSBoundParameters["KerberosDelegatedLoginIdentity"]) {
            $KerberosDelegatedLoginIdentity = $PSBoundParameters["KerberosDelegatedLoginIdentity"]
            $KerberosDelegatedLoginIdentity = $KerberosDelegatedLoginIdentity.Substring(0, 1).ToLower() + $KerberosDelegatedLoginIdentity.Substring(1)
        }
        if ($null -ne $PSBoundParameters["KerberosInternalApplicationServicePrincipalName"]) {
            $KerberosInternalApplicationServicePrincipalName = $PSBoundParameters["KerberosInternalApplicationServicePrincipalName"]
            $KerberosInternalApplicationServicePrincipalName = $KerberosInternalApplicationServicePrincipalName.Substring(0, 1).ToLower() + $KerberosInternalApplicationServicePrincipalName.Substring(1)
        }
        $body = @{
            onPremisesPublishing = @{
                singleSignOnSettings = @{
                    singleSignOnMode = $SingleSignOnMode
                }
            }
        }

        if (-not [string]::IsNullOrWhiteSpace($KerberosInternalApplicationServicePrincipalName) -or -not [string]::IsNullOrWhiteSpace($KerberosDelegatedLoginIdentity) -and ($SingleSignOnMode -ne 'none' -and $SingleSignOnMode -ne 'headerbased')) {
            if ($KerberosInternalApplicationServicePrincipalName -eq '') {
                Write-Error "Set-EntraBetaApplicationProxyApplicationSingleSignOn : KerberosInternalApplicationServicePrincipalName is a required field for kerberos mode."
                break
            }
            elseif ($KerberosDelegatedLoginIdentity -eq '') {
                Write-Error "Set-EntraBetaApplicationProxyApplicationSingleSignOn : KerberosDelegatedLoginIdentity is a required field for kerberos mode."
                break
            }
            $body.onPremisesPublishing.singleSignOnSettings.kerberosSignOnSettings = @{
                kerberosServicePrincipalName       = $KerberosInternalApplicationServicePrincipalName
                kerberosSignOnMappingAttributeType = $KerberosDelegatedLoginIdentity
            }
        }

        $body = $body | ConvertTo-Json -Depth 10

        Write-Debug("============================ TRANSFORMATIONS ============================")
        $params.Keys | ForEach-Object { "$_ : $($params[$_])" } | Write-Debug
        Write-Debug("=========================================================================`n")

        Invoke-GraphRequest -Headers $customHeaders -Method $params.method -Uri $params.uri -Body $body -ContentType "application/json"
    }
}

