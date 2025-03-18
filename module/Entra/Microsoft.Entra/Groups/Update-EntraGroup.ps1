function Update-EntraGroup {
    [CmdletBinding(SupportsShouldProcess,
        ConfirmImpact = 'Medium',
        DefaultParameterSetName = 'Default')]
    param (
        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = "The unique identifier for the group, such as its object ID.")]
        [Alias("ObjectId", "Id")]
        [ValidateNotNullOrEmpty()]
        [string]$GroupId,

        [Parameter(HelpMessage = "The description of the group.")]
        [string]$Description,

        [Parameter(HelpMessage = "The display name of the group.")]
        [string]$DisplayName,

        [Parameter(HelpMessage = "Specifies the group types and its membership. Possible values are 'Unified' or 'DynamicMembership'.")]
        [string[]]$GroupTypes,

        [Parameter(HelpMessage = "Specifies whether the group is mail-enabled.")]
        [bool]$MailEnabled,

        [Parameter(HelpMessage = "The mail nickname for the group.")]
        [string]$MailNickname,

        [Parameter(HelpMessage = "Specifies whether the group is a security group.")]
        [bool]$SecurityEnabled,

        [Parameter(HelpMessage = "A list of SMTP proxy addresses for the group, including the primary SMTP address.")]
        [string[]]$ProxyAddresses,

        [Parameter(HelpMessage = "Specifies whether the group is visible in the address list.")]
        [bool]$Visibility,

        [Parameter(Mandatory = $false, HelpMessage = "A hashtable of additional group properties to update.")]
        [Alias("BodyParameter", "Body", "BodyParameters")]
        [hashtable]$AdditionalProperties = @{}
    )

    begin {

        # Ensure Microsoft Entra PowerShell module is available
        if (-not (Get-Module -ListAvailable -Name Microsoft.Entra.Groups)) {
            Write-Error "Microsoft.Entra module is required. Install it using 'Install-Module Microsoft.Entra.Groups'. See http://aka.ms/entra/ps/installation for more details."
            return
        }
 
        # Ensure connection to Microsoft Entra
        if (-not (Get-EntraContext)) {
            Write-Error "Not connected to Microsoft Graph. Use 'Connect-Entra -Scopes Group.ReadWrite.All' to authenticate."
            return
        }

        # Process business logic

        $graphUri = "https://graph.microsoft.com/v1.0/groups/$GroupId"
        $GroupProperties = @{}
    
        $CommonParameters = @("Verbose", "Debug", "WarningAction", "WarningVariable", "ErrorAction", "ErrorVariable", "OutVariable", "OutBuffer", "WhatIf", "Confirm")
    
        foreach ($param in $PSBoundParameters.Keys) {
            if ($param -ne "GroupId" -and $param -ne "AdditionalProperties" -and $CommonParameters -notcontains $param) {
                $GroupProperties[$param] = $PSBoundParameters[$param]
            }
        }
    
        foreach ($key in $AdditionalProperties.Keys) {
            $GroupProperties[$key] = $AdditionalProperties[$key]
        }
    
        $bodyJson = $GroupProperties | ConvertTo-Json -Depth 2
    }

    process {
        $customHeaders = New-EntraCustomHeaders -Command $MyInvocation.MyCommand

        if ($GroupProperties.Count -eq 0) {
            Write-Warning "No properties provided for update. Exiting."
            return
        }

        if ($PSCmdlet.ShouldProcess($GroupId, "Updating group properties via Microsoft Graph API")) {
            try {
                Invoke-MgGraphRequest -Uri $graphUri -Method PATCH -Body $bodyJson -Headers $customHeaders
                Write-Verbose "Properties for group $GroupId updated successfully. Updated properties: $($GroupProperties | Out-String)"
            }
            catch {
                $errorDetails = @{
                    'ErrorMessage'  = $_.Exception.Message
                    'RequestUri'    = $graphUri
                    'RequestBody'   = $bodyJson
                    'ErrorResponse' = $_.ErrorDetails.Message
                }
                Write-Debug "Error Details: $($errorDetails | ConvertTo-Json)"
                Write-Error "Failed to update group properties: $_"
            }
        }
    }
}
