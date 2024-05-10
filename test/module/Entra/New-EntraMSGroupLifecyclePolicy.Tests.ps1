BeforeAll {  
    if ((Get-Module -Name Microsoft.Graph.Entra) -eq $null) {
        Import-Module Microsoft.Graph.Entra      
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force
    
    $scriptblock = {
        return @(
            [PSCustomObject]@{
                "Id"                          = "a47d4510-08c8-4437-99e9-71ca88e7af0f"
                "AlternateNotificationEmails" = "example@contoso.com"
                "GroupLifetimeInDays"         = "99"
                "ManagedGroupTypes"           = "Selected"
                "Parameters"                  = $args
            }
        )
    }

    Mock -CommandName New-MgGroupLifecyclePolicy -MockWith $scriptblock -ModuleName Microsoft.Graph.Entra
}
  
Describe "New-EntraMSGroupLifecyclePolicy " {
    Context "Test for New-EntraMSGroupLifecyclePolicy" {
        It "Should return created GroupLifecyclePolicy" {
            $result = New-EntraMSGroupLifecyclePolicy -GroupLifetimeInDays 99 -ManagedGroupTypes "Selected" -AlternateNotificationEmails "example@contoso.com"
            $result | Should -Not -BeNullOrEmpty
            $result.Id | should -Be "a47d4510-08c8-4437-99e9-71ca88e7af0f"
            $result.GroupLifetimeInDays | should -Be "99"
            $result.ManagedGroupTypes | should -Be "Selected"
            $result.AlternateNotificationEmails | should -Be "example@contoso.com"

            Should -Invoke -CommandName New-MgGroupLifecyclePolicy -ModuleName Microsoft.Graph.Entra -Times 1
        }
        It "Should fail when GroupLifetimeInDays is invalid" {
            { New-EntraMSGroupLifecyclePolicy -GroupLifetimeInDays a -ManagedGroupTypes "Selected" -AlternateNotificationEmails "example@contoso.com" } | Should -Throw "Cannot process argument transformation on parameter 'GroupLifetimeInDays'.*"
        }
        It "Should fail when GroupLifetimeInDays is empty" {
            { New-EntraMSGroupLifecyclePolicy -GroupLifetimeInDays  -ManagedGroupTypes "Selected" -AlternateNotificationEmails "example@contoso.com" } | Should -Throw "Missing an argument for parameter 'GroupLifetimeInDays'.*"
        } 
        It "Should fail when ManagedGroupTypes is invalid" {
            { New-EntraMSGroupLifecyclePolicy -GroupLifetimeInDays 99 -ManagedGroupTypes "" -AlternateNotificationEmails "example@contoso.com" } | Should -Throw "Cannot bind argument to parameter 'ManagedGroupTypes' because it is an empty string.*"
        }
        It "Should fail when ManagedGroupTypes is empty" {
            { New-EntraMSGroupLifecyclePolicy -GroupLifetimeInDays 99 -ManagedGroupTypes  -AlternateNotificationEmails "example@contoso.com" } | Should -Throw "Missing an argument for parameter 'ManagedGroupTypes'.*"
        }
        It "Should fail when AlternateNotificationEmails is invalid" {
            { New-EntraMSGroupLifecyclePolicy -GroupLifetimeInDays 99 -ManagedGroupTypes "Selected" -AlternateNotificationEmails "" } | Should -Throw "Cannot bind argument to parameter 'AlternateNotificationEmails' because it is an empty string.*"
        }
        It "Should fail when AlternateNotificationEmails is empty" {
            { New-EntraMSGroupLifecyclePolicy -GroupLifetimeInDays 99 -ManagedGroupTypes "Selected" -AlternateNotificationEmails } | Should -Throw "Missing an argument for parameter 'AlternateNotificationEmails'.*"
        }
        It "Result should Contain ObjectId" {
            $result = New-EntraMSGroupLifecyclePolicy -GroupLifetimeInDays 99 -ManagedGroupTypes "Selected" -AlternateNotificationEmails "example@contoso.com"
            $result.ObjectId | should -Be "a47d4510-08c8-4437-99e9-71ca88e7af0f"
        } 
        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion New-EntraMSGroupLifecyclePolicy"

            $result = New-EntraMSGroupLifecyclePolicy -GroupLifetimeInDays 99 -ManagedGroupTypes "Selected" -AlternateNotificationEmails "example@contoso.com"
            $params = Get-Parameters -data $result.Parameters
            $params.Headers["User-Agent"] | Should -Be $userAgentHeaderValue
        }
    }
}