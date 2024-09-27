# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
@{
    SourceName = "Get-AzureADUserExtension"
    TargetName = $null
    Parameters = $null
    Outputs = $null
    CustomScript = @'
	[CmdletBinding(DefaultParameterSetName = '')]
    param (
    [Parameter(Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
    [Alias("ObjectId")]
    [System.String] $UserId,
    [Parameter(Mandatory = $false, ValueFromPipeline = $false, ValueFromPipelineByPropertyName = $true)]
    [System.String[]] $Property
    )
    PROCESS {    
        $params = @{}
        $customHeaders = New-EntraCustomHeaders -Command $MyInvocation.MyCommand
        $baseUri = "https://graph.microsoft.com/beta/users/$UserId"
        $properties = '$select=Identities,OnPremisesDistinguishedName,EmployeeId,CreatedDateTime'        
        $params["Uri"] = "$baseUri/?$properties"        
        
        if($null -ne $PSBoundParameters["Property"])
        {
            $params["Property"] = $PSBoundParameters["Property"]
            $selectProperties = $PSBoundParameters["Property"]
            $selectProperties = $selectProperties -Join ','
            $properties = "`$select=$($selectProperties)"
            $params["Uri"] = "$baseUri/?$properties"
        }
    
        Write-Debug("============================ TRANSFORMATIONS ============================")
        $params.Keys | ForEach-Object {"$_ : $($params[$_])" } | Write-Debug
        Write-Debug("=========================================================================`n")
        
        $data = Invoke-GraphRequest -Uri $($params.Uri) -Method GET -Headers $customHeaders    
        $data
        # if($data){
        #     $userList = @()
        #     foreach ($response in $data) {
        #         $userType = New-Object Microsoft.Graph.PowerShell.Models.MicrosoftGraphExtension
        #         $response.PSObject.Properties | ForEach-Object {
        #             $propertyName = $_.Name
        #             $propertyValue = $_.Value
        #             $userType | Add-Member -MemberType NoteProperty -Name $propertyName -Value $propertyValue -Force
        #         }
        #         $userList += $userType
        #     }
        #     $userList 
        # }
    }
'@
}
