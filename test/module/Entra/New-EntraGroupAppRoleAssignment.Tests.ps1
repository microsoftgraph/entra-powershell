BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra) -eq $null){
        Import-Module Microsoft.Graph.Entra      
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force
    
    $scriptblock = {
        return @(
            [PSCustomObject]@{
              "Id"                           = "c1NLUiFxZk6cP6Nj0RoIyGV2homdrcZNnMeMGgMswmU"
              "AppRoleId"                    = "edaa71bf-f833-4989-8316-82d11fc811e5"
              "CreatedDateTime"              = "06-05-2024 05:42:01"
              "DeletedDateTime"              = $null
              "PrincipalDisplayName"         = "Mock-Group"
              "PrincipalId"                  = "524b5373-7121-4e66-9c3f-a363d11a08c8"
              "ResourceId"                   = "4a795157-504b-4473-ae28-1c54592e7702"
              "ResourceDisplayName"          = "Mock-Group"
              "PrincipalType"                = "PrincipalType"
              "AdditionalProperties"         = @{"@odata.context" = "https://graph.microsoft.com/v1.0/$metadata#groups('524b5373-7121-4e66-9c3f-a363d11a08c8')/appRoleAssignments/$entity"}
              "Parameters"                   = $args
            }
        )
    }

    Mock -CommandName New-MgGroupAppRoleAssignment -MockWith $scriptblock -ModuleName Microsoft.Graph.Entra
}

