# ------------------------------------------------------------------------------ 
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  
#  Licensed under the MIT License.  See License in the project root for license information. 
# ------------------------------------------------------------------------------ 
function Restore-EntraDeletedDirectoryObject {
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
        $customHeaders = New-EntraCustomHeaders -Command $MyInvocation.MyCommand
        $params["Uri"] = '/v1.0/directory/deletedItems/'   
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
        $data = $response | ConvertTo-Json -Depth 10 | ConvertFrom-Json  
        $data | ForEach-Object {
            if ($null -ne $_) {
                Add-Member -InputObject $_ -MemberType AliasProperty -Name ObjectId -Value Id
    
            }
        }     
        $userList = @()
        foreach ($res in $data) {
            $userType = New-Object Microsoft.Graph.PowerShell.Models.MicrosoftGraphDirectoryObject
            $res.PSObject.Properties | ForEach-Object {
                $propertyName = $_.Name.Substring(0, 1).ToUpper() + $_.Name.Substring(1)
                $propertyValue = $_.Value
                $userType | Add-Member -MemberType NoteProperty -Name $propertyName -Value $propertyValue -Force
            }
            $userList += $userType
        }
        $userList       
    }
}

