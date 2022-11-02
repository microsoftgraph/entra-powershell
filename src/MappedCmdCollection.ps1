# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
Set-StrictMode -Version 5

class MappedCmdCollection {
    [string] $Name = $null
    [string[]] $CommandsList = $null
    [string[]] $MissingCommandsList = $null
    [CommandTranslation[]] $Commands  = $null

    MappedCmdCollection([string] $Name){
        $this.Name = $Name
    }
}