# ------------------------------------------------------------------------------ 
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  
#  Licensed under the MIT License.  See License in the project root for license information. 
# ------------------------------------------------------------------------------ 
function Get-EntraContact {
    [CmdletBinding(DefaultParameterSetName = 'GetQuery')]
    param (
        [Alias('ObjectId')]
        [Parameter(ParameterSetName = "GetById", Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
        [System.String] $OrgContactId,
        [Parameter(ParameterSetName = "GetQuery", ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
        [System.String] $Filter,
        [Parameter(ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
        [switch] $All,
        [Parameter(ParameterSetName = "GetQuery", ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
        [Alias("Limit")]
        [System.Nullable`1[System.Int32]] $Top,
        [Parameter(Mandatory = $false, ValueFromPipeline = $false, ValueFromPipelineByPropertyName = $true)]
        [Alias("Select")]
        [System.String[]] $Property
    )  

    begin {
        # Ensure connection to Microsoft Entra
        if (-not (Get-EntraContext)) {
            $errorMessage = "Not connected to Microsoft Graph. Use 'Connect-Entra -Scopes OrgContact.Read.All' to authenticate."
            Write-Error -Message $errorMessage -ErrorAction Stop
            return
        }
    }

    PROCESS {    
        $params = @{}
        $customHeaders = New-EntraCustomHeaders -Command $MyInvocation.MyCommand
        $keysChanged = @{OrgContactId = "Id" }
        if ($null -ne $PSBoundParameters["OrgContactId"]) {
            $params["OrgContactId"] = $PSBoundParameters["OrgContactId"]
        }
        if ($null -ne $PSBoundParameters["Filter"]) {
            $TmpValue = $PSBoundParameters["Filter"]
            foreach ($i in $keysChanged.GetEnumerator()) {
                $TmpValue = $TmpValue.Replace($i.Key, $i.Value)
            }
            $Value = $TmpValue
            $params["Filter"] = $Value
        }
        if ($PSBoundParameters.ContainsKey("Verbose")) {
            $params["Verbose"] = $PSBoundParameters["Verbose"]
        }
        if ($null -ne $PSBoundParameters["All"]) {
            if ($PSBoundParameters["All"]) {
                $params["All"] = $PSBoundParameters["All"]
            }
        }
        if ($PSBoundParameters.ContainsKey("Debug")) {
            $params["Debug"] = $PSBoundParameters["Debug"]
        }
        if ($PSBoundParameters.ContainsKey("Top")) {
            $params["Top"] = $PSBoundParameters["Top"]
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
        
        $response = Get-MgContact @params -Headers $customHeaders
        $response | ForEach-Object {
            if ($null -ne $_) {
                Add-Member -InputObject $_ -NotePropertyMembers $_.AdditionalProperties
                Add-Member -InputObject $_ -MemberType AliasProperty -Name ObjectId -Value Id
                Add-Member -InputObject $_ -MemberType AliasProperty -Name DirSyncEnabled -Value OnPremisesSyncEnabled
                Add-Member -InputObject $_ -MemberType AliasProperty -Name LastDirSyncTime -Value OnPremisesLastSyncDateTime
                Add-Member -InputObject $_ -MemberType AliasProperty -Name Mobile -Value Phones
                Add-Member -InputObject $_ -MemberType AliasProperty -Name ProvisioningErrors -Value ServiceProvisioningErrors
                Add-Member -InputObject $_ -MemberType AliasProperty -Name TelephoneNumber -Value Phones
                $propsToConvert = @('Addresses', 'Manager', 'Phones')
                foreach ($prop in $propsToConvert) {
                    $value = $_.$prop | ConvertTo-Json -Depth 10 | ConvertFrom-Json
                    $_ | Add-Member -MemberType NoteProperty -Name $prop -Value ($value) -Force
                }
            }
        }
        $response
    }      
}

