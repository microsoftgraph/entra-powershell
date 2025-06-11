# ------------------------------------------------------------------------------ 
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  
#  Licensed under the MIT License.  See License in the project root for license information. 
# ------------------------------------------------------------------------------ 
function Get-EntraGroupOwner {
    [CmdletBinding(DefaultParameterSetName = 'GetQuery')]
    param (
        [Alias('ObjectId')]
        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = "Unique ID of the group. Should be a valid GUID value.")]
        [ValidateNotNullOrEmpty()]
        [Guid] $GroupId,

        [Parameter(ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = "Specifies whether to return all object items.")]
        [switch] $All,

        [Parameter(ParameterSetName = "GetQuery", ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = "The maximum number of items to return.")]
        [Alias("Limit")]
        [System.Nullable`1[System.Int32]] $Top,
        
        [Parameter(Mandatory = $false, ValueFromPipeline = $false, ValueFromPipelineByPropertyName = $true, HelpMessage = "Properties to include in the results.")]
        [Alias("Select")]
        [System.String[]] $Property
    )

    begin {
        # Ensure connection to Microsoft Entra
        if (-not (Get-EntraContext)) {
            $errorMessage = "Not connected to Microsoft Graph. Use 'Connect-Entra -Scopes GroupMember.Read.All' to authenticate."
            Write-Error -Message $errorMessage -ErrorAction Stop
            return
        }
    }
    
    PROCESS {
        $params = @{}
        $customHeaders = New-EntraCustomHeaders -Command $MyInvocation.MyCommand
        $topCount = $null
        $baseUri = '/v1.0/groups'
        $properties = '$select=*'
        $Method = "GET"        
        if ($null -ne $PSBoundParameters["Property"]) {
            $selectProperties = $PSBoundParameters["Property"]
            $selectProperties = $selectProperties -Join ','
            $properties = "`$select=$($selectProperties)"
        }
        if ($null -ne $PSBoundParameters["GroupId"]) {
            $params["GroupId"] = $PSBoundParameters["GroupId"]
            $URI = "$baseUri/$($params.GroupId)/owners?$properties"
        }
        if ($null -ne $PSBoundParameters["All"]) {
            $URI = "$baseUri/$($params.GroupId)/owners?$properties"
        }
        if ($PSBoundParameters.ContainsKey("Top")) {
            $topCount = $PSBoundParameters["Top"]
            $URI = "$baseUri/$($params.GroupId)/owners?`$top=$topCount&$properties"
        }
        Write-Debug("============================ TRANSFORMATIONS ============================")
        $params.Keys | ForEach-Object { "$_ : $($params[$_])" } | Write-Debug
        Write-Debug("=========================================================================`n")
        $response = (Invoke-MgGraphRequest  -Headers $customHeaders -Uri $URI -Method $Method).value
        $response = $response | ConvertTo-Json -Depth 10 | ConvertFrom-Json
        $data = @($response)

        $data | ForEach-Object {
            if ($null -ne $_) {
                Add-Member -InputObject $_ -MemberType AliasProperty -Name ObjectId -Value Id
            }
        }

        $servicePrincipal = @()
        if (($response.count -eq 0) -or $response.'@odata.type' -notcontains 'microsoft.graph.servicePrincipal') {
            $URI = "$baseUri/$($params.GroupId)/owners/microsoft.graph.servicePrincipal?$properties"
            $resp = Invoke-MgGraphRequest  -Uri $URI -Method $Method -Headers $customHeaders 
            $servicePrincipal += $resp.value | ConvertTo-Json -Depth 10 | ConvertFrom-Json

            try {
                $servicePrincipal | ForEach-Object {
                    if ($null -ne $_) {
                        Add-Member -InputObject $_ -MemberType NoteProperty -Name '@odata.type' -Value '#microsoft.graph.servicePrincipal' -Force
                    }
                }
                $data += $servicePrincipal
            }
            catch {}
        }

        if ($data) {
            $userList = @()
            foreach ($item in $data) {
                $userType = New-Object Microsoft.Graph.PowerShell.Models.MicrosoftGraphDirectoryObject
                $item.PSObject.Properties | ForEach-Object {
                    $propertyName = $_.Name
                    $propertyValue = $_.Value
                    $userType | Add-Member -MemberType NoteProperty -Name $propertyName -Value $propertyValue -Force
                }
                $userList += $userType
            }
            $userList
        }
    }    
}

