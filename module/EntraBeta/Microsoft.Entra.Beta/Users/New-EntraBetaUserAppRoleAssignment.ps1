# ------------------------------------------------------------------------------ 
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  
#  Licensed under the MIT License.  See License in the project root for license information. 
# ------------------------------------------------------------------------------ 
function New-EntraBetaUserAppRoleAssignment {
    [CmdletBinding(DefaultParameterSetName = 'ByUserIdAndRoleParameters')]
    param (                
        [Parameter(ParameterSetName = "ByUserIdAndRoleParameters", Mandatory = $true, HelpMessage = "Specifies the object ID of the principal (user`, group`, or service principal) to assign the app role to.")]
        [ValidateNotNullOrEmpty()]
        [guid] $PrincipalId,
                
        [Parameter(ParameterSetName = "ByUserIdAndRoleParameters", Mandatory = $true, HelpMessage = "Specifies the object ID of the resource service principal (application) that exposes the app role.")]
        [ValidateNotNullOrEmpty()]
        [guid] $ResourceId,
                
        [Parameter(ParameterSetName = "ByUserIdAndRoleParameters", Mandatory = $true, HelpMessage = "Specifies the ID of the app role to assign to the user.")]
        [ValidateNotNullOrEmpty()]
        [Alias("Id")]
        [guid] $AppRoleId,
                
        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = "Specifies the ID of the user (as a UserPrincipalName or ObjectId) to whom the app role is assigned.")]
        [ValidateNotNullOrEmpty()]
        [Alias("ObjectId")]
        [guid] $UserId
    )

    begin {
        # Ensure connection to Microsoft Entra
        if (-not (Get-EntraContext)) {
            $errorMessage = "Not connected to Microsoft Graph. Use 'Connect-Entra -Scopes AppRoleAssignment.ReadWrite.All' to authenticate."
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
        if ($null -ne $PSBoundParameters["UserId"]) {
            $params["UserId"] = $PSBoundParameters["UserId"]
        }
        if ($null -ne $PSBoundParameters["OutVariable"]) {
            $params["OutVariable"] = $PSBoundParameters["OutVariable"]
        }
        if ($PSBoundParameters.ContainsKey("Verbose")) {
            $params["Verbose"] = $PSBoundParameters["Verbose"]
        }
        if ($null -ne $PSBoundParameters["AppRoleId"]) {
            $params["AppRoleId"] = $PSBoundParameters["AppRoleId"]
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
        if ($null -ne $PSBoundParameters["PrincipalId"]) {
            $params["PrincipalId"] = $PSBoundParameters["PrincipalId"]
        }
        if ($null -ne $PSBoundParameters["ResourceId"]) {
            $params["ResourceId"] = $PSBoundParameters["ResourceId"]
        }

        Write-Debug("============================ TRANSFORMATIONS ============================")
        $params.Keys | ForEach-Object { "$_ : $($params[$_])" } | Write-Debug
        Write-Debug("=========================================================================`n")
    
        $response = New-MgBetaUserAppRoleAssignment @params -Headers $customHeaders
        $response | ForEach-Object {
            if ($null -ne $_) {
                Add-Member -InputObject $_ -MemberType AliasProperty -Name ObjectId -Value Id

            }
        }
        $response
    }
}

