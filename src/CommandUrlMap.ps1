# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
Set-StrictMode -Version 5

class CommandUrlMap {
    [string] $Command = $null
    [string] $URL = $null   
    [string] $Method = $null

    CommandUrlMap($Command, $URL, $Method){
        $this.Command = $Command
        $this.URL = $URL
        $this.Method = $Method
    }

}

