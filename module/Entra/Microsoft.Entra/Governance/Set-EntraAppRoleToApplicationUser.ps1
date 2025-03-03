# ------------------------------------------------------------------------------ 
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  
#  Licensed under the MIT License.  See License in the project root for license information. 
# ------------------------------------------------------------------------------ 
function Set-EntraAppRoleToApplicationUser {
    [CmdletBinding(DefaultParameterSetName = 'Default')]
    param (
        [Parameter(Mandatory = $true, 
            HelpMessage = "Specify the data source type: 'DatabaseorDirectory', 'SAPCloudIdentity', or 'Generic' which determines the column attribute mapping.",
            ParameterSetName = 'Default')]
        [Parameter(Mandatory = $true, ParameterSetName = 'ExportResults')]
        [ValidateSet("DatabaseorDirectory", "SAPCloudIdentity", "Generic")]
        [string]$DataSource,

        [Parameter(Mandatory = $true, 
            HelpMessage = "Path to the input file containing users, e.g., C:\temp\users.csv",
            ParameterSetName = 'Default')]
        [Parameter(Mandatory = $true, ParameterSetName = 'ExportResults')]
        [ValidateNotNullOrEmpty()]
        [ValidateScript({ Test-Path $_ })]
        [System.IO.FileInfo]$FileName,

        [Parameter(Mandatory = $true, 
            HelpMessage = "Name of the application (Service Principal) to assign roles for",
            ParameterSetName = 'Default')]
        [Parameter(Mandatory = $true, ParameterSetName = 'ExportResults')]
        [ValidateNotNullOrEmpty()]
        [string]$ApplicationName,

        [Parameter(Mandatory = $true,
            ParameterSetName = 'ExportResults',
            HelpMessage = "Switch to enable export of results into a CSV file")]
        [switch]$Export,
        
        [Parameter(Mandatory = $false, ParameterSetName = 'ExportResults',
            HelpMessage = "Path for the export file. Defaults to current directory.")]
        [System.IO.FileInfo]$ExportFileName = (Join-Path (Get-Location) "EntraAppRoleAssignments_$(Get-Date -Format 'yyyyMMdd_HHmmss').csv")
    )

    process {


        # Custom Verbose Function to Avoid Overriding Built-in Write-ColoredVerbose
        function Write-ColoredVerbose {
            param (
                [Parameter(Mandatory = $true)]
                [string]$Message,

                [ValidateSet("Green", "Yellow", "Red", "Cyan", "Magenta")]
                [string]$Color = "Cyan"
            )

            if ($VerbosePreference -eq "Continue") {
                Write-Host "VERBOSE: $Message" -ForegroundColor $Color
            }
        }

        function SanitizeInput {
            param ([string]$Value)
            if ([string]::IsNullOrWhiteSpace($Value)) { return $null }
            return $Value -replace "'", "''" -replace '\s+', ' ' -replace "`n|`r", "" | ForEach-Object { $_.Trim().ToLower() }
        }

        function CreateUserIfNotExists {
            param (
                [string]$UserPrincipalName,
                [string]$DisplayName,
                [string]$MailNickname
            )
        
            Write-ColoredVerbose -Message "User details: DisplayName $DisplayName | UserPrincipalName: $UserPrincipalName | MailNickname: $MailNickname" -Color "Cyan"
        
            try {
                $existingUser = Get-EntraUser -Filter "userPrincipalName eq '$UserPrincipalName'" -ErrorAction SilentlyContinue
                if ($existingUser) {
                    Write-ColoredVerbose -Message "User $UserPrincipalName exists." -Color "Green"
                    return [PSCustomObject]@{
                        Id                = $existingUser.Id
                        UserPrincipalName = $existingUser.UserPrincipalName
                        DisplayName       = $existingUser.DisplayName
                        MailNickname      = $existingUser.MailNickname
                        Status            = 'Exists'
                    }
                }
        
                $passwordProfile = New-Object -TypeName Microsoft.Open.AzureAD.Model.PasswordProfile
                $passwordProfile.EnforceChangePasswordPolicy = $true
                $passwordProfile.Password = -join (((48..90) + (96..122)) * 16 | Get-Random -Count 16 | % { [char]$_ })
                $userParams = @{
                    DisplayName       = $DisplayName
                    PasswordProfile   = $passwordProfile
                    UserPrincipalName = $UserPrincipalName
                    AccountEnabled    = $false
                    MailNickName      = $MailNickname
                }
        
                $newUser = New-EntraUser @userParams
                Write-ColoredVerbose -Message "Created new user: $UserPrincipalName" -Color "Green"
                
                return [PSCustomObject]@{
                    Id                = $newUser.Id
                    UserPrincipalName = $newUser.UserPrincipalName
                    DisplayName       = $newUser.DisplayName
                    MailNickname      = $newUser.MailNickname
                    Status            = 'Created'
                }
            }
            catch {
                Write-Error "Failed to create or verify user $($UserPrincipalName) $_"
                return $null
            }
        }
        
        function CreateApplicationIfNotExists {
            param ([string]$DisplayName)

            try {
                # Check if application exists
                
                $existingApp = Get-EntraApplication -Filter "displayName eq '$DisplayName'" -ErrorAction SilentlyContinue
    
                if (-not $existingApp) {
                    # Create new application
                    $appParams = @{
                        DisplayName    = $DisplayName
                        SignInAudience = "AzureADMyOrg"
                        Web            = @{
                            RedirectUris = @("https://localhost")
                        }
                    }
    
                    $newApp = New-EntraApplication @appParams
                    Write-ColoredVerbose "Created new application: $DisplayName"
    
                    # Create service principal for the application
                    $spParams = @{
                        AppId       = $newApp.AppId
                        DisplayName = $DisplayName
                    }
    
                    $newSp = New-EntraServicePrincipal @spParams
                    Write-ColoredVerbose "Created new service principal for application: $DisplayName"
    
                    [PSCustomObject]@{
                        ApplicationId               = $newApp.Id
                        ApplicationDisplayName      = $newApp.DisplayName
                        ServicePrincipalId          = $newSp.Id
                        ServicePrincipalDisplayName = $newSp.DisplayName
                        AppId                       = $newApp.AppId
                        Status                      = 'Created'
                    }
                }
                else {
                    # Get existing service principal
                    $existingSp = Get-EntraServicePrincipal -Filter "appId eq '$($existingApp.AppId)'" -ErrorAction SilentlyContinue
    
                    if (-not $existingSp) {
                        # Create service principal if it doesn't exist
                        $spParams = @{
                            AppId       = $existingApp.AppId
                            DisplayName = $DisplayName
                        }
    
                        $newSp = New-EntraServicePrincipal @spParams
                        Write-ColoredVerbose "Created new service principal for existing application: $DisplayName"
                    }
                    else {
                        $newSp = $existingSp
                        Write-ColoredVerbose "Service principal already exists for application: $DisplayName"
                    }
    
                    [PSCustomObject]@{
                        ApplicationId               = $existingApp.Id
                        ApplicationDisplayName      = $existingApp.DisplayName
                        ServicePrincipalId          = $newSp.Id
                        ServicePrincipalDisplayName = $newSp.DisplayName
                        AppId                       = $existingApp.AppId
                        Status                      = 'Exists'
                    }
                }
            }
            catch {
                Write-Error "Error in CreateApplicationIfNotExists: $_"
                return $null
            }
        }

        function AssignAppServicePrincipalRoleAssignmentIfNotExists {

            param (
                [string]$ServicePrincipalId,
                [string]$UserId,
                [string]$ApplicationName,
                [string]$RoleDisplayName
            )
    
            try {
                # Check if assignment exists
    
                $servicePrincipalObject = Get-EntraServicePrincipal -ServicePrincipalId $ServicePrincipalId
                $appRoleId = ($servicePrincipalObject.AppRoles | Where-Object { $_.displayName -eq $RoleDisplayName }).Id
    
                $existingAssignment = Get-EntraServicePrincipalAppRoleAssignedTo -ServicePrincipalId $servicePrincipalObject.Id | Where-Object { $_.AppRoleId -eq $appRoleId } -ErrorAction SilentlyContinue
    
                if ($existingAssignment) {
                    Write-ColoredVerbose "Role assignment already exists for user '$ApplicationName' with role '$RoleDisplayName'" -Color "Yellow"
                
                    return [PSCustomObject]@{
                        ServicePrincipalId = $ServicePrincipalId
                        PrincipalId        = $UserId
                        AppRoleId          = $appRoleId
                        AssignmentId       = $existingAssignment.Id
                        Status             = 'Exists'
                        CreatedDateTime    = $existingAssignment.CreatedDateTime #?? (Get-Date).ToUniversalTime().ToString("o")
                    }
                }
        
                # Create new assignment
                $newAssignment = New-EntraServicePrincipalAppRoleAssignment -ServicePrincipalId $servicePrincipalObject.Id -ResourceId $servicePrincipalObject.Id -Id $appRoleId -PrincipalId $UserId
                Write-ColoredVerbose "Created new role assignment for user '$UserId' - AppName: '$ApplicationName' with role '$RoleDisplayName'" -Color "Green"
        
                return [PSCustomObject]@{
                    ServicePrincipalId = $ServicePrincipalId
                    PrincipalId        = $UserId
                    AppRoleId          = $appRoleId
                    AssignmentId       = $newAssignment.Id
                    Status             = 'Created'
                    CreatedDateTime    = $newAssignment.CreatedDateTime #(Get-Date).ToUniversalTime().ToString("o")  # ISO 8601 format
                }
            }
            catch {
                Write-Error "Failed to create or verify role assignment: $_)"
                return $null
            }
        }

        function NewAppRoleIfNotExists {
            param (
                [Parameter(Mandatory = $true)]
                [string[]]$UniqueRoles,
        
                [Parameter(Mandatory = $true)]
                [string]$ApplicationId
            )
        
            try {
                # Get existing application
                $application = Get-MgApplication -ApplicationId $ApplicationId -ErrorAction Stop
                if (-not $application) {
                    Write-Error "Application not found with ID: $ApplicationId"
                    return $null
                }
        
                # Ensure the existing AppRoles are properly formatted
                $existingRoles = $application.AppRoles ?? @()
                $appRolesList = New-Object 'System.Collections.Generic.List[Microsoft.Graph.PowerShell.Models.MicrosoftGraphAppRole]'
        
                foreach ($role in $existingRoles) {
                    $appRolesList.Add($role)
                }
        
                $allowedMemberTypes = @("User")  # Define allowed member types
                $createdRoles = [System.Collections.ArrayList]::new()
        
                foreach ($roleName in $UniqueRoles) {
                    # Check if the role already exists
                    if ($existingRoles | Where-Object { $_.DisplayName -eq $roleName }) {
                        Write-ColoredVerbose "Role '$roleName' already exists in application" -Color "Yellow"
                        continue
                    }
        
                    # Create new AppRole object
                    $appRole = [Microsoft.Graph.PowerShell.Models.MicrosoftGraphAppRole]@{
                        AllowedMemberTypes = $allowedMemberTypes
                        Description        = $roleName
                        DisplayName        = $roleName
                        Id                 = [Guid]::NewGuid()
                        IsEnabled          = $true
                        Value              = $roleName
                    }
        
                    # Add to the typed list
                    $appRolesList.Add($appRole)
                    [void]$createdRoles.Add($appRole)
                    Write-ColoredVerbose "Created new role definition for '$roleName'" -Color "Green"
                }
        
                if ($createdRoles.Count -gt 0) {
                    # Update application with the new typed list
                    $params = @{
                        ApplicationId = $ApplicationId
                        AppRoles      = $appRolesList
                        Tags          = @("WindowsAzureActiveDirectoryIntegratedApp")
                    }
        
                    Update-MgApplication @params
                    Write-ColoredVerbose "Updated application with $($createdRoles.Count) new roles" -Color "Green"
        
                    return $createdRoles | ForEach-Object {
                        [PSCustomObject]@{
                            ApplicationId = $ApplicationId
                            RoleId        = $_.Id
                            DisplayName   = $_.DisplayName
                            Description   = $_.Description
                            Value         = $_.Value
                            IsEnabled     = $true
                        }
                    }
                }
        
                Write-ColoredVerbose "No new roles needed to be created" -Color "Yellow"
                return $null
            }
            catch {
                Write-Error "Failed to create app roles: $_"
                return $null
            }
        }

        function StartOrchestration {
    
            try {
                # Import users from the CSV file
                Write-ColoredVerbose "Importing users from file: $FileName" -Color "Cyan"
                $users = Import-Csv -Path $FileName
                Write-ColoredVerbose "Imported : $($users.Count) users" -Color "Green"
                if (-not $users) { 
                    Write-Error "No users found in the provided file: $FileName" 
                    return 
                }
    
                # Define the property name for user lookup based on data source
                Write-ColoredVerbose "Using: $DataSource for pattern matching" -Color "Cyan"
                $sourceMatchPropertyName = switch ($DataSource) {
                    "DatabaseorDirectory" { "email" }
                    "SAPCloudIdentity" { "userName" }
                    "Generic" { "userPrincipalName" }
                }
                Write-ColoredVerbose "Column used for lookup in Entra ID : $sourceMatchPropertyName." -Color "Green"

                # Get or create the application and service principal once
                Write-ColoredVerbose -Message "Checking if application exists for: $ApplicationName" -Color "Cyan"
                $application = CreateApplicationIfNotExists -DisplayName $ApplicationName
                if (-not $application) {
                    Write-Error "Failed to retrieve or create application: $ApplicationName"
                    return
                }
                Write-ColoredVerbose "Application $ApplicationName status: $($application.Status) | ApplicationId : $($application.ApplicationId) | AppId : $($application.AppId) | ServicePrincipalId : $($application.ServicePrincipalId)." -Color "Green"

                $uniqueRoles = @()
        
                # Extract unique roles
                $users | ForEach-Object {
                    $role = SanitizeInput -Value $_.Role
                    if ($role -and $role -notin $uniqueRoles) {
                        $uniqueRoles += $role
                    }
                }
        
                Write-ColoredVerbose "Found $($uniqueRoles.Count) unique roles: $($uniqueRoles -join ', ')" -Color "Green"
                # Create new roles if they do not exist

                if ($uniqueRoles.Count -gt 0) {
                    Write-ColoredVerbose "Creating required roles in application..." -Color "Cyan"
                    $createdRoles = NewAppRoleIfNotExists -UniqueRoles $uniqueRoles -ApplicationId $application.ApplicationId
                    if ($createdRoles) {
                        Write-ColoredVerbose "Successfully created $($createdRoles.Count) new roles" -Color "Green"
                    }
                }
                else {
                    Write-ColoredVerbose "No new roles needed to be created" -Color "Yellow"
                }
                # Process users in bulk

                Write-ColoredVerbose "Processing users details..." -Color "Cyan"

                $assignmentResults = [System.Collections.ArrayList]::new()

                foreach ($user in $users) {

                    $cleanUserPrincipalName = SanitizeInput -Value $user.$sourceMatchPropertyName
                    Write-ColoredVerbose "UPN : $($cleanUserPrincipalName)" -Color "Green"

                    if (-not $cleanUserPrincipalName) { 
                        Write-Warning "Skipping user due to invalid userPrincipalName: $($user.$sourceMatchPropertyName)"
                        continue 
                    }
    
                    $cleanDisplayName = SanitizeInput -Value $user.displayName
                    Write-ColoredVerbose "DisplayName : $($cleanDisplayName)" -Color "Green"

                    if (-not $cleanDisplayName) { 
                        Write-Warning "Skipping user due to invalid displayName: $($user.DisplayName)"
                        continue 
                    }
                    $cleanMailNickname = SanitizeInput -Value $user.mailNickname
                    Write-ColoredVerbose "Mail nickname : $($cleanMailNickname)" -Color "Green"
    
                    if (-not $cleanMailNickname) { 
                        Write-Warning "Skipping user due to invalid mailNickname: $($user.MailNickname)"
                        continue 
                    }
    
                    # Get the user's role
                    $userRole = SanitizeInput -Value $user.Role
                    Write-ColoredVerbose "Role : $($userRole)" -Color "Green"
                    if (-not $userRole) {
                        Write-Warning "Skipping user due to invalid Role: $($user.Role)"
                        continue
                    }
    
    
                    # Create user if they do not exist
                    Write-ColoredVerbose "Assigning roles to user $($cleanUserPrincipalName) "
                    $userInfo = CreateUserIfNotExists -UserPrincipalName $cleanUserPrincipalName -DisplayName $cleanDisplayName -MailNickname $cleanMailNickname
                   
                    if (-not $userInfo) { continue }
    
                    # Assign roles to the user (Placeholder for role assignment logic)
                    Write-ColoredVerbose "Start app role assignment with params: ServicePrincipalId - $($application.ServicePrincipalId) | UserId - $($userInfo.Id) | AppName - $($ApplicationName) | Role - $($userRole) " -Color "Cyan"
                    $assignment = AssignAppServicePrincipalRoleAssignmentIfNotExists -ServicePrincipalId $application.ServicePrincipalId -UserId $userInfo.Id -ApplicationName $ApplicationName -RoleDisplayName $userRole
                    if (-not $assignment) { continue }
                    Write-ColoredVerbose "Assigning roles to user $($userInfo.UserPrincipalName) in application $ApplicationName"

                    if ($assignment) {
                        [void]$assignmentResults.Add([PSCustomObject]@{
                                UserPrincipalName             = $cleanUserPrincipalName
                                DisplayName                   = $cleanDisplayName
                                UserId                        = $userInfo.Id
                                Role                          = $userRole
                                ApplicationName               = $ApplicationName
                                ApplicationStatus             = $application.Status
                                ServicePrincipalId            = $application.ServicePrincipalId
                                UserCreationStatus            = $userInfo.Status
                                RoleAssignmentStatus          = $assignment.Status
                                AssignmentId                  = $assignment.AssignmentId
                                AppRoleId                     = $assignment.AppRoleId
                                PrincipalType                 = "User"  # Based on the AllowedMemberTypes in role creation
                                RoleAssignmentCreatedDateTime = $assignment.CreatedDateTime
                                ResourceId                    = $application.ServicePrincipalId  # Same as ServicePrincipalId in this context
                                ProcessedTimestamp            = (Get-Date).ToString('yyyy-MM-dd HH:mm:ss')
                            })
                    }
                }

                # Export results if using ExportResults parameter set
                if ($PSCmdlet.ParameterSetName -eq 'ExportResults' -and $assignmentResults.Count -gt 0) {
                    try {
                        Write-ColoredVerbose "Exporting results to: $ExportFileName" -Color "Cyan"
                        $assignmentResults | Export-Csv -Path $ExportFileName -NoTypeInformation -Force
                        Write-ColoredVerbose "Successfully exported $($assignmentResults.Count) assignments" -Color "Green"
                    }
                    catch {
                        Write-Error "Failed to export results: $_"
                    }
                }

                return $assignmentResults
            }
            catch {
                Write-Error "Error in StartOrchestration: $_)"
            }
        }

        # Debugging output
        Write-ColoredVerbose -Message "Starting orchestration with params: AppName - $ApplicationName | FileName - $FileName | DataSource - $DataSource" -Color "Magenta"
        # Start orchestration
        StartOrchestration

    }
    
}

