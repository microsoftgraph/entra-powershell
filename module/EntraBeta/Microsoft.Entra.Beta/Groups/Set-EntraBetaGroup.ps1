# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.
#  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
function Set-EntraBetaGroup {
    [CmdletBinding(DefaultParameterSetName = 'UpdateGroupByGroupId')]
    param (
        [Parameter(ParameterSetName = 'UpdateGroupByGroupId', HelpMessage = 'Specifies the group type and its membership.')]
        [System.Collections.Generic.List`1[System.String]] $GroupTypes,

        [Parameter(ParameterSetName = 'UpdateGroupByGroupId', HelpMessage = 'Indicates whether this group can be assigned to a Microsoft Entra role.')]
        [ValidateSet('true', 'false', IgnoreCase = $true)]
        [System.String] $Visibility,

        [Parameter(ParameterSetName = 'UpdateGroupByGroupId', HelpMessage = 'Description of the group.')]
        [System.String] $Description,

        [Parameter(ParameterSetName = 'UpdateGroupByGroupId', HelpMessage = 'Indicates whether this group can be assigned to a Microsoft Entra role.')]
        [ValidateSet('true', 'false', IgnoreCase = $true)]
        [System.Nullable`1[System.Boolean]] $IsAssignableToRole,

        [Parameter(ParameterSetName = 'UpdateGroupByGroupId', HelpMessage = 'Display name of the group.')]
        [ValidateLength(1, 256)]
        [System.String] $DisplayName,

        [Parameter(ParameterSetName = 'UpdateGroupByGroupId', HelpMessage = 'The rule that determines members for this group if the group is a dynamic group (groupTypes contains DynamicMembership).')]
        [System.String] $MembershipRule,

        [Parameter(ParameterSetName = 'UpdateGroupByGroupId', HelpMessage = 'Specifies whether the group is mail-enabled.')]
        [Alias('MailEnabledGroup')]
        [ValidateSet('true', 'false', IgnoreCase = $true)]
        [System.Nullable`1[System.Boolean]] $MailEnabled,

        [Parameter(ParameterSetName = 'UpdateGroupByGroupId', HelpMessage = 'Specifies whether the group is a security group.')]
        [Alias('SecurityEnabledGroup')]
        [ValidateSet('true', 'false', IgnoreCase = $true)]
        [System.Nullable`1[System.Boolean]] $SecurityEnabled,

        [Parameter(ParameterSetName = 'UpdateGroupByGroupId', HelpMessage = 'A unique mail alias for the group (max 64 characters). It must use ASCII characters (0-127).')]
        [System.String] $MailNickname,

        [Alias('Id')]
        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Unique ID of the group. Should be a valid GUID value.')]
        [ValidateNotNullOrEmpty()]
        [Guid] $GroupId,

        [Parameter(ParameterSetName = 'UpdateGroupByGroupId', HelpMessage = 'Shows if dynamic membership processing is active or paused. Values: On or Paused.')]
        [System.String] $MembershipRuleProcessingState
    )

    begin {
        # Ensure connection to Microsoft Entra
        if (-not (Get-EntraContext)) {
            $errorMessage = "Not connected to Microsoft Graph. Use 'Connect-Entra -Scopes Group.ReadWrite.All' to authenticate."
            Write-Error -Message $errorMessage -ErrorAction Stop
            return
        }
    }

    PROCESS {
        $params = @{}
        $customHeaders = New-EntraBetaCustomHeaders -Command $MyInvocation.MyCommand

        if ($null -ne $PSBoundParameters['GroupTypes']) {
            $params['GroupTypes'] = $PSBoundParameters['GroupTypes']
        }
        if ($null -ne $PSBoundParameters['ProgressAction']) {
            $params['ProgressAction'] = $PSBoundParameters['ProgressAction']
        }
        if ($null -ne $PSBoundParameters['Visibility']) {
            $params['Visibility'] = $PSBoundParameters['Visibility']
        }
        if ($PSBoundParameters.ContainsKey('Debug')) {
            $params['Debug'] = $PSBoundParameters['Debug']
        }
        if ($null -ne $PSBoundParameters['OutBuffer']) {
            $params['OutBuffer'] = $PSBoundParameters['OutBuffer']
        }
        if ($null -ne $PSBoundParameters['ErrorAction']) {
            $params['ErrorAction'] = $PSBoundParameters['ErrorAction']
        }
        if ($null -ne $PSBoundParameters['WarningVariable']) {
            $params['WarningVariable'] = $PSBoundParameters['WarningVariable']
        }
        if ($null -ne $PSBoundParameters['WarningAction']) {
            $params['WarningAction'] = $PSBoundParameters['WarningAction']
        }
        if ($null -ne $PSBoundParameters['Description']) {
            $params['Description'] = $PSBoundParameters['Description']
        }
        if ($null -ne $PSBoundParameters['IsAssignableToRole']) {
            $params['IsAssignableToRole'] = $PSBoundParameters['IsAssignableToRole']
        }
        if ($null -ne $PSBoundParameters['DisplayName']) {
            $params['DisplayName'] = $PSBoundParameters['DisplayName']
        }
        if ($null -ne $PSBoundParameters['OutVariable']) {
            $params['OutVariable'] = $PSBoundParameters['OutVariable']
        }
        if ($null -ne $PSBoundParameters['MembershipRule']) {
            $params['MembershipRule'] = $PSBoundParameters['MembershipRule']
        }
        if ($PSBoundParameters.ContainsKey('Verbose')) {
            $params['Verbose'] = $PSBoundParameters['Verbose']
        }
        if ($null -ne $PSBoundParameters['MailEnabled']) {
            $params['MailEnabled'] = $PSBoundParameters['MailEnabled']
        }
        if ($null -ne $PSBoundParameters['SecurityEnabled']) {
            $params['SecurityEnabled'] = $PSBoundParameters['SecurityEnabled']
        }
        if ($null -ne $PSBoundParameters['MailNickname']) {
            $params['MailNickname'] = $PSBoundParameters['MailNickname']
        }
        if ($null -ne $PSBoundParameters['GroupId']) {
            $params['GroupId'] = $PSBoundParameters['GroupId']
        }
        if ($null -ne $PSBoundParameters['PipelineVariable']) {
            $params['PipelineVariable'] = $PSBoundParameters['PipelineVariable']
        }
        if ($null -ne $PSBoundParameters['InformationVariable']) {
            $params['InformationVariable'] = $PSBoundParameters['InformationVariable']
        }
        if ($null -ne $PSBoundParameters['InformationAction']) {
            $params['InformationAction'] = $PSBoundParameters['InformationAction']
        }
        if ($null -ne $PSBoundParameters['ErrorVariable']) {
            $params['ErrorVariable'] = $PSBoundParameters['ErrorVariable']
        }
        if ($null -ne $PSBoundParameters['MembershipRuleProcessingState']) {
            $params['MembershipRuleProcessingState'] = $PSBoundParameters['MembershipRuleProcessingState']
        }

        Write-Debug('============================ TRANSFORMATIONS ============================')
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
