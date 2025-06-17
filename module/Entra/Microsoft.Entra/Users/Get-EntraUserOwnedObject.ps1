# ------------------------------------------------------------------------------ 
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  
#  Licensed under the MIT License.  See License in the project root for license information. 
# ------------------------------------------------------------------------------ 
function Get-EntraUserOwnedObject {
    [CmdletBinding(DefaultParameterSetName = 'GetQuery')]
    param (
        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = "Specifies the ID of a user (as a UserPrincipalName or ObjectId) in Microsoft Entra ID.")]
        [Alias('ObjectId', 'UPN', 'Identity', 'UserPrincipalName')]
        [ValidateNotNullOrEmpty()]
        [ValidateScript({
                if ($_ -match '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$' -or 
                    $_ -match '^[0-9a-fA-F]{8}-([0-9a-fA-F]{4}-){3}[0-9a-fA-F]{12}$') {
                    return $true
                }
                throw "UserId must be a valid email address or GUID."
            })]
        [System.String] $UserId,

        [Parameter(ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = "Return all items.")]
        [switch] $All,

        [Parameter(ParameterSetName = "GetQuery", ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = "Maximum number of results to return.")]
        [Alias("Limit")]
        [System.Nullable`1[System.Int32]] $Top,
        
        [Parameter(Mandatory = $false, ValueFromPipeline = $false, ValueFromPipelineByPropertyName = $true, HelpMessage = "Properties to include in the results.")]
        [Alias("Select")]
        [System.String[]] $Property
    )

    begin {
        # Ensure connection to Microsoft Entra
        if (-not (Get-EntraContext)) {
            $errorMessage = "Not connected to Microsoft Graph. Use 'Connect-Entra -Scopes User.Read.All' to authenticate."
            Write-Error -Message $errorMessage -ErrorAction Stop
            return
        }
    }
    
    PROCESS {
        $params = @{}
        $customHeaders = New-EntraCustomHeaders -Command $MyInvocation.MyCommand
        if ($null -ne $PSBoundParameters["UserId"]) {
            $params["UserId"] = $PSBoundParameters["UserId"]
        }
        $URI = "/v1.0/users/$($params.UserId)/ownedObjects"

        if ($null -ne $PSBoundParameters["Property"]) {
            $selectProperties = $PSBoundParameters["Property"]
            $selectProperties = $selectProperties -Join ','
            $properties = "`$select=$($selectProperties)"
            $URI = "/v1.0/users/$($params.UserId)/ownedObjects?$properties"
        }

        Write-Debug("============================ TRANSFORMATIONS ============================")
        $params.Keys | ForEach-Object { "$_ : $($params[$_])" } | Write-Debug
        Write-Debug("=========================================================================`n")

        $Method = "GET"
        $response = (Invoke-GraphRequest -Headers $customHeaders -Uri $URI -Method $Method).value;

        $Top = $null
        if ($PSBoundParameters.ContainsKey("Top")) {
            $Top = $PSBoundParameters["Top"]
        }

        if ($null -ne $Top) {
            $userList = @()
            $response | ForEach-Object {
                if ($null -ne $_ -and $Top -gt 0) {
                    $data = $_ | ConvertTo-Json -Depth 10 | ConvertFrom-Json
                    $userType = New-Object Microsoft.Graph.PowerShell.Models.MicrosoftGraphDirectoryObject
                    $data.PSObject.Properties | ForEach-Object {
                        $propertyName = $_.Name
                        $propertyValue = $_.Value
                        $userType | Add-Member -MemberType NoteProperty -Name $propertyName -Value $propertyValue -Force
                    }
                    $userList += $userType
                    $Top = $Top - 1
                }
            }
            $userList
        }
        else {
            $userList = @()
            $response | ForEach-Object {
                if ($null -ne $_) {
                    $data = $_ | ConvertTo-Json -Depth 10 | ConvertFrom-Json
                    $userType = New-Object Microsoft.Graph.PowerShell.Models.MicrosoftGraphDirectoryObject
                    $data.PSObject.Properties | ForEach-Object {
                        $propertyName = $_.Name
                        $propertyValue = $_.Value
                        $userType | Add-Member -MemberType NoteProperty -Name $propertyName -Value $propertyValue -Force
                    }
                    $userList += $userType
                }
            }
            $userList
        }
    }    
}

