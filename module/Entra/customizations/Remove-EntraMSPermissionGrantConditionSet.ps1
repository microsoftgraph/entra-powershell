# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
@{
    SourceName = "Remove-AzureADMSPermissionGrantConditionSet"
    TargetName = $null
    Parameters = $null
    Outputs = $null
    CustomScript = @'
    PROCESS {    
        $params = @{}
        
        if($PSBoundParameters.ContainsKey("Verbose"))
        {
            $params["Verbose"] = $Null
        }
        if($null -ne $PSBoundParameters["ConditionSetType"])
        {
            $conditionalSet = $PSBoundParameters["ConditionSetType"]
        }
        if($null -ne $PSBoundParameters["PolicyId"])
        {
            $params["PermissionGrantPolicyId"] = $PSBoundParameters["PolicyId"]
        }
        if($PSBoundParameters.ContainsKey("Debug"))
        {
            $params["Debug"] = $Null
        }
        if($null -ne $PSBoundParameters["Id"])
        {
            $params["PermissionGrantConditionSetId"] = $PSBoundParameters["Id"]
        }
    
        Write-Debug("============================ TRANSFORMATIONS ============================")
        $params.Keys | ForEach-Object {"$_ : $($params[$_])" } | Write-Debug
        Write-Debug("=========================================================================")
        

        if("$conditionalSet" -eq "includes"){
            $response = Remove-MgPolicyPermissionGrantPolicyInclude @params
        }
        elseif("$conditionalSet" -eq "excludes"){
            $response = Remove-MgPolicyPermissionGrantPolicyExclude @params
        }
        else{
            Write-Error("Message: Resource not found for the segment '$conditionalSet'.")
            return
        }
                
        $response
        }
'@
}