# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.
#  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

function Get-EntraBetaUserInactiveSignIn {
    [CmdletBinding(DefaultParameterSetName = 'GetQuery')]
    [OutputType([string])]
    param (
        # User Last Sign In Activity is before Days ago
        [Parameter(
            Mandatory = $true, 
            ValueFromPipeline = $true, 
            HelpMessage = "Number of days to check for Last Sign In Activity"
        )]
        [Alias("LastSignInBeforeDaysAgo")]
        [int] 
        $Ago,

        # Return results for All, Member, or Guest userTypes
        [Parameter(
            HelpMessage = "Specifies the type of user to filter. Choose 'All' for all users, 'Member' for internal users, or 'Guest' for external users."
        )]
        [ValidateSet("All", "Member", "Guest")]
        [System.String]
        $UserType = "All"
    )

    begin {
        # Ensure connection to Microsoft Entra
        if (-not (Get-EntraContext)) {
            $errorMessage = "Not connected to Microsoft Graph. Use 'Connect-Entra -Scopes User.Read.All, AuditLog.Read.All' to authenticate."
            Write-Error -Message $errorMessage -ErrorAction Stop
            return
        }
    }

    process {
        $Params = @{}
        $CustomHeaders = New-EntraBetaCustomHeaders -Command $MyInvocation.MyCommand

        foreach ($Param in @("Debug", "WarningVariable", "InformationVariable", "InformationAction", "OutVariable", "OutBuffer", "ErrorVariable", "PipelineVariable", "ErrorAction", "WarningAction")) {
            if ($PSBoundParameters.ContainsKey($Param)) {
                $Params[$Param] = $PSBoundParameters[$Param]
            }
        }

        $QueryDate = Get-Date (Get-Date).AddDays($(0 - $Ago)) -UFormat %Y-%m-%dT00:00:00Z
        $QueryFilter = ("(signInActivity/lastSignInDateTime le {0})" -f $QueryDate)

        Write-Debug ("Retrieving Users with Filter {0}" -f $QueryFilter)

        Write-Debug("============================ TRANSFORMATIONS ============================")
        $Params.Keys | ForEach-Object { "$_ : $($Params[$_])" } | Write-Debug
        Write-Debug("=========================================================================`n")
        
        $QueryUsers = Get-MgBetaUser -Filter $QueryFilter -PageSize 999 -All -Property signInActivity, UserPrincipalName, Id, DisplayName, Mail, UserType, CreatedDateTime, AccountEnabled -Headers $CustomHeaders 

        $Users = if ($UserType -eq "All") {
            $QueryUsers
        }
        else {
            $QueryUsers | Where-Object { $_.UserType -eq $UserType }
        }

        foreach ($UserObject in $Users) {
            $CheckedUser = [ordered] @{
                UserID                            = $UserObject.Id
                DisplayName                       = $UserObject.DisplayName
                UserPrincipalName                 = $UserObject.UserPrincipalName
                Mail                              = $UserObject.Mail
                UserType                          = $UserObject.UserType
                AccountEnabled                    = $UserObject.AccountEnabled
                LastSignInDateTime                = $UserObject.SignInActivity.LastSignInDateTime
                LastSigninDaysAgo                 = if ($null -eq $UserObject.SignInActivity.LastSignInDateTime) { "Unknown" } else { (New-TimeSpan -Start $UserObject.SignInActivity.LastSignInDateTime -End (Get-Date)).Days }
                LastSignInRequestId               = $UserObject.SignInActivity.LastSignInRequestId
                LastNonInteractiveSignInDateTime  = if ($null -eq $UserObject.SignInActivity.LastNonInteractiveSignInDateTime) { "Unknown" } else { $UserObject.SignInActivity.LastNonInteractiveSignInDateTime }
                LastNonInteractiveSigninDaysAgo   = if ($null -eq $UserObject.SignInActivity.LastNonInteractiveSignInDateTime) { "Unknown" } else { (New-TimeSpan -Start $UserObject.SignInActivity.LastNonInteractiveSignInDateTime -End (Get-Date)).Days }
                LastNonInteractiveSignInRequestId = $UserObject.SignInActivity.LastNonInteractiveSignInRequestId
                CreatedDateTime                   = if ($null -eq $UserObject.CreatedDateTime) { "Unknown" } else { $UserObject.CreatedDateTime }
                CreatedDaysAgo                    = if ($null -eq $UserObject.CreatedDateTime) { "Unknown" } else { (New-TimeSpan -Start $UserObject.CreatedDateTime -End (Get-Date)).Days }
            }

            Write-Output ([PSCustomObject]$CheckedUser)
        }
    }
}

