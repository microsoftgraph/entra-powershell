# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
Set-StrictMode -Version 5

class CmdletMap {
    [string] $Name = $null
    [string] $SourceName = $null   
    [DataMap[]] $Parameters = $null
    [DataMap[]] $Outputs = $null
}

