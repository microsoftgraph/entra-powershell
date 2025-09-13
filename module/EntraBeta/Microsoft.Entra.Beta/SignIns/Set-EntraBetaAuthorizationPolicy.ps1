# ------------------------------------------------------------------------------ 
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  
#  Licensed under the MIT License.  See License in the project root for license information. 
# ------------------------------------------------------------------------------ 
function Set-EntraBetaAuthorizationPolicy {
    [CmdletBinding(DefaultParameterSetName = 'ByPolicySettings')]
    param (               
        [Parameter(ParameterSetName = "ByPolicySettings")]
        [System.Nullable`1[System.Boolean]] $BlockMsolPowerShell,
                
        [Parameter(ParameterSetName = "ByPolicySettings")]
        [System.Collections.Generic.List`1[System.String]] $PermissionGrantPolicyIdsAssignedToDefaultUserRole,
                
        [Parameter(ParameterSetName = "ByPolicySettings")]
        [System.Nullable`1[System.Boolean]] $AllowedToUseSSPR,
                
        [Parameter(ParameterSetName = "ByPolicySettings")]
        [System.String] $Description,
                
        [Parameter(ParameterSetName = "ByPolicySettings")]
        [System.String] $GuestUserRoleId,
                
        [Parameter(ParameterSetName = "ByPolicySettings")]
        [System.String] $DisplayName,
                
        [Parameter(ParameterSetName = "ByPolicySettings")]
        [System.Nullable`1[System.Boolean]] $AllowEmailVerifiedUsersToJoinOrganization,
                
        [Parameter(ParameterSetName = "ByPolicySettings")]
        [System.Nullable`1[System.Boolean]] $AllowedToSignUpEmailBasedSubscriptions,
                
        [Parameter(ParameterSetName = "ByPolicySettings")]
        [Microsoft.Open.MSGraph.Model.DefaultUserRolePermissions] $DefaultUserRolePermissions,
                
        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
        [System.String] $Id,
                
        [Parameter(ParameterSetName = "ByPolicySettings")]
        [System.Collections.Generic.List`1[System.String]] $EnabledPreviewFeatures
    )

    begin {
        # Ensure connection to Microsoft Entra
        if (-not (Get-EntraContext)) {
            $errorMessage = "Not connected to Microsoft Graph. Use 'Connect-Entra -Scopes Policy.ReadWrite.Authorization' to authenticate."
            Write-Error -Message $errorMessage -ErrorAction Stop
            return
        }
    }

    PROCESS {    
        $params = @{}
        $customHeaders = New-EntraBetaCustomHeaders -Command $MyInvocation.MyCommand
    
        if ($null -ne $PSBoundParameters["BlockMsolPowerShell"]) {
            $params["BlockMsolPowerShell"] = $PSBoundParameters["BlockMsolPowerShell"]
        }
        if ($null -ne $PSBoundParameters["ProgressAction"]) {
            $params["ProgressAction"] = $PSBoundParameters["ProgressAction"]
        }
        if ($null -ne $PSBoundParameters["PermissionGrantPolicyIdsAssignedToDefaultUserRole"]) {
            $params["PermissionGrantPolicyIdsAssignedToDefaultUserRole"] = $PSBoundParameters["PermissionGrantPolicyIdsAssignedToDefaultUserRole"]
        }
        if ($PSBoundParameters.ContainsKey("Debug")) {
            $params["Debug"] = $PSBoundParameters["Debug"]
        }
        if ($null -ne $PSBoundParameters["OutBuffer"]) {
            $params["OutBuffer"] = $PSBoundParameters["OutBuffer"]
        }
        if ($null -ne $PSBoundParameters["ErrorAction"]) {
            $params["ErrorAction"] = $PSBoundParameters["ErrorAction"]
        }
        if ($null -ne $PSBoundParameters["WarningVariable"]) {
            $params["WarningVariable"] = $PSBoundParameters["WarningVariable"]
        }
        if ($null -ne $PSBoundParameters["WarningAction"]) {
            $params["WarningAction"] = $PSBoundParameters["WarningAction"]
        }
        if ($null -ne $PSBoundParameters["AllowedToUseSSPR"]) {
            $params["AllowedToUseSSPR"] = $PSBoundParameters["AllowedToUseSSPR"]
        }
        if ($null -ne $PSBoundParameters["Description"]) {
            $params["Description"] = $PSBoundParameters["Description"]
        }
        if ($null -ne $PSBoundParameters["GuestUserRoleId"]) {
            $params["GuestUserRoleId"] = $PSBoundParameters["GuestUserRoleId"]
        }
        if ($null -ne $PSBoundParameters["DisplayName"]) {
            $params["DisplayName"] = $PSBoundParameters["DisplayName"]
        }
        if ($null -ne $PSBoundParameters["OutVariable"]) {
            $params["OutVariable"] = $PSBoundParameters["OutVariable"]
        }
        if ($null -ne $PSBoundParameters["AllowEmailVerifiedUsersToJoinOrganization"]) {
            $params["AllowEmailVerifiedUsersToJoinOrganization"] = $PSBoundParameters["AllowEmailVerifiedUsersToJoinOrganization"]
        }
        if ($PSBoundParameters.ContainsKey("Verbose")) {
            $params["Verbose"] = $PSBoundParameters["Verbose"]
        }
        if ($null -ne $PSBoundParameters["AllowedToSignUpEmailBasedSubscriptions"]) {
            $params["AllowedToSignUpEmailBasedSubscriptions"] = $PSBoundParameters["AllowedToSignUpEmailBasedSubscriptions"]
        }
        if ($null -ne $PSBoundParameters["DefaultUserRolePermissions"]) {
            $TmpValue = $PSBoundParameters["DefaultUserRolePermissions"]
            $hash = @{}
            $hash["AllowedToCreateApps"] = $TmpValue.AllowedToCreateApps 
            $hash["AllowedToCreateSecurityGroups"] = $TmpValue.AllowedToCreateSecurityGroups 
            $hash["AllowedToReadOtherUsers"] = $TmpValue.AllowedToReadOtherUsers 
            
            $Value = $hash
            $params["DefaultUserRolePermissions"] = $Value
        }
        if ($null -ne $PSBoundParameters["Id"]) {
            $params["AuthorizationPolicyId"] = $PSBoundParameters["Id"]
        }
        if ($null -ne $PSBoundParameters["PipelineVariable"]) {
            $params["PipelineVariable"] = $PSBoundParameters["PipelineVariable"]
        }
        if ($null -ne $PSBoundParameters["InformationVariable"]) {
            $params["InformationVariable"] = $PSBoundParameters["InformationVariable"]
        }
        if ($null -ne $PSBoundParameters["InformationAction"]) {
            $params["InformationAction"] = $PSBoundParameters["InformationAction"]
        }
        if ($null -ne $PSBoundParameters["ErrorVariable"]) {
            $params["ErrorVariable"] = $PSBoundParameters["ErrorVariable"]
        }
        if ($null -ne $PSBoundParameters["EnabledPreviewFeatures"]) {
            $params["EnabledPreviewFeatures"] = $PSBoundParameters["EnabledPreviewFeatures"]
        }

        Write-Debug("============================ TRANSFORMATIONS ============================")
        $params.Keys | ForEach-Object { "$_ : $($params[$_])" } | Write-Debug
        Write-Debug("=========================================================================`n")
    
        $response = Update-MgBetaPolicyAuthorizationPolicy @params -Headers $customHeaders
        $response | ForEach-Object {
            if ($null -ne $_) {
                Add-Member -InputObject $_ -MemberType AliasProperty -Name ObjectId -Value Id

            }
        }
        $response
    }
}

