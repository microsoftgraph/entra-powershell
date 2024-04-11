# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
function Get-EntraFederationProperty {
    [CmdletBinding(DefaultParameterSetName = 'GetQuery')]
    param (
        [Parameter(ParameterSetName = "GetById", Mandatory = $true, ValueFromPipeline = $false, ValueFromPipelineByPropertyName = $false)][System.String] $DomainName,
        [Parameter(ParameterSetName = "GetQuery", Mandatory = $false, ValueFromPipeline = $false, ValueFromPipelineByPropertyName = $false)][Switch] $SupportMultipleDomain
        )

    PROCESS {    
        $params = @{}
        $customHeaders = New-EntraCustomHeaders -Command $MyInvocation.MyCommand
        $keysChanged = @{}
        if ($PSBoundParameters.ContainsKey("Verbose")) {
            $params["Verbose"] = $Null
        }
        if ($null -ne $PSBoundParameters["DomainName"]) {
            $params["DomainId"] = $PSBoundParameters["DomainName"]
        }
        if ($PSBoundParameters.ContainsKey("Debug")) {
            $params["Debug"] = $Null
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
}