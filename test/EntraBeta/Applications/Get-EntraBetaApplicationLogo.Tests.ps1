# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

BeforeAll {  
    if ((Get-Module -Name Microsoft.Entra.Beta.Applications) -eq $null) {
        Import-Module Microsoft.Entra.Beta.Applications      
    }
    Import-Module (Join-Path $PSScriptRoot "..\..\Common-Functions.ps1") -Force
    
    $scriptblock = {
        @{
            "Info" = @(
                @{
                    "logoUrl"    = ""
                    "Parameters" = $args
                })                     
        }
    }
    
    Mock -CommandName Invoke-GraphRequest -MockWith $scriptblock -ModuleName Microsoft.Entra.Beta.Applications
}
  
Describe "Get-EntraBetaApplicationLogo" {
    It "Should return empty" {
        $result = Get-EntraBetaApplicationLogo -ApplicationId "bbbbcccc-1111-dddd-2222-eeee3333ffff" -FilePath "D:\image.jpg"        
        $result | Should -BeNullOrEmpty
        Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.Beta.Applications -Times 1
    }
    It "Should fail when ApplicationId is empty" {
        { Get-EntraBetaApplicationLogo -ApplicationId "" } | Should -Throw "Cannot validate argument on parameter 'ApplicationId'. The argument is null or empty. Provide an argument that is not null or empty, and then try the command again."
    }
    It "Should fail when ApplicationId is null" {
        { Get-EntraBetaApplicationLogo -ApplicationId } | Should -Throw "Missing an argument for parameter 'ApplicationId'*"
    }
    It "Should contain 'User-Agent' header" {
        $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraBetaApplicationLogo"
        $result = Get-EntraBetaApplicationLogo -ApplicationId "bbbbcccc-1111-dddd-2222-eeee3333ffff" -FilePath "D:\image.jpg"
        $result | Should -BeNullOrEmpty
        $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraBetaApplicationLogo"
        Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.Beta.Applications -Times 1 -ParameterFilter {
            $Headers.'User-Agent' | Should -Be $userAgentHeaderValue
            $true
        }
    }
    It "Should execute successfully without throwing an error " {
        # Disable confirmation prompts       
        $originalDebugPreference = $DebugPreference
        $DebugPreference = 'Continue'

        try {
            # Act & Assert: Ensure the function doesn't throw an exception
            { Get-EntraBetaApplicationLogo -ApplicationId "bbbbcccc-1111-dddd-2222-eeee3333ffff" -FilePath "D:\image.jpg" -Debug } | Should -Not -Throw
        }
        finally {
            # Restore original confirmation preference            
            $DebugPreference = $originalDebugPreference        
        }
    }
}

