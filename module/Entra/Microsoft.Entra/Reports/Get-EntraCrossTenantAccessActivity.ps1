function Get-EntraCrossTenantAccessActivity {
    [CmdletBinding()]
    param(

        #Return events based on external tenant access direction, either 'Inbound', 'Outbound', or 'Both'
        [Parameter(Position = 0)]
        [ValidateSet('Inbound', 'Outbound')]
        [string]$AccessDirection,

        #Return events for the supplied external tenant ID
        [Parameter(Position = 1)]
        [guid]$ExternalTenantId,

        #Show summary statistics by tenant
        [switch]$SummaryStats,

        #Atemmpt to resolve the external tenant ID
        [switch]$ResolveTenantId

    )

    begin {
        ## Initialize Critical Dependencies
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

                    [array] $MgCommands = Find-MgGraphCommand -Command $CommandName -ApiVersion $ApiVersion -ErrorAction Break

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
        $CriticalError = $null
        if (!(Test-MgCommandPrerequisites 'Get-MgAuditLogSignIn' -MinimumVersion 2.8.0 -ErrorVariable CriticalError)) { return }

        #External Tenant ID check

        if ($ExternalTenantId) {

            Write-Verbose -Message "$(Get-Date -f T) - Checking supplied external tenant ID - $ExternalTenantId..."

            if ($ExternalTenantId -eq (Get-MgContext).TenantId) {

                Write-Error "$(Get-Date -f T) - Supplied external tenant ID ($ExternalTenantId) cannot match connected tenant ID ($((Get-MgContext).TenantId)))" -ErrorAction Stop

            }
            else {

                Write-Verbose -Message "$(Get-Date -f T) - Supplied external tenant ID OK"
            }

        }

    }

    process {
        ## Return Immediately On Critical Error
        if ($CriticalError) { return }

        #Get filtered sign-in logs and handle parameters

        if ($AccessDirection -eq "Outbound") {

            if ($ExternalTenantId) {

                Write-Verbose -Message "$(Get-Date -f T) - Access direction 'Outbound' selected"
                Write-Verbose -Message "$(Get-Date -f T) - Outbound: getting sign-ins for local users accessing external tenant ID - $ExternalTenantId"

                $SignIns = Get-MgAuditLogSignIn -Filter ("CrossTenantAccessType ne 'none' and ResourceTenantId eq '{0}'" -f $ExternalTenantId) -All | Group-Object ResourceTenantID

            }
            else {

                Write-Verbose -Message "$(Get-Date -f T) - Access direction 'Outbound' selected"
                Write-Verbose -Message "$(Get-Date -f T) - Outbound: getting external tenant IDs accessed by local users"

                $SignIns = Get-MgAuditLogSignIn -Filter ("CrossTenantAccessType ne 'none' and ResourceTenantId ne '{0}'" -f (Get-MgContext).TenantId) -All | Group-Object ResourceTenantID

            }

        }
        elseif ($AccessDirection -eq 'Inbound') {

            if ($ExternalTenantId) {

                Write-Verbose -Message "$(Get-Date -f T) - Access direction 'Inbound' selected"
                Write-Verbose -Message "$(Get-Date -f T) - Inbound: getting sign-ins for users accessing local tenant from external tenant ID - $ExternalTenantId"

                $SignIns = Get-MgAuditLogSignIn -Filter ("CrossTenantAccessType ne 'none' and HomeTenantId eq '{0}' and TokenIssuerType eq 'AzureAD'" -f $ExternalTenantId) -All | Group-Object HomeTenantID

            }
            else {

                Write-Verbose -Message "$(Get-Date -f T) - Access direction 'Inbound' selected"
                Write-Verbose -Message "$(Get-Date -f T) - Inbound: getting external tenant IDs for external users accessing local tenant"

                $SignIns = Get-MgAuditLogSignIn -Filter ("CrossTenantAccessType ne 'none' and HomeTenantId ne '{0}' and TokenIssuerType eq 'AzureAD'" -f (Get-MgContext).TenantId) -All | Group-Object HomeTenantID

            }
        }
        else {

            if ($ExternalTenantId) {

                Write-Verbose -Message "$(Get-Date -f T) - Default access direction 'Both'"
                Write-Verbose -Message "$(Get-Date -f T) - Outbound: getting sign-ins for local users accessing external tenant ID - $ExternalTenantId"

                $Outbound = Get-MgAuditLogSignIn -Filter ("CrossTenantAccessType ne 'none' and ResourceTenantId eq '{0}'" -f $ExternalTenantId) -All | Group-Object ResourceTenantID


                Write-Verbose -Message "$(Get-Date -f T) - Inbound: getting sign-ins for users accessing local tenant from external tenant ID - $ExternalTenantId"

                $Inbound = Get-MgAuditLogSignIn -Filter ("CrossTenantAccessType ne 'none' and HomeTenantId eq '{0}' and TokenIssuerType eq 'AzureAD'" -f $ExternalTenantId) -All | Group-Object HomeTenantID
            }
            else {

                Write-Verbose -Message "$(Get-Date -f T) - Default access direction 'Both'"
                Write-Verbose -Message "$(Get-Date -f T) - Outbound: getting external tenant IDs accessed by local users"

                $Outbound = Get-MgAuditLogSignIn -Filter ("CrossTenantAccessType ne 'none' and ResourceTenantId ne '{0}'" -f (Get-MgContext).TenantId) -All | Group-Object ResourceTenantID


                Write-Verbose -Message "$(Get-Date -f T) - Inbound: getting external tenant IDs for external users accessing local tenant"

                $Inbound = Get-MgAuditLogSignIn -Filter ("CrossTenantAccessType ne 'none' and HomeTenantId ne '{0}' and TokenIssuerType eq 'AzureAD'" -f (Get-MgContext).TenantId) -All | Group-Object HomeTenantID
            }

            #Combine outbound and inbound results

            [array]$SignIns = $Outbound
            $SignIns += $Inbound
        }
        #Analyse sign-in logs

        Write-Verbose -Message "$(Get-Date -f T) - Checking for sign-ins..."

        if ($SignIns) {

            Write-Verbose -Message "$(Get-Date -f T) - Sign-ins obtained"
            Write-Verbose -Message "$(Get-Date -f T) - Iterating Sign-ins..."

            foreach ($TenantID in $SignIns) {

                #Handle resolving tenant ID

                if ($ResolveTenantId) {

                    Write-Verbose -Message "$(Get-Date -f T) - Attempting to resolve external tenant - $($TenantId.Name)"

                    #Nullify $ResolvedTenant value

                    $ResolvedTenant = $null

                    #Attempt to resolve tenant ID

                    try { $ResolvedTenant = Resolve-MsIdTenant -TenantId $TenantId.Name -ErrorAction Stop }
                    catch { Write-Warning $_.Exception.Message; Write-Verbose -Message "$(Get-Date -f T) - Issue resolving external tenant - $($TenantId.Name)" }

                    if ($ResolvedTenant) {

                        if ($ResolvedTenant.Result -eq 'Resolved') {

                            $ExternalTenantName = $ResolvedTenant.DisplayName
                            $DefaultDomainName = $ResolvedTenant.DefaultDomainName
                        }
                        else {
                            $ExternalTenantName = $ResolvedTenant.Result
                            $DefaultDomainName = $ResolvedTenant.Result
                        }

                        if ($ResolvedTenant.oidcMetadataResult -eq 'Resolved') {

                            $oidcMetadataTenantRegionScope = $ResolvedTenant.oidcMetadataTenantRegionScope
                        }
                        else {

                            $oidcMetadataTenantRegionScope = 'NotFound'

                        }

                    }
                    else {

                        $ExternalTenantName = "NotFound"
                        $DefaultDomainName = "NotFound"
                        $oidcMetadataTenantRegionScope = 'NotFound'
                    }

                }
                #Handle access direction

                if (($AccessDirection -eq 'Inbound') -or ($AccessDirection -eq 'Outbound')) {

                    $Direction = $AccessDirection

                }
                else {

                    if ($TenantID.Name -eq $TenantID.Group[0].HomeTenantId) {

                        $Direction = "Inbound"

                    }
                    elseif ($TenantID.Name -eq $TenantID.Group[0].ResourceTenantId) {

                        $Direction = "Outbound"

                    }

                }

                #Provide summary

                if ($SummaryStats) {

                    Write-Verbose -Message "$(Get-Date -f T) - Creating summary stats for external tenant - $($TenantId.Name)"

                    #Handle resolving tenant ID

                    if ($ResolveTenantId) {

                        $Analysis = [pscustomobject]@{

                            ExternalTenantId          = $TenantId.Name
                            ExternalTenantName        = $ExternalTenantName
                            ExternalTenantRegionScope = $oidcMetadataTenantRegionScope
                            AccessDirection           = $Direction
                            SignIns                   = ($TenantId).count
                            SuccessSignIns            = ($TenantID.Group.Status | Where-Object { $_.ErrorCode -eq 0 } | Measure-Object).count
                            FailedSignIns             = ($TenantID.Group.Status | Where-Object { $_.ErrorCode -ne 0 } | Measure-Object).count
                            UniqueUsers               = ($TenantID.Group | Select-Object UserId -Unique | Measure-Object).count
                            UniqueResources           = ($TenantID.Group | Select-Object ResourceId -Unique | Measure-Object).count

                        }

                    }
                    else {

                        #Build custom output object

                        $Analysis = [pscustomobject]@{

                            ExternalTenantId = $TenantId.Name
                            AccessDirection  = $Direction
                            SignIns          = ($TenantId).count
                            SuccessSignIns   = ($TenantID.Group.Status | Where-Object { $_.ErrorCode -eq 0 } | Measure-Object).count
                            FailedSignIns    = ($TenantID.Group.Status | Where-Object { $_.ErrorCode -ne 0 } | Measure-Object).count
                            UniqueUsers      = ($TenantID.Group | Select-Object UserId -Unique | Measure-Object).count
                            UniqueResources  = ($TenantID.Group | Select-Object ResourceId -Unique | Measure-Object).count

                        }


                    }

                    Write-Verbose -Message "$(Get-Date -f T) - Adding stats for $($TenantId.Name) to total analysis object"

                    [array]$TotalAnalysis += $Analysis

                }
                else {

                    #Get individual events by external tenant

                    Write-Verbose -Message "$(Get-Date -f T) - Getting individual sign-in events for external tenant - $($TenantId.Name)"


                    foreach ($Event in $TenantID.group) {


                        if ($ResolveTenantId) {

                            $CustomEvent = [pscustomobject]@{

                                ExternalTenantId          = $TenantId.Name
                                ExternalTenantName        = $ExternalTenantName
                                ExternalDefaultDomain     = $DefaultDomainName
                                ExternalTenantRegionScope = $oidcMetadataTenantRegionScope
                                AccessDirection           = $Direction
                                UserDisplayName           = $Event.UserDisplayName
                                UserPrincipalName         = $Event.UserPrincipalName
                                UserId                    = $Event.UserId
                                UserType                  = $Event.UserType
                                CrossTenantAccessType     = $Event.CrossTenantAccessType
                                AppDisplayName            = $Event.AppDisplayName
                                AppId                     = $Event.AppId
                                ResourceDisplayName       = $Event.ResourceDisplayName
                                ResourceId                = $Event.ResourceId
                                SignInId                  = $Event.Id
                                CreatedDateTime           = $Event.CreatedDateTime
                                StatusCode                = $Event.Status.Errorcode
                                StatusReason              = $Event.Status.FailureReason


                            }

                            $CustomEvent

                        }
                        else {

                            $CustomEvent = [pscustomobject]@{

                                ExternalTenantId      = $TenantId.Name
                                AccessDirection       = $Direction
                                UserDisplayName       = $Event.UserDisplayName
                                UserPrincipalName     = $Event.UserPrincipalName
                                UserId                = $Event.UserId
                                UserType              = $Event.UserType
                                CrossTenantAccessType = $Event.CrossTenantAccessType
                                AppDisplayName        = $Event.AppDisplayName
                                AppId                 = $Event.AppId
                                ResourceDisplayName   = $Event.ResourceDisplayName
                                ResourceId            = $Event.ResourceId
                                SignInId              = $Event.Id
                                CreatedDateTime       = $Event.CreatedDateTime
                                StatusCode            = $Event.Status.Errorcode
                                StatusReason          = $Event.Status.FailureReason
                            }

                            $CustomEvent

                        }
                    }

                }

            }

        }
        else {

            Write-Warning "$(Get-Date -f T) - No sign-ins matching the selected criteria found."

        }

        #Display summary table

        if ($SummaryStats) {

            #Show array of summary objects for each external tenant

            Write-Verbose -Message "$(Get-Date -f T) - Displaying total analysis object"

            if (!$AccessDirection) {

                $TotalAnalysis | Sort-Object ExternalTenantId

            }
            else {

                $TotalAnalysis | Sort-Object SignIns -Descending

            }

        }

    }

    end {
        if ($CriticalError) { return }
    }
}

