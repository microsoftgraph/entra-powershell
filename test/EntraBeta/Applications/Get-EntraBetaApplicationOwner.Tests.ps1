# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
BeforeAll {  
    if ((Get-Module -Name Microsoft.Entra.Beta.Applications) -eq $null) {
        Import-Module Microsoft.Entra.Beta.Applications      
    }
    Import-Module (Join-Path $PSScriptRoot "..\..\Common-Functions.ps1") -Force

    $mockResponse = {
        return @(
            [PSCustomObject]@{
                Id                          = "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"          
                ageGroup                    = $null
                onPremisesLastSyncDateTime  = $null
                creationType                = $null
                preferredLanguage           = $null
                mail                        = "admin@contonso.com"
                securityIdentifier          = "S-1-12-1-1093396945-1080104032-2731339150-364051459"
                consentProvidedForMinor     = $null
                onPremisesUserPrincipalName = $null
                Parameters                  = $args
                AdditionalProperties        = @{
                        "@odata.type"  = "#microsoft.graph.user"
                        accountEnabled = $true
                    }
            }
        )
    }

    Mock -CommandName Get-MgBetaApplicationOwner -MockWith $mockResponse -ModuleName Microsoft.Entra.Beta.Applications
    Mock -CommandName Get-EntraContext -MockWith { @{Scopes = @("Application.Read.All") } } -ModuleName Microsoft.Entra.Beta.Applications
}

Describe "Get-EntraBetaApplicationOwner" {
    Context "Test for Get-EntraBetaApplicationOwner" {
        It "Should return application owner" {
            $result = Get-EntraBetaApplicationOwner -ApplicationId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
            Write-Host $result
            $result | Should -Not -BeNullOrEmpty
            $result.Id | should -Be @('aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb')

            Should -Invoke -CommandName Get-MgBetaApplicationOwner -ModuleName Microsoft.Entra.Beta.Applications -Times 1
        }
        It "Should fail when ApplicationId is empty" {
            { Get-EntraBetaApplicationOwner -ApplicationId "" } | Should -Throw "Cannot validate argument on parameter 'ApplicationId'. The argument is null or empty. Provide an argument that is not null or empty, and then try the command again."
        }
        It "Should fail when ApplicationId is null" {
            { Get-EntraBetaApplicationOwner -ApplicationId } | Should -Throw "Missing an argument for parameter 'ApplicationId'*"
        }
        It "Should fail when All has an argument" {
            { Get-EntraBetaApplicationOwner -All $true } | Should -Throw "A positional parameter cannot be found that accepts argument 'True'.*"
        }
        It "Should fail when Top is empty" {
            { Get-EntraBetaApplicationOwner -Top } | Should -Throw "Missing an argument for parameter 'Top'*"
        }
        It "Should fail when Top is invalid" {
            { Get-EntraBetaApplicationOwner -Top XY } | Should -Throw "Cannot process argument transformation on parameter 'Top'*"
        } 
        It "Property parameter should work" {
            $result = Get-EntraBetaApplicationOwner -ApplicationId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -Property Id 
            $result | Should -Not -BeNullOrEmpty
            $result.Id | Should -Be "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
        }
        It "Should return append specified properties to the default properties" {
            $scriptblock = {
                return @(
                    [PSCustomObject]@{
                        "DisplayName"           = "Sawyer M"
                        "Id"                    = "bbbbbbbb-1111-2222-3333-cccccccccccc"
                        "CreatedDateTime"       = "2023-01-01T00:00:00Z"
                        "DeletedDateTime"       = $null
                        "OnPremisesImmutableId" = "hhhhhhhh-3333-5555-3333-qqqqqqqqqqqq"
                        "AdditionalProperties"  = @{
                            "@odata.type"  = "#microsoft.graph.user"
                            accountEnabled = $true
                        }
                    }
                )
            }

            Mock -CommandName Get-MgBetaApplicationOwner -MockWith $scriptblock -ModuleName Microsoft.Entra.Beta.Applications
            $result = Get-EntraBetaApplicationOwner -ApplicationId "aaaaaaaa-1111-2222-3333-cccccccccccc" -Property onPremisesImmutableId,Id -AppendSelected | Select-Object id,displayName,'@odata.type',onPremisesImmutableId
            $result.Id | should -Be "bbbbbbbb-1111-2222-3333-cccccccccccc"
            $result.OnPremisesImmutableId | should -Be "hhhhhhhh-3333-5555-3333-qqqqqqqqqqqq"

            Should -Invoke -CommandName Get-MgBetaApplicationOwner -ModuleName Microsoft.Entra.Beta.Applications -Times 1
        }
        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraBetaApplicationOwner"
            $result = Get-EntraBetaApplicationOwner -ApplicationId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
            $result | Should -Not -BeNullOrEmpty
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraBetaApplicationOwner"    
            Should -Invoke -CommandName Get-MgBetaApplicationOwner -ModuleName Microsoft.Entra.Beta.Applications -Times 1 -ParameterFilter {
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
                { Get-EntraBetaApplicationOwner -ApplicationId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -Debug } | Should -Not -Throw
            }
            finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        } 
    }
}

