# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
function Get-EntraScopedRoleMembership {
    [CmdletBinding(DefaultParameterSetName = 'GetQuery')]
    param (
    [Parameter(Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
    [System.String] $ObjectId,
    [Parameter(ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
    [System.String] $ScopedRoleMembershipId
    )

    PROCESS {    
        $params = @{}
        $customHeaders = New-EntraCustomHeaders -Command $MyInvocation.MyCommand
        $keysChanged = @{ObjectId = "Id"}
        $isList = $false
        $baseUri = "https://graph.microsoft.com/v1.0/directory/administrativeUnits/"        
        if($null -ne $PSBoundParameters["ObjectId"])
        {
            $params["AdministrativeUnitId"] = $PSBoundParameters["ObjectId"]
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
        if($PSBoundParameters.ContainsKey("Verbose"))
        {
            $params["Verbose"] = $Null
        }
        if($PSBoundParameters.ContainsKey("Debug"))
        {
            $params["Debug"] = $Null
        }        
        if($null -ne $PSBoundParameters["WarningVariable"])
        {
            $params["WarningVariable"] = $PSBoundParameters["WarningVariable"]
        }
        if($null -ne $PSBoundParameters["InformationVariable"])
        {
            $params["InformationVariable"] = $PSBoundParameters["InformationVariable"]
        }
	    if($null -ne $PSBoundParameters["InformationAction"])
        {
            $params["InformationAction"] = $PSBoundParameters["InformationAction"]
        }
        if($null -ne $PSBoundParameters["OutVariable"])
        {
            $params["OutVariable"] = $PSBoundParameters["OutVariable"]
        }
        if($null -ne $PSBoundParameters["OutBuffer"])
        {
            $params["OutBuffer"] = $PSBoundParameters["OutBuffer"]
        }
        if($null -ne $PSBoundParameters["ErrorVariable"])
        {
            $params["ErrorVariable"] = $PSBoundParameters["ErrorVariable"]
        }
        if($null -ne $PSBoundParameters["PipelineVariable"])
        {
            $params["PipelineVariable"] = $PSBoundParameters["PipelineVariable"]
        }
        if($null -ne $PSBoundParameters["ErrorAction"])
        {
            $params["ErrorAction"] = $PSBoundParameters["ErrorAction"]
        }
        if($null -ne $PSBoundParameters["WarningAction"])
        {
            $params["WarningAction"] = $PSBoundParameters["WarningAction"]
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
}