# ------------------------------------------------------------------------------ 
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  
#  Licensed under the MIT License.  See License in the project root for license information. 
# ------------------------------------------------------------------------------ 
function Add-EntraScopedRoleMembership {
    [CmdletBinding(DefaultParameterSetName = 'Default')]
    param (   
    [Alias("ObjectId")] 
    [Parameter(Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
    [System.String] $AdministrativeUnitId,
    [Parameter(ParameterSetName = "default")]
    [System.String] $RoleObjectId,
    [Parameter(ParameterSetName = "default")]
    [Microsoft.Open.MSGraph.Model.MsRoleMemberInfo] $RoleMemberInfo
    )

    begin {
        # Ensure connection to Microsoft Entra
        if (-not (Get-EntraContext)) {
            $errorMessage = "Not connected to Microsoft Graph. Use 'Connect-Entra -Scopes RoleManagement.ReadWrite.Directory' to authenticate."
            Write-Error -Message $errorMessage -ErrorAction Stop
            return
        }
    }

    PROCESS {    
    $params = @{}
    $body = @{}
    $customHeaders = New-EntraCustomHeaders -Command $MyInvocation.MyCommand

    if($null -ne $PSBoundParameters["AdministrativeUnitId"])
    {
        $params["AdministrativeUnitId"] = $PSBoundParameters["AdministrativeUnitId"]
        $Uri = "/v1.0/directory/administrativeUnits/$($params.AdministrativeUnitId)/scopedRoleMembers"     
    }    
    if($null -ne $PSBoundParameters["RoleObjectId"])
    {
        $params["RoleId"] = $PSBoundParameters["RoleObjectId"]
        $body.roleId = $PSBoundParameters["RoleObjectId"];
    }
    if($null -ne $PSBoundParameters["RoleMemberInfo"])
    {
        $TmpValue = $PSBoundParameters["RoleMemberInfo"]
        $Value = @{
            id = ($TmpValue).Id
        }
        $params["RoleMemberInfo"] = $Value | ConvertTo-Json
        $body.roleMemberInfo = $Value
    }

    Write-Debug("============================ TRANSFORMATIONS ============================")
    $params.Keys | ForEach-Object {"$_ : $($params[$_])" } | Write-Debug
    Write-Debug("=========================================================================`n")
    
    $response = Invoke-GraphRequest -Headers $customHeaders -Uri $Uri -Method "POST" -Body $body
    $response = $response | ConvertTo-Json -Depth 5 | ConvertFrom-Json
    $response | ForEach-Object {
        if($null -ne $_) {
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

