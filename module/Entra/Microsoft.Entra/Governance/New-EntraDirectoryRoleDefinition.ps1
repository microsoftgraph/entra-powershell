# ------------------------------------------------------------------------------ 
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  
#  Licensed under the MIT License.  See License in the project root for license information. 
# ------------------------------------------------------------------------------ 
function New-EntraDirectoryRoleDefinition {
    [CmdletBinding(DefaultParameterSetName = 'CreateRoleDefinition')]
    param (
                
        [Parameter(ParameterSetName = "CreateRoleDefinition", Mandatory = $true)]
        [System.Collections.Generic.List`1[Microsoft.Open.MSGraph.Model.RolePermission]] $RolePermissions,
                
        [Parameter(ParameterSetName = "CreateRoleDefinition")]
        [System.Collections.Generic.List`1[System.String]] $ResourceScopes,
                
        [Parameter(ParameterSetName = "CreateRoleDefinition")]
        [System.String] $Description,
                
        [Parameter(ParameterSetName = "CreateRoleDefinition")]
        [System.String] $Version,
                
        [Parameter(ParameterSetName = "CreateRoleDefinition")]
        [System.String] $TemplateId,
                
        [Parameter(ParameterSetName = "CreateRoleDefinition", Mandatory = $true)]
        [System.Nullable`1[System.Boolean]] $IsEnabled,
                
        [Parameter(ParameterSetName = "CreateRoleDefinition", Mandatory = $true)]
        [System.String] $DisplayName
    )

    begin {
        # Ensure connection to Microsoft Entra
        if (-not (Get-EntraContext)) {
            $errorMessage = "Not connected to Microsoft Graph. Use 'Connect-Entra -Scopes RoleManagement.ReadWrite.Directory' to authenticate."
            Write-Error -Message $errorMessage -ErrorAction Stop
            return
        }
    }

    PROCESS {    
        $params = @{}
        $customHeaders = New-EntraCustomHeaders -Command $MyInvocation.MyCommand
    
        if ($null -ne $PSBoundParameters["RolePermissions"]) {
            $TmpValue = $PSBoundParameters["RolePermissions"]
            $Temp = @{
                allowedResourceActions = $TmpValue.allowedResourceActions
                condition              = $TmpValue.condition
            }
            $Value = $Temp 
            $params["RolePermissions"] = $Value
        }
        if ($null -ne $PSBoundParameters["OutVariable"]) {
            $params["OutVariable"] = $PSBoundParameters["OutVariable"]
        }
        if ($null -ne $PSBoundParameters["ResourceScopes"]) {
            $params["ResourceScopes"] = $PSBoundParameters["ResourceScopes"]
        }
        if ($null -ne $PSBoundParameters["Description"]) {
            $params["Description"] = $PSBoundParameters["Description"]
        }
        if ($PSBoundParameters.ContainsKey("Debug")) {
            $params["Debug"] = $PSBoundParameters["Debug"]
        }
        if ($null -ne $PSBoundParameters["PipelineVariable"]) {
            $params["PipelineVariable"] = $PSBoundParameters["PipelineVariable"]
        }
        if ($null -ne $PSBoundParameters["InformationVariable"]) {
            $params["InformationVariable"] = $PSBoundParameters["InformationVariable"]
        }
        if ($null -ne $PSBoundParameters["OutBuffer"]) {
            $params["OutBuffer"] = $PSBoundParameters["OutBuffer"]
        }
        if ($null -ne $PSBoundParameters["WarningVariable"]) {
            $params["WarningVariable"] = $PSBoundParameters["WarningVariable"]
        }
        if ($PSBoundParameters.ContainsKey("Verbose")) {
            $params["Verbose"] = $PSBoundParameters["Verbose"]
        }
        if ($null -ne $PSBoundParameters["Version"]) {
            $params["Version"] = $PSBoundParameters["Version"]
        }
        if ($null -ne $PSBoundParameters["ErrorVariable"]) {
            $params["ErrorVariable"] = $PSBoundParameters["ErrorVariable"]
        }
        if ($null -ne $PSBoundParameters["ErrorAction"]) {
            $params["ErrorAction"] = $PSBoundParameters["ErrorAction"]
        }
        if ($null -ne $PSBoundParameters["TemplateId"]) {
            $params["TemplateId"] = $PSBoundParameters["TemplateId"]
        }
        if ($null -ne $PSBoundParameters["IsEnabled"]) {
            $params["IsEnabled"] = $PSBoundParameters["IsEnabled"]
        }
        if ($null -ne $PSBoundParameters["InformationAction"]) {
            $params["InformationAction"] = $PSBoundParameters["InformationAction"]
        }
        if ($null -ne $PSBoundParameters["WarningAction"]) {
            $params["WarningAction"] = $PSBoundParameters["WarningAction"]
        }
        if ($null -ne $PSBoundParameters["ProgressAction"]) {
            $params["ProgressAction"] = $PSBoundParameters["ProgressAction"]
        }
        if ($null -ne $PSBoundParameters["DisplayName"]) {
            $params["DisplayName"] = $PSBoundParameters["DisplayName"]
        }

        Write-Debug("============================ TRANSFORMATIONS ============================")
        $params.Keys | ForEach-Object { "$_ : $($params[$_])" } | Write-Debug
        Write-Debug("=========================================================================`n")
    
        $response = New-MgRoleManagementDirectoryRoleDefinition @params -Headers $customHeaders
        $response | ForEach-Object {
            if ($null -ne $_) {
                Add-Member -InputObject $_ -MemberType AliasProperty -Name ObjectId -Value Id

            }
        }
        $response
    }
}

