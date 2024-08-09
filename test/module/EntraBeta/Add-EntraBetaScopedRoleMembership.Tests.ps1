BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra.Beta) -eq $null){
        Import-Module Microsoft.Graph.Entra.Beta       
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force
    
    $scriptblock = {
        return @(
            [PSCustomObject]@{
              "Id"                           = "zTVcE8KFQ0W4bI9tvt6kz-5AOA62QHJLgnvAbh9Z0r7uQTWi6U_yTLYoEC66749-U"
              "RoleId"                       = "cccccccc-85c2-4543-b86c-cccccccccccc"
              "AdministrativeUnitId"         = "dddddddd-7902-4be2-a25b-dddddddddddd"

              "RoleMemberInfo"               = @{
                                                  "DisplayName"          = "Conf Room Adams"
                                                  "Id"                   = "aaaaaaaa-1111-2222-3333-bbbbbbbbbbbb"
                                                  "AdditionalProperties" = @{"userPrincipalName" = "Adams@M365x99297270.OnMicrosoft.com" }  
                                                }
              "AdditionalProperties"         = @{"@odata.context"  = "https://graph.microsoft.com/beta/$metadata#scopedRoleMemberships/$entity]"}
              "Parameters"                   = $args
            }
        )
    }

    Mock -CommandName New-MgBetaDirectoryAdministrativeUnitScopedRoleMember -MockWith $scriptblock -ModuleName Microsoft.Graph.Entra.Beta
}

