# ------------------------------------------------------------------------------ 
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  
#  Licensed under the MIT License.  See License in the project root for license information. 
# ------------------------------------------------------------------------------ 
function Set-EntraBetaAppRoleToApplicationUser {
    [CmdletBinding(DefaultParameterSetName = 'Default')]
    param (
        [Parameter(Mandatory = $true, 
            HelpMessage = "Specify the data source type: 'DatabaseorDirectory'`, 'SAPCloudIdentity'`, or 'Generic' which determines the column attribute mapping.")]
        [ValidateSet("DatabaseorDirectory", "SAPCloudIdentity", "Generic")]
        [string]$DataSource,

        [Parameter(Mandatory = $true,
            HelpMessage = "Path to the input file containing users`, e.g: C:\temp\users.csv")]
        [ValidateNotNullOrEmpty()]
        [ValidateScript({ Test-Path $_ })]
        [System.IO.FileInfo]$FilePath,

        [Parameter(Mandatory = $true, 
            HelpMessage = "Name of the application (Service Principal) to assign roles for")]
        [ValidateNotNullOrEmpty()]
        [string]$ApplicationName,

        [Parameter(Mandatory = $false,
            HelpMessage = "Specifies what Microsoft accounts are supported for the application. Options are 'AzureADMyOrg'`, 'AzureADMultipleOrgs'`, 'AzureADandPersonalMicrosoftAccount'`, 'PersonalMicrosoftAccount'")]
        [ValidateSet("AzureADMyOrg", "AzureADMultipleOrgs", "AzureADandPersonalMicrosoftAccount", "PersonalMicrosoftAccount")]
        [string]$SignInAudience = "AzureADMyOrg",

        [Parameter(Mandatory = $false,
            ParameterSetName = 'ExportResults',
            HelpMessage = "Switch to enable export of results into a CSV file")]
        [switch]$Export,
        
        [Parameter(Mandatory = $false, ParameterSetName = 'ExportResults',
            HelpMessage = "Path for the export file. Defaults to current directory.")]
        [System.IO.FileInfo]$ExportFilePath = (Join-Path (Get-Location) "EntraAppRoleAssignments_$(Get-Date -Format 'yyyyMMdd_HHmmss').csv")
    )

    begin {
        # Ensure connection to Microsoft Entra
        if (-not (Get-EntraContext)) {
            $errorMessage = "Not connected to Microsoft Graph. Use 'Connect-Entra -Scopes Application.ReadWrite.All,Application.ReadWrite.OwnedBy,User.ReadWrite.All,AppRoleAssignment.ReadWrite.All' to authenticate."
            Write-Error -Message $errorMessage -ErrorAction Stop
            return
        }
    }

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
                $params = @{}
                $baseUri = "/beta/users"
                $query = "?`$filter=userPrincipalName eq '$UserPrincipalName'&`$select=Id,CreationType,DisplayName,GivenName,Mail,MailNickName,MobilePhone,OtherMails, UserPrincipalName,EmployeeId,JobTitle"
                $params["Method"] = "GET"
                $params["Uri"] = "$baseUri{0}" -f $query
                $getUserResponse = Invoke-GraphRequest @params

                # User doesn't exist
                if($null -eq $getUserResponse.value -or $getUserResponse.value.Count -eq 0){
                    $passwordProfile = @{
                        ForceChangePasswordNextSignIn = $true
                        Password = -join (((48..90) + (96..122)) * 16 | Get-Random -Count 16 | % { [char]$_ })

                    }

                    $userParams = @{
                        displayName       = $DisplayName
                        passwordProfile   = $passwordProfile
                        userPrincipalName = $UserPrincipalName
                        accountEnabled    = $false
                        mailNickName      = $MailNickname
                        mail              = $UserPrincipalName
                    }

                    $userParams = $userParams | ConvertTo-Json

                    $newUserResponse = Invoke-GraphRequest -Uri '/beta/users?$select=*' -Method POST -Body $userParams
                    $newUserResponse = $newUserResponse | ConvertTo-Json | ConvertFrom-Json

                    Write-ColoredVerbose -Message "Created new user: $UserPrincipalName" -Color "Green"

                    return [PSCustomObject]@{
                        Id                = $newUserResponse.Id
                        UserPrincipalName = $newUserResponse.UserPrincipalName
                        DisplayName       = $newUserResponse.DisplayName
                        MailNickname      = $newUserResponse.MailNickname
                        Mail              = $newUserResponse.Mail
                        Status            = 'Created'
                    }
                }
                else{
                    # User exists
                    Write-ColoredVerbose -Message "User $UserPrincipalName exists." -Color "Green"
                    return [PSCustomObject]@{
                        Id                = $getUserResponse.value.id
                        UserPrincipalName = $getUserResponse.value.userPrincipalName
                        DisplayName       = $getUserResponse.value.displayName
                        MailNickname      = $getUserResponse.value.mailNickname
                        Mail              = $getUserResponse.value.mail
                        Status            = 'Exists'
                    }
                }
            }
            catch {
                Write-Error "Failed to create or verify user $($UserPrincipalName) $_"
                return $null
            }
        }
        
        function CreateApplicationIfNotExists {
            param (
                [string]$DisplayName,
                [string]$SignInAudience
                )

            try {
                # Check if application exists

                $params = @{}
                $baseUri = "/beta/applications"
                $query = "?`$filter=displayName eq '$DisplayName'"
                $params["Method"] = "GET"
                $params["Uri"] = "$baseUri{0}" -f $query
                $getAppResponse = Invoke-GraphRequest @params
    
                if ($null -eq $getAppResponse.value -or $getAppResponse.value.Count -eq 0) {
                    # Create new application
                    $appParams = @{
                        displayName    = $DisplayName
                        signInAudience = $SignInAudience
                        web            = @{
                            RedirectUris = @("https://localhost")
                        }
                    }

                    $appParams = $appParams | ConvertTo-Json

                    $newAppResponse = Invoke-GraphRequest -Uri '/beta/applications' -Method POST -Body $appParams
                    $newAppResponse = $newAppResponse | ConvertTo-Json | ConvertFrom-Json
                    Write-ColoredVerbose "Created new application: $DisplayName"
    
                    # Create service principal for the application
                    $spParams = @{
                        appId       = $newAppResponse.AppId
                        displayName = $DisplayName
                    }

                    $spParams = $spParams | ConvertTo-Json

                    $newSPResponse = Invoke-GraphRequest -Uri "/beta/servicePrincipals" -Method POST -Body $spParams
                    $newSPResponse = $newSPResponse | ConvertTo-Json | ConvertFrom-Json

                    Write-ColoredVerbose "Created new service principal for application: $DisplayName"
    
                    [PSCustomObject]@{
                        ApplicationId               = $newAppResponse.Id
                        ApplicationDisplayName      = $newAppResponse.DisplayName
                        ServicePrincipalId          = $newSPResponse.Id
                        ServicePrincipalDisplayName = $newSPResponse.DisplayName
                        AppId                       = $newAppResponse.AppId
                        Status                      = 'Created'
                    }
                }
                else {
                    # Get existing service principal

                    $params = @{}
                    $baseUri = "/beta/servicePrincipals"
                    $query = "?`$filter=appId eq '$($getAppResponse.value.AppId)'"
                    $params["Method"] = "GET"
                    $params["Uri"] = "$baseUri{0}" -f $query
                    $getSPResponse = Invoke-GraphRequest @params
                    $sp = $null
    
                    if ($null -eq $getSPResponse.value -or $getSPResponse.value.Count -eq 0) {
                        # Create service principal if it doesn't exist

                        $spParams = @{
                            appId       = $getAppResponse.value.AppId
                            displayName = $DisplayName
                        }

                        $spParams = $spParams | ConvertTo-Json

                        $newSPResponse = Invoke-GraphRequest -Uri "/beta/servicePrincipals" -Method POST -Body $spParams
                        $newSPResponse = $newSPResponse | ConvertTo-Json | ConvertFrom-Json
                        $sp = $newSPResponse
                        Write-ColoredVerbose "Created new service principal for existing application: $DisplayName"
                    }
                    else {
                        $sp = $getSPResponse.value
                        Write-ColoredVerbose "Service principal already exists for application: $DisplayName"
                    }
    
                    [PSCustomObject]@{
                        ApplicationId               = $getAppResponse.value.Id
                        ApplicationDisplayName      = $getAppResponse.value.DisplayName
                        ServicePrincipalId          = $sp.Id
                        ServicePrincipalDisplayName = $sp.DisplayName
                        AppId                       = $getAppResponse.value.AppId
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

                $params = @{}
                $params["Uri"] = "/beta/servicePrincipals/$ServicePrincipalId"
                $params["Method"] = "GET"
                $servicePrincipalObject = Invoke-GraphRequest @params
                $appRoleId = ($servicePrincipalObject.AppRoles | Where-Object { $_.displayName -eq $RoleDisplayName }).Id

                $params = @{}
                $params["Uri"] = "/beta/servicePrincipals/$ServicePrincipalId/appRoleAssignedTo"
                $params["Method"] = "GET"
                $existingAssignment = (Invoke-GraphRequest @params).value | Where-Object { $_.AppRoleId -eq $appRoleId } -ErrorAction SilentlyContinue

                if($existingAssignment){
                    Write-ColoredVerbose "Role assignment already exists for user '$ApplicationName' with role '$RoleDisplayName'" -Color "Yellow"
                
                    return [PSCustomObject]@{
                        ServicePrincipalId = $ServicePrincipalId
                        PrincipalId        = $UserId
                        AppRoleId          = $appRoleId
                        AssignmentId       = $existingAssignment.Id
                        Status             = 'Exists'
                        #CreatedDateTime    = $existingAssignment.CreatedDateTime ?? (Get-Date).ToUniversalTime().ToString("o") # This works in v1.0 end point
                        CreatedDateTime    = (Get-Date).ToUniversalTime().ToString("o")  # ISO 8601 format
                    }
                }
        
                # Create new assignment

                $assignmentParams = @{
                    appRoleId       = $appRoleId
                    principalId     = $UserId
                    resourceId      = $ServicePrincipalId
                }

                $assignmentParams = $assignmentParams | ConvertTo-Json

                $assignmentResponse = Invoke-GraphRequest -Uri "/beta/servicePrincipals/$ServicePrincipalId/appRoleAssignments" -Method POST -Body $assignmentParams
                $assignmentResponse = $assignmentResponse | ConvertTo-Json | ConvertFrom-Json

                Write-ColoredVerbose "Created new role assignment for user '$UserId' - AppName: '$ApplicationName' with role '$RoleDisplayName'" -Color "Green"
        
                return [PSCustomObject]@{
                    ServicePrincipalId = $ServicePrincipalId
                    PrincipalId        = $UserId
                    AppRoleId          = $appRoleId
                    AssignmentId       = $assignmentResponse.Id
                    Status             = 'Created'
                    #CreatedDateTime    = $assignmentResponse.CreatedDateTime ?? (Get-Date).ToUniversalTime().ToString("o")  # ISO 8601 format # This works in v1.0 end point
                    CreatedDateTime    = (Get-Date).ToUniversalTime().ToString("o")  # ISO 8601 format
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

                $params = @{}
                $params["Uri"] = "/beta/applications/$ApplicationId"
                $params["Method"] = "GET"
                $application = Invoke-GraphRequest @params

                if (-not $application) {
                    Write-Error "Application not found with ID: $ApplicationId"
                    return $null
                }
        
                # Ensure the existing AppRoles are properly formatted
                $existingRoles = @()
                if($null -ne $application.AppRoles){
                    $existingRoles = $application.AppRoles
                }
                $appRolesList = New-Object System.Collections.ArrayList
        
                foreach ($role in $existingRoles) {
                    $appRolesList.Add($role)
                }

                $createdRoles = [System.Collections.ArrayList]::new()
        
                foreach ($roleName in $UniqueRoles) {
                    # Check if the role already exists
                    if ($existingRoles | Where-Object { $_.DisplayName -eq $roleName }) {
                        Write-ColoredVerbose "Role '$roleName' already exists in application" -Color "Yellow"
                        continue
                    }

                    $memberTypes = $roleToMemberTypeMapping[$roleName]
                    $allowedMemberTypes = $memberTypes -split "," # Create array from comma separated string
        
                    # Create new AppRole object
                    $appRole = @{
                        allowedMemberTypes = $allowedMemberTypes
                        description        = $roleName
                        displayName        = $roleName
                        id                 = [Guid]::NewGuid()
                        isEnabled          = $true
                        value              = $roleName
                    }
        
                    # Add to the typed list
                    $appRolesList.Add($appRole)
                    [void]$createdRoles.Add($appRole)
                    Write-ColoredVerbose "Created new role definition for '$roleName'" -Color "Green"
                }
        
                if ($createdRoles.Count -gt 0) {
                    # Update application with the new typed list
                    $params = @{
                        appRoles      = $appRolesList
                        tags          = @("WindowsAzureActiveDirectoryIntegratedApp")
                    }

                    $params = $params | ConvertTo-Json -Depth 10

                    $patchResponse = Invoke-GraphRequest -Uri "/beta/applications/$ApplicationId" -Method PATCH -Body $params
                    $patchResponse = $patchResponse | ConvertTo-Json | ConvertFrom-Json
        
                    Write-ColoredVerbose "Updated application with $($createdRoles.Count) new roles" -Color "Green"
        
                    return $createdRoles | ForEach-Object {
                        [PSCustomObject]@{
                            ApplicationId = $ApplicationId
                            RoleId        = $_.id
                            DisplayName   = $_.displayName
                            Description   = $_.description
                            Value         = $_.value
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
                Write-ColoredVerbose "Importing users from file: $FilePath" -Color "Cyan"
                $users = Import-Csv -Path $FilePath
                Write-ColoredVerbose "Imported : $($users.Count) users" -Color "Green"
                if (-not $users) { 
                    Write-Error "No users found in the provided file: $FilePath" 
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
                $application = CreateApplicationIfNotExists -DisplayName $ApplicationName -SignInAudience $SignInAudience
                if (-not $application) {
                    Write-Error "Failed to retrieve or create application: $ApplicationName"
                    return
                }
                Write-ColoredVerbose "Application $ApplicationName status: $($application.Status) | ApplicationId : $($application.ApplicationId) | AppId : $($application.AppId) | ServicePrincipalId : $($application.ServicePrincipalId)." -Color "Green"

                $uniqueRoles = @()
                $roleToMemberTypeMapping = @{}
        
                # Extract unique roles
                $users | ForEach-Object {
                    $role = SanitizeInput -Value $_.Role
                    if ($role -and $role -notin $uniqueRoles) {
                        $uniqueRoles += $role
                        $memberType = SanitizeInput -Value $_.memberType
                        $roleToMemberTypeMapping[$role] = $memberType
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
                    $userRoleType = SanitizeInput -Value $user.memberType
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
                                PrincipalType                 = $userRoleType
                                RoleAssignmentCreatedDateTime = $assignment.CreatedDateTime
                                ResourceId                    = $application.ServicePrincipalId  # Same as ServicePrincipalId in this context
                                ProcessedTimestamp            = (Get-Date).ToString('yyyy-MM-dd HH:mm:ss')
                            })
                    }
                }

                # Export results if using ExportResults parameter set
                if ($Export -and $assignmentResults.Count -gt 0) {
                    try {
                        Write-ColoredVerbose "Exporting results to: $ExportFilePath" -Color "Cyan"
                        $assignmentResults | Export-Csv -Path $ExportFilePath -NoTypeInformation -Force
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
        Write-ColoredVerbose -Message "Starting orchestration with params: AppName - $ApplicationName | FilePath - $FilePath | DataSource - $DataSource" -Color "Magenta"
        # Start orchestration
        StartOrchestration

    }
}

