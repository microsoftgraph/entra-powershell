BeforeAll {
    if((Get-Module -Name Microsoft.Graph.Entra) -eq $null){
        Import-Module Microsoft.Graph.Entra
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force

    $scriptblock = {
        return @(
            [PSCustomObject]@{
              "Id"               = "bea81df1-91cb-4b6e-aa79-b40888fe0b8b"
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
            $Groups.GroupIds = "bea81df1-91cb-4b6e-aa79-b40888fe0b8b"
            $GroupID = "bea81df1-91cb-4b6e-aa79-b40888fe0b8b"
            $result = Select-EntraGroupIdsGroupIsMemberOf -ObjectId $GroupID -GroupIdsForMembershipCheck $Groups
            $result | Should -Not -BeNullOrEmpty
            $result | Should -Be 'bea81df1-91cb-4b6e-aa79-b40888fe0b8b'

            Should -Invoke -CommandName Get-MgGroupMemberOf -ModuleName Microsoft.Graph.Entra -Times 1
        }

        It "Should fail when ObjectId is missing" {
            $Groups = New-Object Microsoft.Open.AzureAD.Model.GroupIdsForMembershipCheck
            $Groups.GroupIds = "bea81df1-91cb-4b6e-aa79-b40888fe0b8b"
            { Select-EntraGroupIdsGroupIsMemberOf -ObjectId  -GroupIdsForMembershipCheck $Groups } | Should -Throw "Missing an argument for parameter 'ObjectId'*"
        }

        It "Should fail when ObjectId is empty" {
            $Groups = New-Object Microsoft.Open.AzureAD.Model.GroupIdsForMembershipCheck
            $Groups.GroupIds = "bea81df1-91cb-4b6e-aa79-b40888fe0b8b"
            { Select-EntraGroupIdsGroupIsMemberOf -ObjectId "" -GroupIdsForMembershipCheck $Groups } | Should -Throw "Cannot bind argument to parameter 'ObjectId' because it is an empty string."
        }

        It "Should fail when GroupIdsForMembershipCheck is empty" {
            $GroupID = "bea81df1-91cb-4b6e-aa79-b40888fe0b8b"
            { Select-EntraGroupIdsGroupIsMemberOf -ObjectId $GroupID  -GroupIdsForMembershipCheck  } | Should -Throw "Missing an argument for parameter 'GroupIdsForMembershipCheck'*"
        }

        It "Should fail when GroupIdsForMembershipCheck is invalid" {
            $GroupID = "bea81df1-91cb-4b6e-aa79-b40888fe0b8b"
            { Select-EntraGroupIdsGroupIsMemberOf -ObjectId $GroupID -GroupIdsForMembershipCheck "ZZZ" } | Should -Throw "Cannot process argument transformation on parameter 'GroupIdsForMembershipCheck'.*"
        }
    }
}