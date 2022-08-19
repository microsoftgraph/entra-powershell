# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
Set-StrictMode -Version 5

enum TransformationTypes {
    Unknown = 0
    None = 1
    Name = 2
    Exception = 98
    Custom = 99
}

class DataMap {
    [string] $Name = $null
    [string] $TargetName = $null   
    [TransformationTypes] $ConversionType = 0
    [scriptblock] $SpecialMapping = $null

    DataMap(){        
    }

    DataMap($Name){
        $this.Name = $Name
        $this.ConversionType = 0    
    }

    DataMap($Name, $TargetName){
        $this.Name = $Name
        $this.TargetName = $TargetName
        $this.ConversionType = 1    
    }

    DataMap($Name, $TargetName, $ConversionType, $SpecialMapping){
        $this.Name = $Name
        $this.TargetName = $TargetName
        $this.ConversionType = $ConversionType    
        $this.SpecialMapping = $SpecialMapping
    }

    SetNone(){
        $this.ConversionType = 1
    }

    SetException(){
        $this.ConversionType = 98
    }

    SetCustom(){
        $this.ConversionType = 99
    }

    SetTargetName($TargetName){
        $this.TargetName = $TargetName
        $this.ConversionType = 2
    }

    [DataMap] GetIdMapping(){
        return [DataMap]::New("Id", "ObjectId")
    }
}