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
        
        [Parameter(ParameterSetName = "GetQuery", Mandatory = $false, ValueFromPipeline = $false, ValueFromPipelineByPropertyName = $true, HelpMessage = "Properties to include in the results.")]
        [Parameter(ParameterSetName = "Append", Mandatory = $true, ValueFromPipeline = $false, ValueFromPipelineByPropertyName = $true, HelpMessage = "Properties to include in the results.")]
        [Alias("Select")]
        [System.String[]] $Property,

        [Parameter(ParameterSetName = "Append", Mandatory = $true, HelpMessage = "Specifies whether to append the selected properties.")]
        [switch] $AppendSelected
    )

    begin {
        # Ensure connection to Microsoft Entra
        if (-not (Get-EntraContext)) {
            $errorMessage = "Not connected to Microsoft Graph. Use 'Connect-Entra -Scopes User.Read.All' to authenticate."
            Write-Error -Message $errorMessage -ErrorAction Stop
            return
        }
    }
    
    PROCESS {    
        $params = @{}
        $customHeaders = New-EntraBetaCustomHeaders -Command $MyInvocation.MyCommand
        $defaultProperties = "id,displayName,userPrincipalName,mail,mailNickName,createdDateTime,deletedDateTime,givenName,surname,usageLocation,accountEnabled"
        
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
        if ($null -ne $Property -and $Property.Count -gt 0) {
            $params["Property"] = $Property
        }
        if ($PSBoundParameters.ContainsKey("AppendSelected")) {
            $params["Property"] = $defaultProperties + "," + $params["Property"]
        }
    
        Write-Debug("============================ TRANSFORMATIONS ============================")
        $params.Keys | ForEach-Object { "$_ : $($params[$_])" } | Write-Debug
        Write-Debug("=========================================================================`n")
        $response = Get-MgBetaUserManager @params -Headers $customHeaders -ErrorAction Stop
        try {      
            $data = $response | ConvertTo-Json -Depth 10 | ConvertFrom-Json     
            
            $targetList = @()
            foreach ($res in $data) {
                $orderedDictionary = $res.AdditionalProperties | ConvertTo-Json | ConvertFrom-Json -AsHashtable
                Add-Member -InputObject $res -NotePropertyMembers $orderedDictionary
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

