# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
Set-StrictMode -Version 5

enum TransformationTypes {
    Name = 1
    Type = 2
    NameAndType = 3
    Custom = 99
}

class DataMap {
    [string] $Name = $null
    [string] $SourceName = $null   
    [TransformationTypes] $ConversionType = $null
    [scriptblock] $SpecialMapping = $null
}