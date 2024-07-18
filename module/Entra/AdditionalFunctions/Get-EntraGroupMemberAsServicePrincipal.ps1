# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

function Get-EntraGroupMemberAsServicePrincipal {
    [CmdletBinding(DefaultParameterSetName = 'List', PositionalBinding = $false)]
    param(
        [Parameter(ParameterSetName = 'Get', Mandatory = $true)]
        [string]$DirectoryObjectId,

        [Parameter(ParameterSetName = 'List', Mandatory = $true)]
        [Parameter(ParameterSetName = 'Get', Mandatory = $true)]
        [string]$GroupId,

        [Alias('Select')]
        [AllowEmptyCollection()]
        [string[]]$Property,

        [Parameter(ParameterSetName = 'List')]
        [string]$Filter,

        [Parameter(ParameterSetName = 'List')]
        [string]$Search,

        [Parameter(ParameterSetName = 'List')]
        [int]
        ${Skip},

        [Parameter(ParameterSetName = 'List')]
        [Alias('OrderBy')]
        [AllowEmptyCollection()]
        [string[]]
        ${Sort},

        [Parameter(ParameterSetName = 'List')]
        [Alias('Limit')]
        [int]
        ${Top},

        [string]
        ${ConsistencyLevel},

        [Alias('RHV')]
        [string]
        ${ResponseHeadersVariable},

        [switch]
        ${Break},

        [Parameter(ValueFromPipeline = $true)]
        [System.Collections.IDictionary]
        ${Headers},

        [ValidateNotNull()]
        [Microsoft.Graph.PowerShell.Runtime.SendAsyncStep[]]
        ${HttpPipelineAppend},

        [ValidateNotNull()]
        [Microsoft.Graph.PowerShell.Runtime.SendAsyncStep[]]
        ${HttpPipelinePrepend},

        [uri]
        ${Proxy},

        [ValidateNotNull()]
        [pscredential]
        [System.Management.Automation.CredentialAttribute()]
        ${ProxyCredential},

        [switch]
        ${ProxyUseDefaultCredentials},

        [Parameter(ParameterSetName = 'List')]
        [int]
        ${PageSize},

        [Parameter(ParameterSetName = 'List')]
        [switch]
        ${All},

        [Parameter(ParameterSetName = 'List')]
        [Alias('CV')]
        [string]
        ${CountVariable})
}