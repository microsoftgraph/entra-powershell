BeforeAll {  
    if ((Get-Module -Name Microsoft.Graph.Entra) -eq $null) {
        Import-Module Microsoft.Graph.Entra      
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force
    
    $scriptblock = {
        return @(
            [PSCustomObject]@{
                "Id"                          = "a47d4510-08c8-4437-99e9-71ca88e7af0f"
                "AlternateNotificationEmails" = "admingroup@contoso.com"
                "GroupLifetimeInDays"         = "100"
                "ManagedGroupTypes"           = "All"
                "Parameters"                  = $args
            }
        )
    }

    Mock -CommandName Update-MgGroupLifecyclePolicy -MockWith $scriptblock -ModuleName Microsoft.Graph.Entra
}
  
Describe "Set-EntraMSGroupLifecyclePolicy " {
    Context "Test for Set-EntraMSGroupLifecyclePolicy" {
        It "Should return updated GroupLifecyclePolicy" {
            $result = Set-EntraMSGroupLifecyclePolicy -Id a47d4510-08c8-4437-99e9-71ca88e7af0f -GroupLifetimeInDays 200 -AlternateNotificationEmails "admingroup@contoso.com" -ManagedGroupTypes "All"
            $result | Should -Not -BeNullOrEmpty
            $result.Id | should -Be "a47d4510-08c8-4437-99e9-71ca88e7af0f"
            $result.GroupLifetimeInDays | should -Be "100"
            $result.ManagedGroupTypes | should -Be "All"
            $result.AlternateNotificationEmails | should -Be "admingroup@contoso.com"

            Should -Invoke -CommandName Update-MgGroupLifecyclePolicy -ModuleName Microsoft.Graph.Entra -Times 1
        }
        It "Should fail when Id is invalid" {
            { Set-EntraMSGroupLifecyclePolicy -Id "" -GroupLifetimeInDays a -ManagedGroupTypes "Selected" -AlternateNotificationEmails "example@contoso.com" } | Should -Throw "Cannot bind argument to parameter 'Id' because it is an empty string.*"
        }
        It "Should fail when Id is empty" {
            { Set-EntraMSGroupLifecyclePolicy -Id -GroupLifetimeInDays  -ManagedGroupTypes "Selected" -AlternateNotificationEmails "example@contoso.com" } | Should -Throw "Missing an argument for parameter 'Id'.*"
        } 
        It "Should fail when GroupLifetimeInDays is invalid" {
            { Set-EntraMSGroupLifecyclePolicy -Id a47d4510-08c8-4437-99e9-71ca88e7af0f -GroupLifetimeInDays a -ManagedGroupTypes "Selected" -AlternateNotificationEmails "example@contoso.com" } | Should -Throw "Cannot process argument transformation on parameter 'GroupLifetimeInDays'.*"
        }
        It "Should fail when GroupLifetimeInDays is empty" {
            { Set-EntraMSGroupLifecyclePolicy -Id a47d4510-08c8-4437-99e9-71ca88e7af0f -GroupLifetimeInDays  -ManagedGroupTypes "Selected" -AlternateNotificationEmails "example@contoso.com" } | Should -Throw "Missing an argument for parameter 'GroupLifetimeInDays'.*"
        } 
        It "Should fail when ManagedGroupTypes is empty" {
            { Set-EntraMSGroupLifecyclePolicy -Id a47d4510-08c8-4437-99e9-71ca88e7af0f -GroupLifetimeInDays 99 -ManagedGroupTypes  -AlternateNotificationEmails "example@contoso.com" } | Should -Throw "Missing an argument for parameter 'ManagedGroupTypes'.*"
        }
        It "Should fail when AlternateNotificationEmails is empty" {
            { Set-EntraMSGroupLifecyclePolicy -Id a47d4510-08c8-4437-99e9-71ca88e7af0f -GroupLifetimeInDays 99 -ManagedGroupTypes "Selected" -AlternateNotificationEmails } | Should -Throw "Missing an argument for parameter 'AlternateNotificationEmails'.*"
        }
        It "Result should Contain ObjectId" {
            $result = Set-EntraMSGroupLifecyclePolicy -Id a47d4510-08c8-4437-99e9-71ca88e7af0f -GroupLifetimeInDays 200 -AlternateNotificationEmails "admingroup@contoso.com" -ManagedGroupTypes "All"
            $result.ObjectId | should -Be "a47d4510-08c8-4437-99e9-71ca88e7af0f"
        } 
        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Set-EntraMSGroupLifecyclePolicy"

            $result = Set-EntraMSGroupLifecyclePolicy -Id a47d4510-08c8-4437-99e9-71ca88e7af0f -GroupLifetimeInDays 200 -AlternateNotificationEmails "admingroup@contoso.com" -ManagedGroupTypes "All"
            $params = Get-Parameters -data $result.Parameters
            $params.Headers["User-Agent"] | Should -Be $userAgentHeaderValue
        }
    }
}