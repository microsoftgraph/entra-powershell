# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
@{
    SourceName = "New-AzureADServicePrincipalPasswordCredential"
    TargetName = $null
    Parameters = $null
    Outputs = $null
    CustomScript = @'
    function New-EntraBetaServicePrincipalPasswordCredential {
        [CmdletBinding(DefaultParameterSetName = '')]
        param (
            [Parameter(ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
            [System.String] $CustomKeyIdentifier,
            [Parameter(ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
            [System.Nullable`1[System.DateTime]] $StartDate,
            [Parameter(Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
            [Alias("ObjectId")]
            [System.String] $ServicePrincipalId,
            [Parameter(ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
            [System.String] $Value,
            [Parameter(ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
            [System.Nullable`1[System.DateTime]] $EndDate,
            [Parameter(ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
            [System.String] $DisplayName
        )

        PROCESS {
            $params = @{}
            $customHeaders = New-EntraBetaCustomHeaders -Command $MyInvocation.MyCommand

            if ($null -ne $PSBoundParameters["ServicePrincipalId"]) {
                $params["ServicePrincipalId"] = $PSBoundParameters["ServicePrincipalId"]
            }
            if ($null -ne $PSBoundParameters["DisplayName"]) {
                $params["DisplayName"] = $PSBoundParameters["DisplayName"]
            }
            if ($null -ne $PSBoundParameters["StartDate"]) {
                $params["StartDate"] = $PSBoundParameters["StartDate"]
            }
            if ($null -ne $PSBoundParameters["EndDate"]) {
                $params["EndDate"] = $PSBoundParameters["EndDate"]
            }
            if ($null -ne $PSBoundParameters["Value"]) {
                $params["Value"] = $PSBoundParameters["Value"]
            }
            if ($null -ne $PSBoundParameters["CustomKeyIdentifier"]) {
                $params["CustomKeyIdentifier"] = $PSBoundParameters["CustomKeyIdentifier"]
            }

            $params["Url"] = "https://graph.microsoft.com/beta/servicePrincipals/$ServicePrincipalId/addPassword"
            $body = @{
                passwordCredential = @{
                    startDateTime = $PSBoundParameters["StartDate"];
                    endDateTime = $PSBoundParameters["EndDate"];
                    displayName = $PSBoundParameters["DisplayName"];
                }
            } | ConvertTo-Json -Depth 10

            Write-Debug("============================ TRANSFORMATIONS ============================")
            $params.Keys | ForEach-Object { "$_ : $($params[$_])" } | Write-Debug
            Write-Debug("=========================================================================`n")

            $response = Invoke-GraphRequest -Headers $customHeaders -Uri $params.Url -Method POST -Body $body -ContentType "application/json"

            $response = $response | ConvertTo-Json | ConvertFrom-Json

            $response | ForEach-Object {
                if ($null -ne $_) {
                    Add-Member -InputObject $_ -MemberType AliasProperty -Name StartDate -Value StartDateTime
                    Add-Member -InputObject $_ -MemberType AliasProperty -Name EndDate -Value EndDateTime
                }
            }

            $targetTypeList = @()
            foreach ($data in $response) {
                $target = New-Object Microsoft.Graph.Beta.PowerShell.Models.MicrosoftGraphPasswordCredential
                $data.PSObject.Properties | ForEach-Object {
                    $propertyName = $_.Name.Substring(0, 1).ToUpper() + $_.Name.Substring(1)
                    $propertyValue = $_.Value
                    $target | Add-Member -MemberType NoteProperty -Name $propertyName -Value $propertyValue -Force
                }
                $targetTypeList += $target
            }
            $targetTypeList
        }
    }
'@
}