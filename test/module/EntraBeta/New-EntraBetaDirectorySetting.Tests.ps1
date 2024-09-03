BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra.Beta) -eq $null){
        Import-Module Microsoft.Graph.Entra.Beta    
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force

    $scriptblock = {
        return @(
            [PSCustomObject]@{
                "DisplayName"            = "Password Rule Settings"
                "Id"                     = "9dd37102-c7e0-4176-acf4-84294fcf293c"
                "TemplateId"             = "5cf42378-d67d-4f36-ba46-e8b86229381d"
                "Values"                 = [PSCustomObject]@{
                                            "BannedPasswordCheckOnPremisesMode" = "Audit"
                                            "EnableBannedPasswordCheckOnPremises" = $true
                                            "EnableBannedPasswordCheck" = $true
                                            "LockoutDurationInSeconds" = 60
                                            "LockoutThreshold" = 10
                                            "BannedPasswordList" = $null 
                                           }
                "AdditionalProperties"   = [PSCustomObject]@{
                                            "@odata.context" = "https://graph.microsoft.com/beta/$metadata#settings/$entity"
                                           }
                "Parameters"             = $args
            }
        )
    }    
    Mock -CommandName New-MgBetaDirectorySetting -MockWith $scriptblock -ModuleName Microsoft.Graph.Entra.Beta
}

Describe "New-EntraBetaDirectorySetting" {
    Context "Test for New-EntraBetaDirectorySetting" {
        It "Should creates a directory settings object in Azure Active Directory (AD)" {
            $template = Get-EntraBetaDirectorySettingTemplate -Id "5cf42378-d67d-4f36-ba46-e8b86229381d"
            $settingsCopy = $template.CreateDirectorySetting()
            $result = New-EntraBetaDirectorySetting -DirectorySetting $settingsCopy
            $result | Should -Not -BeNullOrEmpty
            $result.DisplayName | should -Be "Password Rule Settings"
            $result.TemplateId | should -Be "5cf42378-d67d-4f36-ba46-e8b86229381d"
            $result.Id | should -Be "9dd37102-c7e0-4176-acf4-84294fcf293c"

            Should -Invoke -CommandName New-MgBetaDirectorySetting -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }

        It "Should fail when DirectorySetting is empty" {
            { New-EntraBetaDirectorySetting -DirectorySetting  } | Should -Throw "Missing an argument for parameter 'DirectorySetting'*"
        }
    
        It "Should fail when DirectorySetting is Invalid" {
            {
                $template = Get-EntraBetaDirectorySettingTemplate -Id "5cf42378-d67d-4f36-ba46-e8b86229381d"
                $settingsCopy = $template
                New-EntraBetaDirectorySetting -DirectorySetting $settingsCopy } | Should -Throw "Cannot process argument transformation on parameter 'DirectorySetting'*"
        }
        
        It "Should contain BodyParameter in parameters when passed DirectorySetting to it" {
            $template = Get-EntraBetaDirectorySettingTemplate -Id "5cf42378-d67d-4f36-ba46-e8b86229381d"
            $settingsCopy = $template.CreateDirectorySetting()
            $result = New-EntraBetaDirectorySetting -DirectorySetting $settingsCopy
            $params = Get-Parameters -data $result.Parameters
            $params.BodyParameter | Should -Not -BeNullOrEmpty
        }

        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion New-EntraBetaDirectorySetting"

            $template = Get-EntraBetaDirectorySettingTemplate -Id "5cf42378-d67d-4f36-ba46-e8b86229381d"
            $settingsCopy = $template.CreateDirectorySetting()
            $result = New-EntraBetaDirectorySetting -DirectorySetting $settingsCopy
            $params = Get-Parameters -data $result.Parameters
            $params.Headers["User-Agent"] | Should -Be $userAgentHeaderValue
        }   
    }
}