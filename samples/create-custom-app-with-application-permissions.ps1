# Connect to Entra with required scopes
Connect-Entra -Scopes 'AppRoleAssignment.ReadWrite.All', 'Application.ReadWrite.All', 'User.Read.All', 'Group.Read.All', 'DelegatedPermissionGrant.ReadWrite.All', 'AuditLog.Read.All'

# Define application name and redirect URI
$appName = "Entra PowerShell App (Application)"
$redirectUri = "http://localhost"

# Define Application permission and Graph API ID
$applicationPermission = 'Group.Read.All'
$graphApiId = '00000003-0000-0000-c000-000000000000'

# Get a user and a group
$user = Get-EntraUser -UserId 'AdeleV@contoso.com'
$group = Get-EntraGroup -Search 'Sales and Marketing'

# Create a new application
$app = New-EntraApplication -DisplayName $appName -PublicClient @{ RedirectUris = $redirectUri } -IsFallbackPublicClient $False

# Create a service principal for the application
$servicePrincipal = New-EntraServicePrincipal -AppId $app.AppId

# Assign users and groups to the application
$emptyGuidUser = [Guid]::Empty.ToString()
New-EntraUserAppRoleAssignment -ObjectId $user.Id -PrincipalId $user.Id -ResourceId $servicePrincipal.Id -Id $emptyGuidUser

$emptyGuidGroup = [Guid]::Empty.ToString()
New-EntraGroupAppRoleAssignment -GroupId $group.Id -PrincipalId $group.Id -ResourceId $servicePrincipal.Id -Id $emptyGuidGroup

# Get Graph service principal
$graphServicePrincipal = Get-EntraServicePrincipal -Filter "AppId eq '$graphApiId'"

# Create resource access object
$resourceAccessAppPerms = New-Object Microsoft.Open.MSGraph.Model.ResourceAccess
$resourceAccessAppPerms.Id = ((Get-EntraServicePrincipal -ServicePrincipalId $graphServicePrincipal.ObjectId).AppRoles | Where-Object { $_.Value -eq $applicationPermission}).Id
$resourceAccessAppPerms.Type = 'Scope'

# Create required resource access object
$requiredResourceAccessAppPerms = New-Object Microsoft.Open.MSGraph.Model.RequiredResourceAccess
$requiredResourceAccessAppPerms.ResourceAppId = $graphApiId
$requiredResourceAccessAppPerms.ResourceAccess = $resourceAccessAppPerms

# Set application required resource access
Set-EntraApplication -ApplicationId $app.Id -RequiredResourceAccess $requiredResourceAccessAppPerms

# Set service principal parameters
Set-EntraServicePrincipal -ServicePrincipalId $servicePrincipal.Id -AppRoleAssignmentRequired $True

# Get application role ID
$appRoleId = ($graphServicePrincipal.AppRoles | Where-Object { $_.Value -eq $applicationPermission }).Id

New-EntraServicePrincipalAppRoleAssignment -ObjectId $servicePrincipal.Id -ResourceId $graphServicePrincipal.Id -Id $appRoleId -PrincipalId $servicePrincipal.Id