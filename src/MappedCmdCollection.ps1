# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
Set-StrictMode -Version 5

class MappedCmdCollection {
    [string] $Name = $null
    [string[]] $CmdletsList = $null
    [string[]] $MissingCmdletsList = $null
    [CmdletTranslation[]] $Cmdlets  = $null

    MappedCmdCollection([string] $Name){
        $this.Name = $Name
    }
}