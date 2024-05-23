BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra) -eq $null){
        Import-Module Microsoft.Graph.Entra      
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force
    
    $scriptblock = {
        return @(
            [PSCustomObject]@{
                "Id"                   = "fd560167-ff1f-471a-8d74-3b0070abcea1"
                "AdditionalProperties" = @{DisplayName="Test-App";}
                "DeletedDateTime"      = "2/2/2024 5:33:56 AM"
                "Parameters"           = $args
            }
        )
    }

    Mock -CommandName Get-MgDirectoryDeletedItem -MockWith $scriptblock -ModuleName Microsoft.Graph.Entra
}

Describe "Get-EntraMSDeletedDirectoryObject"{
    It "Should fail when Id is empty" {
        { Get-EntraMSDeletedDirectoryObject -Id "" } | Should -Throw "Cannot bind argument to parameter 'Id'*"
    }
    It "Should fail when Id is null" {
        { Get-EntraMSDeletedDirectoryObject -Id  } | Should -Throw "Missing an argument for parameter 'Id'*"
    }
    It "Should fail when invalid parameter is passed" {
        { Get-EntraMSDeletedDirectoryObject -DisplayName "abc" } | Should -Throw "A parameter cannot be found that matches parameter name 'DisplayName'*"
    }
    It "Result should Contain ObjectId" {
        $result = Get-EntraMSDeletedDirectoryObject -Id "fd560167-ff1f-471a-8d74-3b0070abcea1"
        $result.ObjectId | should -Be "fd560167-ff1f-471a-8d74-3b0070abcea1"
    }
    It "Should contain DirectoryObjectId in parameters when passed Id to it" {              
        $result = Get-EntraMSDeletedDirectoryObject -Id "fd560167-ff1f-471a-8d74-3b0070abcea1"
        $params = Get-Parameters -data $result.Parameters
        $params.DirectoryObjectId | Should -Be "fd560167-ff1f-471a-8d74-3b0070abcea1"
    }
    It "Should contain 'User-Agent' header" {
        $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraMSDeletedDirectoryObject"
        $result = Get-EntraMSDeletedDirectoryObject -Id "fd560167-ff1f-471a-8d74-3b0070abcea1"
        $params = Get-Parameters -data $result.Parameters
        $params.Headers["User-Agent"] | Should -Be $userAgentHeaderValue
    }
}