# ------------------------------------------------------------------------------ 
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  
#  Licensed under the MIT License.  See License in the project root for license information. 
# ------------------------------------------------------------------------------ 
function Remove-EntraScopedRoleMembership {
    [CmdletBinding(DefaultParameterSetName = 'Default')]
    param (
    [Alias("ObjectId")]
    [Parameter(Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
    [System.String] $AdministrativeUnitId,
    [Parameter(Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
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
    if($null -ne $PSBoundParameters["AdministrativeUnitId"])
    {
        $params["AdministrativeUnitId"] = $PSBoundParameters["AdministrativeUnitId"]
    }    
    if($null -ne $PSBoundParameters["ScopedRoleMembershipId"])
    {
        $params["ScopedRoleMembershipId"] = $PSBoundParameters["ScopedRoleMembershipId"]
    }    

    $uri = "/v1.0/directory/administrativeUnits/$($params.AdministrativeUnitId)/scopedRoleMembers/$($params.ScopedRoleMembershipId)"
    $params["Uri"] = $uri

    Write-Debug("============================ TRANSFORMATIONS ============================")
    $params.Keys | ForEach-Object {"$_ : $($params[$_])" } | Write-Debug
    Write-Debug("=========================================================================`n")
    
    $response = Invoke-GraphRequest -Headers $customHeaders -Uri $uri -Method DELETE    
    $response | ForEach-Object {
        if($null -ne $_) {
            Add-Member -InputObject $_ -MemberType AliasProperty -Name ObjectId -Value Id
        }
    }
    $response
    }
}
