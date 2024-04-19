# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
@{
    SourceName = "Select-AzureADGroupIdsGroupIsMemberOf"
    TargetName = $null
    Parameters = $null
    Outputs = $null
    CustomScript = @'
    PROCESS {    
        $params = @{}
        $customHeaders = New-EntraBetaCustomHeaders -Command $MyInvocation.MyCommand
        if($null -ne $PSBoundParameters["ObjectId"])
        {
            $params["GroupId"] = $PSBoundParameters["ObjectId"]
        }
        if($null -ne $PSBoundParameters["GroupIdsForMembershipCheck"])
        {
            $GroupIds = $PSBoundParameters["GroupIdsForMembershipCheck"]
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
        Write-Debug("=========================================================================`n")
        $initalResponse = Get-MgBetaGroupMemberOf @params -Headers $customHeaders
        $response = $initalResponse | Where-Object -Filterscript {$_.Id -in ($GroupIdsForMembershipCheck.GroupIds)} 
        $result=@()
        if($response){
            $result = $response.Id
        }
        foreach ($Id in $GroupIds.GroupIds) {
            if ($result -notcontains $Id) {
                Write-Error "Select-EntraGroupIdsGroupIsMemberOf : Error occurred while executing SelectEntraGroupIdsGroupIsMemberOf
            Code: Request_BadRequest
            Message:  Invalid GUID:$Id"
            return
            }
        }
        if($response){
            $response.Id
        }
    }
'@
}