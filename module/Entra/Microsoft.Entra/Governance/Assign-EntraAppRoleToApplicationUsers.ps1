function Assign-EntraAppRoleToApplicationUsers {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true, HelpMessage = "Specify the data source type: 'DatabaseorDirectory', 'SAPCloudIdentity', or 'Generic'")]
        [ValidateSet("DatabaseorDirectory", "SAPCloudIdentity", "Generic")]
        [string]$DataSource,

        [Parameter(Mandatory = $true, HelpMessage = "Path to the input file containing users, e.g., C:\temp\users.csv")]
        [ValidateNotNullOrEmpty()]
        [ValidateScript({ Test-Path $_ })]
        [string]$FileName,

        [Parameter(Mandatory = $true, HelpMessage = "Name of the application (Service Principal) to assign roles for")]
        [ValidateNotNullOrEmpty()]
        [string]$ApplicationName
    )

    process {

        # Call the orchestrator function
        Write-Verbose "Service principal already exists for application with params: AppName - " $ApplicationName" | FileName - " $FileName" | DataSource - " $DataSource

        Main
        
        function Main() {
    
            try {
                # Import users from the CSV file
                $users = Import-Csv -Path $FileName
                if (-not $users) { 
                    Write-Error "No users found in the provided file: $FileName" 
                    return 
                }
    
                # Define the property name for user lookup based on data source
                $sourceMatchPropertyName = switch ($DataSource) {
                    "DatabaseorDirectory" { "email" }
                    "SAPCloudIdentity" { "userName" }
                    "Generic" { "userPrincipalName" }
                }
    
                # Get or create the application and service principal once
                $application = Get-OrCreateEntraApplication -DisplayName $ApplicationName
                if (-not $application) {
                    Write-Error "Failed to retrieve or create application: $ApplicationName"
                    return
                }
    
                # Get unique roles from users - commenting out this part due to creation error
                <#         $uniqueRoles = $users | 
            Where-Object { -not [string]::IsNullOrWhiteSpace($_.Role) } | 
            Select-Object -ExpandProperty Role -Unique
    
            if (-not $uniqueRoles) {
                Write-Error "No roles found in the input file"
                return
            }
    
            Write-Verbose "Found $($uniqueRoles.Count) unique roles to process"
    
            # Create app roles for each unique role
            $createdRoles = @{}
            foreach ($role in $uniqueRoles) {
                $cleanRoleName = Clean-PropertyValue -Value $role -PropertyName "Role"
                if (-not $cleanRoleName) { continue }
    
                $newRole = New-AppRoleIfNotExists -ApplicationId $application.ApplicationId -RoleDisplayName $cleanRoleName
                if ($newRole) {
                    $createdRoles[$cleanRoleName] = $newRole
                    Write-Verbose "Created/Retrieved role: $cleanRoleName"
                }
            } #>
    
    
                # Process users in bulk where possible
                foreach ($user in $users) {
                    $cleanUserPrincipalName = Clean-PropertyValue -Value $user.$sourceMatchPropertyName -PropertyName $sourceMatchPropertyName
                    if (-not $cleanUserPrincipalName) { 
                        Write-Warning "Skipping user due to invalid sourceMatchPropertyName: $($user.$sourceMatchPropertyName)"
                        continue 
                    }
    
                    $cleanDisplayName = Clean-PropertyValue -Value $user.displayName -PropertyName "displayName"
    
                    if (-not $cleanDisplayName) { 
                        Write-Warning "Skipping user due to invalid sourceMatchPropertyName: $($user.$DisplayName)"
                        continue 
                    }
                    $cleanMailNickname = Clean-PropertyValue -Value $user.mailNickname -PropertyName "mailNickname"
    
                    if (-not $cleanMailNickname) { 
                        Write-Warning "Skipping user due to invalid sourceMatchPropertyName: $($user.$MailNickname)"
                        continue 
                    }
    
                    # Get the user's role
                    $userRole = Clean-PropertyValue -Value $user.Role -PropertyName "Role"
                    if (-not $userRole -or -not $createdRoles.ContainsKey($userRole)) {
                        Write-Warning "Invalid or unmapped role for user $($userInfo.UserPrincipalName): $($user.Role)"
                        continue
                    }
    
    
                    # Create user if they do not exist
                    $userInfo = New-EntraUserIfNotExists -UserPrincipalName $cleanUserPrincipalName -DisplayName $cleanDisplayName -MailNickname $cleanMailNickname
                    if (-not $userInfo) { continue }
    
                    # Assign roles to the user (Placeholder for role assignment logic)
    
                    $assignment = Assign-AppServicePrincipalRoleAssignmentIfNotExists -ServicePrincipalId $application.ServicePrincipalId -UserId $userInfo.Id -ApplicationName $ApplicationName -RoleDisplayName $userRole
                    if (-not $assignment) { continue }
                    Write-Verbose "Assigning roles to user $($userInfo.UserPrincipalName) in application $ApplicationName"
                }
            }
            catch {
                Write-Error "Error in Start-Orchestration: $_"
            }
        }
    
        function New-EntraUserIfNotExists($UserPrincipalName, $DisplayName, $MailNickname) {
    
            try {
                # Check if user exists
                $existingUser = Get-EntraUser -Filter "userPrincipalName eq '$UserPrincipalName'" -ErrorAction SilentlyContinue
                if ($existingUser) {
                    Write-Verbose "User exists: $UserPrincipalName"
                    return $existingUser
                }
    
                # Create new user
                $params = @{
                    UserPrincipalName = $UserPrincipalName
                    DisplayName       = ($UserPrincipalName -split '@')[0]
                    MailNickname      = ($UserPrincipalName -split '@')[0]
                    AccountEnabled    = $false
                    PasswordProfile   = @{
                        Password                      = -join (((48..90) + (96..122)) * 16 | Get-Random -Count 16 | % { [char]$_ })
                        ForceChangePasswordNextSignIn = $true
                    }
                }
    
                $newUser = New-EntraUser @params
                Write-Verbose "Created new user: $UserPrincipalName"
                return $newUser
            }
            catch {
                Write-Error "Failed to create or verify user $($UserPrincipalName): $_"
                return $null
            }
        }
    
        function Clean-PropertyValue($Value, $PropertyName) {
    
            try {
                if ([string]::IsNullOrWhiteSpace($Value)) {
                    Write-Warning "Invalid $PropertyName value"
                    return $null
                }
    
                # Remove unwanted characters and normalize
                $cleanValue = $Value -replace '[^\w\s@\.-]', '' -replace '\s+', ' ' | ForEach-Object { $_.Trim().ToLower() }
    
                return if ([string]::IsNullOrWhiteSpace($cleanValue)) { 
                    Write-Warning "$PropertyName is empty after cleanup"
                    $null 
                } else { $cleanValue }
            }
            catch {
                Write-Error "Error cleaning $($PropertyName): $($_)"
                return $null
            }
        }
    
        function Get-OrCreateEntraApplication($DisplayName) {
    
            try {
                # Check if application exists
                $existingApp = Get-EntraApplication -Filter "displayName eq '$DisplayName'" -ErrorAction SilentlyContinue
    
                if (-not $existingApp) {
                    # Create new application
                    $appParams = @{
                        DisplayName    = $DisplayName
                        Description    = $DisplayName
                        SignInAudience = "AzureADMyOrg"
                        Web            = @{
                            RedirectUris = @("https://localhost")
                        }
                    }
    
                    $newApp = New-EntraApplication @appParams
                    Write-Verbose "Created new application: $DisplayName"
    
                    # Create service principal for the application
                    $spParams = @{
                        AppId       = $newApp.AppId
                        DisplayName = $DisplayName
                    }
    
                    $newSp = New-EntraServicePrincipal @spParams
                    Write-Verbose "Created new service principal for application: $DisplayName"
    
                    [PSCustomObject]@{
                        ApplicationId               = $newApp.Id
                        ApplicationDisplayName      = $newApp.DisplayName
                        ServicePrincipalId          = $newSp.Id
                        ServicePrincipalDisplayName = $newSp.DisplayName
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
                        Write-Verbose "Created new service principal for existing application: $DisplayName"
                    }
                    else {
                        $newSp = $existingSp
                        Write-Verbose "Service principal already exists for application: $DisplayName"
                    }
    
                    [PSCustomObject]@{
                        ApplicationId               = $existingApp.Id
                        ApplicationDisplayName      = $existingApp.DisplayName
                        ServicePrincipalId          = $newSp.Id
                        ServicePrincipalDisplayName = $newSp.DisplayName
                        Status                      = 'Exists'
                    }
                }
            }
            catch {
                Write-Error "Error in Get-OrCreateEntraApplication: $_"
                return $null
            }
        }
    
        function New-AppRoleIfNotExists($ApplicationId, $RoleDisplayName) {
    
            try {
                # Get existing application
                $application = Get-EntraApplication -ApplicationId $ApplicationId -ErrorAction Stop
                if (-not $application) {
                    Write-Error "Application not found with ID: $ApplicationId"
                    return $null
                }
    
                $AllowedMemberTypes = "User"
    
                # Create new app role
                $appRole = @{
                    AllowedMemberTypes = $AllowedMemberTypes
                    Description        = $RoleDisplayName
                    DisplayName        = $RoleDisplayName
                    Id                 = [guid]::NewGuid()
                    IsEnabled          = $true
                    Value              = $RoleValue ?? $RoleDisplayName
                }
    
                # Get existing roles and add new role
                $existingRoles = $application.AppRoles ?? @()
            
                # Check if role already exists
                if ($existingRoles.Where({ $_.DisplayName -eq $RoleDisplayName })) {
                    Write-Warning "Role '$RoleDisplayName' already exists in application"
                    return $null
                }
    
                $updatedRoles = $existingRoles + $appRole
    
                # Update application with new role
                $params = @{
                    ApplicationId = $ApplicationId
                    AppRoles      = $updatedRoles
                    Tags          = @("WindowsAzureActiveDirectoryIntegratedApp")
                }
    
                $updatedApp = Set-EntraApplication @params
            
                Write-Verbose "Created new role '$RoleDisplayName' in application '$($application.DisplayName)'"
            
                # Return the newly created role
                return [PSCustomObject]@{
                    ApplicationId = $ApplicationId
                    RoleId        = $appRole.Id
                    DisplayName   = $RoleDisplayName
                    Description   = $RoleDescription
                    Value         = $appRole.Value
                    IsEnabled     = $true
                }
            }
            catch {
                Write-Error "Failed to create app role: $_"
                return $null
            }
        }
    
        function Assign-AppServicePrincipalRoleAssignmentIfNotExists($ServicePrincipalId, $UserId, $ApplicationName, $RoleDisplayName) {
    
            try {
                # Check if assignment exists
    
                $servicePrincipalObject = Get-EntraServicePrincipal -ServicePrincipalId $ServicePrincipalId
                $appRoleId = $servicePrincipalObject.AppRoles | Where-Object { $_.displayName -eq $RoleDisplayName } | Select-Object -Property Id
    
                $existingAssignment = Get-EntraServicePrincipalAppRoleAssignedTo -ServicePrincipalId $ServicePrincipalId | Where-Object { $_.AppRoleId -eq $appRoleId } -ErrorAction SilentlyContinue
    
                if ($existingAssignment) {
                    Write-Verbose "Role assignment already exists for user '$ApplicationName' with role '$RoleDisplayName'"
                
                    return [PSCustomObject]@{
                        ServicePrincipalId = $ServicePrincipalId
                        PrincipalId        = $UserId
                        AppRoleId          = $appRoleId
                        Status             = 'Exists'
                    }
                }
    
                # Create new assignment
    
                $newAssignment = New-EntraServicePrincipalAppRoleAssignment -ServicePrincipalId $ServicePrincipalId -ResourceId $ServicePrincipalId -Id $appRoleId -PrincipalId $UserId
                Write-Verbose "Created new role assignment for user '$UserId' - AppName: '$ApplicationName' with role '$RoleDisplayName'"
    
                return [PSCustomObject]@{
                    ServicePrincipalId = $ServicePrincipalId
                    PrincipalId        = $UserId
                    AppRoleId          = $appRoleId
                    Status             = 'Created'
                }
            }
            catch {
                Write-Error "Failed to create or verify role assignment: $_"
                return $null
            }
        }

    }
    
}