Describe "Get-EntraBetaScopedRoleMembership" {
Context "Test for Get-EntraBetaScopedRoleMembership" {
        It "Should return specific scoped role membership" {
            $RoleMember = New-Object -TypeName Microsoft.Open.AzureAD.Model.RoleMemberInfo
            $RoleMember.ObjectId = "a23541ee-4fe9-4cf2-b628-102ebaef8f7e"
            $result = Add-EntraBetaScopedRoleMembership -ObjectId "0e3840ee-40b6-4b72-827b-c06e1f59d2be" -RoleObjectId "135c35cd-85c2-4543-b86c-8f6dbedea4cf" -RoleMemberInfo $RoleMember
            $result | Should -Not -BeNullOrEmpty
            $result.Id | Should -Be "zTVcE8KFQ0W4bI9tvt6kz-5AOA62QHJLgnvAbh9Z0r7uQTWi6U_yTLYoEC66749-U"
            $result.RoleId | Should -Be "cccccccc-85c2-4543-b86c-cccccccccccc"
            $result.AdministrativeUnitId | Should -Be "dddddddd-7902-4be2-a25b-dddddddddddd"

            Should -Invoke -CommandName New-MgBetaDirectoryAdministrativeUnitScopedRoleMember -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }
        It "Should fail when ObjectId is empty" {
            { Get-EntraBetaScopedRoleMembership -ObjectId  } | Should -Throw "Missing an argument for parameter 'ObjectId'*"
        }
        It "Should fail when ObjectId is invalid" {
            { Get-EntraBetaScopedRoleMembership -ObjectId "" } | Should -Throw "Cannot bind argument to parameter 'ObjectId' because it is an empty string."
        }
        It "Should fail when RoleObjectId is empty" {
            { Add-EntraBetaScopedRoleMembership -ObjectId "cccccccc-7902-4be2-a25b-dddddddddddd" -RoleObjectId   } | Should -Throw "Missing an argument for parameter 'RoleObjectId'*"
        }
        It "Should fail when AdministrativeUnitObjectId is empty" {
            { Add-EntraBetaScopedRoleMembership -ObjectId "cccccccc-7902-4be2-a25b-dddddddddddd" -AdministrativeUnitObjectId   } | Should -Throw "Missing an argument for parameter 'AdministrativeUnitObjectId'*"
        }
        It "Should fail when RoleMemberInfo is empty" {
            { Add-EntraBetaScopedRoleMembership -ObjectId "cccccccc-7902-4be2-a25b-dddddddddddd" -RoleMemberInfo   } | Should -Throw "Missing an argument for parameter 'RoleMemberInfo'*"
        }
        It "Should fail when RoleMemberInfo is invalid" {
            { Add-EntraBetaScopedRoleMembership -ObjectId "cccccccc-7902-4be2-a25b-dddddddddddd" -RoleMemberInfo "" } | Should -Throw "Cannot process argument transformation on parameter 'RoleMemberInfo'*"
        }
        It "Result should contain Alias properties"{
            $RoleMember = New-Object -TypeName Microsoft.Open.AzureAD.Model.RoleMemberInfo
            $RoleMember.ObjectId = "a23541ee-4fe9-4cf2-b628-102ebaef8f7e"
            $result = Add-EntraBetaScopedRoleMembership -ObjectId "0e3840ee-40b6-4b72-827b-c06e1f59d2be" -RoleObjectId "135c35cd-85c2-4543-b86c-8f6dbedea4cf" -RoleMemberInfo $RoleMember
            $result.ObjectId | should -Be "zTVcE8KFQ0W4bI9tvt6kz-5AOA62QHJLgnvAbh9Z0r7uQTWi6U_yTLYoEC66749-U"
            $result.RoleObjectId | should -Be "cccccccc-85c2-4543-b86c-cccccccccccc"
            $result.AdministrativeUnitObjectId | should -Be "dddddddd-7902-4be2-a25b-dddddddddddd"
        }
        It "Should contain AdministrativeUnitId in parameters when passed ObjectId to it" {    
            
            $result = Add-EntraBetaScopedRoleMembership -ObjectId "0e3840ee-40b6-4b72-827b-c06e1f59d2be" -RoleObjectId "135c35cd-85c2-4543-b86c-8f6dbedea4cf"
            $params = Get-Parameters -data $result.Parameters
            $params.AdministrativeUnitId | Should -Be "0e3840ee-40b6-4b72-827b-c06e1f59d2be"
        }
        It "Should contain AdministrativeUnitId1 in parameters when passed AdministrativeUnitObjectId to it" {    
            
            $result = Add-EntraBetaScopedRoleMembership -ObjectId "0e3840ee-40b6-4b72-827b-c06e1f59d2be" -AdministrativeUnitObjectId "0e3840ee-40b6-4b72-827b-c06e1f59d2be" -RoleObjectId "135c35cd-85c2-4543-b86c-8f6dbedea4cf"
            $params = Get-Parameters -data $result.Parameters
            $params.AdministrativeUnitId1 | Should -Be "0e3840ee-40b6-4b72-827b-c06e1f59d2be"
        }
        It "Should contain RoleId in parameters when passed RoleObjectId to it" {    
            $RoleMember = New-Object -TypeName Microsoft.Open.AzureAD.Model.RoleMemberInfo
            $RoleMember.ObjectId = "a23541ee-4fe9-4cf2-b628-102ebaef8f7e"

            $result = Add-EntraBetaScopedRoleMembership -ObjectId "0e3840ee-40b6-4b72-827b-c06e1f59d2be" -RoleObjectId "135c35cd-85c2-4543-b86c-8f6dbedea4cf" -RoleMemberInfo $RoleMember
            $params = Get-Parameters -data $result.Parameters
            $params.RoleId | Should -Be "135c35cd-85c2-4543-b86c-8f6dbedea4cf"
        }
        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Add-EntraBetaScopedRoleMembership"

            $result = Add-EntraBetaScopedRoleMembership -ObjectId "0e3840ee-40b6-4b72-827b-c06e1f59d2be" -RoleObjectId "135c35cd-85c2-4543-b86c-8f6dbedea4cf" 
            $params = Get-Parameters -data $result.Parameters
            $params.Headers["User-Agent"] | Should -Be $userAgentHeaderValue
        }

    }
}   