Describe "New-EntraGroupAppRoleAssignment" {
Context "Test for New-EntraGroupAppRoleAssignment" {
        It "Should return created Group AppRole Assignment" {
            $result = New-EntraGroupAppRoleAssignment -ObjectId "524b5373-7121-4e66-9c3f-a363d11a08c8"  -PrincipalId "524b5373-7121-4e66-9c3f-a363d11a08c8" -ResourceId "4a795157-504b-4473-ae28-1c54592e7702" -Id "edaa71bf-f833-4989-8316-82d11fc811e5"
            $result | Should -Not -BeNullOrEmpty
            $result.Id | Should -Be "c1NLUiFxZk6cP6Nj0RoIyGV2homdrcZNnMeMGgMswmU"
            $result.ResourceId | Should -Be "4a795157-504b-4473-ae28-1c54592e7702"
            $result.PrincipalId | Should -Be "524b5373-7121-4e66-9c3f-a363d11a08c8"
            $result.AppRoleId | Should -Be "edaa71bf-f833-4989-8316-82d11fc811e5"


            Should -Invoke -CommandName New-MgGroupAppRoleAssignment  -ModuleName Microsoft.Graph.Entra -Times 1
        }
        It "Should fail when ObjectlId is empty" {
            { New-EntraGroupAppRoleAssignment -ObjectId   -PrincipalId "524b5373-7121-4e66-9c3f-a363d11a08c8" -ResourceId "4a795157-504b-4473-ae28-1c54592e7702" -Id "edaa71bf-f833-4989-8316-82d11fc811e5" } | Should -Throw "Missing an argument for parameter 'ObjectId'*"
        }
        It "Should fail when ObjectlId is invalid" {
            { New-EntraGroupAppRoleAssignment -ObjectId ""  -PrincipalId "524b5373-7121-4e66-9c3f-a363d11a08c8" -ResourceId "4a795157-504b-4473-ae28-1c54592e7702" -Id "edaa71bf-f833-4989-8316-82d11fc811e5" } | Should -Throw "Cannot bind argument to parameter 'ObjectId' because it is an empty string."
        }
        It "Should fail when PrincipalId is empty" {
            { New-EntraGroupAppRoleAssignment -ObjectId "524b5373-7121-4e66-9c3f-a363d11a08c8"  -PrincipalId  -ResourceId "4a795157-504b-4473-ae28-1c54592e7702" -Id "edaa71bf-f833-4989-8316-82d11fc811e5" } | Should -Throw "Missing an argument for parameter 'PrincipalId'*"
        }
        It "Should fail when PrincipalId is invalid" {
            { New-EntraGroupAppRoleAssignment -ObjectId "524b5373-7121-4e66-9c3f-a363d11a08c8"  -PrincipalId "" -ResourceId "4a795157-504b-4473-ae28-1c54592e7702" -Id "edaa71bf-f833-4989-8316-82d11fc811e5" } | Should -Throw "Cannot bind argument to parameter 'PrincipalId' because it is an empty string."
        }
        It "Should fail when ResourceId is empty" {
            { New-EntraGroupAppRoleAssignment -ObjectId "524b5373-7121-4e66-9c3f-a363d11a08c8"  -PrincipalId "524b5373-7121-4e66-9c3f-a363d11a08c8" -ResourceId  -Id "edaa71bf-f833-4989-8316-82d11fc811e5"  } | Should -Throw "Missing an argument for parameter 'ResourceId'*"
        }
        It "Should fail when ResourceId is invalid" {
            { New-EntraGroupAppRoleAssignment -ObjectId "524b5373-7121-4e66-9c3f-a363d11a08c8"  -PrincipalId "524b5373-7121-4e66-9c3f-a363d11a08c8" -ResourceId "" -Id "edaa71bf-f833-4989-8316-82d11fc811e5" } | Should -Throw "Cannot bind argument to parameter 'ResourceId' because it is an empty string."
        }
        It "Should fail when Id is empty" {
            { New-EntraGroupAppRoleAssignment -ObjectId "524b5373-7121-4e66-9c3f-a363d11a08c8"  -PrincipalId "524b5373-7121-4e66-9c3f-a363d11a08c8" -ResourceId "4a795157-504b-4473-ae28-1c54592e7702" -Id   } | Should -Throw "Missing an argument for parameter 'Id'*"
        }
        It "Should fail when Id is invalid" {
            { New-EntraGroupAppRoleAssignment -ObjectId "524b5373-7121-4e66-9c3f-a363d11a08c8"  -PrincipalId "524b5373-7121-4e66-9c3f-a363d11a08c8" -ResourceId "4a795157-504b-4473-ae28-1c54592e7702" -Id "" } | Should -Throw "Cannot bind argument to parameter 'Id' because it is an empty string."
        }
        It "Result should Contain ObjectId" {
            $result = New-EntraGroupAppRoleAssignment -ObjectId "524b5373-7121-4e66-9c3f-a363d11a08c8"  -PrincipalId "524b5373-7121-4e66-9c3f-a363d11a08c8" -ResourceId "4a795157-504b-4473-ae28-1c54592e7702" -Id "edaa71bf-f833-4989-8316-82d11fc811e5"
            $result.ObjectId | should -Be "c1NLUiFxZk6cP6Nj0RoIyGV2homdrcZNnMeMGgMswmU"
        }
        It "Should contain AppRoleId in parameters when passed Id to it" {              
            $result = New-EntraGroupAppRoleAssignment -ObjectId "524b5373-7121-4e66-9c3f-a363d11a08c8"  -PrincipalId "524b5373-7121-4e66-9c3f-a363d11a08c8" -ResourceId "4a795157-504b-4473-ae28-1c54592e7702" -Id "edaa71bf-f833-4989-8316-82d11fc811e5"
            $params = Get-Parameters -data $result.Parameters
            $params.AppRoleId | Should -Be "edaa71bf-f833-4989-8316-82d11fc811e5"
        }
        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion New-EntraGroupAppRoleAssignment"

            $result = New-EntraGroupAppRoleAssignment -ObjectId "524b5373-7121-4e66-9c3f-a363d11a08c8"  -PrincipalId "524b5373-7121-4e66-9c3f-a363d11a08c8" -ResourceId "4a795157-504b-4473-ae28-1c54592e7702" -Id "edaa71bf-f833-4989-8316-82d11fc811e5"
            $params = Get-Parameters -data $result.Parameters
            $params.Headers["User-Agent"] | Should -Be $userAgentHeaderValue
        }


    }
}