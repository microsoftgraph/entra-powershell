# ------------------------------------------------------------------------------ 
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  
#  Licensed under the MIT License.  See License in the project root for license information. 
# ------------------------------------------------------------------------------ 
function Add-EntraBetaApplicationOwner {
    [CmdletBinding(DefaultParameterSetName = 'ByApplicationIdAndOwnerId')]
    param (
        [Alias('ObjectId')]
        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = "Unique ID of the application object (Application Object ID).")]
        [System.String] $ApplicationId,

        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = "The ID of the user, group, or service principal to be added as an owner of the application.")]
        [Alias('RefObjectId')]
        [System.String] $OwnerId
    )

    begin {
        # Ensure connection to Microsoft Entra
        if (-not (Get-EntraContext)) {
            $errorMessage = "Not connected to Microsoft Graph. Use 'Connect-Entra -Scopes Application.ReadWrite.All' to authenticate."
            Write-Error -Message $errorMessage -ErrorAction Stop
            return
        }

        # Get the Graph endpoint from the current environment
        $environment = (Get-EntraContext).Environment
        $graphEndpoint = (Get-EntraEnvironment | Where-Object Name -eq $environment).GraphEndPoint

        # Default to global endpoint if not found
        if (-not $graphEndpoint) {
            $graphEndpoint = "https://graph.microsoft.com"
            Write-Verbose "Using default Graph endpoint: $graphEndpoint"
        }
        else {
            Write-Verbose "Using environment-specific Graph endpoint: $graphEndpoint"
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
        if ($null -ne $PSBoundParameters["WarningVariable"]) {
            $params["WarningVariable"] = $PSBoundParameters["WarningVariable"]
        }
        if ($null -ne $PSBoundParameters["WarningAction"]) {
            $params["WarningAction"] = $PSBoundParameters["WarningAction"]
        }
        if ($null -ne $PSBoundParameters["OwnerId"]) {
            $TmpValue = $PSBoundParameters["OwnerId"]
            $Value = "$graphEndpoint/beta/directoryObjects/$TmpValue"
            $params["OdataId"] = $Value
        }
        if ($null -ne $PSBoundParameters["ApplicationId"]) {
            $params["ApplicationId"] = $PSBoundParameters["ApplicationId"]
        }
        if ($null -ne $PSBoundParameters["OutVariable"]) {
            $params["OutVariable"] = $PSBoundParameters["OutVariable"]
        }
        if ($PSBoundParameters.ContainsKey("Verbose")) {
            $params["Verbose"] = $PSBoundParameters["Verbose"]
        }
        if ($null -ne $PSBoundParameters["PipelineVariable"]) {
            $params["PipelineVariable"] = $PSBoundParameters["PipelineVariable"]
        }
        if ($null -ne $PSBoundParameters["InformationAction"]) {
            $params["InformationAction"] = $PSBoundParameters["InformationAction"]
        }
        if ($null -ne $PSBoundParameters["InformationVariable"]) {
            $params["InformationVariable"] = $PSBoundParameters["InformationVariable"]
        }
        if ($null -ne $PSBoundParameters["ErrorAction"]) {
            $params["ErrorAction"] = $PSBoundParameters["ErrorAction"]
        }
        if ($null -ne $PSBoundParameters["ErrorVariable"]) {
            $params["ErrorVariable"] = $PSBoundParameters["ErrorVariable"]
        }

        Write-Debug("============================ TRANSFORMATIONS ============================")
        $params.Keys | ForEach-Object { "$_ : $($params[$_])" } | Write-Debug
        Write-Debug("=========================================================================`n")
    
        $response = New-MgBetaApplicationOwnerByRef @params -Headers $customHeaders
        $response | ForEach-Object {
            if ($null -ne $_) {
                Add-Member -InputObject $_ -MemberType AliasProperty -Name ObjectId -Value Id

            }
        }
        $response
    }
}

