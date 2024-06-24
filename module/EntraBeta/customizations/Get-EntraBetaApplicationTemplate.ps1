# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
@{
    SourceName = "Get-AzureADMSApplicationTemplate"
    TargetName = $null
    Parameters = $null
    Outputs = $null
    CustomScript = @'
    PROCESS {
        $customHeaders = New-EntraBetaCustomHeaders -Command $MyInvocation.MyCommand
        if($null -ne $PSBoundParameters["Id"]){
            Get-MgBetaApplicationTemplate -Headers $customHeaders -ApplicationTemplateId $PSBoundParameters["Id"]
        }
        else{
            Get-MgBetaApplicationTemplate -Headers $customHeaders
        }
    }
'@
}