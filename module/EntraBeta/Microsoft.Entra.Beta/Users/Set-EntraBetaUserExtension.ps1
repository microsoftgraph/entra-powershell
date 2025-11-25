# ------------------------------------------------------------------------------ 
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  
#  Licensed under the MIT License.  See License in the project root for license information. 
# ------------------------------------------------------------------------------ 
function Set-EntraBetaUserExtension {
    [CmdletBinding(DefaultParameterSetName = 'SetSingle')]
    param (
        [Parameter(ParameterSetName = "SetSingle", Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = "The user to set the extension property for. For example`, 'user@domain.com'")]
        [Parameter(ParameterSetName = "SetMultiple", Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = "The user to set the extension property for. For example`, 'user@domain.com'")]
        [Alias('ObjectId', 'UPN', 'Identity', 'UserPrincipalName')]
        [ValidateNotNullOrEmpty()]
        [ValidateScript({
                if ($_ -match '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$' -or 
                    $_ -match '^[0-9a-fA-F]{8}-([0-9a-fA-F]{4}-){3}[0-9a-fA-F]{12}$') {
                    return $true
                }
                throw "UserId must be a valid email address or GUID."
            })]
        [System.String] $UserId,
                
        [Parameter(ParameterSetName = "SetMultiple", Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = "The dictionary of extension name and values. For example`, @{extension_d2ba83696c3f45429fbabb363ae391a0_JobGroup='Job Group N'; extension_d2ba83696c3f45429fbabb363ae391a0_JobTitle='Job Title N'}")]
        [ValidateNotNullOrEmpty()]
        [System.Collections.Generic.Dictionary`2[System.String, System.String]] $ExtensionNameValues,
                
        [Parameter(ParameterSetName = "SetSingle", Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = "The value of the extension property to set. For example`, 'Job Group N'")]
        [ValidateNotNullOrEmpty()]
        [System.String] $ExtensionValue,
                
        [Parameter(ParameterSetName = "SetSingle", Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = "The name of the extension property to set. For example`, extension_d2ba83696c3f45429fbabb363ae391a0_JobGroup")]
        [ValidateNotNullOrEmpty()]
        [System.String] $ExtensionName
    )

    begin {

        # Ensure connection to Microsoft Entra
        if (-not (Get-EntraContext)) {
            $errorMessage = "Not connected to Microsoft Graph. Use 'Connect-Entra -Scopes User.ReadWrite.All' to authenticate."
            Write-Error -Message $errorMessage -ErrorAction Stop
            return
        }

    }

    PROCESS {    
        $params = @{}
        $customHeaders = New-EntraBetaCustomHeaders -Command $MyInvocation.MyCommand
    
        if ($null -ne $PSBoundParameters["UserId"]) {
            $params["UserId"] = $PSBoundParameters["UserId"]
        }
        if ($null -ne $PSBoundParameters["ProgressAction"]) {
            $params["ProgressAction"] = $PSBoundParameters["ProgressAction"]
        }
        if ($null -ne $PSBoundParameters["WarningVariable"]) {
            $params["WarningVariable"] = $PSBoundParameters["WarningVariable"]
        }
        if ($null -ne $PSBoundParameters["ExtensionNameValues"]) {
            $params["ExtensionNameValues"] = $PSBoundParameters["ExtensionNameValues"]
        }
        if ($null -ne $PSBoundParameters["ExtensionValue"]) {
            $params["ExtensionValue"] = $PSBoundParameters["ExtensionValue"]
        }
        if ($null -ne $PSBoundParameters["PipelineVariable"]) {
            $params["PipelineVariable"] = $PSBoundParameters["PipelineVariable"]
        }
        if ($null -ne $PSBoundParameters["ExtensionName"]) {
            $params["ExtensionName"] = $PSBoundParameters["ExtensionName"]
        }
        if ($null -ne $PSBoundParameters["OutBuffer"]) {
            $params["OutBuffer"] = $PSBoundParameters["OutBuffer"]
        }
        if ($null -ne $PSBoundParameters["ErrorVariable"]) {
            $params["ErrorVariable"] = $PSBoundParameters["ErrorVariable"]
        }
        if ($null -ne $PSBoundParameters["ErrorAction"]) {
            $params["ErrorAction"] = $PSBoundParameters["ErrorAction"]
        }
        if ($null -ne $PSBoundParameters["InformationVariable"]) {
            $params["InformationVariable"] = $PSBoundParameters["InformationVariable"]
        }
        if ($null -ne $PSBoundParameters["InformationAction"]) {
            $params["InformationAction"] = $PSBoundParameters["InformationAction"]
        }
        if ($null -ne $PSBoundParameters["WarningAction"]) {
            $params["WarningAction"] = $PSBoundParameters["WarningAction"]
        }
        if ($null -ne $PSBoundParameters["OutVariable"]) {
            $params["OutVariable"] = $PSBoundParameters["OutVariable"]
        }
        if ($PSBoundParameters.ContainsKey("Debug")) {
            $params["Debug"] = $PSBoundParameters["Debug"]
        }
        if ($PSBoundParameters.ContainsKey("Verbose")) {
            $params["Verbose"] = $PSBoundParameters["Verbose"]
        }

        $uri = "/beta/users/$UserId"

        Write-Debug("============================ TRANSFORMATIONS ============================")
        $params.Keys | ForEach-Object { "$_ : $($params[$_])" } | Write-Debug
        Write-Debug("=========================================================================`n")

        if ($PSCmdlet.ParameterSetName -eq "SetSingle") {
            $properties = @{ $ExtensionName = $ExtensionValue }
            $jsonBody = $properties | ConvertTo-Json -Depth 2
            $response = Invoke-MgGraphRequest -Method PATCH -Uri $uri -Body $jsonBody -ContentType "application/json" -Headers $customHeaders
            return $response
        }
        elseif ($PSCmdlet.ParameterSetName -eq "SetMultiple") {
            $properties = @{}
            foreach ($key in $ExtensionNameValues.Keys) {
                $properties[$key] = $ExtensionNameValues[$key]
            }
           
            # Convert hashtable to JSON
            $jsonBody = $properties | ConvertTo-Json -Depth 2
            # Make the PATCH request to update the user properties            
            $response = Invoke-MgGraphRequest -Method PATCH -Uri $uri -Body $jsonBody -ContentType "application/json" -Headers $customHeaders
            
            return $response
        }
    }
}
Set-Alias -Name Update-EntraBetaUserExtension -Value Set-EntraBetaUserExtension -Scope Global -Force
