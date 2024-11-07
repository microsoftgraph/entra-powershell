# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

function Get-EntraUserInactiveSignIn {
    [CmdletBinding(DefaultParameterSetName = 'GetQuery')]
    [OutputType([string])]
    param (
        # User Last Sign In Activity is before Days ago
        [Parameter(Mandatory = $true, ValueFromPipeline = $true, HelpMessage = "Number of days to check for Last Sign In Activity")]
        [Alias("LastSignInBeforeDaysAgo")]
        [int] $Ago,
        # Return results for All, Member, or Guest userTypes
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
        $queryUsers = Get-MgUser -Filter $queryFilter -Pagesize 999 -All:$true  -Property signInActivity, UserPrincipalName, Id, DisplayName, mail, userType, createdDateTime, accountEnabled -Headers $customHeaders 

        $users = if ($UserType -eq "All") {
            $queryUsers
        }
        else {
            $queryUsers | Where-Object { $_.userType -eq $UserType }
        }

        foreach ($userObject in $users) {
            $checkedUser = [ordered] @{}
            $checkedUser.UserID = $userObject.Id
            $checkedUser.DisplayName = $userObject.DisplayName
            $checkedUser.UserPrincipalName = $userObject.UserPrincipalName
            $checkedUser.Mail = $userObject.Mail
            $checkedUser.UserType = $userObject.UserType
            $checkedUser.AccountEnabled = $userObject.AccountEnabled

            If ($null -eq $userObject.signInActivity.LastSignInDateTime) {
                $checkedUser.LastSignInDateTime = "Unknown"
                $checkedUser.LastSigninDaysAgo = "Unknown"
                $checkedUser.lastNonInteractiveSignInDateTime = "Unknown"
            }
            else {
                $checkedUser.LastSignInDateTime = $userObject.signInActivity.LastSignInDateTime
                $checkedUser.LastSigninDaysAgo = (New-TimeSpan -Start $checkedUser.LastSignInDateTime -End (Get-Date)).Days
                $checkedUser.lastSignInRequestId = $userObject.signInActivity.lastSignInRequestId

                #lastNonInteractiveSignInDateTime is NULL
                If ($null -eq $userObject.signInActivity.lastNonInteractiveSignInDateTime) {
                    $checkedUser.lastNonInteractiveSignInDateTime = "Unknown"
                    $checkedUser.LastNonInteractiveSigninDaysAgo = "Unknown"

                }
                else {
                    $checkedUser.lastNonInteractiveSignInDateTime = $userObject.signInActivity.lastNonInteractiveSignInDateTime
                    $checkedUser.LastNonInteractiveSigninDaysAgo = (New-TimeSpan -Start $checkedUser.lastNonInteractiveSignInDateTime -End (Get-Date)).Days
                    $checkedUser.lastNonInteractiveSignInRequestId = $userObject.signInActivity.lastNonInteractiveSignInRequestId
                }
            }
            If ($null -eq $userObject.CreatedDateTime) {
                $checkedUser.CreatedDateTime = "Unknown"
                $checkedUser.CreatedDaysAgo = "Unknown"
            }
            else {
                $checkedUser.CreatedDateTime = $userObject.CreatedDateTime
                $checkedUser.CreatedDaysAgo = (New-TimeSpan -Start $userObject.CreatedDateTime -End (Get-Date)).Days
            }

            Write-Output ([pscustomobject]$checkedUser)
        }
    }

}