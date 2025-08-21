# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

BeforeAll {
    if((Get-Module -Name Microsoft.Entra.Beta.NetworkAccess) -eq $null){
        Import-Module Microsoft.Entra.Beta.NetworkAccess    
    }
    Import-Module (Join-Path $PSScriptRoot "..\..\Common-Functions.ps1") -Force

    Mock -CommandName Invoke-GraphRequest -MockWith {} -ModuleName Microsoft.Entra.Beta.NetworkAccess
    Mock -CommandName Get-EntraContext -MockWith { @{Scopes = @("NetworkAccessPolicy.ReadWrite.All", "Application.ReadWrite.All", "NetworkAccess.ReadWrite.All") } } -ModuleName Microsoft.Entra.Beta.NetworkAccess
}

Describe "Remove-EntraBetaPrivateAccessApplicationSegment" {
    It "Should fail when ApplicationId is missing" {
        { Remove-EntraBetaPrivateAccessApplicationSegment } | Should -Throw "Cannot process argument transformation on parameter '-ApplicationId'*"
    }

    It "Should fail when ApplicationId value is missing" {
        { Remove-EntraBetaPrivateAccessApplicationSegment -ApplicationId } | Should -Throw "Cannot process argument transformation on parameter '-ApplicationId'*"
    }

    It "Should fail when ApplicationId is null" {
        { Remove-EntraBetaPrivateAccessApplicationSegment -ApplicationId $null } | Should -Throw "Cannot process argument transformation on parameter '-ApplicationId'*"
    }
    
    It "Should fail when ApplicationSegmentId value is missing" {
        { Remove-EntraBetaPrivateAccessApplicationSegment -ApplicationId "TestApplicationId" -ApplicationSegmentId } | Should -Throw "Missing an argument for parameter 'ApplicationSegmentId'. Specify a parameter of type 'System.String' and try again."
    }

    It "Should execute successfully without throwing an error" {
        # Disable confirmation prompts       
        $originalDebugPreference = $DebugPreference
        $DebugPreference = 'Continue'

        try {
            # Act & Assert: Ensure the function doesn't throw an exception
            { Remove-EntraBetaPrivateAccessApplicationSegment -ApplicationId "TestApplicationId" -ApplicationSegmentId "TestAppSegmentId" } | Should -Not -Throw
        }
        finally {
            # Restore original confirmation preference            
            $DebugPreference = $originalDebugPreference        
        }
    }

    It "Should execute successfully without throwing an error when using an Alias" {
        # Disable confirmation prompts       
        $originalDebugPreference = $DebugPreference
        $DebugPreference = 'Continue'

        try {
            # Act & Assert: Ensure the function doesn't throw an exception
            { Remove-EntraBetaPrivateAccessApplicationSegment -ObjectId "TestApplicationId" -ApplicationSegmentId "TestAppSegmentId" } | Should -Not -Throw
        }
        finally {
            # Restore original confirmation preference            
            $DebugPreference = $originalDebugPreference        
        }
    }
}
