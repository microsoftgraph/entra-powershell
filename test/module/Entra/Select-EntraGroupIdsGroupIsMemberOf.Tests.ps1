BeforeAll {
    if((Get-Module -Name Microsoft.Graph.Entra) -eq $null){
        Import-Module Microsoft.Graph.Entra
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force

    $scriptblock = {
        return @(
            [PSCustomObject]@{
              "Id"               = "00aa00aa-bb11-cc22-dd33-44ee44ee44ee"
              "Parameters"       = $args
            }
        )
    }  
    Mock -CommandName Get-MgGroupMemberOf -MockWith $scriptblock -ModuleName Microsoft.Graph.Entra
}

Describe "Select-EntraGroupIdsGroupIsMemberOf" {
    Context "Test for Select-EntraGroupIdsGroupIsMemberOf" {
        It "Should return specific Group Membership" {
            $Groups = New-Object Microsoft.Open.AzureAD.Model.GroupIdsForMembershipCheck
            $Groups.GroupIds = "00aa00aa-bb11-cc22-dd33-44ee44ee44ee"
            $GroupID = "00aa00aa-bb11-cc22-dd33-44ee44ee44ee"
            $result = Select-EntraGroupIdsGroupIsMemberOf -ObjectId $GroupID -GroupIdsForMembershipCheck $Groups
            $result | Should -Not -BeNullOrEmpty
            $result | Should -Be '00aa00aa-bb11-cc22-dd33-44ee44ee44ee'

            Should -Invoke -CommandName Get-MgGroupMemberOf -ModuleName Microsoft.Graph.Entra -Times 1
        }

        It "Should fail when ObjectId is missing" {
            $Groups = New-Object Microsoft.Open.AzureAD.Model.GroupIdsForMembershipCheck
            $Groups.GroupIds = "00aa00aa-bb11-cc22-dd33-44ee44ee44ee"
            { Select-EntraGroupIdsGroupIsMemberOf -ObjectId  -GroupIdsForMembershipCheck $Groups } | Should -Throw "Missing an argument for parameter 'ObjectId'*"
        }

        It "Should fail when ObjectId is empty" {
            $Groups = New-Object Microsoft.Open.AzureAD.Model.GroupIdsForMembershipCheck
            $Groups.GroupIds = "00aa00aa-bb11-cc22-dd33-44ee44ee44ee"
            { Select-EntraGroupIdsGroupIsMemberOf -ObjectId "" -GroupIdsForMembershipCheck $Groups } | Should -Throw "Cannot bind argument to parameter 'ObjectId' because it is an empty string."
        }

        It "Should fail when GroupIdsForMembershipCheck is empty" {
            $GroupID = "00aa00aa-bb11-cc22-dd33-44ee44ee44ee"
            { Select-EntraGroupIdsGroupIsMemberOf -ObjectId $GroupID  -GroupIdsForMembershipCheck  } | Should -Throw "Missing an argument for parameter 'GroupIdsForMembershipCheck'*"
        }

        It "Should fail when GroupIdsForMembershipCheck is invalid" {
            $GroupID = "00aa00aa-bb11-cc22-dd33-44ee44ee44ee"
            { Select-EntraGroupIdsGroupIsMemberOf -ObjectId $GroupID -GroupIdsForMembershipCheck "Xy" } | Should -Throw "Cannot process argument transformation on parameter 'GroupIdsForMembershipCheck'.*"
        }
        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Select-EntraGroupIdsGroupIsMemberOf"
            $Groups = New-Object Microsoft.Open.AzureAD.Model.GroupIdsForMembershipCheck
            $Groups.GroupIds = "00aa00aa-bb11-cc22-dd33-44ee44ee44ee"
            $GroupID = "00aa00aa-bb11-cc22-dd33-44ee44ee44ee"

            Select-EntraGroupIdsGroupIsMemberOf -ObjectId $GroupID -GroupIdsForMembershipCheck $Groups

            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Select-EntraGroupIdsGroupIsMemberOf"

            Should -Invoke -CommandName Get-MgGroupMemberOf -ModuleName Microsoft.Graph.Entra -Times 1 -ParameterFilter {
                $Headers.'User-Agent' | Should -Be $userAgentHeaderValue
                $true
            }
        } 
        It "Should execute successfully without throwing an error" {
            # Disable confirmation prompts       
            $originalDebugPreference = $DebugPreference
            $DebugPreference = 'Continue'
            $Groups = New-Object Microsoft.Open.AzureAD.Model.GroupIdsForMembershipCheck
            $Groups.GroupIds = "00aa00aa-bb11-cc22-dd33-44ee44ee44ee"
            $GroupID = "00aa00aa-bb11-cc22-dd33-44ee44ee44ee"

            try {
                # Act & Assert: Ensure the function doesn't throw an exception
                { Select-EntraGroupIdsGroupIsMemberOf -ObjectId $GroupID -GroupIdsForMembershipCheck $Groups -Debug } | Should -Not -Throw
            } finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        } 
    }
}