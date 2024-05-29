BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra.Beta) -eq $null){
        Import-Module Microsoft.Graph.Entra.Beta    
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force

    Mock -CommandName Update-MgBetaDirectorySetting -MockWith {} -ModuleName Microsoft.Graph.Entra.Beta
}

Describe "Set-EntraBetaDirectorySetting" {
    Context "Test for Set-EntraBetaDirectorySetting" {
        It "Should updates a directory setting in Azure Active Directory (AD)" {
            $template = Get-EntraBetaDirectorySettingTemplate -Id "5cf42378-d67d-4f36-ba46-e8b86229381d"
            $settingsCopy = $template.CreateDirectorySetting()
            $settingsCopy["EnableBannedPasswordCheckOnPremises"] = "False"
            $result = Set-EntraBetaDirectorySetting -Id "9dd37102-c7e0-4176-acf4-84294fcf293c" -DirectorySetting $settingsCopy 
            $result | Should -BeNullOrEmpty

            Should -Invoke -CommandName Update-MgBetaDirectorySetting -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }

        It "Should fail when Id is empty" {
            {   $template = Get-EntraBetaDirectorySettingTemplate -Id "5cf42378-d67d-4f36-ba46-e8b86229381d"
                $settingsCopy = $template.CreateDirectorySetting()
                $settingsCopy["EnableBannedPasswordCheckOnPremises"] = "False"
                Set-EntraBetaDirectorySetting -Id  -DirectorySetting $settingsCopy } | Should -Throw "Missing an argument for parameter 'Id'*"
        } 

        It "Should fail when Id is invalid" {
            {   $template = Get-EntraBetaDirectorySettingTemplate -Id "5cf42378-d67d-4f36-ba46-e8b86229381d"
                $settingsCopy = $template.CreateDirectorySetting()
                $settingsCopy["EnableBannedPasswordCheckOnPremises"] = "False"
                Set-EntraBetaDirectorySetting -Id "" -DirectorySetting $settingsCopy } | Should -Throw "Cannot bind argument to parameter 'Id' because it is an empty string.*"
        } 

        It "Should fail when DirectorySetting is empty" {
            {   $template = Get-EntraBetaDirectorySettingTemplate -Id "5cf42378-d67d-4f36-ba46-e8b86229381d"
                $settingsCopy = $template.CreateDirectorySetting()
                $settingsCopy["EnableBannedPasswordCheckOnPremises"] = "False"
                Set-EntraBetaDirectorySetting -Id "9dd37102-c7e0-4176-acf4-84294fcf293c" -DirectorySetting  } | Should -Throw "Missing an argument for parameter 'DirectorySetting'*"
        } 

        It "Should fail when DirectorySetting is invalid" {
            { Set-EntraBetaDirectorySetting -Id "9dd37102-c7e0-4176-acf4-84294fcf293c" -DirectorySetting "" } | Should -Throw "Cannot process argument transformation on parameter 'DirectorySetting'.*"
        } 

        It "Should contain BodyParameter in parameters when passed DirectorySetting to it" {
            Mock -CommandName Update-MgBetaDirectorySetting -MockWith {$args} -ModuleName Microsoft.Graph.Entra.Beta

            $template = Get-EntraBetaDirectorySettingTemplate -Id "5cf42378-d67d-4f36-ba46-e8b86229381d"
            $settingsCopy = $template.CreateDirectorySetting()
            $settingsCopy["EnableBannedPasswordCheckOnPremises"] = "False"
            $result = Set-EntraBetaDirectorySetting -Id "9dd37102-c7e0-4176-acf4-84294fcf293c" -DirectorySetting $settingsCopy 
            $params = Get-Parameters -data $result
            $params.BodyParameter | Should -Not -BeNullOrEmpty
        }        
        
        It "Should contain DirectorySettingId in parameters when passed Id to it" {
            Mock -CommandName Update-MgBetaDirectorySetting -MockWith {$args} -ModuleName Microsoft.Graph.Entra.Beta

            $template = Get-EntraBetaDirectorySettingTemplate -Id "5cf42378-d67d-4f36-ba46-e8b86229381d"
            $settingsCopy = $template.CreateDirectorySetting()
            $settingsCopy["EnableBannedPasswordCheckOnPremises"] = "False"
            $result = Set-EntraBetaDirectorySetting -Id "9dd37102-c7e0-4176-acf4-84294fcf293c" -DirectorySetting $settingsCopy 
            $params = Get-Parameters -data $result
            $params.DirectorySettingId | Should -Be "9dd37102-c7e0-4176-acf4-84294fcf293c"
        }        

        It "Should contain 'User-Agent' header" {
            Mock -CommandName Update-MgBetaDirectorySetting -MockWith {$args} -ModuleName Microsoft.Graph.Entra.Beta

            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Set-EntraBetaDirectorySetting"
            $template = Get-EntraBetaDirectorySettingTemplate -Id "5cf42378-d67d-4f36-ba46-e8b86229381d"
            $settingsCopy = $template.CreateDirectorySetting()
            $settingsCopy["EnableBannedPasswordCheckOnPremises"] = "False"
            $result = Set-EntraBetaDirectorySetting -Id "9dd37102-c7e0-4176-acf4-84294fcf293c" -DirectorySetting $settingsCopy 
            $params = Get-Parameters -data $result
            $params.Headers["User-Agent"] | Should -Be $userAgentHeaderValue
        }
    }
}