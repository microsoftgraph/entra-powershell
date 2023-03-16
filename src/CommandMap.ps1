# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
Set-StrictMode -Version 5

class CommandMap {
    [string] $Name = $null
    [string] $TargetName = $null   
    [hashtable] $Parameters = $null
    [hashtable] $Outputs = $null
    [scriptblock] $CustomScript = $null
    [bool] $SpecialMapping = $null

    CommandMap($Name, $TargetName = $null, $Parameters = $null, $Outputs = $null){
        $this.Name = $Name
        $this.TargetName = $TargetName
        $this.Parameters = $Parameters
        $this.Outputs = $Outputs
        $this.CustomScript = $null
        $this.SpecialMapping = $false
    }

    CommandMap($Name, $CustomScript){
        $this.Name = $Name
        $this.TargetName = $null
        $this.Parameters = $null
        $this.Outputs = $null
        $this.CustomScript = $CustomScript
        $this.SpecialMapping = $true
    }
}

