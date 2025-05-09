# ------------------------------------------------------------------------------ 
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  
#  Licensed under the MIT License.  See License in the project root for license information. 
# ------------------------------------------------------------------------------ 
function Set-EntraBetaObjectSetting {
    [CmdletBinding(DefaultParameterSetName = 'Default')]
    param (
        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = "Specifies the type of the directory object.")]
        [ValidateNotNullOrEmpty()]
        [System.String] $TargetType,
                
        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = "The directory setting to be applied. Create a new setting using templates from DirectorySettingTemplates.")]
        [ValidateNotNullOrEmpty()]
        [Microsoft.Open.MSGraph.Model.DirectorySetting] $DirectorySetting,
                
        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = "The unique ID of the setting.")]
        [ValidateNotNullOrEmpty()]
        [Guid] $Id,
                
        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = "Specifies the ID of directory object to which to assign settings.")]
        [ValidateNotNullOrEmpty()]
        [System.String] $TargetObjectId
    )

    begin {
        # Ensure connection to Microsoft Entra
        if (-not (Get-EntraContext)) {
            $errorMessage = "Not connected to Microsoft Graph. Use 'Connect-Entra -Scopes Directory.ReadWrite.All' to authenticate."
            Write-Error -Message $errorMessage -ErrorAction Stop
            return
        }
    }

    PROCESS {  
        $params = @{}
        $customHeaders = New-EntraBetaCustomHeaders -Command $MyInvocation.MyCommand
        if ($null -ne $PSBoundParameters["TargetType"]) {
            $params["TargetType"] = $PSBoundParameters["TargetType"]
        }
        if ($null -ne $PSBoundParameters["TargetObjectId"]) {
            $params["TargetObjectId"] = $PSBoundParameters["TargetObjectId"]
        }
        if ($null -ne $PSBoundParameters["DirectorySetting"]) {
            $params["DirectorySetting"] = $PSBoundParameters["DirectorySetting"]
        }
        if ($null -ne $PSBoundParameters["ID"]) {
            $params["ID"] = $PSBoundParameters["ID"]
        }
        Write-Debug("============================ TRANSFORMATIONS ============================")
        $params.Keys | ForEach-Object { "$_ : $($params[$_])" } | Write-Debug
        Write-Debug("=========================================================================`n")
        $directorySettingsJson = $DirectorySetting | ForEach-Object {
            $NonEmptyProperties = $_.psobject.Properties | Where-Object { $_.Value } | Select-Object -ExpandProperty Name
            $propertyValues = $_ | Select-Object -Property $NonEmptyProperties | ConvertTo-Json
            [regex]::Replace($propertyValues, '(?<=")(\w+)(?=":)', { $args[0].Groups[1].Value.ToLower() })
        }
        $response = Invoke-GraphRequest -Headers $customHeaders -Method PATCH -Uri /beta/$TargetType/$TargetObjectId/settings/$ID -Body $directorySettingsJson
        $response | ConvertTo-Json | ConvertFrom-Json
    }      
}

