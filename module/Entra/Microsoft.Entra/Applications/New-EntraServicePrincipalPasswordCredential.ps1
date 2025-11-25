# ------------------------------------------------------------------------------ 
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  
#  Licensed under the MIT License.  See License in the project root for license information. 
# ------------------------------------------------------------------------------ 
function New-EntraServicePrincipalPasswordCredential {
    [CmdletBinding(DefaultParameterSetName = 'Default')]
    param (
        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true,
            HelpMessage = "Specifies the unique identifier (ObjectId) of the service principal to which the password credential will be added.")]
        [Alias("ObjectId")]
        [ValidateNotNullOrEmpty()]
        [System.String] $ServicePrincipalId,

        [Parameter(ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true,
            HelpMessage = "Specifies the start date and time (UTC) from which the password credential becomes valid. If not specified`, defaults to the current date and time.")]
        [System.Nullable[System.DateTime]] $StartDate,

        [Parameter(ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true,
            HelpMessage = "Specifies the end date and time (UTC) after which the password credential expires. If not specified`, defaults to one year from the current date and time.")]
        [System.Nullable[System.DateTime]] $EndDate,

        [Parameter(ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true,
            HelpMessage = "Specifies a friendly display name to help identify the password credential.")]
        [System.String] $DisplayName
    )

    begin {
        # Ensure connection to Microsoft Entra
        if (-not (Get-EntraContext)) {
            $errorMessage = "Not connected to Microsoft Graph. Use 'Connect-Entra -Scopes Application.ReadWrite.All' to authenticate."
            Write-Error -Message $errorMessage -ErrorAction Stop
            return
        }
    }

    PROCESS {
        $params = @{
            ServicePrincipalId = $ServicePrincipalId
            StartDate          = $StartDate
            EndDate            = $EndDate
            DisplayName        = $DisplayName
        }
        $customHeaders = New-EntraCustomHeaders -Command $MyInvocation.MyCommand
        $baseUri = '/v1.0/servicePrincipals'
        $URI = "$baseUri/$ServicePrincipalId/addPassword"
        $body = @{
            passwordCredential = @{
                startDateTime = $StartDate
                endDateTime   = $EndDate
                displayName   = $DisplayName
            }
        }

        Write-Debug("============================ TRANSFORMATIONS ============================")
        $params.Keys | ForEach-Object { "$_ : $($params[$_])" } | Write-Debug
        Write-Debug("=========================================================================`n")

        try {
            $response = Invoke-GraphRequest -Headers $customHeaders -Uri $URI -Method "POST" -Body $body
            $response = $response | ConvertTo-Json -Depth 10 | ConvertFrom-Json

            $response | ForEach-Object {
                if ($null -ne $_) {
                    Add-Member -InputObject $_ -MemberType AliasProperty -Name StartDate -Value $_.startDateTime -Force
                    Add-Member -InputObject $_ -MemberType AliasProperty -Name EndDate -Value $_.endDateTime -Force
                }
            }

            $targetTypeList = @()
            foreach ($data in $response) {
                $target = New-Object Microsoft.Graph.PowerShell.Models.MicrosoftGraphPasswordCredential
                $data.PSObject.Properties | ForEach-Object {
                    $propertyName = $_.Name.Substring(0, 1).ToUpper() + $_.Name.Substring(1)
                    $propertyValue = $_.Value
                    $target | Add-Member -MemberType NoteProperty -Name $propertyName -Value $propertyValue -Force
                }
                $targetTypeList += $target
            }
            $targetTypeList
        }
        catch {
            Write-Error "Failed to add password credential: $_"
        }
    }
}

