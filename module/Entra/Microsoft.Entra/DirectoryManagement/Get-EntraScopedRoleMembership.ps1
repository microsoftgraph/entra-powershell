# ------------------------------------------------------------------------------ 
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  
#  Licensed under the MIT License.  See License in the project root for license information. 
# ------------------------------------------------------------------------------ 
function Get-EntraScopedRoleMembership {
    [CmdletBinding(DefaultParameterSetName = 'GetQuery')]
    param (
    [Alias("ObjectId")]
    [Parameter(Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
    [System.String] $AdministrativeUnitId,
    [Parameter(ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
    [System.String] $ScopedRoleMembershipId
    )

    begin {
        # Ensure connection to Microsoft Entra
        if (-not (Get-EntraContext)) {
            $errorMessage = "Not connected to Microsoft Graph. Use 'Connect-Entra -Scopes RoleManagement.Read.Directory' to authenticate."
            Write-Error -Message $errorMessage -ErrorAction Stop
            return
        }
    }

    PROCESS {
        $params = @{}
        $customHeaders = New-EntraCustomHeaders -Command $MyInvocation.MyCommand
        $isList = $false
        $baseUri = "/v1.0/directory/administrativeUnits"
        if($null -ne $PSBoundParameters["AdministrativeUnitId"])
        {
            $params["AdministrativeUnitId"] = $PSBoundParameters["AdministrativeUnitId"]
            $uri = $baseUri + "/$($params.AdministrativeUnitId)/scopedRoleMembers"
            $params["Uri"] = $uri
            $isList = $true
        }
        if($null -ne $PSBoundParameters["ScopedRoleMembershipId"])
        {
            $isList = $false
            $params["ScopedRoleMembershipId"] = $PSBoundParameters["ScopedRoleMembershipId"]
            $uri = $uri + "/$($params.ScopedRoleMembershipId)"
            $params["Uri"] = $uri
        }

        Write-Debug("============================ TRANSFORMATIONS ============================")
        $params.Keys | ForEach-Object {"$_ : $($params[$_])" } | Write-Debug
        Write-Debug("=========================================================================")

        $response = (Invoke-GraphRequest -Uri $uri -Headers $customHeaders -Method GET) | ConvertTo-Json -Depth 5 | ConvertFrom-Json
        if($isList){
            $response = $response.value
        }

        $response | ForEach-Object {
            if ($null -ne $_) {
                Add-Member -InputObject $_ -MemberType AliasProperty -Name AdministrativeUnitObjectId -Value AdministrativeUnitId
                Add-Member -InputObject $_ -MemberType AliasProperty -Name RoleObjectId -Value RoleId
                Add-Member -InputObject $_ -MemberType AliasProperty -Name ObjectId -Value Id
            }
        }

        $memberList = @()
        foreach($data in $response){
            $memberType = New-Object Microsoft.Graph.PowerShell.Models.MicrosoftGraphScopedRoleMembership
            if (-not ($data -is [psobject])) {
                $data = [pscustomobject]@{ Value = $data }
            }
            $data.PSObject.Properties | ForEach-Object {
                $propertyName = $_.Name
                $propertyValue = $_.Value
                $memberType | Add-Member -MemberType NoteProperty -Name $propertyName -Value $propertyValue -Force
            }
            $memberList += $memberType
        }
        $memberList
    }
}# ------------------------------------------------------------------------------

