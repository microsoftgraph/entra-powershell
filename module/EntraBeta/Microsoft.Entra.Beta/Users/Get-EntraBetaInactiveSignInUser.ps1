# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

function Get-EntraBetaInactiveSignInUser {
    [CmdletBinding()]
    [OutputType([string])]
    param (
        # User Last Sign In Activity is before Days ago
        [Parameter(ValueFromPipeline = $true, Position = 1)]
        [Alias("BeforeDaysAgo")]
        [ValidateRange(0,30)]
        [int] $LastSignInBeforeDaysAgo = 30,
        # Return results for All, Member, or Guest userTypes
        [ValidateSet("All", "Member", "Guest")]
        [string]
        $UserType = "All"
    )

    process {
        $customHeaders = New-EntraBetaCustomHeaders -Command $MyInvocation.MyCommand 
        $queryDate = (Get-Date).AddDays(-$LastSignInBeforeDaysAgo).ToString("yyyy-MM-ddTHH:mm:ssZ")
        $inactiveFilter = "(signInActivity/lastSignInDateTime le $queryDate)"

        $uri = "/beta/users?`$filter=$inactiveFilter&`$select=signInActivity,UserPrincipalName,Id,DisplayName,mail,userType,createdDateTime,accountEnabled"

        Write-Debug ("Retrieving Users with Filter {0}" -f $inactiveFilter)
        $queryUsers = (Invoke-GraphRequest -Method GET -Uri $uri -Headers $customHeaders).value

        switch ($UserType) {
            "Member" { $users = $queryUsers | Where-Object { $_.userType -eq 'Member' } }
            "Guest" { $users = $queryUsers | Where-Object { $_.userType -eq 'Guest' } }
            "All" { $users = $queryUsers }
        }

        foreach ($userObject in $users) {
            # Some objects only have the id and signInActivity properties,
            # so we need to check for the existence of UserPrincipalName and ignore them in the response
            # {
            #     "@odata.context": "https://graph.microsoft.com/v1.0/$metadata#users(id,signInActivity)/$entity",
            #     "id": "740d59d4-057f-4a6d-838b-a30bf3e31ec4",
            #     "signInActivity": {
            #         "lastSignInDateTime": "2024-08-22T04:13:19Z",
            #         "lastSignInRequestId": "bcbac647-1e81-45cb-9e45-c670173e1700",
            #         "lastNonInteractiveSignInDateTime": null,
            #         "lastNonInteractiveSignInRequestId": null,
            #         "lastSuccessfulSignInDateTime": "2024-08-22T04:13:19Z",
            #         "lastSuccessfulSignInRequestId": "bcbac647-1e81-45cb-9e45-c670173e1700"
            #     }
            # }
            if (-not($userObject.ContainsKey("UserPrincipalName"))) {
                continue
            }

            $checkedUser = [ordered] @{
                UserID = $userObject.Id
                DisplayName = $userObject.DisplayName
                UserPrincipalName = $userObject.UserPrincipalName
                Mail = $userObject.Mail
                UserType = $userObject.UserType
                AccountEnabled = $userObject.AccountEnabled
            }

            If ($null -eq $userObject.signInActivity.LastSignInDateTime) {
                $checkedUser["LastSignInDateTime"] = "Unknown"
                $checkedUser["LastSigninDaysAgo"] = "Unknown"
                $checkedUser["lastNonInteractiveSignInDateTime"] = "Unknown"
            }
            else {
                $checkedUser["LastSignInDateTime"] = $userObject.signInActivity.LastSignInDateTime
                $checkedUser["LastSigninDaysAgo"] = (New-TimeSpan -Start $checkedUser.LastSignInDateTime -End (Get-Date)).Days
                $checkedUser["lastSignInRequestId"] = $userObject.signInActivity.lastSignInRequestId

                If ($null -eq $userObject.signInActivity.lastNonInteractiveSignInDateTime) {
                    $checkedUser["lastNonInteractiveSignInDateTime"] = "Unknown"
                    $checkedUser["LastNonInteractiveSigninDaysAgo"] = "Unknown"
                } else {
                    $checkedUser["lastNonInteractiveSignInDateTime"] = $userObject.signInActivity.lastNonInteractiveSignInDateTime
                    $checkedUser["LastNonInteractiveSigninDaysAgo"] = (New-TimeSpan -Start $checkedUser.lastNonInteractiveSignInDateTime -End (Get-Date)).Days
                    $checkedUser["lastNonInteractiveSignInRequestId"] = $userObject.signInActivity.lastNonInteractiveSignInRequestId
                }
            }

            If ($null -eq $userObject.CreatedDateTime) {
                $checkedUser["CreatedDateTime"] = "Unknown"
                $checkedUser["CreatedDaysAgo"] = "Unknown"
            }
            else {
                $checkedUser["CreatedDateTime"] = $userObject.CreatedDateTime
                $checkedUser["CreatedDaysAgo"] = (New-TimeSpan -Start $userObject.CreatedDateTime -End (Get-Date)).Days
            }

            Write-Output ([PSCustomObject]$checkedUser)
        }
    }
}


