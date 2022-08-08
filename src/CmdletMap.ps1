# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
Set-StrictMode -Version 5

class CmdletMap {
    [string] $Name = $null
    [string] $TargetName = $null   
    [hashtable] $Parameters = $null
    [hashtable] $Outputs = $null

    CmdletMap($Name){
        $this.Name = $Name
    }

    CmdletMap($Name, $TargetName){
        $this.Name = $Name
        $this.TargetName = $TargetName           
    }

    CmdletMap($Name, $TargetName, $Parameters){
        $this.Name = $Name
        $this.TargetName = $TargetName
        $this.Parameters = $Parameters
    }

    CmdletMap($Name, $TargetName, $Parameters, $Outputs){
        $this.Name = $Name
        $this.TargetName = $TargetName
        $this.Parameters = $Parameters
        $this.Outputs = $Outputs
    }
}

