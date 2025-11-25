# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

function Set-EntraAdministrativeUnit {
    [CmdletBinding(DefaultParameterSetName = 'Default')]
    param (
        [Alias("ObjectId")]
        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = "The unique identifier of the administrative unit.")]
        [System.String] $AdministrativeUnitId,

        [Parameter(ParameterSetName = "Default", HelpMessage = "Description of the administrative unit.")]
        [System.String] $Description,

        [Parameter(ParameterSetName = "Default", HelpMessage = "Display name of the administrative unit.")]
        [System.String] $DisplayName,

        [Parameter(ParameterSetName = "Default", HelpMessage = "The dynamic membership rule for the administrative unit.")]
        [System.String] $MembershipRule,

        [Parameter(ParameterSetName = "Default", HelpMessage = "Controls whether the dynamic membership rule is actively processed e.g. On`, Paused.")]
        [System.String] $MembershipRuleProcessingState,

        [Parameter(ParameterSetName = "Default", HelpMessage = "Indicates the membership type for the administrative unit. The possible values are: dynamic`, assigned.")]
        [System.String] $MembershipType,

        [Parameter(ParameterSetName = "Default", HelpMessage = "The visibility of the administrative unit. If not set`, the default value is null and the default behavior is public.")]
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

        if ($null -ne $PSBoundParameters["AdministrativeUnitId"]) {
            $params["AdministrativeUnitId"] = $PSBoundParameters["AdministrativeUnitId"]
        }
        if ($null -ne $PSBoundParameters["DisplayName"]) {
            $params["DisplayName"] = $PSBoundParameters["DisplayName"]
            $body["DisplayName"] = $PSBoundParameters["DisplayName"]
        }
        if ($null -ne $PSBoundParameters["Description"]) {
            $params["Description"] = $PSBoundParameters["Description"]
            $body["Description"] = $PSBoundParameters["Description"]
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

        $uri = "/v1.0/directory/administrativeUnits/$($params.AdministrativeUnitId)"
        $params["Uri"] = $uri

        $body = $body | ConvertTo-Json

        Write-Debug("============================ TRANSFORMATIONS ============================")
        $params.Keys | ForEach-Object { "$_ : $($params[$_])" } | Write-Debug
        Write-Debug("=========================================================================`n")

        Invoke-GraphRequest -Headers $customHeaders -Uri $uri -Method PATCH -Body $body
    }
}

