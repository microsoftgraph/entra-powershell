# Connect to Entra with required scopes
Connect-Entra -Scopes 'AppRoleAssignment.ReadWrite.All', 'Application.ReadWrite.All', 'User.Read.All', 'Group.Read.All', 'DelegatedPermissionGrant.ReadWrite.All', 'AuditLog.Read.All'

# Define application name and redirect URI
$appName = "Entra PowerShell App (Delegated)"
$redirectUri = "http://localhost"

# Define delegated permission and Graph API ID
$delegatedPermission = 'User.Read.All'
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
$resourceAccessDelegated = New-Object Microsoft.Open.MSGraph.Model.ResourceAccess
$resourceAccessDelegated.Id = ((Get-EntraServicePrincipal -ServicePrincipalId $graphServicePrincipal.Id).Oauth2PermissionScopes | Where-Object { $_.Value -eq $delegatedPermission }).Id
$resourceAccessDelegated.Type = 'Scope'

# Create required resource access object
$requiredResourceAccessDelegated = New-Object Microsoft.Open.MSGraph.Model.RequiredResourceAccess
$requiredResourceAccessDelegated.ResourceAppId = $graphApiId
$requiredResourceAccessDelegated.ResourceAccess = $resourceAccessDelegated

# Set application required resource access
Set-EntraApplication -ApplicationId $app.Id -RequiredResourceAccess $requiredResourceAccessDelegated

# Set service principal parameters
Set-EntraServicePrincipal -ServicePrincipalId $servicePrincipal.Id -AppRoleAssignmentRequired $True

# Grant OAuth2 permission
$permissionGrant = New-EntraOauth2PermissionGrant -ClientId $servicePrincipal.Id -ConsentType 'AllPrincipals' -ResourceId $graphServicePrincipal.Id -Scope $delegatedPermission

# Get and filter OAuth2 permission grants
Get-EntraOAuth2PermissionGrant -All | Where-Object { $_.Id -eq $permissionGrant.Id }