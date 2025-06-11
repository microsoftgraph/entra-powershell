function New-EntraServicePrincipalKeyCredential {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true, HelpMessage = "Specifies the unique identifier (ObjectId) of the service principal to which the password credential will be added.")]
        [Alias("ObjectId")]
        [ValidateNotNullOrEmpty()]
        [System.String]$ServicePrincipalId,

        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, 
            HelpMessage = "Specifies the start date and time (UTC) from which the password credential becomes valid. If not specified, defaults to the current date and time.")]
        [System.String]$Value,

        [Parameter(Mandatory = $true)]
        [ValidateSet('AsymmetricX509Cert', 'X509CertAndPassword')]
        [System.String]$Type,
        
        [Parameter(Mandatory = $true)]
        [ValidateSet('Sign', 'Verify')]
        [System.String]$Usage,
        
        [Parameter(Mandatory = $true)]
        [System.String]$Proof,

        [Parameter(ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = "Specifies the start date and time (UTC) from which the password credential becomes valid. If not specified, defaults to the current date and time.")]
        [System.String]$CustomKeyIdentifier,
        
        [Parameter(ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true,
            HelpMessage = "Specifies the start date and time (UTC) from which the password credential becomes valid. If not specified, defaults to the current date and time.")]
        [System.Nullable[System.DateTime]] $StartDate,

        [Parameter(ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true,
            HelpMessage = "Specifies the end date and time (UTC) after which the password credential expires. If not specified, defaults to one year from the current date and time.")]
        [System.Nullable[System.DateTime]] $EndDate
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

        $customHeaders = New-EntraCustomHeaders -Command $MyInvocation.MyCommand
        $customHeaders['Content-Type'] = 'application/json'
        $baseUri = '/v1.0/servicePrincipals'
        $URI = "$baseUri/$ServicePrincipalId/addKey"

        $params = @{
            keyCredential = @{
                type = $Type
                usage = $Usage
                key = $Value
            }
            passwordCredential = $null
            proof = $Proof
        }

        if ($Type -eq 'X509CertAndPassword' -and $null -ne $PSBoundParameters["CustomKeyIdentifier"]) {
            $params["passwordCredential"] = @{
                secretText = $PSBoundParameters["CustomKeyIdentifier"]
            }
        }

        Write-Debug("============================ TRANSFORMATIONS ============================")
        $params.Keys | ForEach-Object { "$_ : $($params[$_])" } | Write-Debug
        Write-Debug("=========================================================================`n")
        
        try {
            $response = Invoke-GraphRequest -Headers $customHeaders -Uri $URI -Method "POST" -Body ($params | ConvertTo-Json -Depth 4)

            $response | ForEach-Object {
                if ($null -ne $_) {
                    Add-Member -InputObject $_ -MemberType AliasProperty -Name StartDate -Value StartDateTime
                    Add-Member -InputObject $_ -MemberType AliasProperty -Name EndDate -Value EndDateTime
                }
            }

            $targetTypeList = @()
            foreach ($data in $response) {
                $target = New-Object Microsoft.Graph.PowerShell.Models.MicrosoftGraphKeyCredential
                $data.PSObject.Properties | ForEach-Object {
                    $propertyName = $_.Name.Substring(0, 1).ToUpper() + $_.Name.Substring(1)
                    $propertyValue = $_.Value
                    $target | Add-Member -MemberType NoteProperty -Name $propertyName -Value $propertyValue -Force
                }
                $targetTypeList += $target
            }
            $targetTypeList
        }
        catch {
            Write-Error "Failed to add key credential: $($_.Exception.Message)"
        }
    }
}

