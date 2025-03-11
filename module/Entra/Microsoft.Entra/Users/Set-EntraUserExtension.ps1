# ------------------------------------------------------------------------------ 
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  
#  Licensed under the MIT License.  See License in the project root for license information. 
# ------------------------------------------------------------------------------ 
function Set-EntraUserExtension {
    [CmdletBinding(DefaultParameterSetName = '')]
    param (
        [Alias('ObjectId')]            
        [Parameter(ParameterSetName = "SetSingle", Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
        [Parameter(ParameterSetName = "SetMultiple", Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
        [System.String] $UserId,
                
        [Parameter(ParameterSetName = "SetMultiple", Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
        [System.Collections.Generic.Dictionary`2[System.String, System.String]] $ExtensionNameValues,
                
        [Parameter(ParameterSetName = "SetSingle", Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
        [System.String] $ExtensionValue,
                
        [Parameter(ParameterSetName = "SetSingle", Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
        [System.String] $ExtensionName
    )

    begin {
        # Ensure Microsoft Entra PowerShell module is available
        if (-not (Get-Module -ListAvailable -Name Microsoft.Entra.Users)) {
            Write-Error "Microsoft.Entra module is required. Install it using 'Install-Module Microsoft.Entra.Users'. See http://aka.ms/entra/ps/installation for more details."
            return
        }

        # Ensure connection to Microsoft Entra
        if (-not (Get-EntraContext)) {
            Write-Error "Not connected to Microsoft Graph. Use 'Connect-Entra -Scopes User.ReadWrite.All' to authenticate."
            return
        }
    }

    PROCESS {    
        $params = @{}
        $customHeaders = New-EntraCustomHeaders -Command $MyInvocation.MyCommand
    
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

        Write-Debug("============================ TRANSFORMATIONS ============================")
        $params.Keys | ForEach-Object { "$_ : $($params[$_])" } | Write-Debug
        Write-Debug("=========================================================================`n")

        if ($PSCmdlet.ParameterSetName -eq "SetSingle") {
            $additionalProperties = @{ $ExtensionName = $ExtensionValue }
            $response = Set-EntraUser -UserId $UserId -AdditionalProperties $additionalProperties -Headers $customHeaders
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
            $uri = "https://graph.microsoft.com/v1.0/users/$UserId"
            $response = Invoke-MgGraphRequest -Method PATCH -Uri $uri -Body $jsonBody -ContentType "application/json" -Headers $customHeaders
            
            return $response
        }    
    }

}
Set-Alias -Name Update-EntraUserExtension -Value Set-EntraUserExtension -Scope Global -Force
