
# ------------------------------------------------------------------------------ 
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  
#  Licensed under the MIT License.  See License in the project root for license information. 
# ------------------------------------------------------------------------------ 

function Update-EntraInvitedUserSponsorsFromInvitedBy {
    [CmdletBinding(SupportsShouldProcess,
        ConfirmImpact = 'High',
        DefaultParameterSetName = 'AllInvitedGuests')]
    param (

        # UserId of Guest User
        [Parameter(ParameterSetName = 'ByUsers')]
        [String[]]
        $UserId,
        # Enumerate and Update All Guest Users.
        [Parameter(ParameterSetName = 'AllInvitedGuests')]
        [switch]
        $All
    )

    begin {
       
        ## Initialize Critical Dependencies
        $CriticalError = $null
        if (!(Test-EntraCommandPrerequisites 'Get-Mguser', 'Update-Mguser' -MinimumVersion 2.8.0 -ErrorVariable CriticalError)) { return }

        $guestFilter = "(CreationType eq 'Invitation')"
    }

    process {

        $customHeaders = New-EntraCustomHeaders -Command $MyInvocation.MyCommand

        if ($CriticalError) { return }
        if ($null -eq $UserId -and !$All) {
            Write-Error "Please specify either -UserId or -All"
            return
        }

        if ($All) {
            $InvitedUsers = Get-MgUser -Filter $guestFilter -All -ExpandProperty Sponsors
        }
        else {
            foreach ($user in $userId) {
                $InvitedUsers += Get-MgUser -UserId $user -ExpandProperty Sponsors
            }
        }

        if ($null -eq $InvitedUsers) {
            Write-Error "No guest users to process"
        }
        else {
            foreach ($InvitedUser in $InvitedUsers) {
                $invitedBy = $null

                $splatArgumentsGetInvitedBy = @{
                    Method = 'Get'
                    Uri    = ((Get-MgEnvironment -Name (Get-MgContext).Environment).GraphEndpoint +
                        "/v1.0/users/" + $InvitedUser.Id + "/invitedBy")
                }

                $invitedBy = Invoke-MgGraphRequest @splatArgumentsGetInvitedBy -Headers $customHeaders

                Write-Verbose ($invitedBy | ConvertTo-Json -Depth 10)

                if ($null -ne $invitedBy -and $null -ne $invitedBy.value -and $null -ne (Get-ObjectPropertyValue $invitedBy.value -Property 'id')) {
                    Write-Verbose ("InvitedBy for Guest User {0}: {1}" -f $InvitedUser.DisplayName, $invitedBy.value.id)

                    if (($null -like $InvitedUser.Sponsors) -or ($InvitedUser.Sponsors.id -notcontains $invitedBy.value.id)) {
                        Write-Verbose "Sponsors does not contain the user who invited them!"

                        if ($PSCmdlet.ShouldProcess(("$($InvitedUser.displayName) ($($InvitedUser.UserPrincipalName) - $($InvitedUser.id))"), "Update Sponsors")) {
                            try {
                                $sponsorUrl = ("https://graph.microsoft.com/v1.0/users/{0}" -f $invitedBy.value.id)
                                $dirObj = @{"sponsors@odata.bind" = @($sponsorUrl) }
                                $sponsorsRequestBody = $dirObj | ConvertTo-Json

                                Update-MgUser -UserId $InvitedUser.Id -BodyParameter $sponsorsRequestBody -Header $customHeaders
                                Write-Output "$($InvitedUser.UserPrincipalName) - Sponsor updated succesfully for this user."
                            }
                            catch {
                                Write-Output "$($InvitedUser.UserPrincipalName) - Failed updating sponsor for this user."
                                Write-Error $_
                            }
                        }
                    }
                    else {
                        Write-Output "$($InvitedUser.UserPrincipalName) - Sponsor already exists for this user."
                    }
                }
                else {
                    Write-Output "$($InvitedUser.UserPrincipalName) - Invited user information not available for this user."
                }
            }
        }
    }

    end {
        Write-Verbose "Complete!"
    }
}

