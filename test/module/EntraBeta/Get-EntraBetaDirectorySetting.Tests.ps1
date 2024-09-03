BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra.Beta) -eq $null){
        Import-Module Microsoft.Graph.Entra.Beta    
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force
    
    $scriptblock = {
        return @(
            [PSCustomObject]@{
                "DisplayName"          = "Application"
                "Id"                   = "a658c48f-fd66-498d-8199-27ed3d33c7c3"
                "TemplateId"           = "4bc7f740-180e-4586-adb6-38b2e9024e6b"
                "Values"               = @("EnableAccessCheckForPrivilegedApplicationUpdates")
                "AdditionalProperties" = @{"[@odata.context" = "https://graph.microsoft.com/beta/$metadata#settings/$entity"}
                "Parameters"           = $args
            }
        )
    }    
    Mock -CommandName Get-MgBetaDirectorySetting -MockWith $scriptblock -ModuleName Microsoft.Graph.Entra.Beta
}
  
Describe "Get-EntraBetaDirectorySetting" {
    Context "Test for Get-EntraBetaDirectorySetting" {
        It "Should gets a directory setting from Azure Active Directory (AD)" {
            $result = Get-EntraBetaDirectorySetting -Id "a658c48f-fd66-498d-8199-27ed3d33c7c3"
            $result | Should -Not -BeNullOrEmpty
            $result.Id | should -Be 'a658c48f-fd66-498d-8199-27ed3d33c7c3'
            $result.DisplayName | should -Be "Application"
            $result.TemplateId | should -Be "4bc7f740-180e-4586-adb6-38b2e9024e6b"
            $result.Values | should -Be @("EnableAccessCheckForPrivilegedApplicationUpdates")

            Should -Invoke -CommandName Get-MgBetaDirectorySetting -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }

        It "Should fail when Id is empty" {
            { Get-EntraBetaDirectorySetting -Id  } | Should -Throw "Missing an argument for parameter 'Id'*"
        }

        It "Should fail when Id is invalid" {
            { Get-EntraBetaDirectorySetting -Id "" } | Should -Throw "Cannot bind argument to parameter 'Id' because it is an empty string."
        }

        It "Should return all group" {
            $result = Get-EntraBetaDirectorySetting -All $true
            $result | Should -Not -BeNullOrEmpty            
            
            Should -Invoke -CommandName Get-MgBetaDirectorySetting -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }

        It "Should fail when All is empty" {
            { Get-EntraBetaDirectorySetting -All } | Should -Throw "Missing an argument for parameter 'All'*"
        }      

        It "Should fail when All is invalid" {
            { Get-EntraBetaDirectorySetting -All "" } | Should -Throw "Cannot process argument transformation on parameter 'All'*"
        }      
        
        It "Should return top group" {
            $result = Get-EntraBetaDirectorySetting -Top 1
            $result | Should -Not -BeNullOrEmpty

            Should -Invoke -CommandName Get-MgBetaDirectorySetting -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }  

        It "Should fail when top is empty" {
            { Get-EntraBetaDirectorySetting -Top } | Should -Throw "Missing an argument for parameter 'Top'*"
        }  

        It "Should fail when top is invalid" {
            { Get-EntraBetaDirectorySetting -Top y } | Should -Throw "Cannot process argument transformation on parameter 'Top'*"
        }  

        It "Should contain DirectorySettingId in parameters when passed Id to it" {
            $result = Get-EntraBetaDirectorySetting -Id "a658c48f-fd66-498d-8199-27ed3d33c7c3"
            $params = Get-Parameters -data $result.Parameters
            $params.DirectorySettingId | Should -Be "a658c48f-fd66-498d-8199-27ed3d33c7c3"
        }

        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraBetaDirectorySetting"
            $result = Get-EntraBetaDirectorySetting -Id "a658c48f-fd66-498d-8199-27ed3d33c7c3"
            $params = Get-Parameters -data $result.Parameters
            $params.Headers["User-Agent"] | Should -Be $userAgentHeaderValue
        }    
    }
}