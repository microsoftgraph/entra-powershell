# ------------------------------------------------------------------------------ 
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  
#  Licensed under the MIT License.  See License in the project root for license information. 
# ------------------------------------------------------------------------------ 
function Set-EntraBetaConditionalAccessPolicy {
    [CmdletBinding(DefaultParameterSetName = 'ByPolicyId')]
    param (                
        [Parameter(ParameterSetName = "ByPolicyId")]
        [System.String] $State,
                
        [Parameter(ParameterSetName = "ByPolicyId")]
        [Microsoft.Open.MSGraph.Model.ConditionalAccessGrantControls] $GrantControls,
                
        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
        [System.String] $PolicyId,
                
        [Parameter(ParameterSetName = "ByPolicyId")]
        [System.String] $DisplayName,
                
        [Parameter(ParameterSetName = "ByPolicyId")]
        [Microsoft.Open.MSGraph.Model.ConditionalAccessSessionControls] $SessionControls,
                
        [Parameter(ParameterSetName = "ByPolicyId")]
        [Microsoft.Open.MSGraph.Model.ConditionalAccessConditionSet] $Conditions,
                
        [Parameter(ParameterSetName = "ByPolicyId")]
        [System.String] $ModifiedDateTime,
                
        [Parameter(ParameterSetName = "ByPolicyId")]
        [System.String] $Id,
                
        [Parameter(ParameterSetName = "ByPolicyId")]
        [System.String] $CreatedDateTime
    )

    begin {
        # Ensure connection to Microsoft Entra
        if (-not (Get-EntraContext)) {
            $errorMessage = "Not connected to Microsoft Graph. Use 'Connect-Entra -Scopes Policy.ReadWrite.ConditionalAccess, Policy.Read.All' to authenticate."
            Write-Error -Message $errorMessage -ErrorAction Stop
            return
        }
    }

    PROCESS {    
        $params = @{}
        $customHeaders = New-EntraBetaCustomHeaders -Command $MyInvocation.MyCommand
    
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
        if ($null -ne $PSBoundParameters["State"]) {
            $params["State"] = $PSBoundParameters["State"]
        }
        if ($null -ne $PSBoundParameters["GrantControls"]) {
            $TmpValue = $PSBoundParameters["GrantControls"]
            $hash = @{}
            if ($TmpValue._Operator) { $hash["Operator"] = $TmpValue._Operator }
            if ($TmpValue.BuiltInControls) { $hash["BuiltInControls"] = $TmpValue.BuiltInControls }
            if ($TmpValue.CustomAuthenticationFactors) { $hash["CustomAuthenticationFactors"] = $TmpValue.CustomAuthenticationFactors }
            if ($TmpValue.TermsOfUse) { $hash["TermsOfUse"] = $TmpValue.TermsOfUse }
            $Value = $hash
            $params["GrantControls"] = $Value
        }
        if ($null -ne $PSBoundParameters["PolicyId"]) {
            $params["ConditionalAccessPolicyId"] = $PSBoundParameters["PolicyId"]
        }
        if ($null -ne $PSBoundParameters["DisplayName"]) {
            $params["DisplayName"] = $PSBoundParameters["DisplayName"]
        }
        if ($null -ne $PSBoundParameters["OutVariable"]) {
            $params["OutVariable"] = $PSBoundParameters["OutVariable"]
        }
        if ($null -ne $PSBoundParameters["SessionControls"]) {
            $TmpValue = $PSBoundParameters["SessionControls"]
            if ($TmpValue.ApplicationEnforcedRestrictions) {
                $ApplicationEnforcedRestrictions = @{}
                $ApplicationEnforcedRestrictions["IsEnabled"] = $TmpValue.ApplicationEnforcedRestrictions.IsEnabled
            }
            if ($TmpValue.CloudAppSecurity) {
                $CloudAppSecurity = @{}
                $CloudAppSecurity["IsEnabled"] = $TmpValue.CloudAppSecurity.IsEnabled
                $CloudAppSecurity["CloudAppSecurityType"] = $TmpValue.CloudAppSecurity.CloudAppSecurityType
            }
            if ($TmpValue.PersistentBrowser) {
                $PersistentBrowser = @{}
                $PersistentBrowser["IsEnabled"] = $TmpValue.PersistentBrowser.IsEnabled
                $PersistentBrowser["Mode"] = $TmpValue.PersistentBrowser.Mode
            }
            if ($TmpValue.SignInFrequency) {
                $SignInFrequency = @{}
                $SignInFrequency["IsEnabled"] = $TmpValue.SignInFrequency.IsEnabled
                $SignInFrequency["Type"] = $TmpValue.SignInFrequency.Type
                $SignInFrequency["Value"] = $TmpValue.SignInFrequency.Value
            }
            
            $hash = @{}
            if ($TmpValue.ApplicationEnforcedRestrictions) { $hash["ApplicationEnforcedRestrictions"] = $ApplicationEnforcedRestrictions }
            if ($TmpValue.CloudAppSecurity) { $hash["CloudAppSecurity"] = $CloudAppSecurity }
            if ($TmpValue.SignInFrequency) { $hash["SignInFrequency"] = $SignInFrequency }
            if ($TmpValue.PersistentBrowser) { $hash["PersistentBrowser"] = $PersistentBrowser }
            $Value = $hash
            $params["SessionControls"] = $Value
        }
        if ($null -ne $PSBoundParameters["Conditions"]) {
            $TmpValue = $PSBoundParameters["Conditions"]
            if ($TmpValue.Applications) {
                $Applications = @{}
                $Applications["IncludeApplications"] = $TmpValue.Applications.IncludeApplications
                $Applications["ExcludeApplications"] = $TmpValue.Applications.ExcludeApplications
                $Applications["IncludeUserActions"] = $TmpValue.Applications.IncludeUserActions
                $Applications["IncludeProtectionLevels"] = $TmpValue.Applications.IncludeProtectionLevels
            }
            if ($TmpValue.Locations) {
                $Locations = @{}
                $Locations["IncludeLocations"] = $TmpValue.Locations.IncludeLocations
                $Locations["ExcludeLocations"] = $TmpValue.Locations.ExcludeLocations
            }
            if ($TmpValue.Platforms) {
                $Platforms = @{}
                $Platforms["IncludePlatforms"] = $TmpValue.Platforms.IncludePlatforms
                $Platforms["ExcludePlatforms"] = $TmpValue.Platforms.ExcludePlatforms
            }
            if ($TmpValue.Users) {
                $Users = @{}
                $Users["IncludeUsers"] = $TmpValue.Users.IncludeUsers
                $Users["ExcludeUsers"] = $TmpValue.Users.ExcludeUsers
                $Users["IncludeGroups"] = $TmpValue.Users.IncludeGroups
                $Users["ExcludeGroups"] = $TmpValue.Users.ExcludeGroups
                $Users["IncludeRoles"] = $TmpValue.Users.IncludeRoles
                $Users["ExcludeRoles"] = $TmpValue.Users.ExcludeRoles
            }

            $hash = @{}           
            if ($TmpValue.Applications) { $hash["Applications"] = $Applications }
            if ($TmpValue.ClientAppTypes) { $hash["ClientAppTypes"] = $TmpValue.ClientAppTypes }
            if ($TmpValue.Locations) { $hash["Locations"] = $Locations }
            if ($TmpValue.Platforms) { $hash["Platforms"] = $Platforms }
            if ($TmpValue.SignInRiskLevels) { $hash["SignInRiskLevels"] = $TmpValue.SignInRiskLevels }
            if ($TmpValue.Users) { $hash["Users"] = $Users }
            $Value = $hash
            $params["Conditions"] = $Value
        }
        if ($PSBoundParameters.ContainsKey("Verbose")) {
            $params["Verbose"] = $PSBoundParameters["Verbose"]
        }
        if ($null -ne $PSBoundParameters["ModifiedDateTime"]) {
            $params["ModifiedDateTime"] = $PSBoundParameters["ModifiedDateTime"]
        }
        if ($null -ne $PSBoundParameters["Id"]) {
            $params["Id"] = $PSBoundParameters["Id"]
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
        if ($null -ne $PSBoundParameters["CreatedDateTime"]) {
            $params["CreatedDateTime"] = $PSBoundParameters["CreatedDateTime"]
        }

        Write-Debug("============================ TRANSFORMATIONS ============================")
        $params.Keys | ForEach-Object { "$_ : $($params[$_])" } | Write-Debug
        Write-Debug("=========================================================================`n")
    
        $response = Update-MgBetaIdentityConditionalAccessPolicy @params -Headers $customHeaders
        $response | ForEach-Object {
            if ($null -ne $_) {
                Add-Member -InputObject $_ -MemberType AliasProperty -Name ObjectId -Value Id

            }
        }
        $response
    }
}

