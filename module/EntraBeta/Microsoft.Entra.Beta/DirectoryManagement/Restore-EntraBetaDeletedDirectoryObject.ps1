# ------------------------------------------------------------------------------ 
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  
#  Licensed under the MIT License.  See License in the project root for license information. 
# ------------------------------------------------------------------------------ 

function Restore-EntraBetaDeletedDirectoryObject {
    [CmdletBinding(DefaultParameterSetName = 'Default')]
    param (
        [Alias('ObjectId')]
        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = "The ID of the directory object.")]
        [System.String] $Id,

        [Parameter(ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = "Specifies whether Microsoft Entra ID should remove conflicting proxy addresses when restoring a soft-deleted user. Applicable only to soft-deleted user restoration.")]
        [switch] $AutoReconcileProxyConflict
    )

    PROCESS {    
        $params = @{}
        $customHeaders = New-EntraBetaCustomHeaders -Command $MyInvocation.MyCommand
        $params["Uri"] = '/beta/directory/deletedItems/'   
        $params["Method"] = "POST"    
        if ($null -ne $PSBoundParameters["Id"]) {
            $params["Uri"] += $Id + "/microsoft.graph.restore"      
        }
        if ($PSBoundParameters.ContainsKey("AutoReconcileProxyConflict")) {
            $params["Body"] = @{
                autoReconcileProxyConflict = $true
            }
        }
    
        Write-Debug("============================ TRANSFORMATIONS ============================")
        $params.Keys | ForEach-Object { "$_ : $($params[$_])" } | Write-Debug
        Write-Debug("=========================================================================`n")
        
        $response = Invoke-GraphRequest @params -Headers $customHeaders
        if ($response) {
            $userList = @()
            foreach ($data in $response) {
                $userType = New-Object Microsoft.Graph.Beta.PowerShell.Models.MicrosoftGraphDirectoryObject
                $data.PSObject.Properties | ForEach-Object {
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

