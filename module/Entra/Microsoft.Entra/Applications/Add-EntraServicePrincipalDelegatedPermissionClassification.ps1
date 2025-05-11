# ------------------------------------------------------------------------------ 
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  
#  Licensed under the MIT License.  See License in the project root for license information. 
# ------------------------------------------------------------------------------ 
function Add-EntraServicePrincipalDelegatedPermissionClassification {
    [CmdletBinding(DefaultParameterSetName = 'ByServicePrincipalAndPermissionInfo')]
    param (                
        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = "Unique ID of the service principal object (Service Principal Object ID).")]
        [Alias('ObjectId')]
        [ValidateNotNullOrEmpty()]
        [guid] $ServicePrincipalId,
                
        [Parameter(ParameterSetName = "ByServicePrincipalAndPermissionInfo", Mandatory = $true, HelpMessage = "Permission classification. e.g. Low, Medium, High")]
        [ValidateNotNullOrEmpty()]
        [System.Nullable`1[Microsoft.Open.MSGraph.Model.DelegatedPermissionClassification+ClassificationEnum]] $Classification,
                
        [Parameter(ParameterSetName = "ByServicePrincipalAndPermissionInfo", Mandatory = $true, HelpMessage = "Unique ID of the permission. e.g. 00000000-0000-0000-0000-000000000000")]
        [ValidateNotNullOrEmpty()]
        [guid] $PermissionId,
                
        [Parameter(ParameterSetName = "ByServicePrincipalAndPermissionInfo", Mandatory = $true, HelpMessage = "Name of the permission. e.g. HR.Read.All")]
        [ValidateNotNullOrEmpty()]
        [System.String] $PermissionName
    )

    begin {
        # Ensure connection to Microsoft Entra
        if (-not (Get-EntraContext)) {
            $errorMessage = "Not connected to Microsoft Graph. Use 'Connect-Entra -Scopes Policy.ReadWrite.PermissionGrant' to authenticate."
            Write-Error -Message $errorMessage -ErrorAction Stop
            return
        }
    }

    PROCESS {    
        $params = @{}
        $customHeaders = New-EntraCustomHeaders -Command $MyInvocation.MyCommand
    
        if ($null -ne $PSBoundParameters["ServicePrincipalId"]) {
            $params["ServicePrincipalId"] = $PSBoundParameters["ServicePrincipalId"]
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
        if ($null -ne $PSBoundParameters["Classification"]) {
            $params["Classification"] = $PSBoundParameters["Classification"]
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
        if ($null -ne $PSBoundParameters["PermissionId"]) {
            $params["PermissionId"] = $PSBoundParameters["PermissionId"]
        }
        if ($null -ne $PSBoundParameters["PermissionName"]) {
            $params["PermissionName"] = $PSBoundParameters["PermissionName"]
        }
        if ($null -ne $PSBoundParameters["ErrorVariable"]) {
            $params["ErrorVariable"] = $PSBoundParameters["ErrorVariable"]
        }
        if ($null -ne $PSBoundParameters["ErrorAction"]) {
            $params["ErrorAction"] = $PSBoundParameters["ErrorAction"]
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
        if ($null -ne $PSBoundParameters["OutVariable"]) {
            $params["OutVariable"] = $PSBoundParameters["OutVariable"]
        }

        Write-Debug("============================ TRANSFORMATIONS ============================")
        $params.Keys | ForEach-Object { "$_ : $($params[$_])" } | Write-Debug
        Write-Debug("=========================================================================`n")
    
        $response = New-MgServicePrincipalDelegatedPermissionClassification @params -Headers $customHeaders
        $response | ForEach-Object {
            if ($null -ne $_) {
                Add-Member -InputObject $_ -MemberType AliasProperty -Name ObjectId -Value Id

            }
        }
        $response
    }
}

