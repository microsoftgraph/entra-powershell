# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

function Get-EntraUserInactiveSignIn {
    [CmdletBinding()]
    [OutputType([string])]
    param (
        # User Last Sign In Activity is before Days ago
        [Parameter(Mandatory = $true, ValueFromPipeline = $true)]
        [Alias("LastSignInBeforeDaysAgo")]
        [int] $Ago = 30,
        # Return results for All, Member, or Guest userTypes
        [ValidateSet("All", "Member", "Guest")]
        [string]
        $UserType = "All"
    )

    process {
        if ($CriticalError) { return }

        $customHeaders = New-EntraCustomHeaders -Command $MyInvocation.MyCommand

        foreach ($param in @("Debug", "WarningVariable", "InformationVariable", "InformationAction", "OutVariable", "OutBuffer", "ErrorVariable", "PipelineVariable", "ErrorAction", "WarningAction")) {
            if ($PSBoundParameters.ContainsKey($param)) {
                $params[$param] = $PSBoundParameters[$param]
            }
        }

        $queryDate = (Get-Date).AddDays(-$Ago).ToString("yyyy-MM-ddTHH:mm:ssZ")
        $inactiveFilter = "(signInActivity/lastSignInDateTime le '$queryDate')"

        Write-Debug ("Retrieving Users with Filter {0}" -f $inactiveFilter)
        $queryUsers = Get-MgUser -Headers $customHeaders -Filter $inactiveFilter -All:$true  -Property signInActivity, UserPrincipalName, Id, DisplayName, mail, userType, createdDateTime, accountEnabled

        $users = if ($UserType -eq "All") {
            $queryUsers
        }
        else {
            $queryUsers | Where-Object { $_.userType -eq $UserType }
        }

        foreach ($userObject in $users) {
            $checkedUser = [ordered] @{
                UserID                            = $userObject.Id
                DisplayName                       = $userObject.DisplayName
                UserPrincipalName                 = $userObject.UserPrincipalName
                Mail                              = $userObject.Mail
                UserType                          = $userObject.UserType
                AccountEnabled                    = $userObject.AccountEnabled
                LastSignInDateTime                = $userObject.signInActivity.LastSignInDateTime ?? "Unknown"
                LastSigninDaysAgo                 = if ($null -eq $userObject.signInActivity.LastSignInDateTime) { "Unknown" } else { (New-TimeSpan -Start $userObject.signInActivity.LastSignInDateTime -End (Get-Date)).Days }
                lastSignInRequestId               = $userObject.signInActivity.lastSignInRequestId ?? "Unknown"
                lastNonInteractiveSignInDateTime  = $userObject.signInActivity.lastNonInteractiveSignInDateTime ?? "Unknown"
                LastNonInteractiveSigninDaysAgo   = if ($null -eq $userObject.signInActivity.lastNonInteractiveSignInDateTime) { "Unknown" } else { (New-TimeSpan -Start $userObject.signInActivity.lastNonInteractiveSignInDateTime -End (Get-Date)).Days }
                lastNonInteractiveSignInRequestId = $userObject.signInActivity.lastNonInteractiveSignInRequestId ?? "Unknown"
                CreatedDateTime                   = $userObject.CreatedDateTime ?? "Unknown"
                CreatedDaysAgo                    = if ($null -eq $userObject.CreatedDateTime) { "Unknown" } else { (New-TimeSpan -Start $userObject.CreatedDateTime -End (Get-Date)).Days }
            }

            Write-Output [PSCustomObject]$checkedUser
        }
    }

    end {
        if ($CriticalError) { return }
    }
}