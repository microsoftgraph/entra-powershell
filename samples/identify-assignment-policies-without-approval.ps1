<#
DISCLAIMER: This is not an official PowerShell Script. We designed it specifically for the situation you have encountered right now.
This code-sample is provided "AS IT IS" without warranty of any kind, either expressed or implied, including but not limited to the implied warranties of merchantability and/or fitness for a particular purpose.
This sample is not supported under any Microsoft standard support program or service.
Microsoft further disclaims all implied warranties including, without limitation, any implied warranties of merchantability or of fitness for a particular purpose. 
The entire risk arising out of the use or performance of the sample and documentation remains with you. 
In no event shall Microsoft, its authors, or anyone else involved in the creation, production, or delivery of the script be liable for any damages whatsoever (including, without limitation, damages for loss of business profits, business interruption, loss of business information, or other pecuniary loss) arising out of  the use of or inability to use the sample or documentation, even if Microsoft has been advised of the possibility of such damages.

This script must be run against Microsoft Graph v1.0 as the script logic is based on Microsoft Graph v1.0 property values
If you are using Microsoft Graph PowerShell v2 the cmdlets below will ensure Microsoft Graph v1.0 is used
If you are using Microsoft Graph PowerShell v1 upgrade to v2 or ensure Microsoft Graph v1.0 is being used via Select-MgProfile v1.0
Ref. https://devblogs.microsoft.com/microsoft365dev/microsoft-graph-powershell-v2-is-now-in-public-preview-half-the-size-and-will-speed-up-your-automations/
Ensure you are running the script as at least an Global Reader or Identity Governance Administrator. 
#>
Import-Module Microsoft.Graph.Authentication
Import-Module Microsoft.Graph.Identity.Governance

Connect-MgGraph -Scopes EntitlementManagement.Read.All

$allowedTargetScopes = @("allExternalUsers","allConfiguredConnectedOrganizationUsers","specificConnectedOrganizationUsers")
$PoliciesToReview  = @()

Write-Host "Starting to import polices via Microsoft Graph"
$Policies = Get-MgEntitlementManagementAssignmentPolicy -Property Id,DisplayName,AllowedTargetScope,RequestApprovalSettings -All -Top 999
Write-Host "Successfully imported $($Policies.Count) policies"
Write-Host "Starting to analyze policies"
foreach($Policy in $Policies){
    if($allowedTargetScopes -contains $Policy.AllowedTargetScope){
        if($Policy.RequestApprovalSettings.IsApprovalRequiredForAdd -ne $true){
            $PolicyDetails = Get-MgEntitlementManagementAssignmentPolicy -AccessPackageAssignmentPolicyId $Policy.Id -ExpandProperty accessPackage,catalog
            $PoliciesToReview += $PolicyDetails
        }
    }
}
Write-Host "Analysis completed we have identified $($PoliciesToReview.Count) policies which should be reviewed:"
$PoliciesToReview | fl *
Write-Host "Script completed"
