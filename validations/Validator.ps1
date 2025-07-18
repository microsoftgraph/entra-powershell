# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
Set-StrictMode -Version 5

class Validator {
    [string] $RootModuleName
    [string] $DocFolderName
    [string] $ScriptsFolderPath
    [string] $DocsFolderPath
    [string[]] $SubModules

    # Constructor to initialize the validation paths based on the module name
    Validator([string] $Module) {

        if($Module -eq 'Entra'){
            $this.RootModuleName = 'Microsoft.Entra'
            $this.DocFolderName = 'entra-powershell-v1.0'
            $this.SubModules = @('Authentication', 'Applications', 'DirectoryManagement', 'Governance', 'Groups', 'Users', 'Reports', 'SignIns', 'CertificateBasedAuthentication')
        }
        elseif($Module -eq 'EntraBeta'){
            $this.RootModuleName = 'Microsoft.Entra.Beta'
            $this.DocFolderName = 'entra-powershell-beta'
            $this.SubModules = @('Authentication', 'Applications', 'DirectoryManagement', 'Governance', 'Groups', 'Users', 'Reports', 'SignIns', 'NetworkAccess')
        }

        $this.ScriptsFolderPath = (Join-Path $PSScriptRoot "../module/$Module/$($this.RootModuleName)")
        $this.DocsFolderPath = (Join-Path $PSScriptRoot "../module/docs/$($this.DocFolderName)")
    }

    # Method to validate that script subfolders match docs subfolders
    ValidateScriptSubFoldersMatchDocsSubFolders() {
        $scriptSubModules = @(Get-ChildItem -Path $this.ScriptsFolderPath -Directory)
        $docSubModules = @(Get-ChildItem -Path $this.DocsFolderPath -Directory)
        if($scriptSubModules.Count -ne $docSubModules.Count){
            $this.WriteWarning("Script submodules folders count ($($scriptSubModules.Count)) does not match docs submodules folders count ($($docSubModules.Count)).")
        }

        $missingScriptFolders = @()
        $missingDocFolders = @()
        foreach($scriptSubModule in $scriptSubModules){
            if($docSubModules.Name -notcontains $scriptSubModule.Name){
                $this.WriteWarning("Script submodule folder '$($scriptSubModule.Name)' does not have a corresponding docs submodule folder.")
            }
        }
        foreach($docSubModule in $docSubModules){
            if($scriptSubModules.Name -notcontains $docSubModule.Name){
                $this.WriteWarning("Doc submodule folder '$($docSubModule.Name)' does not have a corresponding script submodule folder.")
            }
        }
    }

    # Method to validate that script subfolder files match docs subfolder files
    ValidateScriptSubFolderFilesMatchDocsSubFolderFiles() {
        foreach($subModule in $this.SubModules){
            $scriptFiles = @(Get-ChildItem -Path (Join-Path $this.ScriptsFolderPath $subModule) -Filter *.ps1 | Where-Object { $_.Name -ne "New-EntraCustomHeaders.ps1" -and $_.Name -ne "New-EntraBetaCustomHeaders.ps1" })
            $docFiles = @(Get-ChildItem -Path (Join-Path $this.DocsFolderPath $subModule) -File)
            if($scriptFiles.Count -ne $docFiles.Count){
                $this.WriteWarning("Script submodule folder '$subModule' files count ($($scriptFiles.Count)) does not match docs submodule folder '$subModule' files count ($($docFiles.Count)).")
            }

            foreach($scriptFile in $scriptFiles){
                if($docFiles.BaseName -notcontains $scriptFile.BaseName){
                    $this.WriteWarning("Script file '$($scriptFile.BaseName)' in subfolder '$subModule' does not have a corresponding doc file.")
                }
            }

            foreach($docFile in $docFiles){
                if($scriptFiles.BaseName -notcontains $docFile.BaseName){
                    $this.WriteWarning("Doc file '$($docFile.BaseName)' in subfolder '$subModule' does not have a corresponding script file.")
                }
            }
        }
    }

    hidden WriteWarning([string] $message) {
        #Write-Host "WARNING: $message" -ForegroundColor Yellow
        Write-Warning "$message"
    }

    hidden WriteError([string] $message) {
        Write-Host "ERROR: $message" -ForegroundColor Red
        throw $message
    }
}