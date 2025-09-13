# ------------------------------------------------------------------------------ 
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  
#  Licensed under the MIT License.  See License in the project root for license information. 
# ------------------------------------------------------------------------------ 
function New-EntraBetaIdentityProvider {
    [CmdletBinding(DefaultParameterSetName = 'ByProviderCredentials')]
    param (                
        [Parameter(ParameterSetName = "ByProviderCredentials")]
        [System.String] $Name,
                
        [Parameter(ParameterSetName = "ByProviderCredentials", Mandatory = $true)]
        [System.String] $ClientId,
                
        [Parameter(ParameterSetName = "ByProviderCredentials", Mandatory = $true)]
        [System.String] $Type,
                
        [Parameter(ParameterSetName = "ByProviderCredentials", Mandatory = $true)]
        [System.String] $ClientSecret
    )

    begin {
        # Ensure connection to Microsoft Entra
        if (-not (Get-EntraContext)) {
            $errorMessage = "Not connected to Microsoft Graph. Use 'Connect-Entra -Scopes IdentityProvider.ReadWrite.All' to authenticate."
            Write-Error -Message $errorMessage -ErrorAction Stop
            return
        }
    }

    PROCESS {    
        $params = @{}
        $customHeaders = New-EntraBetaCustomHeaders -Command $MyInvocation.MyCommand
        $body = @{}        
        if ($null -ne $PSBoundParameters["Id"]) {
            $params["IdentityProviderBaseId"] = $PSBoundParameters["Id"]
        }
        if ($null -ne $PSBoundParameters["Type"]) {
            $body["identityProviderType"] = $PSBoundParameters["Type"]
        }
        if ($PSBoundParameters.ContainsKey("Verbose")) {
            $params["Verbose"] = $PSBoundParameters["Verbose"]
        }
        if ($PSBoundParameters.ContainsKey("Debug")) {
            $params["Debug"] = $PSBoundParameters["Debug"]
        }
        if ($null -ne $PSBoundParameters["Name"]) {
            $body["displayName"] = $PSBoundParameters["Name"]
        }
        if ($null -ne $PSBoundParameters["ClientId"]) {
            $body["clientId"] = $PSBoundParameters["ClientId"]
        }
        if ($null -ne $PSBoundParameters["ClientSecret"]) {
            $body["clientSecret"] = $PSBoundParameters["ClientSecret"]
        }
        if ($null -ne $PSBoundParameters["WarningVariable"]) {
            $params["WarningVariable"] = $PSBoundParameters["WarningVariable"]
        }
        if ($null -ne $PSBoundParameters["InformationVariable"]) {
            $params["InformationVariable"] = $PSBoundParameters["InformationVariable"]
        }
        if ($null -ne $PSBoundParameters["InformationAction"]) {
            $params["InformationAction"] = $PSBoundParameters["InformationAction"]
        }
        if ($null -ne $PSBoundParameters["OutVariable"]) {
            $params["OutVariable"] = $PSBoundParameters["OutVariable"]
        }
        if ($null -ne $PSBoundParameters["OutBuffer"]) {
            $params["OutBuffer"] = $PSBoundParameters["OutBuffer"]
        }
        if ($null -ne $PSBoundParameters["ErrorVariable"]) {
            $params["ErrorVariable"] = $PSBoundParameters["ErrorVariable"]
        }
        if ($null -ne $PSBoundParameters["PipelineVariable"]) {
            $params["PipelineVariable"] = $PSBoundParameters["PipelineVariable"]
        }
        if ($null -ne $PSBoundParameters["ErrorAction"]) {
            $params["ErrorAction"] = $PSBoundParameters["ErrorAction"]
        }
        if ($null -ne $PSBoundParameters["WarningAction"]) {
            $params["WarningAction"] = $PSBoundParameters["WarningAction"]
        }
        $body["@odata.type"] = "#microsoft.graph.socialIdentityProvider"
        $params["BodyParameter"] = $body 
    
        Write-Debug("============================ TRANSFORMATIONS ============================")
        $params.Keys | ForEach-Object { "$_ : $($params[$_])" } | Write-Debug
        Write-Debug("=========================================================================`n")
        
        $response = New-MgBetaIdentityProvider @params -Headers $customHeaders
        $response | ForEach-Object {
            if ($null -ne $_) {
                Add-Member -InputObject $_ -NotePropertyMembers $_.AdditionalProperties
                Add-Member -InputObject $_ -MemberType AliasProperty -Name ObjectId -Value Id
                Add-Member -InputObject $_ -MemberType AliasProperty -Name Name -Value DisplayName
                Add-Member -InputObject $_ -MemberType AliasProperty -Name Type -Value identityProviderType
            }
        }
        $response
    }    
}

