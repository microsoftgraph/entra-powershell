# ------------------------------------------------------------------------------ 
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  
#  Licensed under the MIT License.  See License in the project root for license information. 
# ------------------------------------------------------------------------------ 
function Update-EntraBetaInvitedUserSponsorsFromInvitedBy {
    [CmdletBinding(SupportsShouldProcess,
        ConfirmImpact = 'High',
        DefaultParameterSetName = 'AllInvitedGuests')]
    param (
        [Parameter(ParameterSetName = 'ByUsers', HelpMessage = "The Unique ID of the User (User ID).")]
        [String[]] $UserId,

        [Parameter(ParameterSetName = 'AllInvitedGuests', HelpMessage = "A Flag indicating whether to include all invited guests.")]
        [switch] $All
    )

    process {
        $guestFilter = "(CreationType eq 'Invitation')"
        $expand = "sponsors"
        $customHeaders = New-EntraBetaCustomHeaders -Command $MyInvocation.MyCommand
        $environment = (Get-EntraContext).Environment
        $baseUri = (Get-EntraEnvironment -Name $environment).GraphEndpoint

        if ((-not $UserId -or $UserId.Count -eq 0) -and -not $All) {
            throw "Please specify either -UserId or -All"
        }

        $invitedUsers = @()
       $uri = "$baseUri/beta/users?`$filter=$guestFilter&`$expand=sponsors"

        if ($All) {
            $invitedUsers = (Invoke-GraphRequest -Method GET -Uri $uri).value
        }
        else {
            foreach ($user in $UserId) {
                $userUri = $baseUri+"/beta/users/$user`?\$expand=sponsors"
                $invitedUsers += (Invoke-GraphRequest -Method GET -Uri $userUri).value
            }
        }

        if (-not $invitedUsers) {
            Write-Error "No guest users to process"
            return
        }

        foreach ($invitedUser in $invitedUsers) {
            $invitedByUri = "$baseUri/beta/users/$($invitedUser.id)/invitedBy"
            $invitedBy = Invoke-GraphRequest -Method GET -Uri $invitedByUri -Headers $customHeaders

            Write-Verbose ($invitedBy | ConvertTo-Json -Depth 10)

            if ($invitedBy -and $invitedBy.value -and $invitedBy.value.id) {
                $inviterId = $invitedBy.value.id
                Write-Verbose ("InvitedBy for Guest User {0}: {1}" -f $invitedUser.displayName, $inviterId)

                # Get current sponsors
                $currentSponsorIds = @()
                if ($invitedUser.sponsors) {
                    foreach ($s in $invitedUser.sponsors) {
                        if ($s.id) {
                            $currentSponsorIds += $s.id
                        }
                    }
                }

                if (-not ($currentSponsorIds -contains $inviterId)) {
                    Write-Verbose "Sponsors does not contain the user who invited them!"

                    if ($PSCmdlet.ShouldProcess("$($invitedUser.displayName) ($($invitedUser.userPrincipalName) - $($invitedUser.id))", "Update Sponsors")) {
                        try {
                            $sponsorUrl = "https://graph.microsoft.com/beta/users/$inviterId"
                            $dirObj = @{
                                "sponsors@odata.bind" = @($sponsorUrl)
                            }
                            $sponsorsRequestBody = $dirObj | ConvertTo-Json -Depth 5

                            $updateSponsorUri = $baseUri+"/beta/users/$($invitedUser.Id)"
                            Invoke-GraphRequest -Method PATCH -Uri $updateSponsorUri -Body $sponsorsRequestBody -Headers $customHeaders -ContentType "application/json"

                            Write-Output "$($invitedUser.userPrincipalName) - Sponsor updated successfully."
                        }
                        catch {
                            $errorMessage = $_.Exception.Message
                            $responseContent = $_.ErrorDetails

                            if ($responseContent -match "One or more added object references already exist for the following modified properties: 'sponsors'" -or $responseContent -match "One or more added object references already exist for the following modified properties: 'sponsors'") {
                                Write-Warning "$($invitedUser.userPrincipalName) - Sponsor already set. Skipping."
                            }
                            elseif ($_.Exception.Response.StatusCode.Value__ -eq 400) {
                                Write-Warning "$($invitedUser.userPrincipalName) - Bad request: $responseContent"
                            }
                            else {
                                Write-Error "$($invitedUser.userPrincipalName) - Unexpected error: $errorMessage"
                            }
                        }
                    }
                }
                else {
                    Write-Output "$($invitedUser.userPrincipalName) - Sponsor already exists."
                }
            }
            else {
                Write-Output "$($invitedUser.userPrincipalName) - InvitedBy info not found."
            }
        }
    }

    end {
        Write-Verbose "Complete!"
    }
}



