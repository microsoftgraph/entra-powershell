function Restore-EntraBetaDeletedDirectoryObject {
    [CmdletBinding(DefaultParameterSetName = '')]
    param (
    [Parameter(Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
    [System.String] $Id,
    [Parameter(ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
    [switch] $AutoReconcileProxyConflict
    )

    PROCESS {    
        $params = @{}
        $customHeaders = New-EntraBetaCustomHeaders -Command $MyInvocation.MyCommand
        $params["Uri"] = 'https://graph.microsoft.com/beta/directory/deletedItems/'   
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
        if($response){
            $userList = @()
            foreach ($data in $response) {
                $userType = New-Object Microsoft.Graph.Beta.PowerShell.Models.MicrosoftGraphDirectoryObject
                $data.PSObject.Properties | ForEach-Object {
                    $propertyName = $_.Name
                    $propertyValue = $_.Value
                    $userType | Add-Member -MemberType NoteProperty -Name $propertyName -Value $propertyValue -Force
                }
                $userList += $userType
            }
            $userList
        }
    }
}