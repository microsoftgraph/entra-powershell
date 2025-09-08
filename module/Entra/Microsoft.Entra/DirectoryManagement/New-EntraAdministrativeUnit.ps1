# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
function New-EntraAdministrativeUnit {
    [CmdletBinding(DefaultParameterSetName = 'Default')]
    param (
        [Parameter(ParameterSetName = "Default", HelpMessage = "Description of the administrative unit.")]
        [System.String] $Description,

        [Parameter(ParameterSetName = "Default", Mandatory = $true, HelpMessage = "Display name of the administrative unit.")]
        [System.String] $DisplayName,

        [Parameter(ParameterSetName = "Default", HelpMessage = "Membership rule for the administrative unit.")]
        [System.String] $MembershipRule,

        [Parameter(ParameterSetName = "Default", HelpMessage = "Membership rule processing state for the administrative unit.")]
        [System.String] $MembershipRuleProcessingState,

        [Parameter(ParameterSetName = "Default", HelpMessage = "Membership type for the administrative unit.")]
        [System.String] $MembershipType,

        [Parameter(ParameterSetName = "Default", HelpMessage = "Visibility of the administrative unit.")]
        [System.String] $Visibility
    )

    begin {
        # Ensure connection to Microsoft Entra
        if (-not (Get-EntraContext)) {
            $errorMessage = "Not connected to Microsoft Graph. Use 'Connect-Entra -Scopes AdministrativeUnit.ReadWrite.All' to authenticate."
            Write-Error -Message $errorMessage -ErrorAction Stop
            return
        }
    }

    PROCESS {
        $params = @{}
        $body = @{}
        $customHeaders = New-EntraCustomHeaders -Command $MyInvocation.MyCommand

        if ($null -ne $PSBoundParameters["Description"]) {
            $params["Description"] = $PSBoundParameters["Description"]
            $body["Description"] = $PSBoundParameters["Description"]
        }
        if ($null -ne $PSBoundParameters["DisplayName"]) {
            $params["DisplayName"] = $PSBoundParameters["DisplayName"]
            $body["DisplayName"] = $PSBoundParameters["DisplayName"]
        }
        if ($null -ne $PSBoundParameters["MembershipRule"]) {
            $params["MembershipRule"] = $PSBoundParameters["MembershipRule"]
            $body["MembershipRule"] = $PSBoundParameters["MembershipRule"]
        }
        if ($null -ne $PSBoundParameters["MembershipRuleProcessingState"]) {
            $params["MembershipRuleProcessingState"] = $PSBoundParameters["MembershipRuleProcessingState"]
            $body["MembershipRuleProcessingState"] = $PSBoundParameters["MembershipRuleProcessingState"]
        }
        if ($null -ne $PSBoundParameters["MembershipType"]) {
            $params["MembershipType"] = $PSBoundParameters["MembershipType"]
            $body["MembershipType"] = $PSBoundParameters["MembershipType"]
        }
        if ($null -ne $PSBoundParameters["Visibility"]) {
            $params["Visibility"] = $PSBoundParameters["Visibility"]
            $body["Visibility"] = $PSBoundParameters["Visibility"]
        }

        $uri = "/v1.0/directory/administrativeUnits"
        $body = $body | ConvertTo-Json

        Write-Debug "============================ TRANSFORMATIONS ============================"
        $params.Keys | ForEach-Object { "$_ : $($params[$_])" } | Write-Debug
        Write-Debug "=========================================================================`n"

        $response = Invoke-GraphRequest -Headers $customHeaders -Uri $uri -Method POST -Body $body
        $response = $response | ConvertTo-Json | ConvertFrom-Json
        $auList = @()
        foreach ($data in $response) {
            $auType = New-Object Microsoft.Graph.PowerShell.Models.MicrosoftGraphAdministrativeUnit
            $data.PSObject.Properties | ForEach-Object {
                $propertyName = $_.Name
                $propertyValue = $_.Value
                $auType | Add-Member -MemberType NoteProperty -Name $propertyName -Value $propertyValue -Force
            }
            $auList += $auType
        }
        $auList
    }
}