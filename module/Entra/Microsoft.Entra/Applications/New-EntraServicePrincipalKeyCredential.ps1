function New-EntraServicePrincipalKeyCredential {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true, HelpMessage = "Specifies the unique identifier (ObjectId) of the service principal to which the key credential will be added.")]
        [Alias("ObjectId")]
        [ValidateNotNullOrEmpty()]
        [System.String]$ServicePrincipalId,

        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, 
            HelpMessage = "Specifies the value for the public key encoded in Base64.")]
        [System.String]$Value,

        [Parameter(Mandatory = $true, ValueFromPipeline = $true, HelpMessage = "Specifies the type of key credential (e.g., AsymmetricX509Cert, Symmetric).")]
        [ValidateSet('AsymmetricX509Cert', 'X509CertAndPassword')]
        [System.String]$Type,
        
        [Parameter(Mandatory = $true, ValueFromPipeline = $true, HelpMessage = "Specifies the usage of the key credential (e.g., Sign, Verify).")]
        [ValidateSet('Sign', 'Verify')]
        [System.String]$Usage,
        
        [Parameter(Mandatory = $true, ValueFromPipeline = $true, HelpMessage = "A self-signed JWT token used as a proof of possession of the existing keys. This JWT token must be signed with a private key that corresponds to one of the existing valid certificates associated with the servicePrincipal.")]
        [System.String]$Proof,

        [Parameter(ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = "Specifies a custom identifier for the key credential.")]
        [System.String] $CustomKeyIdentifier,
        
        [Parameter(ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = "Specifies the time when the key becomes valid as a DateTime object.")]
        [System.Nullable[System.DateTime]] $StartDate,

        [Parameter(ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true,
            HelpMessage = "Specifies the time when the key becomes invalid as a DateTime object.")]
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
                startDateTime = $StartDate
                endDateTime = $EndDate
                customKeyIdentifier = $CustomKeyIdentifier
            }
            passwordCredential = $null
            proof = $Proof
        }

        Write-Debug("============================ TRANSFORMATIONS ============================")
        $params.Keys | ForEach-Object { "$_ : $($params[$_])" } | Write-Debug
        Write-Debug("=========================================================================`n")

        try {
            $response = Invoke-GraphRequest -Headers $customHeaders -Uri $URI -Method "POST" -Body ($params | ConvertTo-Json -Depth 4)

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
            Write-Error "Failed to add key credential: $($_)"
        }
    }
}