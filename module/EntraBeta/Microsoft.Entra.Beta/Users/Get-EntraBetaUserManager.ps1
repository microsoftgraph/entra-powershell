# ------------------------------------------------------------------------------ 
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  
#  Licensed under the MIT License.  See License in the project root for license information. 
# ------------------------------------------------------------------------------ 
function Get-EntraBetaUserManager {
    [CmdletBinding(DefaultParameterSetName = 'GetQuery')]
    param (
        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = "Specifies the ID of a user (as a UserPrincipalName or ObjectId) in Microsoft Entra ID.")]
        [Alias('ObjectId', 'UPN', 'Identity', 'UserPrincipalName')]
        [ValidateNotNullOrEmpty()]
        [ValidateScript({
                if ($_ -match '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$' -or 
                    $_ -match '^[0-9a-fA-F]{8}-([0-9a-fA-F]{4}-){3}[0-9a-fA-F]{12}$') {
                    return $true
                }
                throw "UserId must be a valid email address or GUID."
            })]
        [System.String] $UserId,
        
        [Parameter(Mandatory = $false, ValueFromPipeline = $false, ValueFromPipelineByPropertyName = $true, HelpMessage = "Properties to include in the results.")]
        [Alias("Select")]
        [System.String[]] $Property
    )
    PROCESS {    
        $params = @{}
        $customHeaders = New-EntraBetaCustomHeaders -Command $MyInvocation.MyCommand
        
        if ($PSBoundParameters.ContainsKey("Verbose")) {
            $params["Verbose"] = $PSBoundParameters["Verbose"]
        }
        if ($null -ne $PSBoundParameters["UserId"]) {
            $params["UserId"] = $PSBoundParameters["UserId"]
        }
        if ($PSBoundParameters.ContainsKey("Debug")) {
            $params["Debug"] = $PSBoundParameters["Debug"]
        }
        if ($null -ne $PSBoundParameters["WarningVariable"]) {
            $params["WarningVariable"] = $PSBoundParameters["WarningVariable"]
        }
        if ($null -ne $PSBoundParameters["InformationVariable"]) {
            $params["InformationVariable"] = $PSBoundParameters["InformationVariable"]
        }
        if ($null -ne $PSBoundParameters["InformationAction"]) {
            $params["InformationAction"] = $PSBoundParameters["InformationAction"]
        }
        if ($null -ne $PSBoundParameters["OutVariable"]) {
            $params["OutVariable"] = $PSBoundParameters["OutVariable"]
        }
        if ($null -ne $PSBoundParameters["OutBuffer"]) {
            $params["OutBuffer"] = $PSBoundParameters["OutBuffer"]
        }
        if ($null -ne $PSBoundParameters["ErrorVariable"]) {
            $params["ErrorVariable"] = $PSBoundParameters["ErrorVariable"]
        }
        if ($null -ne $PSBoundParameters["PipelineVariable"]) {
            $params["PipelineVariable"] = $PSBoundParameters["PipelineVariable"]
        }
        if ($null -ne $PSBoundParameters["ErrorAction"]) {
            $params["ErrorAction"] = $PSBoundParameters["ErrorAction"]
        }
        if ($null -ne $PSBoundParameters["WarningAction"]) {
            $params["WarningAction"] = $PSBoundParameters["WarningAction"]
        }
        if ($null -ne $PSBoundParameters["Property"]) {
            $params["Property"] = $PSBoundParameters["Property"]
        }
    
        Write-Debug("============================ TRANSFORMATIONS ============================")
        $params.Keys | ForEach-Object { "$_ : $($params[$_])" } | Write-Debug
        Write-Debug("=========================================================================`n")
        $response = Get-MgBetaUserManager @params -Headers $customHeaders -ErrorAction Stop
        try {      
            $data = $response | ConvertTo-Json -Depth 10 | ConvertFrom-Json     
            
            $targetList = @()
            foreach ($res in $data) {
                $targetType = New-Object Microsoft.Graph.Beta.PowerShell.Models.MicrosoftGraphDirectoryObject
                $res.PSObject.Properties | ForEach-Object {
                    $propertyName = $_.Name.Substring(0, 1).ToUpper() + $_.Name.Substring(1)
                    $propertyValue = $_.Value
                    $targetType | Add-Member -MemberType NoteProperty -Name $propertyName -Value $propertyValue -Force
                }
                $targetList += $targetType
            }
            $targetList   
        }
        catch {}
    }    
}

