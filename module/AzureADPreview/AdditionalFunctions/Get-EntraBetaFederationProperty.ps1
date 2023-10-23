# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
function Get-EntraBetaFederationProperty {
    <#
    .SYNOPSIS
        For the specified domain, displays the properties of the Active Directory Federation Services 2.0 server and Microsoft Online.
    
    
    .DESCRIPTION
        The Get-EntraBetaFederationProperty cmdlet gets key settings from both the Active Directory Federation Services 2.0 server and Microsoft Online. You can use this
    information to troubleshoot authentication problems caused by mismatched settings between the Active Directory Federation Services 2.0 server and Microsoft Online.

    .PARAMETER DomainName
        The domain name for which the properties from both the Active Directory Federation Services 2.0 server and Microsoft Online will be displayed.

    .PARAMETER SupportMultipleDomain
       

    .PARAMETER <CommonParameters>
        This cmdlet supports the common parameters: Verbose, Debug,
        ErrorAction, ErrorVariable, WarningAction, WarningVariable,
        OutBuffer, PipelineVariable, and OutVariable. For more information, see 
        about_CommonParameters (https:/go.microsoft.com/fwlink/?LinkID=113216).
    
        
    #>
    [CmdletBinding(DefaultParameterSetName = 'GetQuery')]
    param (
        [Parameter(ParameterSetName = "GetById", Mandatory = $true, ValueFromPipeline = $false, ValueFromPipelineByPropertyName = $false)][System.String] $DomainName,
        [Parameter(ParameterSetName = "GetQuery", Mandatory = $false, ValueFromPipeline = $false, ValueFromPipelineByPropertyName = $false)][Switch] $SupportMultipleDomain
        )

    PROCESS {    
        $params = @{}
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
        $response = Get-MgBetaDomainFederationConfiguration @params
        $response
    }
}