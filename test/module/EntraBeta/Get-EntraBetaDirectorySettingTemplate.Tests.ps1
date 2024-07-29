BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra.Beta) -eq $null){
        Import-Module Microsoft.Graph.Entra.Beta    
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force
    
    $scriptblock = {
        return @(
            [PSCustomObject]@{
                "DisplayName"     = "Group.Unified.Guest"
                "Id"              = "08d542b9-071f-4e16-94b0-74abb372e3d9"
                "Description"     = "Settings for a specific Unified Group"
                "Parameters"      = $args
                "Values"          = @(
                    [PSCustomObject]@{
                        "Name"         = "AllowToAddGuests"
                        "Description"  = ""
                        "Type"         = ""
                        "DefaultValue" = $true
                    }
                )
            }
        )
    }    
    Mock -CommandName Get-MgBetaDirectorySettingTemplate -MockWith $scriptblock -ModuleName Microsoft.Graph.Entra.Beta
}
  
Describe "Get-EntraBetaDirectorySettingTemplate" {
    Context "Test for Get-EntraBetaDirectorySettingTemplate" {
        It "Should gets a directory setting template from Azure Active Directory (AD)." {
            $result = Get-EntraBetaDirectorySettingTemplate -Id "08d542b9-071f-4e16-94b0-74abb372e3d9"
            $result | Should -Not -BeNullOrEmpty
            $result.Id | should -Be '08d542b9-071f-4e16-94b0-74abb372e3d9'
            $result.DisplayName | should -Be "Group.Unified.Guest"
            $result.Description | should -Be "Settings for a specific Unified Group"

            Should -Invoke -CommandName Get-MgBetaDirectorySettingTemplate -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }

        It "Should fail when Id is empty" {
            { Get-EntraBetaDirectorySettingTemplate -Id  } | Should -Throw "Missing an argument for parameter 'Id'*"
        }

        It "Should fail when Id is invalid" {
            { Get-EntraBetaDirectorySettingTemplate -Id "" } | Should -Throw "Cannot bind argument to parameter 'Id' because it is an empty string."
        }

        It "Should contain DirectorySettingTemplateId in parameters when passed Id to it" {
            $result = Get-EntraBetaDirectorySettingTemplate -Id "08d542b9-071f-4e16-94b0-74abb372e3d9"
            $result | Should -Not -BeNullOrEmpty
            Should -Invoke -CommandName Get-MgBetaDirectorySettingTemplate -ModuleName Microsoft.Graph.Entra.Beta -Times 1 -ParameterFilter {
            $DirectorySettingTemplateId | Should -Be "08d542b9-071f-4e16-94b0-74abb372e3d9" 
            $true
            }
        }

        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraBetaDirectorySettingTemplate"
            $result = Get-EntraBetaDirectorySettingTemplate -Id "08d542b9-071f-4e16-94b0-74abb372e3d9"
            $result | Should -Not -BeNullOrEmpty
            Should -Invoke -CommandName Get-MgBetaDirectorySettingTemplate -ModuleName Microsoft.Graph.Entra.Beta -Times 1 -ParameterFilter {
            $Headers.'User-Agent' | Should -Be $userAgentHeaderValue 
            $true
            }
        }    
    }
}