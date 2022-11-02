# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
Set-StrictMode -Version 5

class CommandTranslation {
    [string] $Name = $null
    [string] $SourceName = $null   
    [scriptblock] $CommandBlock = $null

    CommandTranslation([string] $Name, [string] $SourceName, [scriptblock] $CommandBlock){
        $this.Name = $Name
        $this.SourceName = $SourceName
        $this.CommandBlock = $CommandBlock
    }
}