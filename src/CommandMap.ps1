# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
Set-StrictMode -Version 5

class CommandMap {
    [string] $Name = $null
    [string] $TargetName = $null   
    [hashtable] $Parameters = $null
    [hashtable] $Outputs = $null

    CommandMap($Name){
        $this.Name = $Name
    }

    CommandMap($Name, $TargetName){
        $this.Name = $Name
        $this.TargetName = $TargetName           
    }

    CommandMap($Name, $TargetName, $Parameters){
        $this.Name = $Name
        $this.TargetName = $TargetName
        $this.Parameters = $Parameters
    }

    CommandMap($Name, $TargetName, $Parameters, $Outputs){
        $this.Name = $Name
        $this.TargetName = $TargetName
        $this.Parameters = $Parameters
        $this.Outputs = $Outputs
    }
}

