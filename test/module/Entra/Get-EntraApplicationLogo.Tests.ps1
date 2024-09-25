# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra) -eq $null){
        Import-Module Microsoft.Graph.Entra      
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force
    
    $scriptblock = {
        @{
            "Info" = @(
            @{
                "logoUrl"    = ""
                "Parameters" = $args
            })                     
        }
    }
    
    Mock -CommandName Invoke-GraphRequest -MockWith $scriptblock -ModuleName Microsoft.Graph.Entra
}
  
Describe "Get-EntraApplicationLogo" {
    It "Should return empty" {
        $result = Get-EntraApplicationLogo -ObjectId "aaaaaaaa-1111-2222-3333-ccccccccccc" -FilePath "D:\image.jpg"        
        $result | Should -BeNullOrEmpty
        Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Graph.Entra -Times 1
    }
    It "Should return empty when passed ileName parameter" {
        $result = Get-EntraApplicationLogo -ObjectId "aaaaaaaa-1111-2222-3333-ccccccccccc" -FileName "image"        
        $result | Should -BeNullOrEmpty
    }
    It "Should fail when FileName is empty" {
        { Get-EntraApplicationLogo -ObjectId "aaaaaaaa-1111-2222-3333-ccccccccccc" -FileName } | Should -Throw "Missing an argument for parameter 'FileName'*"
    }
    It "Should return empty when passed ileName parameter" {
        $result = Get-EntraApplicationLogo -ObjectId "aaaaaaaa-1111-2222-3333-ccccccccccc" -View $true        
        $result | Should -BeNullOrEmpty
    }
    It "Should fail when View is invalid" {
        { Get-EntraApplicationLogo -ObjectId "aaaaaaaa-1111-2222-3333-ccccccccccc" -View "cc" } | Should -Throw "Cannot process argument transformation on parameter 'View'*"
    }
    It "Should fail when View is empty" {
        { Get-EntraApplicationLogo -ObjectId "aaaaaaaa-1111-2222-3333-ccccccccccc" -View } | Should -Throw "Missing an argument for parameter 'View'*"
    }
    It "Should fail when ObjectId is empty" {
        { Get-EntraApplicationLogo -ObjectId "" } | Should -Throw "Cannot bind argument to parameter 'ObjectId'*"
    }
    It "Should fail when ObjectId is null" {
        { Get-EntraApplicationLogo -ObjectId } | Should -Throw "Missing an argument for parameter 'ObjectId'*"
    }
    It "Should contain 'User-Agent' header" {
        $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraApplicationLogo"
        Get-EntraApplicationLogo -ObjectId "aaaaaaaa-1111-2222-3333-ccccccccccc" -FilePath "D:\image.jpg"           
        $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraApplicationLogo"
        Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Graph.Entra -Times 1 -ParameterFilter {
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
            { Get-EntraApplicationLogo -ObjectId "aaaaaaaa-1111-2222-3333-ccccccccccc" -FilePath "D:\image.jpg"  -Debug } | Should -Not -Throw
        } finally {
            # Restore original confirmation preference            
            $DebugPreference = $originalDebugPreference        
        }
    }  
}