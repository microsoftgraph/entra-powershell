# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
@{
    SourceName = "New-AzureADMSApplication"
    TargetName = "New-MgApplication"
    Parameters = @(
        @{
            SourceName = "AddIns"
            TargetName = "AddIns"
            ConversionType = "ScriptBlock"
            SpecialMapping = @'
            $a = @()
            $input = $TmpValue
            foreach($v in $input)
            {
                $Temp = $v | ConvertTo-Json
                $hash = @{}

                (ConvertFrom-Json $Temp).psobject.properties | Foreach { if($null -ne $_.Value){ $hash[$_.Name] = $_.Value }}
                $a += $hash
            }

            $Value = $a
'@
        },
        @{
            SourceName = "Api"
            TargetName = "Api"
            ConversionType = "ScriptBlock"
            SpecialMapping = @'
        
            $Temp = $TmpValue | ConvertTo-Json 
            
            $Value = $Temp
'@
        }
        @{
            SourceName = "AppRoles"
            TargetName = "AppRoles"
            ConversionType = "ScriptBlock"
            SpecialMapping = @'
            $a = @()
            $input = $TmpValue
            foreach($v in $input)
            {
                $Temp = $v | ConvertTo-Json
                $hash = @{}

                (ConvertFrom-Json $Temp).psobject.properties | Foreach { if($null -ne $_.Value){ $hash[$_.Name] = $_.Value }}
                $a += $hash
            }

            $Value = $a
'@
        },
        @{
            SourceName = "InformationalUrl"
            TargetName = "Info"
            ConversionType = "ScriptBlock"
            SpecialMapping = @'
            $Temp = $TmpValue | ConvertTo-Json 
            
            $Value = $Temp
'@
        },
        @{
            SourceName = "KeyCredentials"
            TargetName = "KeyCredentials"
            ConversionType = "ScriptBlock"
            SpecialMapping = @'
            $a = @()
            $input = $TmpValue
            foreach($v in $input)
            {
                $hash = @{
                    CustomKeyIdentifier= $v.CustomKeyIdentifier
                    EndDateTime = $v.EndDateTime
                    Key= $v.Key
                    StartDateTime= $v.StartDateTime
                    Type= $v.Type
                    Usage= $v.Usage
                }
                
                $a += $hash
            }

            $Value = $a
'@
        },
        @{
            SourceName = "OptionalClaims"
            TargetName = "OptionalClaims"
            ConversionType = "ScriptBlock"
            SpecialMapping = @'
           $Temp = $TmpValue | ConvertTo-Json 
            
            $Value = $Temp
'@
        },
        @{
            SourceName = "ParentalControlSettings"
            TargetName = "ParentalControlSettings"
            ConversionType = "ScriptBlock"
            SpecialMapping = @'
            $Temp = $TmpValue | ConvertTo-Json 
            
            $Value = $Temp
'@
        },
        @{
            SourceName = "PasswordCredentials"
            TargetName = "PasswordCredentials"
            ConversionType = "ScriptBlock"
            SpecialMapping = @'
            $a = @()
            $input = $TmpValue
            foreach($v in $input)
            {
                $Temp = $v | ConvertTo-Json
                $hash = @{}

                (ConvertFrom-Json $Temp).psobject.properties | Foreach { if($null -ne $_.Value){ $hash[$_.Name] = $_.Value }}
                $a += $hash
            }

            $Value = $a
'@
        },
        @{
            SourceName = "PublicClient"
            TargetName = "PublicClient"
            ConversionType = "ScriptBlock"
            SpecialMapping = @'
            $Temp = $TmpValue | ConvertTo-Json 
            
            $Value = $Temp
'@
        },
        @{
            SourceName = "RequiredResourceAccess"
            TargetName = "RequiredResourceAccess"
            ConversionType = "ScriptBlock"
            SpecialMapping = @'
            $Value = $TmpValue | ConvertTo-Json
'@
        },
        @{
            SourceName = "Web"
            TargetName = "Web"
            ConversionType = "ScriptBlock"
            SpecialMapping = @'
           $Temp = $TmpValue | ConvertTo-Json 
            
            $Value = $Temp
'@
        }
    )
    outputs = $null
    CustomScript = $null
}