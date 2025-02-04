<#
DISCLAIMER: This script is not an official PowerShell script and is specifically designed for the current situation you are facing.
It is provided "AS IS" with no warranties of any kind, either express or implied, including, but not limited to, any implied warranties of merchantability or fitness for a particular purpose.
This script is not supported by any official Microsoft support programs or services. Microsoft disclaims all implied warranties, including but not limited to implied warranties of merchantability or fitness for a particular purpose.
You assume all risk related to the use or performance of this script and its associated documentation. Under no circumstances shall Microsoft, its authors, or any other party involved in the creation, production, or delivery of this script be liable for any damages (including, but not limited to, loss of business profits, business interruptions, loss of business information, or other financial losses) arising from the use or inability to use the script or documentation, even if Microsoft has been advised of the possibility of such damages.

This script requires Microsoft Graph v1.0, as its logic depends on specific property values from this version. It is only compatible with Microsoft Graph PowerShell v2.x.x, which ensures that Microsoft Graph v1.0 is used. If you are using Microsoft Graph PowerShell v1, please upgrade to v2.
For more information, visit: https://devblogs.microsoft.com/microsoft365dev/microsoft-graph-powershell-v2-is-now-in-public-preview-half-the-size-and-will-speed-up-your-automations/

Ensure you have the appropriate privileges when running this script, such as `Global Reader` or `Identity Governance Administrator`.
#>
Import-Module Microsoft.Graph.Authentication
Import-Module Microsoft.Graph.Identity.Governance

# Connect to Microsoft Graph with the required scopes
Connect-MgGraph -Scopes EntitlementManagement.Read.All

# Define allowed target scopes
$allowedTargetScopes = @("allExternalUsers","allConfiguredConnectedOrganizationUsers","specificConnectedOrganizationUsers")
$PoliciesToReview  = @()

Write-Host "Starting to search for policies..."
try{
    $Policies = Get-MgEntitlementManagementAssignmentPolicy -Property Id,DisplayName,AllowedTargetScope,RequestApprovalSettings -All -Top 999
    Write-Host "Successfully imported $($Policies.Count) policies"
}catch{
    Write-Error "Error importing policies: $_"
    return
}

Write-Host "Starting to analyze policies"
foreach($Policy in $Policies){
    if($allowedTargetScopes -contains $Policy.AllowedTargetScope){
        if($Policy.RequestApprovalSettings.IsApprovalRequiredForAdd -ne $true){
            try {
                $PolicyDetails = Get-MgEntitlementManagementAssignmentPolicy -AccessPackageAssignmentPolicyId $Policy.Id -ExpandProperty accessPackage,catalog
                $PoliciesToReview += $PolicyDetails
            }
            catch {
                Write-Error "Error getting policy details: $_"
                return
            }

        }
    }
}

Write-Host "Analysis completed we have identified $($PoliciesToReview.Count) policies which should be reviewed:"
Write-Host ($PoliciesToReview | Format-Table | Out-String)

Write-Host "Access packages associated with these policies:"
Write-Host ($PoliciesToReview.AccessPackage | Format-Table | Out-String)

Write-Host "Script completed. More information can be found in the `$PoliciesToReview variable."
