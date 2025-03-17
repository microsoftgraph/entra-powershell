# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

$psVersion = $global:PSVersionTable.PSVersion

# Entra

if ($null -ne (Get-Module -Name Microsoft.Entra)) {
    $entraVersion = (Get-module Microsoft.Entra | select version).Version.ToString() 
}
if ($null -ne (Get-Module -Name Microsoft.Entra.Applications)) {
    $entraVersion = (Get-module Microsoft.Entra.Applications | select version).Version.ToString() 
}
if ($null -ne (Get-Module -Name Microsoft.Entra.Authentication)) {
    $entraVersion = (Get-module Microsoft.Entra.Authentication | select version).Version.ToString() 
}
if ($null -ne (Get-Module -Name Microsoft.Entra.DirectoryManagement)) {
    $entraVersion = (Get-module Microsoft.Entra.DirectoryManagement | select version).Version.ToString() 
}
if ($null -ne (Get-Module -Name Microsoft.Entra.Governance)) {
    $entraVersion = (Get-module Microsoft.Entra.Governance | select version).Version.ToString() 
}
if ($null -ne (Get-Module -Name Microsoft.Entra.Users)) {
    $entraVersion = (Get-module Microsoft.Entra.Users | select version).Version.ToString() 
}
if ($null -ne (Get-Module -Name Microsoft.Entra.Groups)) {
    $entraVersion = (Get-module Microsoft.Entra.Groups | select version).Version.ToString() 
}
if ($null -ne (Get-Module -Name Microsoft.Entra.Reports)) {
    $entraVersion = (Get-module Microsoft.Entra.Reports | select version).Version.ToString() 
}
if ($null -ne (Get-Module -Name Microsoft.Entra.SignIns)) {
    $entraVersion = (Get-module Microsoft.Entra.SignIns | Select-Object version).Version.ToString()
}

#EntraBeta

if ($null -ne (Get-Module -Name Microsoft.Entra.Beta)) {
    $entraVersion = (Get-module Microsoft.Entra.Beta | select version).Version.ToString() 
}
if ($null -ne (Get-Module -Name Microsoft.Entra.Beta.Applications)) {
    $entraVersion = (Get-module Microsoft.Entra.Beta.Applications | select version).Version.ToString() 
}
if ($null -ne (Get-Module -Name Microsoft.Entra.Beta.Authentication)) {
    $entraVersion = (Get-module Microsoft.Entra.Beta.Authentication | select version).Version.ToString() 
}
if ($null -ne (Get-Module -Name Microsoft.Entra.Beta.DirectoryManagement)) {
    $entraVersion = (Get-module Microsoft.Entra.Beta.DirectoryManagement | select version).Version.ToString() 
}
if ($null -ne (Get-Module -Name Microsoft.Entra.Beta.Governance)) {
    $entraVersion = (Get-module Microsoft.Entra.Beta.Governance | select version).Version.ToString() 
}
if ($null -ne (Get-Module -Name Microsoft.Entra.Beta.Users)) {
    $entraVersion = (Get-module Microsoft.Entra.Beta.Users | select version).Version.ToString() 
}
if ($null -ne (Get-Module -Name Microsoft.Entra.Beta.Groups)) {
    $entraVersion = (Get-module Microsoft.Entra.Beta.Groups | select version).Version.ToString() 
}
if ($null -ne (Get-Module -Name Microsoft.Entra.Beta.Reports)) {
    $entraVersion = (Get-module Microsoft.Entra.Beta.Reports | select version).Version.ToString() 
}
if ($null -ne (Get-Module -Name Microsoft.Entra.Beta.SignIns)) {
    $entraVersion = (Get-module Microsoft.Entra.Beta.SignIns | select version).Version.ToString()
}


function Get-Parameters {
    param(
        $data
    )

    PROCESS {
        $params = @{}
        for ($i = 0; $i -lt $data.Length; $i += 2) {
            $key = $data[$i] -replace '-', '' -replace ':', ''
            $value = $data[$i + 1]
            $params[$key] = $value
        }

        $params
    }
}