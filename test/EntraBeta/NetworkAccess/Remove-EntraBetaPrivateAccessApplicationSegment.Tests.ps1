# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

BeforeAll {
    if((Get-Module -Name Microsoft.Entra.Beta.NetworkAccess) -eq $null){
        Import-Module Microsoft.Entra.Beta.NetworkAccess    
    }
    Import-Module (Join-Path $PSScriptRoot "..\..\Common-Functions.ps1") -Force

    Mock -CommandName Invoke-GraphRequest -MockWith {} -ModuleName Microsoft.Entra.Beta.NetworkAccess

    Mock -CommandName Get-EntraContext -MockWith {
        @{
            Environment = @{
                Name = "Global"
            }
            Scopes = @("NetworkAccessPolicy.ReadWrite.All", "Application.ReadWrite.All", "NetworkAccess.ReadWrite.All")
        }
    } -ModuleName Microsoft.Entra.Beta.NetworkAccess
}

Describe "Remove-EntraBetaPrivateAccessApplicationSegment" {
    It "Should throw when not connected and not call Graph" {
        Mock -CommandName Get-EntraContext -MockWith { $null } -ModuleName Microsoft.Entra.Beta.NetworkAccess

        { Remove-EntraBetaPrivateAccessApplicationSegment  -ApplicationId "TestApplicationId" -ApplicationSegmentId "TestAppSegmentId" } | Should -Throw "Not connected to Microsoft Graph*"
        Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.Beta.NetworkAccess -Times 0
    }
    
    It "Should fail when ApplicationId is missing" {
        { Remove-EntraBetaPrivateAccessApplicationSegment } | Should -Throw "Cannot process command because of one or more missing mandatory parameters: ApplicationId*"
    }

    It "Should fail when ApplicationId value is missing" {
        { Remove-EntraBetaPrivateAccessApplicationSegment -ApplicationId } | Should -Throw "Missing an argument for parameter 'ApplicationId'*"
    }

    It "Should fail when ApplicationId is null" {
        { Remove-EntraBetaPrivateAccessApplicationSegment -ApplicationId $null } | Should -Throw "Cannot validate argument on parameter 'ApplicationId'*"
    }
    
    It "Should fail when ApplicationSegmentId value is missing" {
        { Remove-EntraBetaPrivateAccessApplicationSegment -ApplicationId "TestApplicationId" -ApplicationSegmentId } | Should -Throw "Missing an argument for parameter 'ApplicationSegmentId'*"
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
