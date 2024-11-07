# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.
#  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

function Get-EntraUserInactiveSignIn {
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

    process {
        $params = @{}
        $customHeaders = New-EntraCustomHeaders -Command $MyInvocation.MyCommand

        foreach ($param in @("Debug", "WarningVariable", "InformationVariable", "InformationAction", "OutVariable", "OutBuffer", "ErrorVariable", "PipelineVariable", "ErrorAction", "WarningAction")) {
            if ($PSBoundParameters.ContainsKey($param)) {
                $params[$param] = $PSBoundParameters[$param]
            }
        }

        $queryDate = Get-Date (Get-Date).AddDays($(0 - $Ago)) -UFormat %Y-%m-%dT00:00:00Z
        $queryFilter = ("(signInActivity/lastSignInDateTime le {0})" -f $queryDate)

        Write-Debug ("Retrieving Users with Filter {0}" -f $queryFilter)
        $queryUsers = Get-MgUser -Filter $queryFilter -PageSize 999 -All:$true -Property signInActivity, UserPrincipalName, Id, DisplayName, mail, userType, createdDateTime, accountEnabled -Headers $customHeaders 

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
                LastSignInDateTime                = $userObject.signInActivity.LastSignInDateTime
                LastSigninDaysAgo                 = if ($null -eq $userObject.signInActivity.LastSignInDateTime) { "Unknown" } else { (New-TimeSpan -Start $userObject.signInActivity.LastSignInDateTime -End (Get-Date)).Days }
                lastSignInRequestId               = $userObject.signInActivity.lastSignInRequestId
                lastNonInteractiveSignInDateTime  = if ($null -eq $userObject.signInActivity.lastNonInteractiveSignInDateTime) { "Unknown" } else { $userObject.signInActivity.lastNonInteractiveSignInDateTime }
                LastNonInteractiveSigninDaysAgo   = if ($null -eq $userObject.signInActivity.lastNonInteractiveSignInDateTime) { "Unknown" } else { (New-TimeSpan -Start $userObject.signInActivity.lastNonInteractiveSignInDateTime -End (Get-Date)).Days }
                lastNonInteractiveSignInRequestId = $userObject.signInActivity.lastNonInteractiveSignInRequestId
                CreatedDateTime                   = if ($null -eq $userObject.CreatedDateTime) { "Unknown" } else { $userObject.CreatedDateTime }
                CreatedDaysAgo                    = if ($null -eq $userObject.CreatedDateTime) { "Unknown" } else { (New-TimeSpan -Start $userObject.CreatedDateTime -End (Get-Date)).Days }
            }

            Write-Output ([pscustomobject]$checkedUser)
        }
    }
}
