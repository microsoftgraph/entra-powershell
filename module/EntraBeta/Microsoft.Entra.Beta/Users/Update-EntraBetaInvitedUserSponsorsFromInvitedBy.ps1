function Update-EntraBetaInvitedUserSponsorsFromInvitedBy {
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
        function Test-MgCommandPrerequisites {
            [CmdletBinding()]
            [OutputType([bool])]
            param (
                # The name of a command.
                [Parameter(Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, Position = 1)]
                [Alias('Command')]
                [string[]] $Name,
                # The service API version.
                [Parameter(Mandatory = $false, Position = 2)]
                [ValidateSet('v1.0')]
                [string] $ApiVersion = 'v1.0',
                # Specifies a minimum version.
                [Parameter(Mandatory = $false)]
                [version] $MinimumVersion,
                # Require "list" permissions rather than "get" permissions when Get-Mg* commands are specified.
                [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
                [switch] $RequireListPermissions
            )

            begin {
                [version] $MgAuthenticationModuleVersion = $null
                $Assembly = [System.AppDomain]::CurrentDomain.GetAssemblies() | Where-Object FullName -Like "Microsoft.Graph.Authentication,*"
                if ($Assembly.FullName -match "Version=(([0-9]+.[0-9]+.[0-9]+).[0-9]+),") {
                    $MgAuthenticationModuleVersion = $Matches[2]
                }
                else {
                    $MgAuthenticationModuleVersion = Get-Command 'Connect-MgGraph' -Module 'Microsoft.Graph.Authentication' | Select-Object -ExpandProperty Version
                }
                Write-Debug "Microsoft.Graph.Authentication module version loaded: $MgAuthenticationModuleVersion"
            }

            process {
                ## Initialize
                $result = $true

                ## Get Graph Command Details
                [hashtable] $MgCommandLookup = @{}
                foreach ($CommandName in $Name) {

                    [array] $MgCommands = Find-MgGraphCommand -Command $CommandName -ApiVersion $ApiVersion

                    if ($MgCommands.Count -eq 1) {
                        $MgCommand = $MgCommands[0]
                    }
                    elseif ($MgCommands.Count -gt 1) {
                        $MgCommand = $MgCommands[0]
                        ## Resolve from multiple results
                        [array] $MgCommandsWithPermissions = $MgCommands | Where-Object Permissions -NE $null
                        [array] $MgCommandsWithListPermissions = $MgCommandsWithPermissions | Where-Object URI -NotLike "*}"
                        [array] $MgCommandsWithGetPermissions = $MgCommandsWithPermissions | Where-Object URI -Like "*}"
                        if ($MgCommandsWithListPermissions -and $RequireListPermissions) {
                            $MgCommand = $MgCommandsWithListPermissions[0]
                        }
                        elseif ($MgCommandsWithGetPermissions) {
                            $MgCommand = $MgCommandsWithGetPermissions[0]
                        }
                        else {
                            $MgCommand = $MgCommands[0]
                        }
                    }

                    if ($MgCommand) {
                        $MgCommandLookup[$MgCommand.Command] = $MgCommand
                    }
                    else {
                        Write-Error "Unable to resolve a specific command for '$CommandName'."
                    }
                }

                ## Import Required Modules
                [string[]] $MgModules = @()
                foreach ($MgCommand in $MgCommandLookup.Values) {
                    if (!$MgModules.Contains($MgCommand.Module)) {
                        $MgModules += $MgCommand.Module
                        [string] $ModuleName = "Microsoft.Graph.$($MgCommand.Module)"
                        try {
                            if ($MgAuthenticationModuleVersion -lt $MinimumVersion) {
                                ## Check for newer module but load will likely fail due to old Microsoft.Graph.Authentication module
                                try {
                                    Import-Module $ModuleName -MinimumVersion $MinimumVersion -Scope Global -ErrorAction Stop -Verbose:$false
                                }
                                catch [System.IO.FileLoadException] {
                                    $result = $false
                                    Write-Error -Exception $_.Exception -Category ResourceUnavailable -ErrorId 'MgModuleOutOfDate' -Message ("The module '{0}' with minimum version '{1}' was found but currently loaded 'Microsoft.Graph.Authentication' module is version '{2}'. To resolve, try opening a new PowerShell session and running the command again." -f $ModuleName, $MinimumVersion, $MgAuthenticationModuleVersion) -TargetObject $ModuleName -RecommendedAction ("Import-Module {0} -MinimumVersion '{1}'" -f $ModuleName, $MinimumVersion)
                                }
                                catch [System.IO.FileNotFoundException] {
                                    $result = $false
                                    Write-Error -Exception $_.Exception -Category ResourceUnavailable -ErrorId 'MgModuleWithVersionNotFound' -Message ("The module '{0}' with minimum version '{1}' not found. To resolve, try installing module '{0}' with the latest version. For example: Install-Module {0} -MinimumVersion '{1}'" -f $ModuleName, $MinimumVersion) -TargetObject $ModuleName -RecommendedAction ("Install-Module {0} -MinimumVersion '{1}'" -f $ModuleName, $MinimumVersion)
                                }
                            }
                            else {
                                ## Load module to match currently loaded Microsoft.Graph.Authentication module
                                try {
                                    Import-Module $ModuleName -RequiredVersion $MgAuthenticationModuleVersion -Scope Global -ErrorAction Stop -Verbose:$false
                                }
                                catch [System.IO.FileLoadException] {
                                    $result = $false
                                    Write-Error -Exception $_.Exception -Category ResourceUnavailable -ErrorId 'MgModuleOutOfDate' -Message ("The module '{0}' was found but is not a compatible version. To resolve, try updating module '{0}' to version '{1}' to match currently loaded modules. For example: Update-Module {0} -RequiredVersion '{1}'" -f $ModuleName, $MgAuthenticationModuleVersion) -TargetObject $ModuleName -RecommendedAction ("Update-Module {0} -RequiredVersion '{1}'" -f $ModuleName, $MgAuthenticationModuleVersion)
                                }
                                catch [System.IO.FileNotFoundException] {
                                    $result = $false
                                    Write-Error -Exception $_.Exception -Category ResourceUnavailable -ErrorId 'MgModuleWithVersionNotFound' -Message ("The module '{0}' with version '{1}' not found. To resolve, try installing module '{0}' with version '{1}' to match currently loaded modules. For example: Install-Module {0} -RequiredVersion '{1}'" -f $ModuleName, $MgAuthenticationModuleVersion) -TargetObject $ModuleName -RecommendedAction ("Install-Module {0} -RequiredVersion '{1}'" -f $ModuleName, $MgAuthenticationModuleVersion)
                                }
                            }
                        }
                        catch {
                            $result = $false
                            Write-Error -ErrorRecord $_
                        }
                    }
                }
                Write-Verbose ('Required Microsoft Graph Modules: {0}' -f (($MgModules | ForEach-Object { "Microsoft.Graph.$_" }) -join ', '))

                ## Check MgModule Connection
                $MgContext = Get-MgContext
                if ($MgContext) {
                    if ($MgContext.AuthType -eq 'Delegated') {
                        ## Check MgModule Consented Scopes
                        foreach ($MgCommand in $MgCommandLookup.Values) {
                            if ($MgCommand.Permissions -and (!$MgContext.Scopes -or !(Compare-Object $MgCommand.Permissions.Name -DifferenceObject $MgContext.Scopes -ExcludeDifferent -IncludeEqual))) {
                                $Exception = New-Object System.Security.SecurityException -ArgumentList "Additional scope required for command '$($MgCommand.Command)', call Connect-MgGraph with one of the following scopes: $($MgCommand.Permissions.Name -join ', ')"
                                Write-Error -Exception $Exception -Category ([System.Management.Automation.ErrorCategory]::PermissionDenied) -ErrorId 'MgScopePermissionRequired'
                                $result = $false
                            }
                        }
                    }
                    else {
                        ## Check MgModule Consented Scopes
                        foreach ($MgCommand in $MgCommandLookup.Values) {
                            if ($MgCommand.Permissions -and (!$MgContext.Scopes -or !(Compare-Object $MgCommand.Permissions.Name -DifferenceObject $MgContext.Scopes -ExcludeDifferent -IncludeEqual))) {
                                Write-Warning "Additional scope may be required for command '$($MgCommand.Command), add and consent ClientId '$($MgContext.ClientId)' to one of the following app scopes: $($MgCommand.Permissions.Name -join ', ')"
                            }
                        }
                    }
                }
                else {
                    $Exception = New-Object System.Security.Authentication.AuthenticationException -ArgumentList "Authentication needed, call Connect-MgGraph."
                    Write-Error -Exception $Exception -Category ([System.Management.Automation.ErrorCategory]::AuthenticationError) -CategoryReason 'AuthenticationException' -ErrorId 'MgAuthenticationRequired'
                    $result = $false
                }

                return $result
            }
        }
        ## Initialize Critical Dependencies
        $CriticalError = $null
        if (!(Test-MgCommandPrerequisites 'Get-MgBetaUser', 'Update-MgBetaUser' -MinimumVersion 2.8.0 -ErrorVariable CriticalError)) { return }

        $guestFilter = "(CreationType eq 'Invitation')"
    }

    process {

        $customHeaders = New-EntraBetaCustomHeaders -Command $MyInvocation.MyCommand

        if ($CriticalError) { return }
        if ($null -eq $UserId -and !$All) {
            Write-Error "Please specify either -UserId or -All"
            return
        }

        if ($All) {
            $InvitedUsers = Get-MgBetaUser -Filter $guestFilter -All -ExpandProperty Sponsors
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
                        "/beta/users/" + $InvitedUser.Id + "/invitedBy")
                }

                $invitedBy = Invoke-MgGraphRequest @splatArgumentsGetInvitedBy -Headers $customHeaders

                Write-Verbose ($invitedBy | ConvertTo-Json -Depth 10)

                if ($null -ne $invitedBy -and $null -ne $invitedBy.value -and $null -ne (Get-ObjectPropertyValue $invitedBy.value -Property 'id')) {
                    Write-Verbose ("InvitedBy for Guest User {0}: {1}" -f $InvitedUser.DisplayName, $invitedBy.value.id)

                    if (($null -like $InvitedUser.Sponsors) -or ($InvitedUser.Sponsors.id -notcontains $invitedBy.value.id)) {
                        Write-Verbose "Sponsors does not contain the user who invited them!"

                        if ($PSCmdlet.ShouldProcess(("$($InvitedUser.displayName) ($($InvitedUser.UserPrincipalName) - $($InvitedUser.id))"), "Update Sponsors")) {
                            try {
                                $sponsorUrl = ("https://graph.microsoft.com/beta/users/{0}" -f $invitedBy.value.id)
                                $dirObj = @{"sponsors@odata.bind" = @($sponsorUrl) }
                                $sponsorsRequestBody = $dirObj | ConvertTo-Json

                                Update-MgUser -UserId $InvitedUser.Id -BodyParameter $sponsorsRequestBody
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

