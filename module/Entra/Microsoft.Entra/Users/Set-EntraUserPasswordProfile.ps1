# ------------------------------------------------------------------------------ 
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  
#  Licensed under the MIT License.  See License in the project root for license information. 
# ------------------------------------------------------------------------------ 
function Set-EntraUserPasswordProfile {
    [CmdletBinding(DefaultParameterSetName = 'Default')]
    param (         
        [Parameter(ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = "Specifies whether the user must change their password at next sign-in.")]
        [Alias('ForceChangePasswordNextLogin')]
        [System.Boolean] $ForceChangePasswordNextSignIn,
			   
        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = "Specifies the ID of a user (as a UserPrincipalName or ObjectId) in Microsoft Entra ID.")]
        [Alias('ObjectId', 'UPN', 'Identity', 'UserPrincipalName')]
        [ValidateNotNullOrEmpty()]
        [ValidateScript({
                if ($_ -match '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$' -or 
                    $_ -match '^[0-9a-fA-F]{8}-([0-9a-fA-F]{4}-){3}[0-9a-fA-F]{12}$') {
                    return $true
                }
                throw "UserId must be a valid email address or GUID."
            })]
        [System.String] $UserId,

        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = "Specifies the password for the user.")]
        [ValidateNotNullOrEmpty()]
        [System.Security.SecureString] $Password,

        [Parameter(ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = "If set to true, force the user to change their password.")]
        [Alias('EnforceChangePasswordPolicy')]
        [System.Boolean] $ForceChangePasswordNextSignInWithMfa
    )

    begin {
        # Ensure connection to Microsoft Entra
        if (-not (Get-EntraContext)) {
            $errorMessage = "Not connected to Microsoft Graph. Use 'Connect-Entra -Scopes Directory.AccessAsUser.All' to authenticate."
            Write-Error -Message $errorMessage -ErrorAction Stop
            return
        }
    }

    PROCESS {    
        $params = @{}
        $customHeaders = New-EntraCustomHeaders -Command $MyInvocation.MyCommand        
        if ($null -ne $PSBoundParameters["UserId"]) {
            $userId = $PSBoundParameters["UserId"]
        }
        if ($PSBoundParameters.ContainsKey("Verbose")) {
            $params["Verbose"] = $PSBoundParameters["Verbose"]
        }
        if ($null -ne $PSBoundParameters["Password"]) {
            $Temp = $PSBoundParameters["Password"]
            $BSTR = [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($Temp)
            $PlainPassword = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($BSTR)
        }
        if ($PSBoundParameters.ContainsKey("Debug")) {
            $params["Debug"] = $PSBoundParameters["Debug"]
        }
        if ($null -ne $PSBoundParameters["WarningVariable"]) {
            $params["WarningVariable"] = $PSBoundParameters["WarningVariable"]
        }
        if ($null -ne $PSBoundParameters["InformationVariable"]) {
            $params["InformationVariable"] = $PSBoundParameters["InformationVariable"]
        }
        if ($null -ne $PSBoundParameters["InformationAction"]) {
            $params["InformationAction"] = $PSBoundParameters["InformationAction"]
        }
        if ($null -ne $PSBoundParameters["OutVariable"]) {
            $params["OutVariable"] = $PSBoundParameters["OutVariable"]
        }
        if ($null -ne $PSBoundParameters["OutBuffer"]) {
            $params["OutBuffer"] = $PSBoundParameters["OutBuffer"]
        }
        if ($null -ne $PSBoundParameters["ErrorVariable"]) {
            $params["ErrorVariable"] = $PSBoundParameters["ErrorVariable"]
        }
        if ($null -ne $PSBoundParameters["PipelineVariable"]) {
            $params["PipelineVariable"] = $PSBoundParameters["PipelineVariable"]
        }
        if ($null -ne $PSBoundParameters["ErrorAction"]) {
            $params["ErrorAction"] = $PSBoundParameters["ErrorAction"]
        }
        if ($null -ne $PSBoundParameters["WarningAction"]) {
            $params["WarningAction"] = $PSBoundParameters["WarningAction"]
        }
        if ($null -ne $PSBoundParameters["ForceChangePasswordNextSignIn"]) {
            $ForceChangePasswordNextSignIn = $PSBoundParameters["ForceChangePasswordNextSignIn"]
        }
        if ($null -ne $PSBoundParameters["ForceChangePasswordNextSignInWithMfa"]) {
            $ForceChangePasswordNextSignInWithMfa = $PSBoundParameters["ForceChangePasswordNextSignInWithMfa"]
        }

        $PasswordProfile = @{}
        if ($null -ne $PSBoundParameters["ForceChangePasswordNextSignIn"]) { $PasswordProfile["ForceChangePasswordNextSignIn"] = $ForceChangePasswordNextSignIn }
        if ($null -ne $PSBoundParameters["ForceChangePasswordNextSignInWithMfa"]) { $PasswordProfile["ForceChangePasswordNextSignInWithMfa"] = $ForceChangePasswordNextSignInWithMfa }
        if ($null -ne $PSBoundParameters["Password"]) { $PasswordProfile["password"] = $PlainPassword }

        Write-Debug("============================ TRANSFORMATIONS ============================")
        $params.Keys | ForEach-Object { "$_ : $($params[$_])" } | Write-Debug
        Write-Debug("=========================================================================`n")
        
        $response = Update-MgUser -Headers $customHeaders -UserId $userId -PasswordProfile $PasswordProfile @params
        $response
    }     
}

Set-Alias -Name Set-EntraUserPassword -Value Set-EntraUserPasswordProfile -Scope Global -Force
