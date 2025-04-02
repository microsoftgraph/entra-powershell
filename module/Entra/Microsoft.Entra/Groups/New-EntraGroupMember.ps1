# ------------------------------------------------------------------------------ 
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  
#  Licensed under the MIT License.  See License in the project root for license information. 
# ------------------------------------------------------------------------------ 
function Add-EntraGroupMember {
    [CmdletBinding(DefaultParameterSetName = 'ByGroupIdAndMemberId', SupportsShouldProcess = $true)]
    param (
        [Alias('ObjectId')]
        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, 
            HelpMessage = "Unique ID of the group.")]
        [ValidateNotNullOrEmpty()]
        [Guid] $GroupId,
                
        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, 
            HelpMessage = "Unique ID of the member to add to the group. You can add users, security groups, Microsoft 365 groups, devices, service principals, and organizational contacts to security groups. Only users can be added to Microsoft 365 groups.")]
        [Alias('RefObjectId')]
        [ValidateNotNullOrEmpty()]
        [Guid] $MemberId
    )

    PROCESS {
        try {
            # Get custom headers for Microsoft Graph API requests
            $customHeaders = New-EntraCustomHeaders -Command $MyInvocation.MyCommand
            
            # Create parameter hashtable for splatting to New-MgGroupMember cmdlet
            $mgParams = @{
                GroupId           = $GroupId
                DirectoryObjectId = $MemberId
                ErrorAction       = 'Stop'
            }
            
            # Add ShouldProcess to prevent accidental modifications
            if ($PSCmdlet.ShouldProcess("Add member '$MemberId' to group '$GroupId'")) {
                Write-Verbose "Adding member $MemberId to group $GroupId"
                
                # Log debug information if requested
                Write-Debug "Parameters for New-MgGroupMember:"
                $mgParams.GetEnumerator() | ForEach-Object { Write-Debug "$($_.Key): $($_.Value)" }
                
                # Make the API call with proper error handling
                $response = New-MgGroupMember @mgParams -Headers $customHeaders
                
                # Return the result to the pipeline
                return $response
            }
        }
        catch {
            # Provide better error messages based on the failure
            if ($_.Exception.Message -match "Request_ResourceNotFound") {
                Write-Error "Either group $GroupId or member $MemberId not found"
            }
            elseif ($_.Exception.Message -match "Authorization_RequestDenied") {
                Write-Error "You don't have permission to add members to this group"
            }
            else {
                Write-Error "Failed to add member: $_"
            }
        }
    }
}