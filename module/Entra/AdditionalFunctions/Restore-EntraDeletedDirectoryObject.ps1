function Restore-EntraDeletedDirectoryObject {
    [CmdletBinding(DefaultParameterSetName = '')]
    param (
    [Alias('ObjectId')]
    [Parameter(Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
    [System.String] $Id,
    [Parameter(ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
    [switch] $AutoReconcileProxyConflict
    )

    PROCESS {    
        $params = @{}
        $customHeaders = New-EntraCustomHeaders -Command $MyInvocation.MyCommand
        $params["Uri"] = 'https://graph.microsoft.com/v1.0/directory/deletedItems/'   
        $params["Method"] = "POST"    
        if($null -ne $PSBoundParameters["Id"])
        {
            $params["Uri"] += $Id+"/microsoft.graph.restore"      
        }
        if($PSBoundParameters.ContainsKey("AutoReconcileProxyConflict"))
        {
            $params["Body"] = @{
                autoReconcileProxyConflict = $true
            }
        }
    
        Write-Debug("============================ TRANSFORMATIONS ============================")
        $params.Keys | ForEach-Object {"$_ : $($params[$_])" } | Write-Debug
        Write-Debug("=========================================================================`n")
        
        $response = Invoke-GraphRequest @params -Headers $customHeaders
        $data = $response | ConvertTo-Json -Depth 10 | ConvertFrom-Json  
        $data | ForEach-Object {
            if($null -ne $_) {
            Add-Member -InputObject $_ -MemberType AliasProperty -Name ObjectId -Value Id
    
            }
        }     
        $userList = @()
        foreach ($res in $data) {
            $userType = New-Object Microsoft.Graph.PowerShell.Models.MicrosoftGraphDirectoryObject
            $res.PSObject.Properties | ForEach-Object {
                $propertyName = $_.Name.Substring(0,1).ToUpper() + $_.Name.Substring(1)
                $propertyValue = $_.Value
                $userType | Add-Member -MemberType NoteProperty -Name $propertyName -Value $propertyValue -Force
            }
            $userList += $userType
        }
        $userList       
    }
}