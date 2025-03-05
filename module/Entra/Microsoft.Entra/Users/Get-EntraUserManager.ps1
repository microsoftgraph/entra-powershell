# ------------------------------------------------------------------------------ 
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  
#  Licensed under the MIT License.  See License in the project root for license information. 
# ------------------------------------------------------------------------------ 
function Get-EntraUserManager {
    [CmdletBinding(DefaultParameterSetName = '')]
    param (
        [Alias('ObjectId')]
        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
        [System.String] $UserId,
        [Parameter(Mandatory = $false, ValueFromPipeline = $false, ValueFromPipelineByPropertyName = $true)]
        [Alias("Select")]
        [System.String[]] $Property,
        [Parameter(ValueFromPipeline = $false, ValueFromPipelineByPropertyName = $true)]
        [switch] $AppendSelected
    )
    PROCESS {
        $params = @{}
        $customHeaders = New-EntraCustomHeaders -Command $MyInvocation.MyCommand
        $Method = "GET"
        $keysChanged = @{UserId = "Id" }
        if ($null -ne $PSBoundParameters["UserId"]) {
            $params["UserId"] = $PSBoundParameters["UserId"]
        }

        $defaultProperties = "id,displayName,givenName,jobTitle,mail,mobilePhone,officeLocation,preferredLanguage,surname,userPrincipalName,businessPhones"
        $baseUri = "https://graph.microsoft.com/v1.0/users/$($params.UserId)/manager"
        $URI = $baseUri

        if ($null -ne $Property -and $Property.Count -gt 0) {
            $selectProperties = $Property -Join ','
            $URI = '{0}?$select={1}' -f $baseUri,$selectProperties
        }
        if ($PSBoundParameters.ContainsKey("AppendSelected")) {
            $selectProperties = $defaultProperties + ',' +$selectProperties
            $URI = '{0}?$select={1}' -f $baseUri,$selectProperties
        }
        Write-Debug("============================ TRANSFORMATIONS ============================")
        $params.Keys | ForEach-Object { "$_ : $($params[$_])" } | Write-Debug
        Write-Debug("=========================================================================`n")
        $response = Invoke-GraphRequest -Headers $customHeaders -Uri $URI -Method $Method -ErrorAction Stop
        try {
            $response = $response | ConvertTo-Json -Depth 5 | ConvertFrom-Json
            $response | ForEach-Object {
                if ($null -ne $_) {
                    Add-Member -InputObject $_ -MemberType AliasProperty -Name ObjectId -Value Id
                }
            }
            if ($response) {
                $userList = @()
                foreach ($data in $response) {
                    $userType = New-Object Microsoft.Graph.PowerShell.Models.MicrosoftGraphDirectoryObject
                    $data.PSObject.Properties | ForEach-Object {
                        $propertyName = $_.Name
                        $propertyValue = $_.Value
                        $userType | Add-Member -MemberType NoteProperty -Name $propertyName -Value $propertyValue -Force
                    }
                    $userList += $userType
                }
                $userList
            }
        }
        catch {}
    }    
}

