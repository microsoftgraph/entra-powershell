# ------------------------------------------------------------------------------ 
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  
#  Licensed under the MIT License.  See License in the project root for license information. 
# ------------------------------------------------------------------------------ 
function Get-EntraDeletedDirectoryObject {
    [CmdletBinding(DefaultParameterSetName = 'Default')]
    param (
        [Alias('Id')]
        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = "The ID of the directory object.")]
        [System.String] $DirectoryObjectId,

        [Parameter(Mandatory = $false, ValueFromPipeline = $false, ValueFromPipelineByPropertyName = $true, HelpMessage = "The properties to include in the response.")]
        [Alias("Select")]
        [System.String[]] $Property
    )

    begin {
        # Ensure connection to Microsoft Entra
        if (-not (Get-EntraContext)) {
            $errorMessage = "Not connected to Microsoft Graph. Use 'Connect-Entra -Scopes AdministrativeUnit.Read.All, Application.Read.All, Group.Read.All, User.Read.All' to authenticate."
            Write-Error -Message $errorMessage -ErrorAction Stop
            return
        }
    }

    PROCESS {    
        $params = @{}
        $customHeaders = New-EntraCustomHeaders -Command $MyInvocation.MyCommand
    
        if ($null -ne $PSBoundParameters["OutVariable"]) {
            $params["OutVariable"] = $PSBoundParameters["OutVariable"]
        }
        if ($PSBoundParameters.ContainsKey("Debug")) {
            $params["Debug"] = $PSBoundParameters["Debug"]
        }
        if ($null -ne $PSBoundParameters["PipelineVariable"]) {
            $params["PipelineVariable"] = $PSBoundParameters["PipelineVariable"]
        }
        if ($null -ne $PSBoundParameters["InformationVariable"]) {
            $params["InformationVariable"] = $PSBoundParameters["InformationVariable"]
        }
        if ($null -ne $PSBoundParameters["OutBuffer"]) {
            $params["OutBuffer"] = $PSBoundParameters["OutBuffer"]
        }
        if ($null -ne $PSBoundParameters["WarningVariable"]) {
            $params["WarningVariable"] = $PSBoundParameters["WarningVariable"]
        }
        if ($PSBoundParameters.ContainsKey("Verbose")) {
            $params["Verbose"] = $PSBoundParameters["Verbose"]
        }
        if ($null -ne $PSBoundParameters["DirectoryObjectId"]) {
            $params["DirectoryObjectId"] = $PSBoundParameters["DirectoryObjectId"]
        }
        if ($null -ne $PSBoundParameters["ErrorVariable"]) {
            $params["ErrorVariable"] = $PSBoundParameters["ErrorVariable"]
        }
        if ($null -ne $PSBoundParameters["ErrorAction"]) {
            $params["ErrorAction"] = $PSBoundParameters["ErrorAction"]
        }
        if ($null -ne $PSBoundParameters["InformationAction"]) {
            $params["InformationAction"] = $PSBoundParameters["InformationAction"]
        }
        if ($null -ne $PSBoundParameters["WarningAction"]) {
            $params["WarningAction"] = $PSBoundParameters["WarningAction"]
        }
        if ($null -ne $PSBoundParameters["ProgressAction"]) {
            $params["ProgressAction"] = $PSBoundParameters["ProgressAction"]
        }
        if ($null -ne $PSBoundParameters["Property"]) {
            $params["Property"] = $PSBoundParameters["Property"]
        }

        Write-Debug("============================ TRANSFORMATIONS ============================")
        $params.Keys | ForEach-Object { "$_ : $($params[$_])" } | Write-Debug
        Write-Debug("=========================================================================`n")
    
        $response = Get-MgDirectoryDeletedItem @params -Headers $customHeaders
        $response | ForEach-Object {
            if ($null -ne $_) {
                Add-Member -InputObject $_ -NotePropertyMembers $_.AdditionalProperties
                Add-Member -InputObject $_ -MemberType AliasProperty -Name ObjectId -Value Id

                if ($null -ne $_.DeletedDateTime) {
                    # Add DeletionAgeInDays property
                    $deletionAgeInDays = (Get-Date) - ($_.DeletedDateTime)
                    Add-Member -InputObject $_ -MemberType NoteProperty -Name DeletionAgeInDays -Value ($deletionAgeInDays.Days) -Force
                }

            }
        }
        $response
    }
}

