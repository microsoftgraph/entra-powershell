# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.
#  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
function New-EntraBetaServicePrincipalPasswordCredential {
    [CmdletBinding(DefaultParameterSetName = '')]
    param (
        [Parameter(ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
        [System.String] $CustomKeyIdentifier,

        [Parameter(ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
        [System.Nullable[System.DateTime]] $StartDate,

        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
        [Alias("ObjectId")]
        [System.String] $ServicePrincipalId,

        [Parameter(ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
        [System.String] $Value,

        [Parameter(ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
        [System.Nullable[System.DateTime]] $EndDate,

        [Parameter(ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
        [System.String] $DisplayName
    )

    PROCESS {
        try {
            # Initialize parameters and headers
            $params = @{}
            $customHeaders = New-EntraBetaCustomHeaders -Command $MyInvocation.MyCommand
            $baseUri = 'https://graph.microsoft.com/beta/servicePrincipals'
            $Method = "POST"

            if ($null -ne $PSBoundParameters["ServicePrincipalId"]) {
                $params["ServicePrincipalId"] = $PSBoundParameters["ServicePrincipalId"]
                $params["StartDate"] = $PSBoundParameters["StartDate"]
                $params["EndDate"] = $PSBoundParameters["EndDate"]

                $URI = "$baseUri/$($params.ServicePrincipalId)/addPassword"
                $body = @{
                    passwordCredential = @{
                        startDateTime = $PSBoundParameters["StartDate"]
                        endDateTime = $PSBoundParameters["EndDate"]
                        displayName = $PSBoundParameters["DisplayName"]
                    }
                }
            }

            Write-Debug("============================ TRANSFORMATIONS ============================")
            $params.Keys | ForEach-Object { "$_ : $($params[$_])" } | Write-Debug
            Write-Debug("=========================================================================`n")

            # Invoke the Graph request
            $response = Invoke-GraphRequest -Headers $customHeaders -Uri $URI -Method $Method -Body $body
            $response = $response | ConvertTo-Json -Depth 10 | ConvertFrom-Json

            # Add alias properties to the response
            $response | ForEach-Object {
                if ($null -ne $_) {
                    Add-Member -InputObject $_ -MemberType AliasProperty -Name StartDate -Value StartDateTime
                    Add-Member -InputObject $_ -MemberType AliasProperty -Name EndDate -Value EndDateTime
                }
            }

            # Transform the response into the target type
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
        } catch {
            Write-Error "An error occurred: $_"
        }
    }
}