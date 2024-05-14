BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra) -eq $null){
        Import-Module Microsoft.Graph.Entra      
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force

    $scriptblock = {
        return @(
            [PSCustomObject]@{
              "DeletedDateTime"         = $null
              "Id"                      = "d083d12d-c280-4a23-a644-b4e71a09a4cb"
              "AppDisplayName"          = "Mock-App"
              "DataType"                = "String"
              "IsSyncedFromOnPremises"  = $False
              "Name"                    = "extension_ec5edf3fe79749dd8d1e7760a1c1c943_NewAttribute"
              "TargetObjects"           = { "User" }  
              "Parameters"              = $args            
            }
        )
    }

    Mock -CommandName New-MgApplicationExtensionProperty -MockWith $scriptblock -ModuleName Microsoft.Graph.Entra

    $targets = New-Object System.Collections.Generic.List[System.String]
    $targets.Add('User')
}
Describe "New-EntraApplicationExtensionProperty"{
    It "Should return created extension property"{
        $result = New-EntraApplicationExtensionProperty -ObjectID "3ddd22e7-a150-4bb3-b100-e410dea1cb84" -Name "NewAttribute" -TargetObjects $targets
        $result | Should -Not -BeNullOrEmpty
        $result.AppDisplayName | should -Be "Mock-App"
        $result.Name | Should -Be "extension_ec5edf3fe79749dd8d1e7760a1c1c943_NewAttribute"
        Should -Invoke -CommandName New-MgApplicationExtensionProperty -ModuleName Microsoft.Graph.Entra -Times 1
    }
    It "Should fail when ObjectId is empty" {
        { New-EntraApplicationExtensionProperty -ObjectId "" } | Should -Throw "Cannot bind argument to parameter 'ObjectId'*"
    }
    It "Should fail when ObjectId is null" {
        { New-EntraApplicationExtensionProperty -ObjectId } | Should -Throw "Missing an argument for parameter 'ObjectId'*"
    }
    It "Should fail when Name is null" {
        { New-EntraApplicationExtensionProperty -ObjectID "3ddd22e7-a150-4bb3-b100-e410dea1cb84" -Name } | Should -Throw "Missing an argument for parameter 'Name'*"
    }
    It "Should fail when DataType is null" {
        { New-EntraApplicationExtensionProperty -ObjectID "3ddd22e7-a150-4bb3-b100-e410dea1cb84" -Name "NewAttribute" -DataType } | Should -Throw "Missing an argument for parameter 'DataType'*"
    }    
    It "Should fail when TargetObjects is null" {
        { New-EntraApplicationExtensionProperty -ObjectID "3ddd22e7-a150-4bb3-b100-e410dea1cb84" -Name "NewAttribute" -TargetObjects } | Should -Throw "Missing an argument for parameter 'TargetObjects'*"
    }
    It "Should fail when invalid parameter is passed" {
        { New-EntraApplicationExtensionProperty -DisplayName "abc" } | Should -Throw "A parameter cannot be found that matches parameter name 'DisplayName'."
    }
    It "Should return result when TargetObjects is empty" {
        New-EntraApplicationExtensionProperty -ObjectID "3ddd22e7-a150-4bb3-b100-e410dea1cb84" -Name "NewAttribute" -TargetObjects {} | Should -Not -BeNullOrEmpty
    }
    It "Should contain ObjectId in result"{
        $result = New-EntraApplicationExtensionProperty -ObjectID "3ddd22e7-a150-4bb3-b100-e410dea1cb84" -Name "NewAttribute"
        $result.ObjectID | Should -Be "d083d12d-c280-4a23-a644-b4e71a09a4cb"
    }
    It "Should contain ApplicationId in parameters when passed ObjectId to it" {    
        $result = New-EntraApplicationExtensionProperty -ObjectID "3ddd22e7-a150-4bb3-b100-e410dea1cb84" -Name "NewAttribute"
        $params = Get-Parameters -data $result.Parameters
        $params.ApplicationId | Should -Be "3ddd22e7-a150-4bb3-b100-e410dea1cb84"
    }
    It "Should contain 'User-Agent' header" {
        $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion New-EntraApplicationExtensionProperty"
        $result = New-EntraApplicationExtensionProperty -ObjectID "3ddd22e7-a150-4bb3-b100-e410dea1cb84" -Name "NewAttribute"
        $params = Get-Parameters -data $result.Parameters
        $params.Headers["User-Agent"] | Should -Be $userAgentHeaderValue
    }
}