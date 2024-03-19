# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
@{
    SourceName = "Restore-AzureADMSDeletedDirectoryObject"
    TargetName = $null
    Parameters = $null
    Outputs = $null
    CustomScript = @'
    PROCESS {    
        $params = @{}
        $customHeaders = New-EntraBetaCustomHeaders -Command $MyInvocation.MyCommand
        $keysChanged = @{}
        if($PSBoundParameters.ContainsKey("Verbose"))
        {
            $params["Verbose"] = $Null
        }
        if($null -ne $PSBoundParameters["Id"])
        {
            $params["DirectoryObjectId"] = $PSBoundParameters["Id"]
        }
        if($PSBoundParameters.ContainsKey("Debug"))
        {
            $params["Debug"] = $Null
        }
    
        Write-Debug("============================ TRANSFORMATIONS ============================")
        $params.Keys | ForEach-Object {"$_ : $($params[$_])" } | Write-Debug
        Write-Debug("=========================================================================`n")
        
        $response = Restore-MgBetaDirectoryDeletedItem @params -Headers $customHeaders
        $response | ForEach-Object {
            if($null -ne $_) {
            Add-Member -InputObject $_ -NotePropertyMembers $_.AdditionalProperties
            Add-Member -InputObject $_ -MemberType AliasProperty -Name ObjectId -Value Id   
            Add-Member -InputObject $_ -MemberType NoteProperty -Name OdataType -value $_.AdditionalProperties['@odata.type'] 
            }
        }
        $response
    }
'@
}