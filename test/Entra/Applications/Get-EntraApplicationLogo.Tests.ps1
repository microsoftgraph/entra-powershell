# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

BeforeAll {  
    if ((Get-Module -Name Microsoft.Entra.Applications) -eq $null) {
        Import-Module Microsoft.Entra.Applications      
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
    
    Mock -CommandName Invoke-GraphRequest -MockWith $scriptblock -ModuleName Microsoft.Entra.Applications
}
  
Describe "Get-EntraApplicationLogo" {
    It "Should return empty" {
        $result = Get-EntraApplicationLogo -ApplicationId "aaaaaaaa-1111-2222-3333-ccccccccccc" -FilePath "D:\image.jpg"        
        $result | Should -BeNullOrEmpty
        Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.Applications -Times 1
    }
    It "Should return empty" {
        $result = Get-EntraApplicationLogo -ObjectId "aaaaaaaa-1111-2222-3333-ccccccccccc" -FilePath "D:\image.jpg"        
        $result | Should -BeNullOrEmpty
        Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.Applications -Times 1
    }
    It "Should return empty when passed ileName parameter" {
        $result = Get-EntraApplicationLogo -ApplicationId "aaaaaaaa-1111-2222-3333-ccccccccccc" -FileName "image"        
        $result | Should -BeNullOrEmpty
    }
    It "Should fail when FileName is empty" {
        { Get-EntraApplicationLogo -ApplicationId "aaaaaaaa-1111-2222-3333-ccccccccccc" -FileName } | Should -Throw "Missing an argument for parameter 'FileName'*"
    }
    It "Should return empty when passed ileName parameter" {
        $result = Get-EntraApplicationLogo -ApplicationId "aaaaaaaa-1111-2222-3333-ccccccccccc" -View $true        
        $result | Should -BeNullOrEmpty
    }
    It "Should fail when View is invalid" {
        { Get-EntraApplicationLogo -ApplicationId "aaaaaaaa-1111-2222-3333-ccccccccccc" -View "cc" } | Should -Throw "Cannot process argument transformation on parameter 'View'*"
    }
    It "Should fail when View is empty" {
        { Get-EntraApplicationLogo -ApplicationId "aaaaaaaa-1111-2222-3333-ccccccccccc" -View } | Should -Throw "Missing an argument for parameter 'View'*"
    }
    It "Should fail when ApplicationId is empty" {
        { Get-EntraApplicationLogo -ApplicationId "" } | Should -Throw "Cannot validate argument on parameter 'ApplicationId'. The argument is null or empty. Provide an argument that is not null or empty, and then try the command again."
    }
    It "Should fail when ApplicationId is null" {
        { Get-EntraApplicationLogo -ApplicationId } | Should -Throw "Missing an argument for parameter 'ApplicationId'*"
    }
    It "Should contain 'User-Agent' header" {
        $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraApplicationLogo"
        Get-EntraApplicationLogo -ApplicationId "aaaaaaaa-1111-2222-3333-ccccccccccc" -FilePath "D:\image.jpg"           
        $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraApplicationLogo"
        Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.Applications -Times 1 -ParameterFilter {
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
            { Get-EntraApplicationLogo -ApplicationId "aaaaaaaa-1111-2222-3333-ccccccccccc" -FilePath "D:\image.jpg" -Debug } | Should -Not -Throw
        }
        finally {
            # Restore original confirmation preference            
            $DebugPreference = $originalDebugPreference        
        }
    }  
}

