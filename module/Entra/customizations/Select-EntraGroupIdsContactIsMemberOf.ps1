# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
@{
    SourceName = "Select-AzureADGroupIdsContactIsMemberOf"
    TargetName = $null
    Parameters = $null
    Outputs = $null
    CustomScript = @'
    PROCESS {    
        $params = @{}
        if($null -ne $PSBoundParameters["ObjectId"])
        {
            $params["OrgContactId"] = $PSBoundParameters["ObjectId"]
        }
        if($PSBoundParameters.ContainsKey("Debug"))
        {
            $params["Debug"] = $Null
        }
        if($PSBoundParameters.ContainsKey("Verbose"))
        {
            $params["Verbose"] = $Null
        }
        Write-Debug("============================ TRANSFORMATIONS ============================")
        $params.Keys | ForEach-Object {"$_ : $($params[$_])" } | Write-Debug
        Write-Debug("=========================================================================")
        $initalResponse = Get-MgContactMemberOfAsGroup @params
        $response = $initalResponse | Where-Object -Filterscript {$_.Id -in ($GroupIdsForMembershipCheck.GroupIds)} 
        if($response){
            $response.Id
        }
    } 
'@
}