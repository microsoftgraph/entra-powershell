# ------------------------------------------------------------------------------ 
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  
#  Licensed under the MIT License.  See License in the project root for license information. 
# ------------------------------------------------------------------------------ 
function Set-EntraBetaGroup {
    [CmdletBinding(DefaultParameterSetName = 'UpdateGroupByGroupId')]
    param (
                
        [Parameter(ParameterSetName = "UpdateGroupByGroupId")]
        [System.Collections.Generic.List`1[System.String]] $GroupTypes,
                
        [Parameter(ParameterSetName = "UpdateGroupByGroupId")]
        [System.String] $Visibility,
                
        [Parameter(ParameterSetName = "UpdateGroupByGroupId")]
        [System.String] $Description,
                
        [Parameter(ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
        [System.String] $LabelId,
                
        [Parameter(ParameterSetName = "UpdateGroupByGroupId")]
        [System.Nullable`1[System.Boolean]] $IsAssignableToRole,
                
        [Parameter(ParameterSetName = "UpdateGroupByGroupId")]
        [System.String] $DisplayName,
                
        [Parameter(ParameterSetName = "UpdateGroupByGroupId")]
        [System.String] $MembershipRule,
                
        [Parameter(ParameterSetName = "UpdateGroupByGroupId")]
        [System.Nullable`1[System.Boolean]] $MailEnabled,
                
        [Parameter(ParameterSetName = "UpdateGroupByGroupId")]
        [System.Nullable`1[System.Boolean]] $SecurityEnabled,
                
        [Parameter(ParameterSetName = "UpdateGroupByGroupId")]
        [System.String] $MailNickname,
        [Alias('Id')]            
        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
        [System.String] $GroupId,
                
        [Parameter(ParameterSetName = "UpdateGroupByGroupId")]
        [System.String] $MembershipRuleProcessingState
    )

    PROCESS {    
        $params = @{}
        $customHeaders = New-EntraBetaCustomHeaders -Command $MyInvocation.MyCommand
    
        if ($null -ne $PSBoundParameters["GroupTypes"]) {
            $params["GroupTypes"] = $PSBoundParameters["GroupTypes"]
        }
        if ($null -ne $PSBoundParameters["ProgressAction"]) {
            $params["ProgressAction"] = $PSBoundParameters["ProgressAction"]
        }
        if ($null -ne $PSBoundParameters["Visibility"]) {
            $params["Visibility"] = $PSBoundParameters["Visibility"]
        }
        if ($PSBoundParameters.ContainsKey("Debug")) {
            $params["Debug"] = $PSBoundParameters["Debug"]
        }
        if ($null -ne $PSBoundParameters["OutBuffer"]) {
            $params["OutBuffer"] = $PSBoundParameters["OutBuffer"]
        }
        if ($null -ne $PSBoundParameters["ErrorAction"]) {
            $params["ErrorAction"] = $PSBoundParameters["ErrorAction"]
        }
        if ($null -ne $PSBoundParameters["WarningVariable"]) {
            $params["WarningVariable"] = $PSBoundParameters["WarningVariable"]
        }
        if ($null -ne $PSBoundParameters["WarningAction"]) {
            $params["WarningAction"] = $PSBoundParameters["WarningAction"]
        }
        if ($null -ne $PSBoundParameters["Description"]) {
            $params["Description"] = $PSBoundParameters["Description"]
        }
        if ($null -ne $PSBoundParameters["LabelId"]) {
            $params["LabelId"] = $PSBoundParameters["LabelId"]
        }
        if ($null -ne $PSBoundParameters["IsAssignableToRole"]) {
            $params["IsAssignableToRole"] = $PSBoundParameters["IsAssignableToRole"]
        }
        if ($null -ne $PSBoundParameters["DisplayName"]) {
            $params["DisplayName"] = $PSBoundParameters["DisplayName"]
        }
        if ($null -ne $PSBoundParameters["OutVariable"]) {
            $params["OutVariable"] = $PSBoundParameters["OutVariable"]
        }
        if ($null -ne $PSBoundParameters["MembershipRule"]) {
            $params["MembershipRule"] = $PSBoundParameters["MembershipRule"]
        }
        if ($PSBoundParameters.ContainsKey("Verbose")) {
            $params["Verbose"] = $PSBoundParameters["Verbose"]
        }
        if ($null -ne $PSBoundParameters["MailEnabled"]) {
            $params["MailEnabled"] = $PSBoundParameters["MailEnabled"]
        }
        if ($null -ne $PSBoundParameters["SecurityEnabled"]) {
            $params["SecurityEnabled"] = $PSBoundParameters["SecurityEnabled"]
        }
        if ($null -ne $PSBoundParameters["MailNickname"]) {
            $params["MailNickname"] = $PSBoundParameters["MailNickname"]
        }
        if ($null -ne $PSBoundParameters["GroupId"]) {
            $params["GroupId"] = $PSBoundParameters["GroupId"]
        }
        if ($null -ne $PSBoundParameters["PipelineVariable"]) {
            $params["PipelineVariable"] = $PSBoundParameters["PipelineVariable"]
        }
        if ($null -ne $PSBoundParameters["InformationVariable"]) {
            $params["InformationVariable"] = $PSBoundParameters["InformationVariable"]
        }
        if ($null -ne $PSBoundParameters["InformationAction"]) {
            $params["InformationAction"] = $PSBoundParameters["InformationAction"]
        }
        if ($null -ne $PSBoundParameters["ErrorVariable"]) {
            $params["ErrorVariable"] = $PSBoundParameters["ErrorVariable"]
        }
        if ($null -ne $PSBoundParameters["MembershipRuleProcessingState"]) {
            $params["MembershipRuleProcessingState"] = $PSBoundParameters["MembershipRuleProcessingState"]
        }

        Write-Debug("============================ TRANSFORMATIONS ============================")
        $params.Keys | ForEach-Object { "$_ : $($params[$_])" } | Write-Debug
        Write-Debug("=========================================================================`n")
    
        $response = Update-MgBetaGroup @params -Headers $customHeaders
        $response | ForEach-Object {
            if ($null -ne $_) {
                Add-Member -InputObject $_ -MemberType AliasProperty -Name ObjectId -Value Id

            }
        }
        $response
    }
}

