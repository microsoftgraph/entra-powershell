# ------------------------------------------------------------------------------ 
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  
#  Licensed under the MIT License.  See License in the project root for license information. 
# ------------------------------------------------------------------------------ 
function Add-EntraGroupMember {
    [CmdletBinding(DefaultParameterSetName = 'ByGroupIdAndMemberId', SupportsShouldProcess = $true)]
    param (
        [Alias('ObjectId')]
        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, 
            HelpMessage = "Unique ID of the group. Should be a valid GUID value.")]
        [ValidateNotNullOrEmpty()]
        [ValidateScript({
                if ($_ -match '^[0-9a-fA-F]{8}-([0-9a-fA-F]{4}-){3}[0-9a-fA-F]{12}$') {
                    return $true
                }
                throw "GroupId must be a valid GUID format (xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx)."
            })]
        [Guid] $GroupId,
                
        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, 
            HelpMessage = "Unique ID of the member to add to the group. You can add users, security groups, Microsoft 365 groups, devices, service principals, and organizational contacts to security groups. Only users can be added to Microsoft 365 groups.")]
        [Alias('RefObjectId')]
        [ValidateNotNullOrEmpty()]
        [ValidateScript({
                if ($_ -match '^[0-9a-fA-F]{8}-([0-9a-fA-F]{4}-){3}[0-9a-fA-F]{12}$') {
                    return $true
                }
                throw "MemberId must be a valid GUID format (xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx)."
            })]
        [Guid] $MemberId
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
            $params = @{}
            # Get custom headers for Microsoft Graph API requests
            $customHeaders = New-EntraCustomHeaders -Command $MyInvocation.MyCommand

            if ($null -ne $PSBoundParameters["OutVariable"]) {
                $params["OutVariable"] = $PSBoundParameters["OutVariable"]
            }
            if ($PSBoundParameters.ContainsKey("Debug")) {
                $params["Debug"] = $PSBoundParameters["Debug"]
            }
            if ($null -ne $PSBoundParameters["PipelineVariable"]) {
                $params["PipelineVariable"] = $PSBoundParameters["PipelineVariable"]
            }
            if ($null -ne $PSBoundParameters["InformationVariable"]) {
                $params["InformationVariable"] = $PSBoundParameters["InformationVariable"]
            }
            if ($null -ne $PSBoundParameters["OutBuffer"]) {
                $params["OutBuffer"] = $PSBoundParameters["OutBuffer"]
            }
            if ($null -ne $PSBoundParameters["WarningVariable"]) {
                $params["WarningVariable"] = $PSBoundParameters["WarningVariable"]
            }
            if ($PSBoundParameters.ContainsKey("Verbose")) {
                $params["Verbose"] = $PSBoundParameters["Verbose"]
            }
            if ($null -ne $PSBoundParameters["ErrorVariable"]) {
                $params["ErrorVariable"] = $PSBoundParameters["ErrorVariable"]
            }
            if ($null -ne $PSBoundParameters["ErrorAction"]) {
                $params["ErrorAction"] = $PSBoundParameters["ErrorAction"]
            }
           
            if ($null -ne $PSBoundParameters["InformationAction"]) {
                $params["InformationAction"] = $PSBoundParameters["InformationAction"]
            }
            if ($null -ne $PSBoundParameters["WarningAction"]) {
                $params["WarningAction"] = $PSBoundParameters["WarningAction"]
            }
            if ($null -ne $PSBoundParameters["ProgressAction"]) {
                $params["ProgressAction"] = $PSBoundParameters["ProgressAction"]
            }
            if ($null -ne $PSBoundParameters["MemberId"]) {
                $params["DirectoryObjectId"] = $PSBoundParameters["MemberId"]
            }
            if ($null -ne $PSBoundParameters["GroupId"]) {
                $params["GroupId"] = $PSBoundParameters["GroupId"]
            }

            Write-Debug("============================ TRANSFORMATIONS ============================")
            $params.Keys | ForEach-Object { "$_ : $($params[$_])" } | Write-Debug
            Write-Debug("=========================================================================`n")
    
            
            # Add ShouldProcess to prevent accidental modifications
            if ($PSCmdlet.ShouldProcess("Add member '$MemberId' to group '$GroupId'")) {
                Write-Verbose "Adding member $MemberId to group $GroupId"
                
                $response = New-MgGroupMember @params -Headers $customHeaders
                
                # Return the result to the pipeline
                return $response
            }
        }
        catch {
            # Handle error messages based on the failure
            if ($_.Exception.Message -match "Request_ResourceNotFound") {
                Write-Error "Either group $GroupId or member $MemberId not found"
            }
            elseif ($_.Exception.Message -match "Authorization_RequestDenied") {
                Write-Error "You don't have permission to add members to this group. To connect, use 'Connect-Entra -Scopes GroupMember.ReadWrite.All'"
            }
            else {
                Write-Error "Failed to add member: $_"
            }
        }
    }
}
Set-Alias -Name New-EntraGroupMember -Value Add-EntraGroupMember -Scope Global -Force
