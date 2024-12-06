# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
function Connect-Entra {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$false)]
        [string]$Scopes
    )

    if ($PSCmdlet.MyInvocation.BoundParameters.ContainsKey('Scopes')) {
        Connect-MgGraph -Scopes $Scopes
    } else {
        Connect-MgGraph
    }
}

# Export the function to make it available as a command
Export-ModuleMember -Function Connect-Entra