# ------------------------------------------------------------------------------ 
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  
#  Licensed under the MIT License.  See License in the project root for license information. 
# ------------------------------------------------------------------------------ 
function Remove-EntraDeletedDirectoryObject {
    [CmdletBinding(DefaultParameterSetName = 'Default')]
    param (
        [Alias("Id")]
        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = "Unique ID of the directory object.")]
        [ValidateNotNullOrEmpty()]
        [System.String] $DirectoryObjectId
    )

    begin {
        # Ensure connection to Microsoft Entra
        if (-not (Get-EntraContext)) {
            $errorMessage = "Not connected to Microsoft Graph. Use 'Connect-Entra -Scopes Application.ReadWrite.All' to authenticate."
            Write-Error -Message $errorMessage -ErrorAction Stop
            return
        }
    }

    PROCESS {  
        $params = @{}
        $Method = "DELETE"
        $customHeaders = New-EntraCustomHeaders -Command $MyInvocation.MyCommand
        if ($null -ne $PSBoundParameters["DirectoryObjectId"]) {
            $params["DirectoryObjectId"] = $PSBoundParameters["DirectoryObjectId"]
        }        
        Write-Debug("============================ TRANSFORMATIONS ============================")
        $params.Keys | ForEach-Object { "$_ : $($params[$_])" } | Write-Debug
        Write-Debug("=========================================================================`n")
        $URI = "/v1.0/directory/deletedItems/$DirectoryObjectId"
        $response = Invoke-GraphRequest -Headers $customHeaders -Uri $uri -Method $Method
        $response
    }    
}

