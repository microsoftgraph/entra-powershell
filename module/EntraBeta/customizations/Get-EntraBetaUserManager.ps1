# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
@{
    SourceName = "Get-AzureADUserManager"
    TargetName = $null
    Parameters = $null
    outputs = $null
    CustomScript = @'   
    PROCESS {    
        $params = @{}
        $customHeaders = New-CustomHeaders -Module Entra -Command $MyInvocation.MyCommand
        $keysChanged = @{ObjectId = "Id"}
        if($PSBoundParameters.ContainsKey("Verbose"))
        {
            $params["Verbose"] = $Null
        }
        if($null -ne $PSBoundParameters["ObjectId"])
        {
            $params["UserId"] = $PSBoundParameters["ObjectId"]
        }
        if($PSBoundParameters.ContainsKey("Debug"))
        {
            $params["Debug"] = $Null
        }
    
        Write-Debug("============================ TRANSFORMATIONS ============================")
        $params.Keys | ForEach-Object {"$_ : $($params[$_])" } | Write-Debug
        Write-Debug("=========================================================================`n")
        try {
            $response = Get-MgBetaUserManager @params -ErrorAction Stop
            $response | ForEach-Object {
                if($null -ne $_) {
                    Add-Member -InputObject $_ -NotePropertyMembers $_.AdditionalProperties
                    Add-Member -InputObject $_ -MemberType AliasProperty -Name ObjectId -Value Id
                }
            }
            $response | ConvertTo-Json | ConvertFrom-Json
        }
        catch {}
        }
'@
}