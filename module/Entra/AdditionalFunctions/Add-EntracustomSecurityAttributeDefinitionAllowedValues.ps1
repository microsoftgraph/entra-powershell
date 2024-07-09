function Add-EntraCustomSecurityAttributeDefinitionAllowedValues {
    [CmdletBinding(DefaultParameterSetName = 'InvokeByDynamicParameters')]
    param (
        [Parameter(ParameterSetName = "InvokeByDynamicParameters", Mandatory = $true)]
        [System.String] $Id,
        [Parameter(ParameterSetName = "InvokeByDynamicParameters", Mandatory = $true)]
        [System.Nullable`1[System.Boolean]] $IsActive,
        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
        [System.String] $CustomSecurityAttributeDefinitionId
    )

    PROCESS {    
        $params = @{}
        $body = @{}
        $customHeaders = New-EntraCustomHeaders -Command $MyInvocation.MyCommand
        if ($null -ne $PSBoundParameters["ErrorAction"]) {
            $params["ErrorAction"] = $PSBoundParameters["ErrorAction"]
        }
        if ($null -ne $PSBoundParameters["Id"]) {
            $body["Id"] = $PSBoundParameters["Id"]
        }
        if ($null -ne $PSBoundParameters["PipelineVariable"]) {
            $params["PipelineVariable"] = $PSBoundParameters["PipelineVariable"]
        }
        if ($null -ne $PSBoundParameters["OutVariable"]) {
            $params["OutVariable"] = $PSBoundParameters["OutVariable"]
        }
        if ($null -ne $PSBoundParameters["IsActive"]) {
            $body["IsActive"] = $PSBoundParameters["IsActive"]
        }
        if ($null -ne $PSBoundParameters["InformationAction"]) {
            $params["InformationAction"] = $PSBoundParameters["InformationAction"]
        }
        if ($null -ne $PSBoundParameters["WarningVariable"]) {
            $params["WarningVariable"] = $PSBoundParameters["WarningVariable"]
        }
        if ($PSBoundParameters.ContainsKey("Verbose")) {
            $params["Verbose"] = $Null
        }
        if ($PSBoundParameters.ContainsKey("Debug")) {
            $params["Debug"] = $Null
        }
        if ($null -ne $PSBoundParameters["ErrorVariable"]) {
            $params["ErrorVariable"] = $PSBoundParameters["ErrorVariable"]
        }
        if ($null -ne $PSBoundParameters["OutBuffer"]) {
            $params["OutBuffer"] = $PSBoundParameters["OutBuffer"]
        }
        if ($null -ne $PSBoundParameters["WarningAction"]) {
            $params["WarningAction"] = $PSBoundParameters["WarningAction"]
        }
        if ($null -ne $PSBoundParameters["InformationVariable"]) {
            $params["InformationVariable"] = $PSBoundParameters["InformationVariable"]
        }

        Write-Debug("============================ TRANSFORMATIONS ============================")
        $params.Keys | ForEach-Object { "$_ : $($params[$_])" } | Write-Debug
        Write-Debug("=========================================================================`n")
        
        $Uri = "https://graph.microsoft.com/v1.0/directory/customSecurityAttributeDefinitions/$CustomSecurityAttributeDefinitionId/allowedValues"
        $Method = "POST"
        $response = Invoke-GraphRequest -Uri $Uri -Method $Method -Body $body -Headers $customHeaders
        $response
    }
}