# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
Set-StrictMode -Version 5

enum TransformationTypes {
    None = 1
    Name = 2
    Bool2Switch = 3
    SystemSwitch = 4
    KeyId = 5
    ScriptBlock = 99
}

class DataMap {
    [string] $Name = $null
    [string] $TargetName = $null   
    [TransformationTypes] $ConversionType = 1
    [scriptblock] $SpecialMapping = $null
    [bool] $NameChanged = $false

    DataMap(){        
    }

    DataMap($Name){
        $this.Name = $Name
        $this.ConversionType = 1    
    }

    DataMap($Name, $TargetName){
        $this.Name = $Name
        $this.TargetName = $TargetName
        $this.ConversionType = 2    
        $this.NameChanged = $true
    }

    DataMap($Name, $TargetName = $null, $ConversionType = 1, $SpecialMapping = $null){
        $this.Name = $Name
        $this.TargetName = $TargetName
        $this.ConversionType = $ConversionType    
        $this.SpecialMapping = $SpecialMapping
        if($Name -ne $TargetName){
            $this.NameChanged = $true
        }
    }

    SetNone(){
        $this.ConversionType = 1
    }

    SetCustom(){
        $this.ConversionType = 99
        if($this.Name -ne $this.TargetName){
            $this.NameChanged = $true
        }
    }

    SetTargetName($TargetName){
        $this.TargetName = $TargetName
        $this.ConversionType = 2
        if($this.Name -ne $this.TargetName){
            $this.NameChanged = $true
        }
    }

    SetBool2Switch($Name){
        $this.Name = $Name
        $this.TargetName = $Name
        $this.ConversionType = 3
    }

    SetSystemSwitch($Name){
        $this.Name = $Name
        $this.TargetName = $Name
        $this.ConversionType = 4
    }

    [DataMap] GetIdMapping(){
        return [DataMap]::New("Id", "ObjectId")
    }
}