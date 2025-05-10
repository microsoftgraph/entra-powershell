# ------------------------------------------------------------------------------ 
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  
#  Licensed under the MIT License.  See License in the project root for license information. 
# ------------------------------------------------------------------------------ 
function Get-EntraBetaApplicationPasswordCredential {
    [CmdletBinding(DefaultParameterSetName = 'Default')]
    param (
        [Alias('ObjectId')]
        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = "Unique ID of the application object (Application Object ID).")]
        [ValidateNotNullOrEmpty()]
        [System.String] $ApplicationId,
        
        [Parameter(Mandatory = $false, ValueFromPipeline = $false, ValueFromPipelineByPropertyName = $true, HelpMessage = "Properties to include in the results.")]
        [Alias("Select")]
        [System.String[]] $Property
    )

    PROCESS {
        $customHeaders = New-EntraBetaCustomHeaders -Command $MyInvocation.MyCommand
        $params = @{}
        $baseUri = "/beta/applications/$ApplicationId/passwordCredentials"
        $params["Method"] = "GET"
        $params["Uri"] = "$baseUri"

        $response = Invoke-GraphRequest @params -Headers $customHeaders | ConvertTo-Json | ConvertFrom-Json
        try {
            $response = $response.value
        }
        catch {}
        $response | ForEach-Object {
            if ($null -ne $_) {
                $CustomKeyIdentifier = [System.Text.Encoding]::UTF8.GetBytes([System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String($_.CustomKeyIdentifier)))
                Add-Member -InputObject $_ -MemberType NoteProperty -Name CustomKeyIdentifier -Value $CustomKeyIdentifier -Force
                Add-Member -InputObject $_ -MemberType AliasProperty -Name EndDate -Value endDateTime
                Add-Member -InputObject $_ -MemberType AliasProperty -Name StartDate -Value startDateTime
            }
        }
        if ($response) {
            $userList = @()
            foreach ($data in $response) {
                $userType = New-Object Microsoft.Graph.Beta.PowerShell.Models.MicrosoftGraphPasswordCredential
                $data.PSObject.Properties | ForEach-Object {
                    $propertyName = $_.Name
                    $propertyValue = $_.Value
                    $userType | Add-Member -MemberType NoteProperty -Name $propertyName -Value $propertyValue -Force
                }
                $userList += $userType
            } 
            if ($null -ne $PSBoundParameters["Property"]) {
                $userList | Select-Object $PSBoundParameters["Property"]
            }
            else {
                $userList
            } 
        }
    }
}
