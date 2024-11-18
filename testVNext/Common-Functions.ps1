# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

$psVersion = $global:PSVersionTable.PSVersion

# Entra

if($null -ne (Get-Module -Name Microsoft.Graph.Entra)){
    $entraVersion = (Get-module Microsoft.Graph.Entra | select version).Version.ToString() 
}
if($null -ne (Get-Module -Name Microsoft.Graph.Entra.Applications)){
    $entraVersion = (Get-module Microsoft.Graph.Entra.Applications | select version).Version.ToString() 
}
if($null -ne (Get-Module -Name Microsoft.Graph.Entra.Authentication)){
    $entraVersion = (Get-module Microsoft.Graph.Entra.Authentication | select version).Version.ToString() 
}
if($null -ne (Get-Module -Name Microsoft.Graph.Entra.DirectoryManagement)){
    $entraVersion = (Get-module Microsoft.Graph.Entra.DirectoryManagement | select version).Version.ToString() 
}
if($null -ne (Get-Module -Name Microsoft.Graph.Entra.Governance)){
    $entraVersion = (Get-module Microsoft.Graph.Entra.Governance | select version).Version.ToString() 
}
if($null -ne (Get-Module -Name Microsoft.Graph.Entra.Users)){
    $entraVersion = (Get-module Microsoft.Graph.Entra.Users | select version).Version.ToString() 
}
if($null -ne (Get-Module -Name Microsoft.Graph.Entra.Groups)){
    $entraVersion = (Get-module Microsoft.Graph.Entra.Groups | select version).Version.ToString() 
}
if($null -ne (Get-Module -Name Microsoft.Graph.Entra.Reports)){
    $entraVersion = (Get-module Microsoft.Graph.Entra.Reports | select version).Version.ToString() 
}
if($null -ne (Get-Module -Name Microsoft.Graph.Entra.SignIns)){
    $entraVersion = (Get-module Microsoft.Graph.Entra.SignIns | select version).Version.ToString()
}

#EntraBeta

if($null -ne (Get-Module -Name Microsoft.Graph.Entra.Beta)){
    $entraVersion = (Get-module Microsoft.Graph.Entra.Beta | select version).Version.ToString() 
}
if($null -ne (Get-Module -Name Microsoft.Graph.Entra.Beta.Applications)){
    $entraVersion = (Get-module Microsoft.Graph.Entra.Beta.Applications | select version).Version.ToString() 
}
if($null -ne (Get-Module -Name Microsoft.Graph.Entra.Beta.Authentication)){
    $entraVersion = (Get-module Microsoft.Graph.Entra.Beta.Authentication | select version).Version.ToString() 
}
if($null -ne (Get-Module -Name Microsoft.Graph.Entra.Beta.DirectoryManagement)){
    $entraVersion = (Get-module Microsoft.Graph.Entra.Beta.DirectoryManagement | select version).Version.ToString() 
}
if($null -ne (Get-Module -Name Microsoft.Graph.Entra.Beta.Governance)){
    $entraVersion = (Get-module Microsoft.Graph.Entra.Beta.Governance | select version).Version.ToString() 
}
if($null -ne (Get-Module -Name Microsoft.Graph.Entra.Beta.Users)){
    $entraVersion = (Get-module Microsoft.Graph.Entra.Beta.Users | select version).Version.ToString() 
}
if($null -ne (Get-Module -Name Microsoft.Graph.Entra.Beta.Groups)){
    $entraVersion = (Get-module Microsoft.Graph.Entra.Beta.Groups | select version).Version.ToString() 
}
if($null -ne (Get-Module -Name Microsoft.Graph.Entra.Beta.Reports)){
    $entraVersion = (Get-module Microsoft.Graph.Entra.Beta.Reports | select version).Version.ToString() 
}
if($null -ne (Get-Module -Name Microsoft.Graph.Entra.Beta.SignIns)){
    $entraVersion = (Get-module Microsoft.Graph.Entra.Beta.SignIns | select version).Version.ToString()
}


function Get-Parameters{
    param(
        $data
    )

    PROCESS{
        $params = @{}
        for ($i = 0; $i -lt $data.Length; $i += 2) {
            $key = $data[$i] -replace '-', '' -replace ':', ''
            $value = $data[$i + 1]
            $params[$key] = $value
        }

        $params
    }
}