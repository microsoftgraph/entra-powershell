BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra.Beta) -eq $null){
        Import-Module Microsoft.Graph.Entra.Beta       
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force
    
    $scriptblock = {
        return @{
            value = @(
                @{
                    "Id"                           = "dddddddd-7902-4be2-a25b-dddddddddddd"
                    "templateId"                   = "dddddddd-1111-2222-3333-aaaaaaaaaaaa"
                    "@odata.context"               = "https://graph.microsoft.com/beta/$metadata#settings/$entity"
                    "displayName"                  = "Group.Unified.Guest"
                    "values"                       = @{
                                                            "name"  = "AllowToAddGuests"
                                                            "value" = $False
                                                        }
                    "Parameters"                   = $args
                }
            )
         }
    }

    Mock -CommandName Invoke-GraphRequest -MockWith $scriptblock -ModuleName Microsoft.Graph.Entra.Beta
}
Describe "Get-EntraBetaObjectSetting" {
Context "Test for Get-EntraBetaObjectSetting" {
        It "Should return object setting" {
            $result = Get-EntraBetaObjectSetting -TargetType "Groups" -TargetObjectId "aaaaaaaa-5a8c-4f5a-a368-cccccccccccc" 
            $result | Should -Not -BeNullOrEmpty
            $result.Id | Should -Be "dddddddd-7902-4be2-a25b-dddddddddddd"
            $result.templateId | Should -be "dddddddd-1111-2222-3333-aaaaaaaaaaaa"

            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }
        It "Should fail when TargetType is empty" {
            { $result = Get-EntraBetaObjectSetting -TargetType  -TargetObjectId "aaaaaaaa-5a8c-4f5a-a368-cccccccccccc" -Id "dddddddd-7902-4be2-a25b-dddddddddddd"} | Should -Throw "Missing an argument for parameter 'TargetType'*"
        }
        It "Should fail when TargetType is invalid" {
            { $result = Get-EntraBetaObjectSetting -TargetType  -TargetObjectId "aaaaaaaa-5a8c-4f5a-a368-cccccccccccc" -Id "dddddddd-7902-4be2-a25b-dddddddddddd"} | Should -Throw "Missing an argument for parameter 'TargetType'*"
        }
        It "Should fail when TargetObjectId is empty" {
            { $result = Get-EntraBetaObjectSetting -TargetType "Groups" -TargetObjectId  -Id "dddddddd-7902-4be2-a25b-dddddddddddd"} | Should -Throw "Missing an argument for parameter 'TargetObjectId'*"
        }
        It "Should fail when TargetObjectId is invalid" {
            { $result = Get-EntraBetaObjectSetting -TargetType "Groups" -TargetObjectId  -Id "dddddddd-7902-4be2-a25b-dddddddddddd"} | Should -Throw "Missing an argument for parameter 'TargetObjectId'*"
        }
        It "Should return policy applied object by Id" {
            $result = Get-EntraBetaObjectSetting -TargetType "Groups" -TargetObjectId "aaaaaaaa-5a8c-4f5a-a368-cccccccccccc" -Id "dddddddd-7902-4be2-a25b-dddddddddddd"
            $result | Should -Not -BeNullOrEmpty
            $result.value.Id | Should -Be "dddddddd-7902-4be2-a25b-dddddddddddd"
            $result.value.templateId | Should -be "dddddddd-1111-2222-3333-aaaaaaaaaaaa"

            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }
        It "Should fail when Id is empty" {
            { $result = Get-EntraBetaObjectSetting -TargetType "Groups" -TargetObjectId "aaaaaaaa-5a8c-4f5a-a368-cccccccccccc"  -Id  } | Should -Throw "Missing an argument for parameter 'Id'*"
        }
        It "Should fail when Id is invalid" {
            { $result = Get-EntraBetaObjectSetting -TargetType "Groups" -TargetObjectId "aaaaaaaa-5a8c-4f5a-a368-cccccccccccc" -Id "" } | Should -Throw "Cannot bind argument to parameter 'Id' because it is an empty string."
        }
        It "Should return all object settings" {
            $result = Get-EntraBetaObjectSetting -TargetType "Groups" -TargetObjectId "aaaaaaaa-5a8c-4f5a-a368-cccccccccccc" -All
            $result | Should -Not -BeNullOrEmpty            
            
            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }
        It "Should fail when All is invalid" {
            { Get-EntraBetaObjectSetting -TargetType "Groups" -TargetObjectId "aaaaaaaa-5a8c-4f5a-a368-cccccccccccc" -All $true } | Should -Throw "A positional parameter cannot be found that accepts argument 'True'*"
        }
        It "Should return top object setting" {
            $result = Get-EntraBetaObjectSetting -TargetType "Groups" -TargetObjectId "aaaaaaaa-5a8c-4f5a-a368-cccccccccccc" -Top 1
            $result | Should -Not -BeNullOrEmpty
            $result.Id | Should -Be "dddddddd-7902-4be2-a25b-dddddddddddd"
            $result.templateId | Should -be "dddddddd-1111-2222-3333-aaaaaaaaaaaa"

            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }
        It "Should fail when Top is empty" {
            { Get-EntraBetaObjectSetting -TargetType "Groups" -TargetObjectId "aaaaaaaa-5a8c-4f5a-a368-cccccccccccc" -Top  } | Should -Throw "Missing an argument for parameter 'Top'*"
        }
        It "Should fail when Top is invalid" {
            { Get-EntraBetaObjectSetting -TargetType "Groups" -TargetObjectId "aaaaaaaa-5a8c-4f5a-a368-cccccccccccc" -Top XY } | Should -Throw "Cannot process argument transformation on parameter 'Top'*"
        } 
        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraBetaObjectSetting"
            
            $result = Get-EntraBetaObjectSetting -TargetType "Groups" -TargetObjectId "aaaaaaaa-5a8c-4f5a-a368-cccccccccccc" 
            $params = Get-Parameters -data $result.Parameters
            $para = $params | ConvertTo-json | ConvertFrom-json
            $para.Headers."User-Agent" | Should -Be $userAgentHeaderValue
        }
    }
}    