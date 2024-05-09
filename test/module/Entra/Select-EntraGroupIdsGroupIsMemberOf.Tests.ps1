BeforeAll {
    if((Get-Module -Name Microsoft.Graph.Entra) -eq $null){
        Import-Module Microsoft.Graph.Entra
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force

    $scriptblock = {
        return @(
            [PSCustomObject]@{
              "Id"               = "69641f6c-41dc-4f63-9c21-cc9c8ed12931"
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
            $Groups.GroupIds = "69641f6c-41dc-4f63-9c21-cc9c8ed12931"
            $UserID = "cb4e4d7f-3cd6-43f2-8d37-b23b04b6417c"
            $result = Select-EntraGroupIdsGroupIsMemberOf -ObjectId $UserID -GroupIdsForMembershipCheck $Groups
            $result | Should -Not -BeNullOrEmpty
            $result | Should -Be '69641f6c-41dc-4f63-9c21-cc9c8ed12931'

            Should -Invoke -CommandName Get-MgGroupMemberOf -ModuleName Microsoft.Graph.Entra -Times 1
        }

        It "Should fail when UserID is invalid " {
            $Groups = New-Object Microsoft.Open.AzureAD.Model.GroupIdsForMembershipCheck
            $Groups.GroupIds = "69641f6c-41dc-4f63-9c21-cc9c8ed12931"
            $UserID = ""
            { Select-EntraGroupIdsGroupIsMemberOf -ObjectId $UserID -GroupIdsForMembershipCheck $Groups } | Should -Throw "Cannot bind argument to parameter 'ObjectId' because it is an empty string."
        }

        It "Should fail when UserID is empty " {
            $Groups = New-Object Microsoft.Open.AzureAD.Model.GroupIdsForMembershipCheck
            $Groups.GroupIds = "69641f6c-41dc-4f63-9c21-cc9c8ed12931"
            $UserID =
            { Select-EntraGroupIdsGroupIsMemberOf -ObjectId $UserID -GroupIdsForMembershipCheck $Groups } | Should -Throw "Cannot bind argument to parameter 'ObjectId' because it is an empty string."
        }
    }
}

# PR yet to be merged