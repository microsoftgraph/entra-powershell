# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
@{
    SourceName = "Get-AzureADDevice"
    TargetName = "Get-MgBetaDevice"
    Parameters = @(
        @{
            SourceName = "SearchString"
            TargetName = "Filter"
            ConversionType = "ScriptBlock"
            SpecialMapping = @"
`$Value = "displayName eq '`$TmpValue' or startswith(displayName,'`$TmpValue')"
"@
        }
    )
    Outputs =  @(
        @{
            SourceName = "OperatingSystem"
            TargetName = "DeviceOSType"
            ConversionType = "Name"
            SpecialMapping = $null
        }
        @{
            SourceName = "OperatingSystemVersion"
            TargetName = "DeviceOSVersion"
            ConversionType = "Name"
            SpecialMapping = $null
        }
        @{
            SourceName = "TrustType"
            TargetName = "DeviceTrustType"
            ConversionType = "Name"
            SpecialMapping = $null
        }
        @{
            SourceName = "ApproximateLastSignInDateTime"
            TargetName = "ApproximateLastLogonTimestamp"
            ConversionType = "Name"
            SpecialMapping = $null
        }
        @{
            SourceName = "ComplianceExpirationDateTime"
            TargetName = "ComplianceExpiryTime"
            ConversionType = "Name"
            SpecialMapping = $null
        }
        @{
            SourceName = "DeletedDateTime"
            TargetName = "DeletionTimestamp"
            ConversionType = "Name"
            SpecialMapping = $null
        }
        @{
            SourceName = "DeviceVersion"
            TargetName = "DeviceObjectVersion"
            ConversionType = "Name"
            SpecialMapping = $null
        }
        @{
            SourceName = "PhysicalIds"
            TargetName = "DevicePhysicalIds"
            ConversionType = "Name"
            SpecialMapping = $null
        }
        @{
            SourceName = "OnPremisesSyncEnabled"
            TargetName = "DirSyncEnabled"
            ConversionType = "Name"
            SpecialMapping = $null
        }
        @{
            SourceName = "OnPremisesLastSyncDateTime"
            TargetName = "LastDirSyncTime"
            ConversionType = "Name"
            SpecialMapping = $null
        }
    )


}