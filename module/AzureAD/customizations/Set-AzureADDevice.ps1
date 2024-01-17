# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
@{
    SourceName = "Set-AzureADDevice"
    TargetName = "Update-MgDevice"
    Parameters = @(
        @{
            SourceName = "ApproximateLastLogonTimeStamp"
            TargetName = "ApproximateLastSignInDateTime"
            ConversionType = "Name"
            SpecialMapping = $null
        }
        @{
            SourceName = "DeviceId"
            TargetName = "DeviceId1"
            ConversionType = "Name"
            SpecialMapping = $null
        }
        @{
            SourceName = "DeviceObjectVersion"
            TargetName = "DeviceVersion"
            ConversionType = "Name"
            SpecialMapping = $null
        }
        @{
            SourceName = "DeviceOSType"
            TargetName = "OperatingSystem"
            ConversionType = "Name"
            SpecialMapping = $null
        }
        @{
            SourceName = "DeviceOSVersion"
            TargetName = "OperatingSystemVersion"
            ConversionType = "Name"
            SpecialMapping = $null
        }
        @{
            SourceName = "DevicePhysicalIds"
            TargetName = "PhysicalIds"
            ConversionType = "Name"
            SpecialMapping = $null
        }
        @{
            SourceName = "DeviceTrustType"
            TargetName = "TrustType"
            ConversionType = "Name"
            SpecialMapping = $null
        }
        @{
            SourceName = "AlternativeSecurityIds"
            TargetName = "BodyParameter"
            ConversionType = "ScriptBlock"
            SpecialMapping = @'
            $key = [System.Text.Encoding]::UTF8.GetString($TmpValue.key)
            $Temp = @{
                alternativeSecurityIds = @(
                    @{
                        type = $TmpValue.type
                        key = [System.Text.Encoding]::ASCII.GetBytes($key)
                    }
                )
            }
            $Value = $Temp 
'@
        }
    )
    Outputs = $null
}