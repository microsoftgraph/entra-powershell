# ------------------------------------------------------------------------------ 
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  
#  Licensed under the MIT License.  See License in the project root for license information. 
# ------------------------------------------------------------------------------ 
function Set-EntraBetaPrivilegedRoleSetting {
    [CmdletBinding(DefaultParameterSetName = 'ByRoleSettingIdAndProviderId')]
    param (
                
        [Parameter(ParameterSetName = "ByRoleSettingIdAndProviderId")]
        [System.Collections.Generic.List`1[Microsoft.Open.MSGraph.Model.AzureADMSPrivilegedRuleSetting]] $UserEligibleSettings,
                
        [Parameter(ParameterSetName = "ByRoleSettingIdAndProviderId")]
        [System.Collections.Generic.List`1[Microsoft.Open.MSGraph.Model.AzureADMSPrivilegedRuleSetting]] $UserMemberSettings,
                
        [Parameter(ParameterSetName = "ByRoleSettingIdAndProviderId")]
        [System.String] $RoleDefinitionId,
                
        [Parameter(ParameterSetName = "ByRoleSettingIdAndProviderId")]
        [System.Collections.Generic.List`1[Microsoft.Open.MSGraph.Model.AzureADMSPrivilegedRuleSetting]] $AdminMemberSettings,
                
        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
        [System.String] $Id,
                
        [Parameter(ParameterSetName = "ByRoleSettingIdAndProviderId")]
        [System.Collections.Generic.List`1[Microsoft.Open.MSGraph.Model.AzureADMSPrivilegedRuleSetting]] $AdminEligibleSettings,
                
        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
        [System.String] $ProviderId,
                
        [Parameter(ParameterSetName = "ByRoleSettingIdAndProviderId")]
        [System.String] $ResourceId
    )

    begin {
        # Ensure connection to Microsoft Entra
        if (-not (Get-EntraContext)) {
            $errorMessage = "Not connected to Microsoft Graph. Use PrivilegedAccess.ReadWrite.AzureAD, PrivilegedAccess.ReadWrite.AzureResources, PrivilegedAccess.ReadWrite.AzureADGroup' to authenticate."
            Write-Error -Message $errorMessage -ErrorAction Stop
            return
        }
    }

    PROCESS {    
        $params = @{}
        $customHeaders = New-EntraBetaCustomHeaders -Command $MyInvocation.MyCommand
    
        if ($null -ne $PSBoundParameters["UserEligibleSettings"]) {
            $TmpValue = $PSBoundParameters["UserEligibleSettings"]
            $a = @()
            foreach ($setting in $TmpValue) {
                $Temp = $setting | ConvertTo-Json
                $a += $Temp
            }

            $Value = $a  
            $params["UserEligibleSettings"] = $Value
        }
        if ($null -ne $PSBoundParameters["ProgressAction"]) {
            $params["ProgressAction"] = $PSBoundParameters["ProgressAction"]
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
        if ($null -ne $PSBoundParameters["OutVariable"]) {
            $params["OutVariable"] = $PSBoundParameters["OutVariable"]
        }
        if ($null -ne $PSBoundParameters["UserMemberSettings"]) {
            $TmpValue = $PSBoundParameters["UserMemberSettings"]
            $a = @()
            foreach ($setting in $TmpValue) {
                $Temp = $setting | ConvertTo-Json
                $a += $Temp
            }

            $Value = $a 
            $params["UserMemberSettings"] = $Value
        }
        if ($PSBoundParameters.ContainsKey("Verbose")) {
            $params["Verbose"] = $PSBoundParameters["Verbose"]
        }
        if ($null -ne $PSBoundParameters["RoleDefinitionId"]) {
            $params["RoleDefinitionId"] = $PSBoundParameters["RoleDefinitionId"]
        }
        if ($null -ne $PSBoundParameters["AdminMemberSettings"]) {
            $TmpValue = $PSBoundParameters["AdminMemberSettings"]
            $a = @()
            foreach ($setting in $TmpValue) {
                $Temp = $setting | ConvertTo-Json
                $a += $Temp
            }

            $Value = $a  
            $params["AdminMemberSettings"] = $Value
        }
        if ($null -ne $PSBoundParameters["Id"]) {
            $params["GovernanceRoleSettingId"] = $PSBoundParameters["Id"]
        }
        if ($null -ne $PSBoundParameters["PipelineVariable"]) {
            $params["PipelineVariable"] = $PSBoundParameters["PipelineVariable"]
        }
        if ($null -ne $PSBoundParameters["InformationVariable"]) {
            $params["InformationVariable"] = $PSBoundParameters["InformationVariable"]
        }
        if ($null -ne $PSBoundParameters["AdminEligibleSettings"]) {
            $TmpValue = $PSBoundParameters["AdminEligibleSettings"]
            $a = @()
            foreach ($setting in $TmpValue) {
                $Temp = $setting | ConvertTo-Json
                $a += $Temp
            }

            $Value = $a  
            $params["AdminEligibleSettings"] = $Value
        }
        if ($null -ne $PSBoundParameters["ProviderId"]) {
            $params["PrivilegedAccessId"] = $PSBoundParameters["ProviderId"]
        }
        if ($null -ne $PSBoundParameters["InformationAction"]) {
            $params["InformationAction"] = $PSBoundParameters["InformationAction"]
        }
        if ($null -ne $PSBoundParameters["ErrorVariable"]) {
            $params["ErrorVariable"] = $PSBoundParameters["ErrorVariable"]
        }
        if ($null -ne $PSBoundParameters["ResourceId"]) {
            $params["ResourceId"] = $PSBoundParameters["ResourceId"]
        }

        Write-Debug("============================ TRANSFORMATIONS ============================")
        $params.Keys | ForEach-Object { "$_ : $($params[$_])" } | Write-Debug
        Write-Debug("=========================================================================`n")
    
        $response = Update-MgBetaPrivilegedAccessRoleSetting @params -Headers $customHeaders
        $response | ForEach-Object {
            if ($null -ne $_) {
                Add-Member -InputObject $_ -MemberType AliasProperty -Name ObjectId -Value Id

            }
        }
        $response
    }
}

