# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
@{
    SourceName = "Get-AzureADDeviceRegisteredUser"
    TargetName = "Get-MgDeviceRegisteredUser"
    Parameters = @(
        @{
            SourceName = "ObjectId"
            TargetName = "DeviceId"
            ConversionType = "Name"
            SpecialMapping = $null
        }
    )
    Outputs = $null
}