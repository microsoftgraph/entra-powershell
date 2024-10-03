# Connect to Entra with required scopes
Connect-Entra -Scopes 'AppRoleAssignment.ReadWrite.All', 'Application.ReadWrite.All', 'User.Read.All', 'Group.Read.All', 'DelegatedPermissionGrant.ReadWrite.All', 'AuditLog.Read.All'

# Define application name and redirect URI
$AppName = "Entra PowerShell Five"
$RedirectUri = "http://localhost"

# Define Application permission and Graph API ID
$ApplicationPermission = 'Group.Read.All'
$GraphApiId = '00000003-0000-0000-c000-000000000000'

# Get a user and a group
$User = Get-EntraUser -SearchString 'Adele'
$Group = Get-EntraGroup -Search 'Sales and Marketing'

# Create a new application
$AppParams = @{
    DisplayName            = $AppName
    PublicClient           = @{ RedirectUris = $RedirectUri }
    IsFallbackPublicClient = $false
}
$App = New-EntraApplication @AppParams

# Create a service principal for the application
$ServicePrincipalParams = @{
    AppId = $App.AppId
}
$ServicePrincipal = New-EntraServicePrincipal @ServicePrincipalParams

# Assign users and groups to the application
$UserAppRoleAssignmentParams = @{
    ObjectId    = $User.ObjectId
    PrincipalId = $User.ObjectId
    ResourceId  = $ServicePrincipal.ObjectId
    Id          = [Guid]::Empty
}
New-EntraUserAppRoleAssignment @UserAppRoleAssignmentParams

$GroupAppRoleAssignmentParams = @{
    ObjectId    = $Group.ObjectId
    PrincipalId = $Group.ObjectId
    ResourceId  = $ServicePrincipal.ObjectId
    Id          = [Guid]::Empty
}
New-EntraGroupAppRoleAssignment @GroupAppRoleAssignmentParams

# Get Graph service principal
$GraphServicePrincipal = Get-EntraServicePrincipal -Filter "AppId eq '$GraphApiId'"

# Create resource access object
$ResourceAccess = New-Object Microsoft.Open.MSGraph.Model.ResourceAccess
$ResourceAccess.Id = ((Get-EntraServicePrincipal -ObjectId $GraphServicePrincipal.ObjectId).AppRoles | Where-Object { $_.Value -eq $ApplicationPermission}).Id
$ResourceAccess.Type = 'Scope'

# Create required resource access object
$RequiredResourceAccess = New-Object Microsoft.Open.MSGraph.Model.RequiredResourceAccess
$RequiredResourceAccess.ResourceAppId = $GraphApiId
$RequiredResourceAccess.ResourceAccess = $ResourceAccess

# Set application required resource access
$SetAppParams = @{
    ObjectId               = $App.ObjectId
    RequiredResourceAccess = $RequiredResourceAccess
}
Set-EntraApplication @SetAppParams

# Set service principal parameters
$ServicePrincipalUpdateParams = @{
    ObjectId                  = $ServicePrincipal.ObjectId
    AppRoleAssignmentRequired = $true
}
Set-EntraServicePrincipal @ServicePrincipalUpdateParams

# Get application role ID
$AppRoleId = ($GraphServicePrincipal.AppRoles | Where-Object { $_.Value -eq $ApplicationPermission }).Id

$AppRoleAssignmentParams = @{
    ObjectId    = $ServicePrincipal.Id
    ResourceId  = $GraphServicePrincipal.Id
    Id          = $AppRoleId
    PrincipalId = $ServicePrincipal.Id
}

New-EntraServiceAppRoleAssignment @AppRoleAssignmentParams