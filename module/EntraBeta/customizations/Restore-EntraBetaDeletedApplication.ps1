# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
@{
    SourceName = "Restore-AzureADDeletedApplication"
    TargetName = $null
    Parameters = $null
    Outputs = $null
    CustomScript = @'
    PROCESS {    
        $params = @{}
        $customHeaders = New-EntraBetaCustomHeaders -Command $MyInvocation.MyCommand
        $keysChanged = @{ObjectId = "Id"}
        if($PSBoundParameters.ContainsKey("Verbose"))
        {
            $params["Verbose"] = $Null
        }
        if($null -ne $PSBoundParameters["ObjectId"])
        {
            $params["DirectoryObjectId"] = $PSBoundParameters["ObjectId"]
        }
        if($null -ne $PSBoundParameters["IdentifierUris"])
        {
            $params["IdentifierUris"] = $PSBoundParameters["IdentifierUris"]
        }
        if($PSBoundParameters.ContainsKey("Debug"))
        {
            $params["Debug"] = $Null
        }
    
        Write-Debug("============================ TRANSFORMATIONS ============================")
        $params.Keys | ForEach-Object {"$_ : $($params[$_])" } | Write-Debug
        Write-Debug("=========================================================================`n")
        
        $response = Restore-MgBetaDirectoryDeletedItem @params -Headers $customHeaders
        $response | ForEach-Object {
            if($null -ne $_) {        
            Add-Member -InputObject $_ -MemberType NoteProperty -Name Homepage -value $_.AdditionalProperties['web']['homePageUrl']
            Add-Member -InputObject $_ -MemberType NoteProperty -Name ReplyUrls -value $_.AdditionalProperties['web']['redirectUris']
            Add-Member -InputObject $_ -MemberType NoteProperty -Name ParentalControlSettings -value $_.AdditionalProperties['parentalControlSettings']
            Add-Member -InputObject $_ -MemberType NoteProperty -Name PasswordCredentials -value $_.AdditionalProperties['passwordCredentials']
            Add-Member -InputObject $_ -MemberType NoteProperty -Name KeyCredentials -value $_.AdditionalProperties['keyCredentials']
            Add-Member -InputObject $_ -MemberType NoteProperty -Name AddIns -value $_.AdditionalProperties['addIns']
            Add-Member -InputObject $_ -MemberType NoteProperty -Name AppId -value $_.AdditionalProperties['appId']
            Add-Member -InputObject $_ -MemberType NoteProperty -Name AppRoles -value $_.AdditionalProperties['appRoles']
            Add-Member -InputObject $_ -MemberType NoteProperty -Name DisplayName -value $_.AdditionalProperties['displayName']
            Add-Member -InputObject $_ -MemberType NoteProperty -Name IdentifierUris -value $_.AdditionalProperties['identifierUris']
            Add-Member -InputObject $_ -MemberType NoteProperty -Name KnownClientApplications -value $_.AdditionalProperties['api']['knownClientApplications']
            Add-Member -InputObject $_ -MemberType NoteProperty -Name Oauth2Permissions -value $_.AdditionalProperties['api']['oauth2PermissionScopes']
            Add-Member -InputObject $_ -MemberType NoteProperty -Name PreAuthorizedApplications -value $_.AdditionalProperties['api']['preAuthorizedApplications']
            Add-Member -InputObject $_ -MemberType NoteProperty -Name PublicClient -value $_.AdditionalProperties['publicClient']
            Add-Member -InputObject $_ -MemberType NoteProperty -Name PublisherDomain -value $_.AdditionalProperties['publisherDomain']
            Add-Member -InputObject $_ -MemberType NoteProperty -Name RequiredResourceAccess -value $_.AdditionalProperties['requiredResourceAccess']
            Add-Member -InputObject $_ -MemberType NoteProperty -Name SignInAudience -value $_.AdditionalProperties['signInAudience']
            Add-Member -InputObject $_ -MemberType NoteProperty -Name ObjectType -value $_.AdditionalProperties['@odata.type']
            Add-Member -InputObject $_ -MemberType AliasProperty -Name DeletionTimestamp -Value DeletedDateTime
            Add-Member -InputObject $_ -MemberType AliasProperty -Name ObjectId -Value Id
            }
        }
        $response
    }
'@
}