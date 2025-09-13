# ------------------------------------------------------------------------------ 
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  
#  Licensed under the MIT License.  See License in the project root for license information. 
# ------------------------------------------------------------------------------ 
function Get-EntraFederationProperty {
    [CmdletBinding(DefaultParameterSetName = 'GetQuery')]
    param (
        [Parameter(ParameterSetName = "GetById", Mandatory = $true, ValueFromPipeline = $false, ValueFromPipelineByPropertyName = $false)][System.String] $DomainName,
        [Parameter(ParameterSetName = "GetQuery", Mandatory = $false, ValueFromPipeline = $false, ValueFromPipelineByPropertyName = $false)][Switch] $SupportMultipleDomain
    )

    begin {
        # Ensure connection to Microsoft Entra
        if (-not (Get-EntraContext)) {
            $errorMessage = "Not connected to Microsoft Graph. Use 'Connect-Entra -Scopes Domain.Read.All' to authenticate."
            Write-Error -Message $errorMessage -ErrorAction Stop
            return
        }
    }

    PROCESS {    
        $params = @{}
        $customHeaders = New-EntraCustomHeaders -Command $MyInvocation.MyCommand        
        if ($PSBoundParameters.ContainsKey("Verbose")) {
            $params["Verbose"] = $PSBoundParameters["Verbose"]
        }
        if ($null -ne $PSBoundParameters["DomainName"]) {
            $params["DomainId"] = $PSBoundParameters["DomainName"]
        }
        if ($PSBoundParameters.ContainsKey("Debug")) {
            $params["Debug"] = $PSBoundParameters["Debug"]
        }
        if($null -ne $PSBoundParameters["WarningVariable"])
        {
            $params["WarningVariable"] = $PSBoundParameters["WarningVariable"]
        }
        if($null -ne $PSBoundParameters["InformationVariable"])
        {
            $params["InformationVariable"] = $PSBoundParameters["InformationVariable"]
        }
	    if($null -ne $PSBoundParameters["InformationAction"])
        {
            $params["InformationAction"] = $PSBoundParameters["InformationAction"]
        }
        if($null -ne $PSBoundParameters["OutVariable"])
        {
            $params["OutVariable"] = $PSBoundParameters["OutVariable"]
        }
        if($null -ne $PSBoundParameters["OutBuffer"])
        {
            $params["OutBuffer"] = $PSBoundParameters["OutBuffer"]
        }
        if($null -ne $PSBoundParameters["ErrorVariable"])
        {
            $params["ErrorVariable"] = $PSBoundParameters["ErrorVariable"]
        }
        if($null -ne $PSBoundParameters["PipelineVariable"])
        {
            $params["PipelineVariable"] = $PSBoundParameters["PipelineVariable"]
        }
        if($null -ne $PSBoundParameters["ErrorAction"])
        {
            $params["ErrorAction"] = $PSBoundParameters["ErrorAction"]
        }
        if($null -ne $PSBoundParameters["WarningAction"])
        {
            $params["WarningAction"] = $PSBoundParameters["WarningAction"]
        }
        Write-Debug("============================ TRANSFORMATIONS ============================")
        $params.Keys | ForEach-Object { "$_ : $($params[$_])" } | Write-Debug
        Write-Debug("=========================================================================`n")
        $response = Get-MgDomainFederationConfiguration @params -Headers $customHeaders
        $response | ForEach-Object {
            if($null -ne $_) {
            Add-Member -InputObject $_ -MemberType AliasProperty -Name ActiveClientSignInUrl -Value ActiveSignInUri
            Add-Member -InputObject $_ -MemberType AliasProperty -Name FederationServiceDisplayName -Value DisplayName
            Add-Member -InputObject $_ -MemberType AliasProperty -Name FederationServiceIdentifier -Value IssuerUri
            Add-Member -InputObject $_ -MemberType AliasProperty -Name FederationMetadataUrl -Value MetadataExchangeUri
            Add-Member -InputObject $_ -MemberType AliasProperty -Name PassiveClientSignInUrl -Value PassiveSignInUri
            Add-Member -InputObject $_ -MemberType AliasProperty -Name PassiveClientSignOutUrl -Value SignOutUri
            }
        }
        $response

    }
}# ------------------------------------------------------------------------------

