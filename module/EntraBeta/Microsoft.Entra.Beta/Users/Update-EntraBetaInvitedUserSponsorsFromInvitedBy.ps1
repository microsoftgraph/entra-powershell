# ------------------------------------------------------------------------------ 
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  
#  Licensed under the MIT License.  See License in the project root for license information. 
# ------------------------------------------------------------------------------ 
function Update-EntraBetaInvitedUserSponsorsFromInvitedBy {
    [CmdletBinding(SupportsShouldProcess,
        ConfirmImpact = 'High',
        DefaultParameterSetName = 'AllInvitedGuests')]
    param (

        # UserId of Guest User
        [Parameter(ParameterSetName = 'ByUsers', HelpMessage = "The Unique ID of the User (User ID).")]
        [ValidateScript({ ($_ -ne $null -and $_.Count -gt 0) -or $PSCmdlet.MyInvocation.BoundParameters.ContainsKey('All') })]
        [String[]]
        $UserId,

        # Enumerate and Update All Guest Users.
        [Parameter(ParameterSetName = 'AllInvitedGuests', HelpMessage = "A Flag indicating whether to include all invited guests.")]
        [switch]
        $All
    )

    begin {      
        $guestFilter = "(CreationType eq 'Invitation')"
    }

    process {

        $customHeaders = New-EntraBetaCustomHeaders -Command $MyInvocation.MyCommand

        if ($All) {
            #TODO: Change to Get-EntraBetaUser when -ExpandProperty is implemented
            $invitedUsers = Get-MgUser -Filter $guestFilter -All -ExpandProperty Sponsors
        }
        else {
            foreach ($user in $UserId) {
                  #TODO: Change to Get-EntraBetaUser when -ExpandProperty is implemented
                $invitedUsers += Get-MgUser -UserId $user -ExpandProperty Sponsors
            }
        }

        if ($null -eq $invitedUsers) {
            Write-Error "No guest users to process"
        }
        else {
            foreach ($invitedUser in $invitedUsers) {
                $invitedBy = $null

                $splatArgumentsGetInvitedBy = @{
                    Method = 'Get'
                    Uri    = ((Get-EntraEnvironment -Name (Get-EntraContext).Environment).GraphEndpoint +
                        "/beta/users/" + $invitedUser.id + "/invitedBy")
                }

                $invitedBy = Invoke-MgGraphRequest @splatArgumentsGetInvitedBy -Headers $customHeaders

                Write-Verbose ($invitedBy | ConvertTo-Json -Depth 10)

                if ($null -ne $invitedBy -and $null -ne $invitedBy.value -and $null -ne (Get-ObjectPropertyValue $invitedBy.value -Property 'id')) {
                    Write-Verbose ("InvitedBy for Guest User {0}: {1}" -f $invitedUser.displayName, $invitedBy.value.id)

                    if (($null -like $invitedUser.sponsors) -or ($invitedUser.sponsors.id -notcontains $invitedBy.value.id)) {
                        Write-Verbose "Sponsors does not contain the user who invited them!"

                        if ($PSCmdlet.ShouldProcess(("$($invitedUser.displayName) ($($invitedUser.userPrincipalName) - $($invitedUser.id))"), "Update Sponsors")) {
                            try {
                                $sponsorUrl = ("https://graph.microsoft.com/beta/users/{0}" -f $invitedBy.value.id)
                                $dirObj = @{"sponsors@odata.bind" = @($sponsorUrl) }
                                $sponsorsRequestBody = $dirObj | ConvertTo-Json

                                Set-EntraUser -UserId $invitedUser.id -BodyParameter $sponsorsRequestBody -Header $customHeaders
                                Write-Output "$($invitedUser.userPrincipalName) - Sponsor updated successfully for this user."
                            }
                            catch {
                                Write-Output "$($invitedUser.userPrincipalName) - Failed updating sponsor for this user."
                                Write-Error $_
                            }
                        }
                    }
                    else {
                        Write-Output "$($invitedUser.userPrincipalName) - Sponsor already exists for this user."
                    }
                }
                else {
                    Write-Output "$($invitedUser.userPrincipalName) - Invited user information not available for this user."
                }
            }
        }
    }

    end {
        Write-Verbose "Complete!"
    }
}

function Get-ObjectPropertyValue {
    [CmdletBinding()]
    [OutputType([psobject])]
    param (
        # Object containing property values
        [Parameter(Mandatory = $true, Position = 0, ValueFromPipeline = $true)]
        [AllowNull()]
        [psobject] $InputObjects,
        # Name of property. Specify an array of property names to tranverse nested objects.
        [Parameter(Mandatory = $true, ValueFromRemainingArguments = $true)]
        [string[]] $Property
    )

    process {
        foreach ($InputObject in $InputObjects) {
            for ($iProperty = 0; $iProperty -lt $Property.Count; $iProperty++) {
                ## Get property value
                if ($InputObject -is [hashtable]) {
                    if ($InputObject.ContainsKey($Property[$iProperty])) {
                        $PropertyValue = $InputObject[$Property[$iProperty]]
                    }
                    else { $PropertyValue = $null }
                }
                else {
                    $PropertyValue = Select-Object -InputObject $InputObject -ExpandProperty $Property[$iProperty] -ErrorAction Ignore
                    if ($null -eq $PropertyValue) { break }
                }
                ## Check for more nested properties
                if ($iProperty -lt $Property.Count - 1) {
                    $InputObject = $PropertyValue
                    if ($null -eq $InputObject) { break }
                }
                else {
                    Write-Output $PropertyValue
                }
            }
        }
    }
}

