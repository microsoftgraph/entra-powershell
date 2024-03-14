# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
@{
    SourceName = "New-AzureADMSIdentityProvider"
    TargetName = $null
    Parameters = $null
    outputs = $null
    CustomScript = @'   
    PROCESS {    
        $params = @{}
        $body = @{}
        $keysChanged = @{}
        if($null -ne $PSBoundParameters["Id"])
        {
            $params["IdentityProviderBaseId"] = $PSBoundParameters["Id"]
        }
        if($null -ne $PSBoundParameters["Type"])
        {
            $body["identityProviderType"] = $PSBoundParameters["Type"]
        }
        if($PSBoundParameters.ContainsKey("Verbose"))
        {
            $params["Verbose"] = $Null
        }
        if($PSBoundParameters.ContainsKey("Debug"))
        {
            $params["Debug"] = $Null
        }
        if($null -ne $PSBoundParameters["Name"])
        {
            $body["displayName"] = $PSBoundParameters["Name"]
        }
        if($null -ne $PSBoundParameters["ClientId"])
        {
            $body["clientId"] = $PSBoundParameters["ClientId"]
        }
        if($null -ne $PSBoundParameters["ClientSecret"])
        {
            $body["clientSecret"] = $PSBoundParameters["ClientSecret"]
        }
        $body["@odata.type"] = "#microsoft.graph.socialIdentityProvider"
        $params["BodyParameter"] = $body 
    
        Write-Debug("============================ TRANSFORMATIONS ============================")
        $params.Keys | ForEach-Object {"$_ : $($params[$_])" } | Write-Debug
        Write-Debug("=========================================================================")
        
        $response = New-MgIdentityProvider @params
        $response | ForEach-Object {
            if($null -ne $_) {
                Add-Member -InputObject $_ -NotePropertyMembers $_.AdditionalProperties
                Add-Member -InputObject $_ -MemberType AliasProperty -Name ObjectId -Value Id
                Add-Member -InputObject $_ -MemberType AliasProperty -Name Name -Value DisplayName
                Add-Member -InputObject $_ -MemberType AliasProperty -Name Type -Value identityProviderType
            }
        }
        $response
    }
'@
}