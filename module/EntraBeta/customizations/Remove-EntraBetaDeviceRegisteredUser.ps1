# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
@{
    SourceName = "Remove-AzureADDeviceRegisteredUser"
    TargetName = "Remove-MgBetaDeviceRegisteredUserByRef"
    Parameters = @(
        @{
            SourceName = "UserId"
            TargetName = "DirectoryObjectId"
            ConversionType = "Name"
            SpecialMapping = $null
        }
        @{
            SourceName = "ObjectId"
            TargetName = "DeviceId"
            ConversionType = "Name"
            SpecialMapping = $null
        }
    )
    Outputs = $null
}