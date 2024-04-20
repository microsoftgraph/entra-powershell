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
        $customHeaders = New-EntraCustomHeaders -Command $MyInvocation.MyCommand
        if($null -ne $PSBoundParameters["ObjectId"])
        {
            $params["GroupId"] = $PSBoundParameters["ObjectId"]
        }
        if($null -ne $PSBoundParameters["GroupIdsForMembershipCheck"])
        {
            $GroupIds = $PSBoundParameters["GroupIdsForMembershipCheck"]
            $GroupIdData = Get-EntraBetaGroup -All $true
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
        $notMember = $GroupIdsForMembershipCheck.GroupIds | Where-Object -Filterscript { $_ -notin $result }
        foreach ($Id in $notMember) {
            if ($GroupIdData.Id -notcontains $Id) {
                Write-Error "Error occurred while executing SelectEntraBetaGroupIdsGroupIsMemberOf
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