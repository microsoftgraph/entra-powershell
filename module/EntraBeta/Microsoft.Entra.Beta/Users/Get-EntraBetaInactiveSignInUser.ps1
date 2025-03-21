# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

function Get-EntraBetaInactiveSignInUser {
    [CmdletBinding()]
    [OutputType([string])]
    param (
        # User Last Sign In Activity is before Days ago
        [Parameter(Mandatory = $true, ValueFromPipeline = $true, Position = 1)]
        [Alias("BeforeDaysAgo")]
        [int] $LastSignInBeforeDaysAgo = 30,
        # Return results for All, Member, or Guest userTypes
        [ValidateSet("All", "Member", "Guest")]
        [string]
        $UserType = "All"
    )

    process {

        $customHeaders = New-EntraBetaCustomHeaders -Command $MyInvocation.MyCommand 
        $queryDate = Get-Date (Get-Date).AddDays($(0 - $LastSignInBeforeDaysAgo)) -UFormat %Y-%m-%dT00:00:00Z

        $inactiveFilter = ("(signInActivity/lastSignInDateTime le {0})" -f $queryDate)

        $queryFilter = $inactiveFilter

        # Using Date scope here, since conflict with service side odata filter on userType.
        Write-Debug ("Retrieving Users with Filter {0}" -f $queryFilter)
        $queryUsers = Get-MgBetaUser -Filter $queryFilter -All:$true -Property signInActivity, UserPrincipalName, Id, DisplayName, mail, userType, createdDateTime, accountEnabled -Headers $customHeaders

        switch ($UserType) {
            "Member" {
                $users = $queryUsers | Where-Object -FilterScript { $_.userType -eq 'Member' }
            }
            "Guest" {
                $users = $queryUsers | Where-Object -FilterScript { $_.userType -eq 'Guest' }

            }
            "All" {
                $users = $queryUsers
            }
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
                If ($null -eq $userObject.signInActivity.lastNonInteractiveSignInDateTime){
                    $checkedUser.lastNonInteractiveSignInDateTime = "Unknown"
                    $checkedUser.LastNonInteractiveSigninDaysAgo = "Unknown"

                } else {
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

            Write-Output ([PSCustomObject]$checkedUser)
        }

    }
}

