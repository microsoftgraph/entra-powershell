BeforeAll{
    if ((Get-Module -Name Microsoft.Graph.Entra) -eq $null) {
        Import-Module Microsoft.Graph.Entra      
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force

    $response = @{
        "id" = "aaaaaaaa-1111-2222-3333-cccccccccccc"
        "supportedSingleSignOnModes" = @{}
        "publisher" = "test publisher"
        "displayName" = "test name"
        "homePageUrl" = "samplehomePageUrl"
        "logoUrl" = "samplelogourl"
        "categories" = @{}
        "description" = ""
        "supportedProvisioningTypes" = @{}
    }

    Mock -CommandName Invoke-GraphRequest -MockWith { $response } -ModuleName Microsoft.Graph.Entra
}
Describe "Get-EntraApplicationTemplate tests"{
    It "Should return specific application" {
        $result = Get-EntraApplicationTemplate -Id "aaaaaaaa-1111-2222-3333-cccccccccccc"
        $result | Should -Not -BeNullOrEmpty
        $result.Id | should -Be @('aaaaaaaa-1111-2222-3333-cccccccccccc')
        Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Graph.Entra -Times 1
    }
    It "Should fail when Id is empty" {
        { Get-EntraApplicationTemplate -Id "" } | Should -Throw "Cannot bind argument to parameter 'Id'*"
    }
    It "Should fail when Id is null" {
        { Get-EntraApplicationTemplate -Id } | Should -Throw "Missing an argument for parameter 'Id'*"
    }
    It "Should fail when invalid parameter is passed" {
        { Get-EntraApplicationTemplate -xyz } | Should -Throw "A parameter cannot be found that matches parameter name 'xyz'*"
    }
    It "Should return all application templates" {
        $result = Get-EntraApplicationTemplate
        $result | Should -Not -BeNullOrEmpty
        Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Graph.Entra -Times 1
    }
}