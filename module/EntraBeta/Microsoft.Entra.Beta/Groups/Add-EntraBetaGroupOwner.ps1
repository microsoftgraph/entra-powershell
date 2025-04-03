# ------------------------------------------------------------------------------ 
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  
#  Licensed under the MIT License.  See License in the project root for license information. 
# ------------------------------------------------------------------------------ 
function Add-EntraBetaGroupOwner {
    [CmdletBinding(DefaultParameterSetName = 'ByGroupIdAndOwnerId', SupportsShouldProcess = $true)]
    param (
        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, 
            HelpMessage = "Object ID of a user or service principal to assign as a group owner.")]
        [Alias('RefObjectId')]
        [ValidateNotNullOrEmpty()]
        [ValidateScript({
                if ($_ -match '^[0-9a-fA-F]{8}-([0-9a-fA-F]{4}-){3}[0-9a-fA-F]{12}$') {
                    return $true
                }
                throw "OwnerId must be a valid GUID format (xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx)."
            })]
        [System.String] $OwnerId,

        [Alias('ObjectId')]
        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, 
            HelpMessage = "Unique ID of the group.")]
        [ValidateNotNullOrEmpty()]
        [ValidateScript({
                if ($_ -match '^[0-9a-fA-F]{8}-([0-9a-fA-F]{4}-){3}[0-9a-fA-F]{12}$') {
                    return $true
                }
                throw "GroupId must be a valid GUID format (xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx)."
            })]
        [System.String] $GroupId
    )

    begin {
        # Ensure connection to Microsoft Entra
        if (-not (Get-EntraContext)) {
            $errorMessage = "Not connected to Microsoft Graph. Use 'Connect-Entra -Scopes GroupMember.ReadWrite.All' to authenticate."
            Write-Error -Message $errorMessage -ErrorAction Stop
            return
        }
    }

    PROCESS {    
        try {
            $customHeaders = New-EntraBetaCustomHeaders -Command $MyInvocation.MyCommand
            $params = @{
                GroupId = $GroupId
            }
            
            $commonParams = @{} + $PSBoundParameters
            foreach ($key in @('GroupId', 'OwnerId', 'WhatIf', 'Confirm')) {
                if ($commonParams.ContainsKey($key)) {
                    $commonParams.Remove($key)
                }
            }
            
            # Merge common parameters into the params hashtable
            foreach ($key in $commonParams.Keys) {
                $params[$key] = $commonParams[$key]
            }
            
            $bodyValue = @{ 
                "@odata.id" = "https://graph.microsoft.com/beta/directoryObjects/$OwnerId" 
            }
            $params["BodyParameter"] = $bodyValue
            
            Write-Debug("============================ TRANSFORMATIONS ============================")
            $params.Keys | ForEach-Object { "$_ : $($params[$_])" } | Write-Debug
            Write-Debug("=========================================================================`n")
            
            if ($PSCmdlet.ShouldProcess("Add owner '$OwnerId' to group '$GroupId'")) {
                $response = New-MgGroupOwnerByRef @params -Headers $customHeaders
                
                $response | ForEach-Object {
                    if ($null -ne $_) {
                        if (Get-Member -InputObject $_ -Name "Id" -MemberType Properties) {
                            Add-Member -InputObject $_ -MemberType AliasProperty -Name ObjectId -Value Id -ErrorAction SilentlyContinue
                        }
                    }
                }
                
                return $response
            }
        }
        catch {
            # Error handling with useful messages
            if ($_.Exception.Message -match "Request_ResourceNotFound") {
                Write-Error "Either group $GroupId or directory object $OwnerId not found."
            }
            elseif ($_.Exception.Message -match "Authorization_RequestDenied") {
                Write-Error "You don't have permission to add owners to this group. To connect, use 'Connect-Entra -Scopes GroupMember.ReadWrite.All'"
            }
            elseif ($_.Exception.Message -match "added object references already exist") {
                Write-Warning "Directory object $OwnerId is already an owner of group $GroupId."
            }
            else {
                Write-Error "Failed to add owner: $_"
            }
        }
    }
}
Set-Alias -Name New-EntraBetaGroupOwner -Value Add-EntraBetaGroupOwner -Scope Global -Force

