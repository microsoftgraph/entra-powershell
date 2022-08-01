# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
Set-StrictMode -Version 5

class ModuleMap {
    [string] $Name = $null
    [string[]] $CmdletsList = $null
    [CmdletTranslation[]] $Cmdlets  = $null

    ModuleMap([string] $Name){
        $this.Name = $Name
    }
}