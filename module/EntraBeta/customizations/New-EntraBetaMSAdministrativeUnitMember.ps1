# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
@{
    SourceName = "New-AzureADMSAdministrativeUnitMember"
    TargetName = $null
    Parameters = $null
    Outputs = $null
    CustomScript = @"
    PROCESS {    
        `$params = @{}
        `$customHeaders = New-CustomHeaders -Module Entra -Command `$MyInvocation.MyCommand
        
        if(`$null -ne `$PSBoundParameters["OdataType"])
        {
            `$params["@odata.type"] = `$PSBoundParameters["OdataType"]
        }
        if(`$null -ne `$PSBoundParameters["AssignedLabels"])
        {
            `$params["AssignedLabels"] = `$PSBoundParameters["AssignedLabels"]
        }
        if(`$null -ne `$PSBoundParameters["Description"])
        {
            `$params["description"] = `$PSBoundParameters["Description"]
        }
        if(`$null -ne `$PSBoundParameters["DisplayName"])
        {
            `$params["displayName"] = `$PSBoundParameters["DisplayName"]
        }
        if(  (`$PSBoundParameters["IsAssignableToRole"]) -or (-not `$PSBoundParameters["IsAssignableToRole"]))
        {
            `$params["IsAssignableToRole"] = `$PSBoundParameters["IsAssignableToRole"]
        }
        if( (`$PSBoundParameters["MailEnabled"]) -or (-not `$PSBoundParameters["MailEnabled"]))
        {
            `$params["mailEnabled"] = `$PSBoundParameters["MailEnabled"]
        }
        if( `$PSBoundParameters["mailNickname"])
        {
            `$params["mailNickname"] = `$PSBoundParameters["mailNickname"]
        }
        if( (`$PSBoundParameters["SecurityEnabled"]) -or (-not `$PSBoundParameters["SecurityEnabled"]))
        {
            `$params["securityEnabled"] = `$PSBoundParameters["SecurityEnabled"]
        }
        if(`$null -ne `$PSBoundParameters["GroupTypes"])
        {
            `$params["groupTypes"] = `$PSBoundParameters["GroupTypes"]
        }
        if(`$null -ne `$PSBoundParameters["membershipRule"])
        {
            `$params["membershipRule"] = `$PSBoundParameters["membershipRule"]
        }
        if(`$null -ne `$PSBoundParameters["membershipRuleProcessingState"])
        {
            `$params["membershipRuleProcessingState"] = `$PSBoundParameters["MembershipRuleProcessingState"]
        }
        if(`$null -ne `$PSBoundParameters["visibility"])
        {
            `$params["visibility"] = `$PSBoundParameters["Visibility"]
        }
    
        Write-Debug("============================ TRANSFORMATIONS ============================")
        `$params.Keys | ForEach-Object {"`$_ : `$(`$params[`$_])" } | Write-Debug
        Write-Debug("=========================================================================``n")
            `$response = New-MGBetaAdministrativeUnitMember -AdministrativeUnitId `$ID -BodyParameter `$params
        `$response
        }
"@
}