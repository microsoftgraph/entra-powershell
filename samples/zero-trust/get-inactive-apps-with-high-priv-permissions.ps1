# ------------------------------------------------------------------------------ 
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  
#  Licensed under the MIT License.  See License in the project root for license information. 
# ------------------------------------------------------------------------------

# Connect to Microsoft Graph with necessary permissions
Connect-Entra -Scopes "Application.Read.All", "Directory.Read.All", "AuditLog.Read.All" -NoWelcome

# Define inactivity threshold (e.g., 90 days)
$inactiveThreshold = (Get-Date).AddDays(-90)

# Sample list of highly privileged Microsoft Graph API permissions
$highPrivPermissions = @(
    "Directory.ReadWrite.All",
    "Directory.AccessAsUser.All",
    "User.ReadWrite.All",
    "Group.ReadWrite.All",
    "Application.ReadWrite.All",
    "RoleManagement.ReadWrite.Directory",
    "Policy.ReadWrite.ConditionalAccess",
    "Device.ReadWrite.All"
)

# Get Microsoft Graph Service Principal - Note: You can also use the AppId ""00000003-0000-0000-c000-000000000000"" instead of the DisplayName
$msGraphServicePrincipal = Get-EntraServicePrincipal -Filter "displayName eq 'Microsoft Graph'"

# Map permission IDs to friendly names
$highPrivPermIds = @{}

foreach ($role in $msGraphServicePrincipal.AppRoles) {
    if ($highPrivPermissions -contains $role.Value) {
        $highPrivPermIds[$role.Id] = $role.Value
    }
}

foreach ($scope in $msGraphServicePrincipal.OAuth2PermissionScopes) {
    if ($highPrivPermissions -contains $scope.Value) {
        $highPrivPermIds[$scope.Id] = $scope.Value
    }
}

# Retrieve all registered applications
$applications = Get-EntraApplication -All
$appsWithHighPriv = @()

foreach ($app in $applications) {
    $hasHighPriv = $false
    $appHighPrivPermissions = @()
    if ($app.RequiredResourceAccess) {
        foreach ($req in $app.RequiredResourceAccess) {
            if ($req.ResourceAppId -eq $msGraphServicePrincipal.AppId) {
                foreach ($perm in $req.ResourceAccess) {
                    if ($highPrivPermIds.ContainsKey($perm.Id)) {
                        $hasHighPriv = $true
                        $appHighPrivPermissions += $highPrivPermIds[$perm.Id]
                    }
                }
            }
            if ($hasHighPriv) { break }
        }
    }
    if ($hasHighPriv) {
        $app | Add-Member -MemberType NoteProperty -Name HighPrivilegedPermissions -Value $appHighPrivPermissions
        $appsWithHighPriv += $app
    }
}

# Check inactivity based on sign-in activity
$inactiveApps = @()

foreach ($app in $appsWithHighPriv) {
    $sp = Get-EntraServicePrincipal -Filter "appId eq '$($app.AppId)'" -ErrorAction SilentlyContinue
    $lastSignIn = $null

    if ($sp -and $sp.SignInActivity) {
        $lastSignIn = $sp.SignInActivity.LastSignInDateTime
    }

    # Mark as inactive if never signed in or last sign-in is older than threshold
    $isInactive = -not $lastSignIn -or ([datetime]$lastSignIn -lt $inactiveThreshold)

    if ($isInactive) {
        $inactiveApps += [PSCustomObject]@{
            ApplicationName           = $app.DisplayName
            AppId                     = $app.AppId
            LastSignIn                = $lastSignIn
            HighPrivilegedPermissions = $app.HighPrivilegedPermissions -join ", "
        }
    }
}

$inactiveApps | Format-Table -AutoSize
